#!/bin/bash

#ls -d *.gz |awk -F. '{print $1}' > db.list;

#zgrep -n energy filtered2.eel1.gz |awk '{print $2}' > db.list;

#for i in $(cat db.list);
#do

#~/zhouyu_rescore/para_gen2005/para_gen_opls2005.pl $i $i*.gz opel . 200

~/zhouyu_rescore/para_gen2005/para_gen_opls2005.pl decoys filtered2.eel1.gz opel . 200

#done

date
hostname
