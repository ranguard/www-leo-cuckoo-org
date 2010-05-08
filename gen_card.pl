#!/usr/bin/perl -w

use strict;
use lib qw(lib);
use Path::Class;
use File::Find::Rule;
use JSON::Any;
use Data::Dumper;
use File::Slurp;

use Leo::Site::Model::Card;

#create_image_json_list();

#make_thumbnails();
create_test_card();

sub create_image_json_list {

    my $card = Leo::Site::Model::Card->new();

    my $files = $card->non_thumb_images();

    my $out;
    foreach my $file (@$files) {
        $file = file($file);

        my $section = ( $file->parent()->dir_list() )[-1];
        my $thumb_file
            = dir( $file->dir(), 'thumb' )->file( $file->basename() );

        $out->{"$section"}->{ $file->basename() } = {
            title => 'None',

            # thumb => "$thumb_file" if -r $thumb_file,
        };
    }
    my $j    = JSON::Any->new;
    my $json = $j->objToJson($out);

    my $out_file = dir( $card->img_source() )->parent()->subdir('lib')
        ->file('image_data.js');
    write_file(
        "$out_file",
        (   "// do not edit, this file is created automatically\n",
            "var image_data = $json;\n"
        )
    );
}

sub create_test_card {
    my $card = Leo::Site::Model::Card->new(
        {   'image'      => 'img_animals_dog04.jpg',
            'background' => 'bg_red.png',
            'forground'  => 'fr_flowers_02.png',

            # 'forground'  => 'flowers_orange.png',
            'to'      => 'Dear Fred',
            'message' => "This is a test with a\nReturn character.\n FOOO",
            'from'    => 'Love ME'
        }
    );

    $card->merge('here.png');
}

sub make_thumbnails {

    my $card = Leo::Site::Model::Card->new();

    my $files = $card->non_thumb_images();

    foreach my $file (@$files) {

        $file = file($file);
        my $thumb_file
            = dir( $file->dir(), 'thumb' )->file( $file->basename() );

        $card->crop_image(
            {   from => "$file",
                to   => "$thumb_file"
            }
        );
    }
}

