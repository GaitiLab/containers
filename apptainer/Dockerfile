FROM docker.io/rockylinux/rockylinux:9

RUN dnf -y install epel-release && \
    dnf swap -y curl-minimal curl && \
    dnf -y install \
        systemd systemd-libs dbus sudo \
        ca-certificates wget procps-ng vim-minimal man-db \
        iproute iputils \
        apptainer \
        squashfs-tools squashfuse fuse-overlayfs fuse3 \
        libseccomp shadow-utils cryptsetup openssl fakeroot && \
    dnf clean all
RUN yum -y install docker && \
    yum clean all

RUN cat >/etc/systemd/system/register-binfmt.service <<'EOF'
[Unit]
Description=Mount binfmt_misc and register QEMU handlers
After=network-online.target
Wants=network-online.target

[Service]
Type=oneshot

# Mount binfmt_misc if it isn't already mounted
ExecStartPre=-/usr/bin/mount -t binfmt_misc binfmt_misc /proc/sys/fs/binfmt_misc

# Register amd64 emulation
ExecStart=/usr/bin/podman run --privileged --rm docker.io/tonistiigi/binfmt --install amd64

RemainAfterExit=yes

[Install]
WantedBy=multi-user.target
EOF

# /dev/fuse is root-only by default; unprivileged Apptainer mounts need it writable.
RUN mkdir -p /etc/udev/rules.d && \
   echo 'KERNEL=="fuse", MODE="0666"' > /etc/udev/rules.d/99-fuse.rules && \
   printf '[Unit]\nDescription=Fix /dev/fuse permissions\nDefaultDependencies=no\nAfter=systemd-udevd.service\n\n[Service]\nType=oneshot\nExecStart=/usr/bin/chmod 0666 /dev/fuse\n\n[Install]\nWantedBy=sysinit.target\n' > /etc/systemd/system/fix-fuse-perms.service && \
   systemctl enable fix-fuse-perms.service

RUN >/etc/machine-id && \
   mkdir -p /var/lib/dbus && >/var/lib/dbus/machine-id
RUN systemctl set-default multi-user.target && \
    systemctl enable register-binfmt.service && \
    systemctl mask \
      dev-hugepages.mount \
      sys-fs-fuse-connections.mount \
      systemd-update-utmp.service \
      systemd-tmpfiles-setup.service \
      console-getty.service \
      getty@.service \
      systemd-logind.service

STOPSIGNAL SIGRTMIN+3
CMD ["/sbin/init"]
