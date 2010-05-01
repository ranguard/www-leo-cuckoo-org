package Leo::Site::Controller::Card;

use strict;
use warnings;
use base 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
#__PACKAGE__->config->{namespace} = '';

=head1 NAME

Leo::Site::Controller::CardGen - Generate cards and save to S3

=head2 default

=cut

sub generate : Local {
    my ( $self, $c ) = @_;

    my $params = $c->req->parameters();

    my $card = $c->model('Card')->new($params);

    my $response;
    if ( my $card_url = $card->merge() ) {
        $response = { status => 'ok', img_src => $card_url, };
    } else {
        $response = { status => 'error', };
    }

    $c->send_as_json($response);

}

=head1 AUTHOR

Leo Lapworth

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
