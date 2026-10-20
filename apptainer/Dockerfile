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

# Apple already grants your primary user passwordless sudo; uncomment for others.
# RUN echo 'ALL ALL=(ALL:ALL) NOPASSWD: ALL' > /etc/sudoers.d/nopasswd && \
#    chmod 0440 /etc/sudoers.d/nopasswd

# /dev/fuse is root-only by default; unprivileged Apptainer mounts need it writable.
RUN mkdir -p /etc/udev/rules.d && \
   echo 'KERNEL=="fuse", MODE="0666"' > /etc/udev/rules.d/99-fuse.rules && \
   printf '[Unit]\nDescription=Fix /dev/fuse permissions\nDefaultDependencies=no\nAfter=systemd-udevd.service\n\n[Service]\nType=oneshot\nExecStart=/usr/bin/chmod 0666 /dev/fuse\n\n[Install]\nWantedBy=sysinit.target\n' > /etc/systemd/system/fix-fuse-perms.service && \
   systemctl enable fix-fuse-perms.service

RUN >/etc/machine-id && \
   mkdir -p /var/lib/dbus && >/var/lib/dbus/machine-id

RUN systemctl set-default multi-user.target && \
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
