#!/bin/sh
hps-mc-batch pool -p 5 -d $PWD/scratch -l $PWD/logs -c .hpsmc -r 1:10 aprime_gen jobs.json
