from hpsmc.generators import MG5, StdHepConverter
from hpsmc.tools import SLIC, JobManager, FilterBunches, BeamCoords, AddMother, ExtractEventsWithHitAtHodoEcal

job.description = 'aprime slic to recon'

# Simulate detector response via slic
slic = SLIC()

# insert empty bunches expected by pile-up simulation
#filter_bunches = FilterBunches()
filter_bunches = ExtractEventsWithHitAtHodoEcal()

# Run simulated events in readout to generate triggers
readout = JobManager(steering='readout')
#, append_tok='readout'

# Run physics reconstruction
recon = JobManager(steering='recon')
#, append_tok='recon'

# Set persistency tag for final output file
job.ptag('sim', 'aprime.slcio')
job.ptag('readout', 'aprime_filt_readout.slcio')
job.ptag('recon', 'aprime_filt_readout_recon.slcio')
 
# Add job components
job.add([slic, filter_bunches, readout, recon])
