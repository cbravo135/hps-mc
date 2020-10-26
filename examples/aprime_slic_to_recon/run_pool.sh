#!/bin/sh
hps-mc-batch pool -o -r 1:1000 -p 28 -d /scratch/hps -l /scratch/hps/logs -c ~/.hpsmc -c .hpsmc aprime_slic_to_recon jobsIter4.json
