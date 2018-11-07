set -ex

BLOCK_SIZE=512
# These are all in bytes and need to be in multiples of the block size
BOOT_PARTITION_OFFSET=$((2048 * BLOCK_SIZE))
BOOT_PARTITION_LEN=$((500 * (1024 * 1024) - BLOCK_SIZE))

ROOTFS_PARTITION_OFFSET=$((BOOT_PARTITION_OFSET + BOOT_PARTITION_LEN + BLOCK_SIZE))
ROOTFS_PARTITION_LEN=$((5 * (1024 * 1024 * 1024) - BLOCK_SIZE))

FILE_LENGTH=$((ROOTFS_PARTITION_OFFSET + ROOTFS_PARTITION_LEN + BLOCK_SIZE))
FILE_LENGTH_BLOCKS=$((FILE_LENGTH / BLOCK_SIZE ))

TEMP_FILE=./.temp.img
sudo dd if=/dev/zero of=$TEMP_FILE bs=$BLOCK_SIZE count=$FILE_LENGTH_BLOCKS

create_partition() {
  PARTITION_NUMBER=$1
  START_SECTOR=$2
  LAST_SECTOR=$3
  (
    echo n
    echo p
    echo $PARTITION_NUMBER
    echo $START_SECTOR
    echo $LAST_SECTOR
    echo w
   ) | sudo fdisk $TEMP_FILE
}

set_partition_type() {
  PARTITION_NUMBER=$1
  PARTITION_TYPE=$2
  (
    echo t
    echo $PARTITION_NUMBER
    echo $PARTITION_TYPE
    echo w
  ) | sudo fdisk $TEMP_FILE
}

mount_partitions() {
  loop_num=$1
  sync
  sudo mkdir -p /tmp/mnt/boot
  sudo mkdir -p /tmp/mnt/rootfs
  sudo mount /dev/mapper/loop${loop_num}p1 /tmp/mnt/boot
  sudo mount /dev/mapper/loop${loop_num}p2 /tmp/mnt/rootfs
  sync
}

unmount_partitions() {
  sync
  sudo umount /tmp/mnt/boot
  sync
  sudo umount /tmp/mnt/rootfs
  sync
}

# Create the boot partition

create_partition 1 $((BOOT_PARTITION_OFFSET / BLOCK_SIZE)) $((BOOT_PARTITION_LEN / BLOCK_SIZE))

# Create the rootfs partition

create_partition 2 $((ROOTFS_PARTITION_OFFSET / BLOCK_SIZE)) $(((ROOTFS_PARTITION_OFFSET + ROOTFS_PARTITION_LEN) / BLOCK_SIZE))

# Set the disk type of the boot partition to FAT

set_partition_type 1 6

# Create the block devices
ret=$(sudo kpartx -asv $TEMP_FILE)
ret=$(grep -Eo '[[:alpha:]]+|[0-9]+' <<<"$ret")
readarray -t arr <<<"$ret"
loop_num=${arr[3]}
sync

# Create boot filesystem
sudo mkfs.vfat /dev/mapper/loop${loop_num}p1

# Create rootfs filesystem
sudo mkfs.ext4 /dev/mapper/loop${loop_num}p2

mount_partitions $loop_num

sudo cp deploy/images/apalis-imx6/zImage /tmp/mnt/boot/.
sudo cp deploy/images/apalis-imx6/zImage-imx6q-apalis-eval.dtb /tmp/mnt/boot/.
sudo tar -C /tmp/mnt/rootfs/. -xf deploy/images/apalis-imx6/Apalis-iMX6_LXDE-Image.rootfs.tar.xz

unmount_partitions

# Delete the block devices
sudo kpartx -sd $TEMP_FILE
sync

sudo mv $TEMP_FILE ./cytovale_sd.img
sync

