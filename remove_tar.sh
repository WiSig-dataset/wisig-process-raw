#!/usr/bin/env bash
set -xe




destFldr='wifi_2021_03_01/'

cd $destFldr
for rx in ./*; do
   cd $rx
   rm *.tar
   cd ..
done 


