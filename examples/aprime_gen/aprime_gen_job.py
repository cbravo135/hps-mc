"""
Job script to generate A-prime events, convert to StdHep, and apply transformations.
"""

from hpsmc.generators import MG4, StdHepConverter
from hpsmc.tools import Unzip, StdHepTool, DisplaceTime, BeamCoords, AddMother

job.description = 'A-prime generation using MadGraph'

# Generate A-prime events using MadGraph4
ap = MG4(name="ap", event_types=['unweighted'])

# Unzip the LHE events to a local file
unzip = Unzip()

# Create a stdhep file, displacing the time of decay using EGS5
cnv = StdHepConverter(name="lhe_uniform")

# Add mother particle to tag trident particles
mom = AddMother()

# Rotate events into beam coordinates and move the vertices
rotate = BeamCoords()

# Add components to the job
job.add([ap, unzip, cnv, mom, rotate])
