use inc::Module::Install;

name 'Leo-Site';
all_from 'lib/Leo/Site.pm';

requires 'Data::UUID'      => '0';
requires 'Catalyst::Request::Upload' => '0';
requires 'DateTime'        => '0';
requires 'Path::Class'     => '0';
requires 'Catalyst'        => '5.7011';
requires 'Catalyst::Plugin::ConfigLoader';
requires 'Catalyst::Plugin::Static::Simple';
requires 'Catalyst::Action::RenderView';
requires 'YAML';    # This should reflect the config file format you've chosen
                    # See Catalyst::Plugin::ConfigLoader for supported formats
catalyst;

install_script glob('script/*.pl');
auto_install;
WriteAll;
