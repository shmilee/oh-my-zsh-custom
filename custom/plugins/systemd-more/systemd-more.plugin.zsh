# more simplified systemd command

local systemd_commands=(
    analyze ask-password cat cgls cgtop delta detect-virt escape firstboot
    hwdb inhibit machine-id-setup mount notify nspawn path resolve run
    socket-activate stdio-bridge sysusers tmpfiles tty-ask-password-agent umount)

if systemd-notify --booted 2>/dev/null; then
    alias jc='journalctl'
    alias sc-wants='systemctl show -p "Wants"'
    alias sc-failed='systemctl --failed'
    for c in $systemd_commands; do; alias sd-$c="systemd-$c"; done
fi
