package Leo::Site::Model::Card;

use Moose;
use Image::Imlib2;
use Net::Amazon::S3;
use Path::Class;
use Data::UUID;
use DateTime;
use File::Find::Rule;

use Sys::Hostname;
my $host = hostname();

has 'img_source' => (
    is      => 'rw',
    'isa'   => 'Str',
    default => $host eq 'braga'
    ? '/vhosts/leo.cuckoo.org/iphone-card/Resources/cards/'
    : '/home/leo/git/iphone-card/Resources/cards/'
);

has 'image'      => ( is => 'rw', 'isa' => 'Str' );
has 'background' => ( is => 'rw', 'isa' => 'Str' );
has 'forground'  => ( is => 'rw', 'isa' => 'Str' );
has 'to'         => ( is => 'rw', 'isa' => 'Str', default => 'Hi' );
has 'message'    => ( is => 'rw', 'isa' => 'Str', default => '' );
has 'from'       => ( is => 'rw', 'isa' => 'Str', default => 'Take care' );

has 'width'  => ( is => 'ro', 'isa' => 'Int', default => 480 );
has 'height' => ( is => 'ro', 'isa' => 'Int', default => 622 );

sub crop_image {
    my ($self, $conf) = @_;
    
    my $image = Image::Imlib2->load( $conf->{from} );
    
    my $cropped_image;
    if($conf->{from} =~ /image/) {
        $cropped_image = $image->crop(30, 20, 350, 350);
    } else {
        $cropped_image = $image->crop(0, 0, $self->width(), 450);
    }
    my $scaled_image = $cropped_image->create_scaled_image(58,58);
    $scaled_image->save($conf->{to});
}

sub non_thumb_images {
    my $self = shift;
    
    my @files = File::Find::Rule->file()->name( ( '*.jpg', '*.png' ) )
        ->in( ( $self->img_source() ) );
        
    @files = grep { !/thumb/ } @files;
    return \@files;
}

sub merge {
    my $self = shift;
    my $tmp_file = shift;

    my $image = Image::Imlib2->new( $self->width(), $self->height() );
	$image->set_quality(100);

    foreach my $field (qw(image background forground)) {
        if ( my $img = $self->$field() ) {
            my $filename = file($img)->basename();

            my $source = $self->img_source() . $field . 's/' . $filename;
            
            if($img =~ /tmp/ && -r $img) {
                # User supplied image
                # left 25, top: 26 - width & height 430
                
                my $user_img = Image::Imlib2->load($img);

                $image->blend($user_img, 1, 0, 0, $user_img->width(),
                    $user_img->height(), 25, 26, 430, 430);
                          
            } elsif ( -r $source ) {
                my $to_merge = Image::Imlib2->load($source);
                $image->blend( $to_merge, 1, 0, 0, $self->width(),
                    $self->height(), 0, 0, $self->width(), $self->height() );
            } else {
                warn "Could not find: $source";
            }

        }
    }
    
    my @dirs = qw(/home/leo/git/www-leo-cuckoo-org /Users/leo/git/www-leo-cuckoo-org /vhosts/leo.cuckoo.org);
    foreach my $dir (@dirs) {
        if(-d $dir) {
            $image->add_font_path("$dir/ttfonts/");            
        }        
    }
    
    # Add in copy
    $image->load_font("Arial_Bold/20");

    # $image->set_colour(255, 255, 255, 255); # white
    $image->set_colour(  0,   0,   0, 255); # black
    # $image->set_colour(127, 127, 127, 255); # 50% gray
    $image->draw_text(30,410, $self->to());
        
    my @lines = split("\n", $self->message());
    my $message_top = 440;
    
    my $spacing = 30;
    my $rows = @lines;
    if($rows == 4) {
        $spacing = 30;
    } elsif($rows == 3) {
        $message_top = 450;
        $spacing = 40;
    } elsif($rows == 2) {
        $message_top = 460;
        $spacing = 50;
    } else {
        $message_top = 485;
    }
    
    foreach my $msg (@lines) {
        my ($message_x, $message_y) = $image->get_text_size($msg);
        my $message_left = ($self->width() - $message_x) / 2;
        $image->draw_text($message_left, $message_top, $msg);
        $message_top += $spacing;
    }
    
    my ($from_x, $from_y) = $image->get_text_size($self->from());
    my $from_left = ($self->width() - 30) - $from_x;
    $image->draw_text($from_left, 560, $self->from());
    

    my $uuid      = Data::UUID->new->create_str;
    my $file_name = $uuid . '.jpg';
    my $file      = $tmp_file || "/tmp/$file_name";

	$image->set_quality(100);
    $image->save($file);

    if($tmp_file) {
        warn "Not uploading to S3";
        return;
    }

    return $self->upload_to_s3(
         {   file      => $file,
             file_name => DateTime->now()->ymd('/') . '/' . $file_name,
         }
    );

}

sub upload_to_s3 {
    my $self = shift;
    my $conf = shift;

    my $file = file( $conf->{file} );

    my $aws_access_key_id     = '0Z2QPJMCSKBMS9JPYHR2';
    my $aws_secret_access_key = 'jfLFCQNAWxtJS5HhU7Z6SR13N4mRFe+CAuoW/tdk';

    my $s3 = Net::Amazon::S3->new(
        {   aws_access_key_id     => $aws_access_key_id,
            aws_secret_access_key => $aws_secret_access_key,
            retry                 => 1,
            timeout               => 120,
        }
    );

    my $client = Net::Amazon::S3::Client->new( s3 => $s3 );
    my $bucket = $client->bucket( name => 'hinu-cards' );

    my $upload_conf = {
        acl_short    => 'public-read',
        content_type => $conf->{content_type} || 'image/png',
        key          => $conf->{file_name},
    };

    my $object = $bucket->object(%$upload_conf);
    $object->put_filename( $conf->{file} );
warn 'http://hinu-cards.s3.amazonaws.com/' . $conf->{file_name};
    return 'http://hinu-cards.s3.amazonaws.com/' . $conf->{file_name};

}

1;
