library(oro.nifti)
library(fslr)

qmm <- readNIfTI("qmm_brain.nii.gz")

NLD <- ((max(qmm) - qmm) / (max(qmm)-min(qmm[qmm>0])) ) * 100
mask = NLD < 2500

NLD_masked = NLD * mask
writeNIfTI(NLD_masked, "nld_masked")
