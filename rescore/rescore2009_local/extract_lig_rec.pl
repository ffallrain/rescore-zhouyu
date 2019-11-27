#!/usr/bin/perl -w
# extract the minimized ligand from the rec-lig complex
# Niu, march, 2004

$infile = $ARGV[ 0 ];
$outlig = $ARGV[ 1 ];
$outrec = $ARGV[ 2 ];

open( INFILE, "$infile") || die "could not open $infile";
open( OUTLIG, ">$outlig") || die "could not open $outlig";
open( OUTREC, ">$outrec") || die "could not open $outrec";

print OUTLIG "TER\n";

while(<INFILE>) {
 if(/^HETATM/) {
  $chn = substr($_,21,1);
  $resnum = substr($_,23,3);

  if (($chn eq ' ') and ($resnum eq '  1')) {
    printf OUTLIG "%s",$_; 
  }
  else {
    printf OUTREC "%s",$_;
  } 
 }
 else {
  printf OUTREC "%s",$_;
 }
}

close INFILE;
close OUTLIG;
close OUTREC;
