package Leo::Site;

use strict;
use warnings;

use JSON;

use Catalyst::Runtime '5.70';

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a YAML file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root 
#                 directory

use Catalyst qw/-Debug ConfigLoader Static::Simple/;

our $VERSION = '0.01';

# Configure the application. 
#
# Note that settings in Leo::Site.yml (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with a external configuration file acting as an override for
# local deployment.

__PACKAGE__->config( name => 'Leo::Site',
	static => {
		ignore_extensions => [qw/html svg/],
	}
 );
# Start the application
__PACKAGE__->setup;

sub send_as_json {
    my ( $c, $data ) = @_;

    # Encode and return the results.
    my $json        = JSON->new->pretty;
    my $json_string = $json->encode($data);

    $c->res->content_type('application/json');
    $c->res->body($json_string);

    return 1;
}

=head1 NAME

Leo::Site - Catalyst based application

=head1 SYNOPSIS

    script/leo_site_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<Leo::Site::Controller::Root>, L<Catalyst>

=head1 AUTHOR

Leo Lapworth

=head1 LICENSE

This library is free software, you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
