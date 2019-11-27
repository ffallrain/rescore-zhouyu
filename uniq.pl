#!/usr/bin/perl
use warnings;

$input = $ARGV[0];
$output = $input.".uniq";

open (IN, "$input") or die "";
open (OUT, "> $output") or die "";

@id = ();
@out = ();
while ($line = <IN>)
{
    @dat = split /\s+/, $line;
    $ck = 0;
    foreach $i (@id)
    {
        if ($dat[4] eq $i)
        {
            $ck = 1;
            last;
        }
    }

    if ($ck == 0)
    {
        push @id, $dat[4];
        push @out, $line;
    }
}

print OUT @out;
