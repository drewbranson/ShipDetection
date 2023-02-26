#!/bin/perl

# convert JSON ship locations usefully

require "/home/drew/Documents/GitHub/ShipDetection/scripts/bclib.pl";

my($pi) = 4*atan(1);

# multiply by this number to convert degrees to radians

my($degree) = $pi/180;

# hash to store stuff in

my(%hash); 

# colors based on age (1st elt is 1.0-13.0 days, then 13.0-25.0 days,
# and increasing by 12 until 121

my(@colors) = ("122,4,3", "201,41,3", "245,105,23", "251,185,56",
	       "201,239,52", "116,254,93", "26,229,182", "53,171,249",
	       "70,98,216", "48,18,59");

for $i (glob("../output/data/*.js")) {

    debug("I: $i");

    my($data) = read_file($i);

    # remove variable declaration
    $data=~s/var [a-z0-9_]+ \=\s*//isg;

    my($json);

    eval('$json = JSON::from_json($data);');

    # data/ArabianSea_5.js is broken
    if ($@) {warn("ERROR: $@ on $i"); next;}

    for $j (@{$json->{features}}) {

	my($lng, $lat) = @{$j->{geometry}->{coordinates}};

	my($age) = $j->{properties}->{DaysOld};
	my($color) = $colors[floor(($age-1)/12)];

	# find color index from age
#	debug(floor(($age-1)/12));

	# create tiles to level 6

	for $z (0..10) {
	    my($x, $y, $px, $py) = @{lnglatZ2TileXY($lng, $lat, $z)};

	    # this is truly hideous, but it works
	    $hash{$z}{$x}{$y}{"$px,$py"} = $color;

	}
    }
}

# create the tiles but make sure there's a dir to hold them

unless (-d "TILES") {die "Must have TILES dir";}

for $z (keys %hash) {

    # create a directory for the z level
    unless (-d "TILES/$z") {mkdir("TILES/$z");}

    for $x (keys %{$hash{$z}}) {

	# a subdirectory for the x level
	unless (-d "TILES/$z/$x") {mkdir("TILES/$z/$x");}

	for $y (keys %{$hash{$z}{$x}}) {

	    # create the fly file and populate it
	    open(A, ">TILES/$z/$x/$y.fly");
	    print A "new\nsize 256,256\nsetpixel 0,0,0,0,0\ntransparent 0,0,0\n";

	    for $pt (keys %{$hash{$z}{$x}{$y}}) {

		my($color) = $hash{$z}{$x}{$y}{$pt};
#		debug("COLOR BETA: $color");
#		print A "setpixel $pt,$color\n";
		print A "fcircle $pt,5,$color\n";
	    }
	    close(A);
	}
    }
}

# debug(%hash);

sub lnglatZ2TileXY {

    my($lng, $lat, $z) = @_;

    # The line below does a lot:
    #   - converts latitude to radians
    #   - computes the inverse Gudermannian function
    #   - normalizes the function to go from 0 to 1
    #   - reverse the function to match y increasing = south per OSM
    #   - multiplies by 2^zoomlevel to find the tile number

    my($y) = 2**$z*(1/2-log(tan($lat*$degree) + 1/cos($lat*$degree))/2/$pi);
    
    # longitude is easy, don't even need to convert to rads

    my($x) = ($lng+180)/360*2**$z;

    # to get pixels, we need to look at fractional parts of above

    my($px) = floor(($x-int($x))*256);
    my($py) = floor(($y-int($y))*256);

    # and then toss the fractional parts

    ($x, $y) = (floor($x), floor($y));

    # return the log

    return [$x, $y, $px, $py];

}
