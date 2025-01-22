if [ $(whoami) != "root" ]; then
    echo "
    ⚠️ 请使用 [ROOT] 权限运行该脚本 ⚠️
    "
    exit 1
fi

echo "
===[❄️挂载及冻结状态查询 By: JARK006❄️]===

==============[ 系统信息 ]==============
安卓版本 $(getprop ro.build.version.release) (API $(getprop ro.build.version.sdk))
内核版本 $(uname -r)"

echo "
==============[ 挂载状态 ]=============="

if [ -e /sys/fs/cgroup/uid_0/cgroup.freeze ]; then
    echo "✔️已挂载 FreezerV2(UID)"
else
    echo "❌不支持 FreezerV2(UID)"
fi

if [[ -e /sys/fs/cgroup/frozen/cgroup.freeze ]] && [[ -e /sys/fs/cgroup/unfrozen/cgroup.freeze ]]; then
    echo "✔️已挂载 FreezerV2(FROZEN)"
else
    echo "❌不支持 FreezerV2(frozen)"
fi

if [ -e /sys/fs/cgroup/freezer/perf/frozen/freezer.state ]; then
    echo "✔️已挂载 FreezerV1(FROZEN)"
fi

v1Info=$(mount | grep freezer | awk '{print "✔️已挂载 FreezerV1: ",$3}')
if [ ${#v1Info} -gt 2 ]; then
    echo "$v1Info"
fi

status=$(ps -A | grep -E "refrigerator|do_freezer|signal" | awk '{print $6 " " $9}')
status=${status//"__refrigerator"/"❄️FreezerV1冻结中:"}
status=${status//"do_freezer_trap"/"❄️FreezerV2冻结中:"}
status=${status//"do_signal_stop"/"🧊SIGSTOP冻结中:"}
status=${status//"get_signal"/"❄️不完整V2冻结中:"}

if [ ${#status} -gt 2 ]; then
    echo "
==============[ 冻结状态 ]==============
$status
"
else
    echo "暂无冻结状态的进程"
fi
