package Leo::Site::Model::Card;

use Moose;
use Image::Imlib2;
use Net::Amazon::S3;
use Path::Class;
use Data::UUID;
use DateTime;

has 'img_source' => (
    is      => 'rw',
    'isa'   => 'Str',
    default => '/home/leo/git/iphone-card/Resources/cards/'
);

has 'image'      => ( is => 'rw', 'isa' => 'Str' );
has 'background' => ( is => 'rw', 'isa' => 'Str' );
has 'forground'  => ( is => 'rw', 'isa' => 'Str' );
has 'to'         => ( is => 'rw', 'isa' => 'Str' );
has 'message'    => ( is => 'rw', 'isa' => 'Str' );
has 'from'       => ( is => 'rw', 'isa' => 'Str' );

has 'width'  => ( is => 'ro', 'isa' => 'Int', default => 426 );
has 'height' => ( is => 'ro', 'isa' => 'Int', default => 552 );

sub merge {
    my $self = shift;

    my $image = Image::Imlib2->new( $self->width(), $self->height() );

    foreach my $field (qw(image background forground)) {
        if ( my $img = $self->$field() ) {
            my $filename = file($img)->basename();
            
            my $source = $self->img_source() . $field . 's/' . $filename;
            if ( -r $source ) {
                my $to_merge = Image::Imlib2->load($source);
                $image->blend($to_merge, 1, 0, 0, $self->width(), $self->height(), 0, 0, $self->width(), $self->height() );
            } else {
                warn "Could not find: $source";
            }

        }
    }
    
    my $uuid      = Data::UUID->new->create_str;
    my $file_name = $uuid . '.png';
    my $file = "/tmp/$file_name";
    
    $image->save($file);
    
    return $self->upload_to_s3({
        file => $file,
        file_name => DateTime->now()->ymd('/') . '/' . $file_name,
    });
    

}

sub upload_to_s3 {
    my $self = shift;
    my $conf = shift;
    
    my $file         = file($conf->{file});
    
    
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
        acl_short => 'public-read',
        content_type => $conf->{content_type} || 'image/png',
        key => $conf->{file_name},
    };

    my $object = $bucket->object(%$upload_conf);
    $object->put_filename($conf->{file});
    
    return 'http://hinu-cards.s3.amazonaws.com/' . $conf->{file_name};

}

1;
