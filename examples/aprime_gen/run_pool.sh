#!/bin/sh
hps-mc-batch pool -p 30 -d /scratch/hps -l /scratch/hps/logs -c .hpsmc -c ~/.hpsmc aprime_gen jobs.json
