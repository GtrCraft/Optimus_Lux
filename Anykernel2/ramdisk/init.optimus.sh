#!/system/bin/sh

# custom busybox installation shortcut
bb=/sbin/bb/busybox;

# Set TCP westwood
echo "westwood" > /proc/sys/net/ipv4/tcp_congestion_control

# Set IOSched
echo "bfq" > /sys/block/mmcblk0/queue/scheduler
echo "512" > /sys/block/mmcblk0/bdi/read_ahead_kb

# CPU BOOST
echo "40" > /sys/module/cpu_boost/parameters/input_boost_ms
echo "1094400" > /sys/module/cpu_boost/parameters/input_boost_freq
echo "20" > /sys/module/cpu_boost/parameters/boost_ms
echo "998400" > /sys/module/cpu_boost/parameters/sync_threshold
