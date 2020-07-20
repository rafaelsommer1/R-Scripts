#!/bin/bash

# Extract mask from raw qmm file
bet qmm_raw -f 0.25 -m qmm_raw_brain

# Apply mask to qMM after editing header
fslmaths qmm -mul qmm_raw_brain_mask qmm_brain

# Apply normalisation
Rscript qmm2nld.R