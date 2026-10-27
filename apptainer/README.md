# Running apptainer on MacOS with Apple Silicon (M-chip)

Ref: [apptainer.org/docs/admin/main/installation.html#apple-container](https://apptainer.org/docs/admin/main/installation.html#apple-container)

## Download Apple container

**Option 1: Homebrew**

```Shell
brew install container
```

**Option 2: GitHub**

* Download and install the `.pkg`from the [container releases page](https://github.com/apple/container/releases), then start the system:

## Create Apple container

```Shell
# 1. Start system
container system start

# 2. Enter apptainer directory with Dockerfile
cd apptainer
container build -t local/apptainer-rocky:latest .

# 3. Create the machine
container machine create local/apptainer-rocky:latest --name apptainer

# 4. Test machine
container machine run -n apptainer -- apptainer --version
container machine run -n apptainer -- apptainer pull docker://rockylinux/rockylinux:9
container machine run -n apptainer -- apptainer exec rockylinux_9.sif cat /etc/os-release
```

## Shell Integration

```Shell
# 5. Add wrapper functions
cat > ~/.apptainer-machine.zsh << 'EOF'
APPTAINER_MACHINE="${APPTAINER_MACHINE:-apptainer}"

apptainer() {
    if [ "$1" = "build" ]; then
        container machine run -n "$APPTAINER_MACHINE" -- \
            sudo apptainer "$@"
    else
        container machine run -n "$APPTAINER_MACHINE" -- \
            apptainer "$@"
    fi
}

apptainer-vm() {
    container machine run -n "$APPTAINER_MACHINE"
}
EOF

source ~/.apptainer-machine.zsh

# Add to .zshrc
echo '[ -f ~/.apptainer-machine.zsh ] && . ~/.apptainer-machine.zsh' >> ~/.zshrc

# Reload .zshrc
source ~/.zshrc

# 6. Make exectuable
mkdir -p ~/.local/bin

cat > ~/.local/bin/run-singularity << 'SHIM'
#!/bin/sh
. ~/.apptainer-machine.zsh
apptainer run "$@"
SHIM
chmod +x ~/.local/bin/run-singularity
```

## Usage

### Test Installation

```Shell
# For testing installation 
# 1. pull a container with different arch
apptainer pull --arch amd64 docker://ghcr.io/r-lib/rig/ubuntu-22.04-release
# 2. Use container (interactive)
# a. Open VM
apptainer-vm
# b. Run container
apptainer run ubuntu-22.04-release_latest.sif
```

### General use case

> NOTE if you download `test.def`from GitHub (through your browser), then update the extension to `.def`because it may be automatically downloaded as .`txt.`

```Shell
# Building a container
# --arch amd64 needed for H4H (HPC)
apptainer build --force --arch amd64 test.sif test.def
# you may need to add: --ignore-fakeroot-command 

# Use container (interactive)
# 1. Open VM
apptainer-vm
# 2. Run container
apptainer run test.sif

# apptainer run --cleanenv base.sif
```
