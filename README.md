## Overview
These are the files used to process the WiFi captures to obtain identification signals for the [WiSig dataset](https://cores.ee.ucla.edu/downloads/datasets/wisig).. 

## Citation
If you use this code in your research please cite
> S. Hanna, S. Karunartne, and D. Cabric, “WiSig: A Large-Scale WiFi Signal Dataset for Receiver and Channel Agnostic RF Fingerprinting,” arXiv:2112.15363 [eess], Dec. 2021, Accessed: Jan. 03, 2022. [Online]. Available: http://arxiv.org/abs/2112.15363

## Steps
###  1) Download Files from google drive


There are 4 days. For each day there is a folder per rx. For each Rx there are 9 tar files, each files contains captures from up to 20 transmitters.

a - Using google backup and sync
The easiest way to add to your drive then use google backup and sync (or any equivalent software for linux).
Open the [google drive link](https://drive.google.com/drive/folders/148dJpioM1Go65cNdZehl4cu3aY6N8lqq?usp=sharing).
Click on the folder name, then add shortcut to drive. Then configure google backup and sync to install it on your computer

b - Using links
This approach is more useful if you want to download only specific files.
Open the link provider folder. There a jupyter notebook that can provide you with the days, the rx, and tx_file groups that you want. It provides you with google drive links. You need to use a download manager to download them.

###  2) Untar files

The download files are compressed. Run the `untar_downloads.sh` script to untar them. Then run `remove_tar.sh` to delete the compressed files.

###  3) Packet detection and length screening

Detection and screeing is performed using matlab. Open matlab_detection_screening and follow the readme instructions. This step outputs .mat files containing an entire packet for each tx-rx pairs.


### 4) Equalization

This step is optional and is performed in matlab. Open matlab_equalization  and follow the instructions. This step generates a .mat file containing only the preamble for each tx-rx pairs.

### 5) Create python pkl files

In this step, we create a pkl file for each rx. It can be applied to the non-equalized or equalized data. This is performed using a jupyter notebook.
The output of this step is the Full WiSig dataset


