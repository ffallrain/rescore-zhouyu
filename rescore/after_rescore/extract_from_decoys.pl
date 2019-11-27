#!/usr/bin/perl
#from C Huang
#modified on May 4th, 2009

$ntop = 500;
$curdir = `pwd`;
chop($curdir);
$rm = "";
if(0 == $#ARGV)
{
	$jobname=$ARGV[0];
}
elsif(1 == $#ARGV)
{
	($jobname, $ntop) = @ARGV;
}
else
{
	print "\n   Usage: extract_from_decoys.pl jobname [max_number_of_structures_to_extract(default: 500)]\n\n";
	exit();
}

$top = `head -n $ntop output.$jobname.sorted`;
@read = split(/\n/, $top);
$line=@read;

mkdir("cmxmin") if(! -d "cmxmin");

open PDB,">$jobname-cmxminlig.pdb"or die"No $jobname-cmxminlig.pdb";
for($i=0;$i<$line;$i++){

 @split_1=split(/\s/,$read[$i]);
 $dir="$split_1[2]";
 chop($subdir = `basename $dir`);
 chop($parentdir = `dirname $dir`);
 chdir($parentdir) || die("unable to cd to $parentdir");
 $tar = "$subdir.tar.gz";
 if(!-d "$subdir")
 {
	 $rm .= "$dir;";
 	`tar xzf $tar`;
 }
 chdir($curdir) || die("unable to cd to $curdir"); 
 $lig=$split_1[3];
 $number=$i+1;
 open(SEP,">>cmxmin/$subdir-cmxminlig.pdb") || die("unable to append to cmxmin/$subdir-cmxminlig.pdb"); 
 print PDB "REMARK $number energy = $split_1[1]  $split_1[4]  $dir/$split_1[3]\n";
 print SEP "REMARK $number energy = $split_1[1]  $split_1[4]  $dir/$split_1[3]\n";
 
 $ck = -1;
 open(HET,"$dir/out_files/cmxmin.lig") or die("No $dir/out_files/cmxmin.lig\n");
 READ:while($read = <HET>)
 {
	 if($read =~ /$lig\_cmxmin.lig.gz/)
	 {
		 $ck =1;
	 }
	 else
	 {
		 if(1 == $ck)
		 {
			 if($read =~ /^HETATM/)
			 {
		 		substr($read,0,6,"ATOM  ");
		 		print PDB $read;
		 		print SEP $read;
			 }
			 else
			 {
				 if($read =~ /cmxmin.lig.gz/)
				 {
				 	print PDB "TER\n";
				 	print SEP "TER\n";
					$ck = 2;
				 	last READ;
				 }
			 }
		 }
	 }
 }
 if(1 == $ck)
 {
	 print PDB "TER\n";
	 print SEP "TER\n";
 }
 close(HET);
 close(SEP); 
}
close PDB;

#print "allrm: $rm\n";
foreach $tmprm (split(/;/, $rm))
{
	`rm -r $tmprm/`;
	#print "rm -r $tmprm\n";
}
