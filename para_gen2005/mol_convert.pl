#!/usr/bin/perl
use warnings;

##########################################################################
$schrodinger_path = "/pubhome/yzhou/Software/schrodinger_2006";
##########################################################################

$file = $ARGV[0];
chdir "$file";
chomp($number = `ls | grep het | wc -l`);

foreach $i (0..$number-1)
{
    $index = "000".$i;
    $index = substr($index, -3);
    `$schrodinger_path/utilities/pdbconvert -ipdb $index.het -omae $index.mae`;
    `$schrodinger_path/utilities/hetgrp_ffgen 2005 $index.mae`;
    `rm $index.mae`;
    `gzip $index.het $index`;
}
