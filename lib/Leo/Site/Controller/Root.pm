package Leo::Site::Controller::Root;

use strict;
use warnings;
use base 'Catalyst::Controller';

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config->{namespace} = '';

=head1 NAME

Leo::Site::Controller::Root - Root Controller for Leo::Site

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=cut

=head2 default

=cut

sub default : Private {
    my ( $self, $c ) = @_;

	warn "Path start " .  $c->req->path;


    # Hello World
    # $c->response->body( $c->welcome_message );
}

=head2 end

Attempt to render a view, if needed.

=cut 

sub end : ActionClass('RenderView') {
    my ( $self, $c ) = @_;



    return if $c->stash->{do_not_render};

    # $c->{stash}->{user} = $c->user->get_object if $c->user;
    unless ( $c->stash->{template} ) {

        # No template defined
        my $path = $c->req->path;
        $path .= 'index.html' if $path !~ /html$/ && $path !~ /svg$/;
        my $file = $c->config->{root} . '/' . $path;

        if ( -r $file ) {
            $c->stash->{template} = $path;

			if ($c->req->path =~ /svg$/) {
				$c->res->content_type('image/svg+xml') ;
			} 

        } else {

            # return 404
            $c->response->status(404);
            $c->stash->{template} = 'error.html';
        }
    }

	

}

=head1 AUTHOR

Leo Lapworth

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
