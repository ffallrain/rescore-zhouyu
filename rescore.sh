#!/bin/bash
mkdir $1
cd $1
cp ../../test/FQY/rec_h_opt.* ./
cp ../../$1/Run1.eel1.gz  ./
~/zhouyu_rescore/para_gen2005/para_gen_opls2005.pl RP$1 Run1.eel1.gz ford ./ 50 
cd ../..
