These are scripts to create the equalized Id signals.

You need to  change the folder location in equalize_dataset.m to the location of a single day capture.

This script assumes that you already ran the detection and screening and that the "packets" folder already exits.

The ouptut is "equalized_packets". It only contains the first 256 samples of each signal and not the entire packet.
