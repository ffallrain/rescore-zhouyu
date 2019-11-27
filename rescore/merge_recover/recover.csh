#!/bin/csh
#
#to re-split merged rescoring outputs
#
#modified on Mar.11th, 2009

set script_dir = '/home/sheng/local/bin/scripts'

if($#argv >= 1) then
foreach i (`seq 1 $#argv`)
	set tdir = `basename $argv[$i] .tar.gz`
	set pdir = `dirname $argv[$i]`
	echo "parent directory: $pdir\nprocessing $tdir.tar.gz"
	cd $pdir
	tar xzf $tdir.tar.gz
	cd $tdir
	foreach j (*)
		if(-d "$j") then
			cd $j
			$script_dir/recover.pl het
			$script_dir/recover.pl para
			rm het para
			cd log_files
			foreach type (ligmin cmxmin ligfix)
				$script_dir/recover.pl $type.log
				rm $type.log
			end
			cd ../out_files
			foreach type (ligmin.out cmxmin.lig)
				$script_dir/recover.pl $type
				rm $type
			end
			cd ../..
		endif
	end
	cd ..
	rm $tdir.tar.gz
end
else
	echo "\n   Please enter package names(e.g. /tmp/decoys.tar.gz)\n"
	exit(1)
endif
