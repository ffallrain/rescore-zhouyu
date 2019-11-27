#!/usr/bin/perl -w
# extract the minimized ligand from the prot-lig complex
# Niu, march, 2004

$infile = $ARGV[ 0 ];
$outlig = $ARGV[ 1 ];

open( INFILE, "$infile") || die "could not open $infile";
open( OUTLIG, ">$outlig") || die "could not open $outlig";

print OUTLIG "TER\n";

while(<INFILE>) {
  if(/^HETATM/) {

  $chn = substr($_,21,1);
  $resnum = substr($_,23,3);

  if (($chn eq ' ') and ($resnum eq '  1')) {
  printf OUTLIG "%s",$_; 
  }
 
  }
}

close INFILE;
close OUTLIG;
