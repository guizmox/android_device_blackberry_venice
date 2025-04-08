#!/system/bin/sh
# Copyright (c) 2016 The Brobro Foundation
# This is the fuck you placeholder. get rekt
# 
# It basically says don't come bitching to me about 
# your unahappiness with this shit. It wasn't designed to 
# please you. It was designed to please me.
# You are borrowing it. The worst that could happen is
# your fucking battery life diminishes to fucking nothing.
# 

target=`getprop ro.board.platform`
case "$target" in
    "msm8992")
        # disable thermal bcl hotplug to switch governor
        echo 0 > /sys/module/msm_thermal/core_control/enabled
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n disable > $mode
        done
        for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
        do
            bcl_hotplug_mask=`cat $hotplug_mask`
            echo 0 > $hotplug_mask
        done
        for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
        do
            bcl_soc_hotplug_mask=`cat $hotplug_soc_mask`
            echo 0 > $hotplug_soc_mask
        done
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n enable > $mode
        done

	# Disable CPU retention
	echo 0 > /sys/module/lpm_levels/system/a53/cpu0/retention/idle_enabled
	echo 0 > /sys/module/lpm_levels/system/a53/cpu1/retention/idle_enabled
	echo 0 > /sys/module/lpm_levels/system/a53/cpu2/retention/idle_enabled
	echo 0 > /sys/module/lpm_levels/system/a53/cpu3/retention/idle_enabled
	echo 0 > /sys/module/lpm_levels/system/a57/cpu4/retention/idle_enabled
	echo 0 > /sys/module/lpm_levels/system/a57/cpu5/retention/idle_enabled

	# Disable L2 retention
	echo 0 > /sys/module/lpm_levels/system/a53/a53-l2-retention/idle_enabled
	echo 0 > /sys/module/lpm_levels/system/a57/a57-l2-retention/idle_enabled

        # configure governor settings for little cluster
        echo "interactive" > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
        echo 384000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
        # online CPU4
        chown root.root /sys/devices/system/cpu/cpu4/online
        chown root.root /sys/devices/system/cpu/cpu5/online
        echo 1 > /sys/devices/system/cpu/cpu4/online
        echo 1 > /sys/devices/system/cpu/cpu5/online
        chown root.root /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        chown root.root /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
        # configure governor settings for big cluster
        echo "interactive" > /sys/devices/system/cpu/cpu4/cpufreq/scaling_governor
        echo 384000 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_min_freq
        # restore A57's max
        cat /sys/devices/system/cpu/cpu4/cpufreq/cpuinfo_max_freq > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
        cat /sys/devices/system/cpu/cpu5/cpufreq/cpuinfo_max_freq > /sys/devices/system/cpu/cpu5/cpufreq/scaling_max_freq
        # re-enable thermal and BCL hotplug
        echo 1 > /sys/module/msm_thermal/core_control/enabled
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n disable > $mode
        done
        for hotplug_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_mask
        do
            echo $bcl_hotplug_mask > $hotplug_mask
        done
        for hotplug_soc_mask in /sys/devices/soc.0/qcom,bcl.*/hotplug_soc_mask
        do
            echo $bcl_soc_hotplug_mask > $hotplug_soc_mask
        done
        for mode in /sys/devices/soc.0/qcom,bcl.*/mode
        do
            echo -n enable > $mode
        done
        # plugin remaining A57s
        echo 1 > /sys/devices/system/cpu/cpu5/online
        echo 0 > /sys/module/lpm_levels/parameters/sleep_disabled
        # Restore CPU 4 max freq from msm_performance
        echo "4:4294967295 5:4294967295" > /sys/module/msm_performance/parameters/cpu_max_freq

        # core_ctl module
#        insmod /system/lib/modules/core_ctl.ko
#        echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/min_cpus
#        echo 60 > /sys/devices/system/cpu/cpu4/core_ctl/busy_up_thres
#        echo 30 > /sys/devices/system/cpu/cpu4/core_ctl/busy_down_thres
#        echo 100 > /sys/devices/system/cpu/cpu4/core_ctl/offline_delay_ms
#        echo 1 > /sys/devices/system/cpu/cpu4/core_ctl/is_big_cluster
#        echo 2 > /sys/devices/system/cpu/cpu4/core_ctl/task_thres

        # Setting b.L scheduler parameters
        echo 1 > /proc/sys/kernel/sched_migration_fixup
        echo 30 > /proc/sys/kernel/sched_small_task
        echo 20 > /proc/sys/kernel/sched_mostly_idle_load
        echo 3 > /proc/sys/kernel/sched_mostly_idle_nr_run
        echo 99 > /proc/sys/kernel/sched_upmigrate
        echo 85 > /proc/sys/kernel/sched_downmigrate
        echo 400000 > /proc/sys/kernel/sched_freq_inc_notify
        echo 400000 > /proc/sys/kernel/sched_freq_dec_notify
        #enable rps static configuration
        echo 8 >  /sys/class/net/rmnet_ipa0/queues/rx-0/rps_cpus
        for devfreq_gov in /sys/class/devfreq/qcom,cpubw*/governor
        do
            echo "bw_hwmon" > $devfreq_gov
        done
        for devfreq_gov in /sys/class/devfreq/qcom,mincpubw*/governor
        do
            echo "cpufreq" > $devfreq_gov
        done
        # Disable sched_boost
        echo 0 > /proc/sys/kernel/sched_boost

        # Disable retention and standalone power collapse
        echo "N" > /sys/module/lpm_levels/system/a53/cpu0/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu1/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu2/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu3/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu4/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu5/standalone_pc/idle_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu0/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu1/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu2/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a53/cpu3/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu4/standalone_pc/suspend_enabled
        echo "N" > /sys/module/lpm_levels/system/a57/cpu5/standalone_pc/suspend_enabled
    ;;
esac

# Post-setup services
case "$target" in
    "msm8994" | "msm8992")
        rm /data/system/perfd/default_values
        setprop ro.min_freq_0 384000
        setprop ro.min_freq_4 384000
        start perfd
    ;;
esac

case "$target" in
    "msm8994" | "msm8992")
        # Let kernel know our image version/variant/crm_version
        image_version="10:"
        image_version+=`getprop ro.build.id`
        image_version+=":"
        image_version+=`getprop ro.build.version.incremental`
        image_variant=`getprop ro.product.name`
        image_variant+="-"
        image_variant+=`getprop ro.build.type`
        oem_version=`getprop ro.build.version.codename`
        echo 10 > /sys/devices/soc0/select_image
        echo $image_version > /sys/devices/soc0/image_version
        echo $image_variant > /sys/devices/soc0/image_variant
        echo $oem_version > /sys/devices/soc0/image_crm_version
        ;;
esac

# Added modifications by warBeard
# 
# IO for device and msd
# (switch to cfq sched, set read ahead
echo 256 > /sys/block/mmcblk0/bdi/read_ahead_kb
echo "cfq" > /sys/block/mmcblk0/queue/scheduler
echo 16 > /sys/block/mmcblk0/queue/iosched/back_seek_max
echo 512 > /sys/block/mmcblk1/bdi/read_ahead_kb
echo "cfq" > /sys/block/mmcblk1/queue/scheduler
echo 16 > /sys/block/mmcblk1/queue/iosched/back_seek_max

# Tuning Transmission Control Protocols.
echo "cubic" > /proc/sys/net/ipv4/tcp_congestion_control
echo 1 > /proc/sys/net/ipv4/tcp_timestamps
echo 1 > /proc/sys/net/ipv4/tcp_sack
echo 1 > /proc/sys/net/ipv4/tcp_window_scaling

# Reduce swappiness
echo 10 > /proc/sys/vm/swappiness
# Increase cache buffers slightly
echo 20 > /proc/sys/vm/dirty_background_ratio
echo 40 > /proc/sys/vm/dirty_ratio
# Adjust CPU parameters for a53 cluster
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
chmod 777 /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_target_load
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
echo "10000 1248000:40000" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
echo 20 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
echo 10000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
echo 20000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
echo 460800 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
echo 1 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
echo "40 864000:60 1248000:80" > /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
echo 30000 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
echo 0 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
echo 70 > /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_target_load
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_sched_load
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/use_migration_notif
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/above_hispeed_delay
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/go_hispeed_load
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_rate
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/timer_slack
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/hispeed_freq
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/io_is_busy
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/target_loads
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/min_sample_time
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/max_freq_hysteresis
chmod 555 /sys/devices/system/cpu/cpu0/cpufreq/interactive/gpu_target_load
# Adjust CPU parameters for a57 cluster
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_sched_load
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/use_migration_notif
echo "10000 1536000:40000" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/above_hispeed_delay
echo 20 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/go_hispeed_load
echo 10000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_rate
echo 20000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/timer_slack
echo 633600 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/hispeed_freq
echo 1 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/io_is_busy
echo "40 864000:60 1248000:80 1536000:90" > /sys/devices/system/cpu/cpu4/cpufreq/interactive/target_loads
echo 30000 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/min_sample_time
echo 0 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/max_freq_hysteresis
echo 70 > /sys/devices/system/cpu/cpu4/cpufreq/interactive/gpu_target_load
# Adjust input and multi boost parameters
echo "0:864000 1:864000 2:864000 3:864000 4:864000 5:864000" > /sys/module/cpu_boost/parameters/input_boost_freq
echo 40 > /sys/module/cpu_boost/parameters/input_boost_ms
echo "0:864000 1:864000 2:864000 3:864000 4:864000 5:864000" > /sys/module/cpu_boost/parameters/multi_boost_freq
chmod 555 /sys/module/cpu_boost/parameters/input_boost_freq
chmod 555 /sys/module/cpu_boost/parameters/multi_boost_freq
# Option to change GPU governor, remove #
# echo "simple_ondemand" > /sys/devices/soc.0/fdb00000.qcom,kgsl-3d0/devfreq/fdb00000.qcom,kgsl-3d0/governor