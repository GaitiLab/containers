rsync -a \
    --exclude='data/' \
    --exclude='.git/' \
    --exclude='tests/' \
    --exclude='*.pyc' \
	--exclude='deployment_testing/' \
    off-target-probe-tracker/ \
    off-target-probe-tracker-build/

apptainer build --arch amd64 opt.sif opt.def

rm off-target-probe-tracker-build