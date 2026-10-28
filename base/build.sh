export APPTAINER_TMPDIR=$PWD/tmp 
mkdir -p $PWD/tmp 
apptainer build --force --arch amd64 --ignore-fakeroot-command base.sif base.def
