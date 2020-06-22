from hpsmc.tools import ExtractEventsWithHitAtHodoEcal, JobManager, LCIOCount, LCIOMerge

job.description = 'tritrig-beam from merge to recon'

# Get job input file targets
inputs = job.input_files.values()

# Input tritrig events (slcio format)
tritrig_file_name = [] 

# Input beam events (slcio format)
beam_file_name = [] 

for input in inputs:
    if "tritrig" in input:
	tritrig_file_name.append(input)
    if "beam" in input:
	beam_file_name.append(input)

# Check for expected input file targets
if len(tritrig_file_name) == 0:
    raise Exception("Missing required input file(s) for tritrig")
if len(beam_file_name) == 0:
    raise Exception("Missing required input file(s) for beam")

# Base name of intermediate tritrig files
tritrig_name = 'tritrig'

# Base name of intermediate beam files
beam_name = 'beam'

# Base name of merged files
tritrig_beam_name = 'tritrig-beam'

# Filter and space signal events and catenate files before merging
filter_events = ExtractEventsWithHitAtHodoEcal(inputs=tritrig_file_name,
                               outputs=['%s_filt.slcio' % tritrig_name], event_interval=250, num_hodo_hits=1)

# Count filtered events
count_filter = LCIOCount(inputs=filter_events.output_files())

# catenate beam files before merging
catenate_beam = ExtractEventsWithHitAtHodoEcal(inputs=beam_file_name,
                               outputs=['%s_filt.slcio' % beam_name], event_interval=0, num_hodo_hits=0)

# Count beam events
count_beam = LCIOCount(inputs=catenate_beam.output_files())

# Merge signal and beam events
merge = LCIOMerge(inputs=[filter_events.output_files()[0],
                          catenate_beam.output_files()[0]],
                  outputs=['%s.slcio' % tritrig_beam_name],
                  ignore_job_params=['nevents'])

# Print number of merged events
count_merge = LCIOCount(inputs=merge.output_files())

# Run simulated events in readout to generate triggers
readout = JobManager(steering='readout',
                     inputs=merge.output_files(),
                     outputs=['%s_readout.slcio' % tritrig_beam_name])

# Print number of readout events
count_readout = LCIOCount(inputs=readout.output_files())

# Run physics reconstruction
recon = JobManager(steering='recon',
                   inputs=readout.output_files(),
                   outputs=['%s_recon.slcio' % tritrig_beam_name])

# Print number of recon events
count_recon = LCIOCount(inputs=recon.output_files())
 
# Add the components
job.add([filter_events, count_filter, catenate_beam,count_beam, merge, 
	count_merge, readout, count_readout, recon, count_recon])

