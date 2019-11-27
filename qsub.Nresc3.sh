#!/bin/bash

#ls -d *.gz |awk -F. '{print $1}' > db.list;

for i in $(cat db.list);
do
	cd $i;
	~/zhouyu_rescore/rescore/after_rescore/calculate_binding_energy.pl pose
	~/zhouyu_rescore/rescore/after_rescore/extract_from_decoys.pl pose 1000		# pose can be replaced by $i  ?
	cd ..;
done

date
hostname
