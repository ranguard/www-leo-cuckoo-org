package Leo::Site::Model::Card;

use Moose;
use Image::Imlib2;

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
            my $source = $self->img_source() . $field . 's/' . $img;
            if ( -r $source ) {
                my $to_merge = Image::Imlib2->load($source);
                $image->blend($to_merge, 1, 0, 0, $self->width(), $self->height(), 0, 0, $self->width(), $self->height() );
            } else {
                warn "Could not find: $source";
            }

        }
    }
    
    $image->save('out.png');

}

1;
