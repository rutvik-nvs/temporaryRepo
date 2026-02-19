#!/bin/bash
# Exit immediately if a command fails (Don't break the AMI)
set -e

# 1. Create the Storage Space
pvcreate /dev/nvme1n1
vgcreate vg_system /dev/nvme1n1

# 2. Carve the Logical Volumes
lvcreate -L 10G   -n lv_home     vg_system
lvcreate -L 8G   -n lv_tmp      vg_system
lvcreate -L 32G   -n lv_opt      vg_system
lvcreate -L 10G   -n lv_var      vg_system
lvcreate -L 8G   -n lv_var_log  vg_system
lvcreate -L 2G   -n lv_var_tmp  vg_system
lvcreate -L 2G   -n lv_audit    vg_system
lvcreate -l 100%FREE   -n lv_weka     vg_system

# 3. Format the Slices (Format as XFS - RHEL standard)
mkfs.xfs /dev/vg_system/lv_home
mkfs.xfs /dev/vg_system/lv_tmp
mkfs.xfs /dev/vg_system/lv_opt
mkfs.xfs /dev/vg_system/lv_var
mkfs.xfs /dev/vg_system/lv_var_log
mkfs.xfs /dev/vg_system/lv_var_tmp
mkfs.xfs /dev/vg_system/lv_audit
mkfs.xfs /dev/vg_system/lv_weka

# 4. Move the Data
# We do this for /var because it contains existing logs/data
mkdir /mnt/temp_var
mount /dev/vg_system/lv_var /mnt/temp_var
rsync -aqxP /var/ /mnt/temp_var/ || { 
    # If rsync fails, check if it's code 24
    if [ $? -eq 24 ]; then
        echo "Warning: Some files vanished during transfer (code 24)."
    else
        # If it's any other error code, exit for real
        exit $?
    fi
}
umount /mnt/temp_var

# 5. Update the (/etc/fstab)
# This tells RHEL to mount these at boot time
cat <<EOF >> /etc/fstab
/dev/mapper/vg_system-lv_home      /home           xfs     defaults        0 0
/dev/mapper/vg_system-lv_tmp       /tmp            xfs     defaults        0 0
/dev/mapper/vg_system-lv_opt       /opt            xfs     defaults        0 0
/dev/mapper/vg_system-lv_var       /var            xfs     defaults        0 0
/dev/mapper/vg_system-lv_var_log   /var/log        xfs     defaults        0 0
/dev/mapper/vg_system-lv_var_tmp   /var/tmp        xfs     defaults        0 0
/dev/mapper/vg_system-lv_audit     /var/log/audit  xfs     defaults,x-mount.mkdir        0 0
/dev/mapper/vg_system-lv_weka      /opt/weka       xfs     defaults,x-mount.mkdir        0 0
EOF

# 6. Apply the Mounts immediately
mount -a
systemctl daemon-reload

touch /.autorelabel
