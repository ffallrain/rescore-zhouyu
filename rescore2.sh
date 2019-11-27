#!/bin/bash
cd $1/
cd RP$1/
rm -r *tmp
cp ../rec_h_opt.* ./
~/zhouyu_rescore/rescore/rescore2009/super_submit_2009.csh R$1 opls 2009 opel
cd ..
cd ..
