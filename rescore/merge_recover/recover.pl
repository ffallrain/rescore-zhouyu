#!/usr/bin/perl -w
#
#to split file by *.gz
#
#modified on Mar.11th, 2009

$infile = $ARGV[0];
open(IN, "$infile") || die("unable to open input: $infile");
while($in = <IN>)
{
	if($in =~ /(\S+)\.gz/)
	{
		close(OUT) if(defined($outfile)); 
		$outfile = $1;
		open(OUT, ">$outfile") || die("unable to create output: $outfile");
	}
	else
	{
		print OUT $in;
	}
}
close(IN);
close(OUT);
