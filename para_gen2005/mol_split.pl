#!/usr/bin/perl
use warnings;

if (@ARGV != 3) 
{
    die "Useage: ./test.eel1_split.pl  Input(test.eel1.gz)  Number(no. of ligands in each dir, <=1000)  Output(e.g., decoys)\n";
}

$infile = $ARGV[0];
$number = $ARGV[1];
$outdir = $ARGV[2];

$name = "decoys";
$count = $number - 1;
$index = 0;

mkdir "$outdir", 0755 or warn "";
open (IN, "gzip -dc $infile |") or die "Can not open .gz file $infile !\n";
# open (IN, "$infile") or die "Can not open file $infile\n";

while ($line = <IN>)
{
    if ($line =~ /^REMARK/)
    {
        if ($line =~ /energy/)
        {
            $count ++;
            if ($count > $number - 1)			# a new dir which contains $number poses for rescoring (index)
            {
                $index ++;
                $index_tmp = "00000".$index;
                $index_tmp = substr($index_tmp, -6);
                mkdir "$outdir/$name.$index_tmp", 0755 or warn "";
                open (LIST, "> $outdir/$name.$index_tmp/list") or die "";
                open (NAME, "> $outdir/$name.$index_tmp/namelist") or die "";

                $count = $count - $number;
            }

            $count_tmp = "000".$count;		# a new pose (count)
            $count_tmp = substr($count_tmp, -3);
            open (OUT, "> $outdir/$name.$index_tmp/$count_tmp.het") or die "";

            $zincid = substr($line, 7, 9);	# list and namelist
            print LIST "$count_tmp\n";
            print NAME "$zincid\n";
        }
    }

    elsif ($line =~ /^ATOM/)
    {
        substr($line, 0, 6) = "HETATM";
        substr($line, 17, 3) = $count_tmp;
        substr($line, 22, 4) = "   1";
        substr($line, 54) = "  1.00";		# in dock it is charge, but PDB format it is occupancy, PLOP will not recognizeit
        print OUT $line, "\n";
    }

    elsif ($line =~ /^TER/)
    {
        close (OUT);
    }

    else
    {
        die "Unexpected record:\n$line";
    }
}
