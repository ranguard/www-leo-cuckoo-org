#!/usr/bin/perl -w

use strict;
use lib qw(lib);
use Path::Class;
use File::Find::Rule;

use Leo::Site::Model::Card;

make_thumbnails();

# my $card = Leo::Site::Model::Card->new({
#     'image'      => 'cat_01.png',
#     'background' => 'bg_blue.png',
#     'forground' => 'flowers_orange_trans.png',
#     # 'forground'  => 'flowers_orange.png',
#     'to'         => 'Dear Fred',
#     'message'    => "Happy Birthday\nYou old codger",
#     'from'       => 'Love ME'
# });
#
# $card->merge('here.png');

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

