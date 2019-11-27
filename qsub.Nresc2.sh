#!/bin/bash

#ls -d *.gz |awk -F. '{print $1}' > db.list;

for i in $(cat db.list);
do
	cd $i;
	rm -r *tmp;
	cp ../rec_h_* .
	 ~/zhouyu_rescore/rescore/rescore2009/super_submit_2009.csh job_$i opls 2005 opel
	cd ..;
done

date
hostname
