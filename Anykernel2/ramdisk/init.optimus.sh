#!/system/bin/sh

# custom busybox installation shortcut
bb=/sbin/bb/busybox;

# Set TCP westwood
echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control

# Set IOSched
echo "bfq" > /sys/block/mmcblk0/queue/scheduler
echo "512" > /sys/block/mmcblk0/bdi/read_ahead_kb

