#!/usr/bin/perl -w

use strict;
use lib qw(lib);

use Leo::Site::Model::Card;

my $card = Leo::Site::Model::Card->new({
    'image'      => 'cat_01.png',
    'background' => 'bg_blue.png',
    'forground' => 'flowers_orange_trans.png',
    # 'forground'  => 'flowers_orange.png',
    'to'         => 'Dear fred',
    'message'    => "Happy Birthday\nYou old codger",
    'from'       => 'Love ME'
});

$card->merge('here.png');