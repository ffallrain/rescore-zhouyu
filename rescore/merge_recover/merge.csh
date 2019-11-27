#!/bin/csh
#
#to merge rescoring outputs
#
#modified on Feb.24th, 2009

if($#argv >= 1) then
foreach i (`seq 1 $#argv`)
	set tdir = `basename $argv[$i]`
	echo "processing $argv[$i]"
	cd $argv[$i]
	foreach j (*)
		if(-d "$j") then
			cd $j
			rm -r data fort.2 $j.pdb.gz
			foreach het (???.het.gz)
				echo $het >> het
				zcat $het >> het
				rm $het
			end
			foreach para (???.gz)
				echo $para >> para
				zcat $para >> para
				rm $para
			end
			cd log_files
			foreach type (ligmin cmxmin ligfix)
				foreach file (*_$type.log.gz)
					echo $file >> $type.log
            	    zcat $file >> $type.log
					rm $file
				end
			end
			cd ../out_files
			foreach type (ligmin.out cmxmin.lig)
				foreach file (*_$type.gz)
					echo $file >> $type
            	    zcat $file >> $type
					rm $file
				end
			end
			cd ../..
		endif
	end
	cd ..
	tar czf $tdir.tar.gz $tdir
	rm -r $tdir
end
else
	echo "\n   Please enter directory names(e.g. /tmp/decoys)\n"
	exit(1)
endif
