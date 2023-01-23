# this is really ugly-- it creates the PNG files from the fly files (do "tcsh runme.tcsh 1" to run)

if $argv[1] == 1 then

find TILES -iname '*.fly' | perl -nle 's/\.fly//; if (-M "$_.fly" < -M "$_.png" || !(-s "$_.png")) {print "echo $_; fly -q -i $_.fly -o $_.png"}'

endif
