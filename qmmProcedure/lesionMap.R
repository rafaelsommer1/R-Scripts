library(fslr)
library(oasis)
library(neurobase)
library(papayar)

# Read command line arguments
args <- commandArgs(trailingOnly = TRUE)
wd <- getwd()
t1 <- paste0 (wd, "/", "args[1]")
t2 <- paste0 (wd, "/", "args[2]")
flair <- paste0 (wd, "/", "args[3]")

# Read anatomical files
t2 <- readnii(t2)
flair <- readnii(flair)
t1 <- readnii(t1)

# Create t1 mask
mask <- fslbet(t1, "t1_brain", opts = "-m -f 0.2")

# Read mask
brainmask <- readnii("t1_brain_mask.nii.gz")

# Run OASIS preproc
preproc <- oasis_preproc(flair, t1, t2, brain_mask = brainmask)

# Write processed files
writenii(preproc$flair, filename = "flair_proc")
writenii(preproc$t2, filename = "t2_proc")
writenii(preproc$t1, filename = "t1_proc")
writenii(preproc$brain_mask, filename = "mask")

# Train DF
df <- oasis_train_dataframe(flair = preproc$flair,
                            t1 = preproc$t1,
                            t2 = preproc$t2,
                            brain_mask = brainmask,
                            eroder = "oasis")
# Save DF
oasis_dataframe <- df$oasis_dataframe
brain_mask <- df$brain_mask
top_voxels <- df$voxel_selection

# Predict lesions
predictions = predict( oasis::nopd_oasis_model,
        newdata = oasis_dataframe,
        type = 'response')
pred_img = niftiarr(brain_mask, 0)
pred_img[top_voxels == 1] = predictions
# Create probability map
prob_map = fslsmooth(pred_img, sigma = 1.25,
                     mask = brain_mask, retimg = TRUE,
                     smooth_mask = TRUE)
# Create binary map
threshold = 0.22
binary_map = prob_map > threshold

# Write maps
write_nifti(prob_map, "prob_map")
write_nifti(binary_map, "bin_map")
