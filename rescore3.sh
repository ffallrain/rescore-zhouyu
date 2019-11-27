#!/bin/bash
cd $1/
cd RP$1/
~/zhouyu_rescore/rescore/after_rescore/calculate_binding_energy.pl R$1
cd ..
cd ..
