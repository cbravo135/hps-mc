#!/bin/sh
hps-mc-batch auger -D -c .hpsmc -W 4 -l $PWD/logs beam_gen_to_slic jobs.json
