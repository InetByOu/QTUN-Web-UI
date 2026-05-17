#!/system/bin/sh

MODDIR="/data/adb/modules/qtun_tunneling"

QTUN_DIR="/data/adb/QTUN"
SCRIPTS="$QTUN_DIR/scripts"

RUN_DIR="$QTUN_DIR/run"
RUNLOG="$RUN_DIR/run.log"

PIDFILE="$RUN_DIR/clash.pid"

STATUS_FILE="$RUN_DIR/status"

mkdir -p "$RUN_DIR"

log() {
    echo "[$(date '+%H:%M:%S')] $1" >> "$RUNLOG"
}

set_status() {
    echo "$1" > "$STATUS_FILE"
}

is_running() {

    if [ -f "$PIDFILE" ]; then

        PID="$(cat "$PIDFILE" 2>/dev/null)"

        if [ -n "$PID" ] && [ -d "/proc/$PID" ]; then
            return 0
        fi
    fi

    pgrep -x clash >/dev/null 2>&1 && return 0

    return 1
}

stop_service() {

    echo ""
    echo "=============================="
    echo "     QTUN STOPPING"
    echo "=============================="

    log "[ACTION] Stop Request"

    "$SCRIPTS/qtun.iptables" disable >> "$RUNLOG" 2>&1

    "$SCRIPTS/qtun.service" stop >> "$RUNLOG" 2>&1

    rm -f "$PIDFILE"

    touch "$MODDIR/disable"

    set_status "offline"

    echo "[OK] QTUN Offline"

    log "[STATUS] OFFLINE"

    return 0
}

start_service() {

    echo ""
    echo "=============================="
    echo "     QTUN STARTING"
    echo "=============================="

    log "[ACTION] Start Request"

    rm -f "$MODDIR/disable"

    if "$SCRIPTS/qtun.service" start >> "$RUNLOG" 2>&1; then

        "$SCRIPTS/qtun.iptables" enable >> "$RUNLOG" 2>&1

        set_status "online"

        log "[STATUS] ONLINE"
        log "[ACTION] System Ready"

        echo ""
        echo "=============================="
        echo "      QTUN ONLINE"
        echo "=============================="

        echo " Workers  : $(pidof libuz | wc -w 2>/dev/null || echo 0)"

        echo " Aggregat : $(pidof libload >/dev/null && echo Running || echo Stopped)"

        echo " Clash    : $(pidof clash >/dev/null && echo Running || echo Stopped)"

        [ -f "$PIDFILE" ] && \
        echo " Clash PID: $(cat "$PIDFILE")"

        echo "=============================="

        return 0

    else

        set_status "offline"

        log "[ERROR] Failed Start"

        echo "[ERROR] Failed start QTUN"

        return 1
    fi
}

restart_service() {

    echo ""
    echo "=============================="
    echo "     QTUN RESTART"
    echo "=============================="

    log "[ACTION] Restart Request"

    stop_service

    sleep 2

    start_service
}

status_service() {

    echo ""
    echo "=============================="
    echo "      QTUN STATUS"
    echo "=============================="

    if is_running; then

        echo " Status   : ONLINE"

        echo " Workers  : $(pidof libuz | wc -w 2>/dev/null || echo 0)"

        echo " Aggregat : $(pidof libload >/dev/null && echo Running || echo Stopped)"

        echo " Clash    : $(pidof clash >/dev/null && echo Running || echo Stopped)"

        [ -f "$PIDFILE" ] && \
        echo " Clash PID: $(cat "$PIDFILE")"

        set_status "online"

    else

        echo " Status   : OFFLINE"

        set_status "offline"
    fi

    echo "=============================="
}

case "$1" in

    start)

        if is_running; then

            echo "[INFO] QTUN already running"

            exit 0
        fi

        start_service
    ;;

    stop)

        if ! is_running; then

            echo "[INFO] QTUN already stopped"

            touch "$MODDIR/disable"

            set_status "offline"

            exit 0
        fi

        stop_service
    ;;

    restart)

        restart_service
    ;;

    status)

        status_service
    ;;

    toggle)

        if is_running; then
            stop_service
        else
            start_service
        fi
    ;;

    *)

        echo ""
        echo "QTUN ACTION"
        echo ""
        echo "Usage:"
        echo "  sh action.sh start"
        echo "  sh action.sh stop"
        echo "  sh action.sh restart"
        echo "  sh action.sh status"
        echo "  sh action.sh toggle"
        echo ""

        exit 1
    ;;

esac

exit 0
