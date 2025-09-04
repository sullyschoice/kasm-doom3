#!/usr/bin/env bash
set -ex
START_COMMAND="/opt/doom3/dhewm3/dhewm3"
PGREP="dhewm3"
export MAXIMIZE="false"
export MAXIMIZE_NAME="dhewm3"
MAXIMIZE_SCRIPT=$STARTUPDIR/maximize_window.sh
DEFAULT_ARGS="+set com_maxfps 125 +set cg_drawfps 1"
#DEFAULT_ARGS="+set com_maxfps 125 +set cg_drawfps 1 +set r_fullscreen 1 +set r_customwidth 640 +set r_customheight 480"

ARGS=${APP_ARGS:-$DEFAULT_ARGS}


FORCE=$2

# run with vgl if GPU is available
if [ -f /opt/VirtualGL/bin/vglrun ] && [ ! -z "${KASM_EGL_CARD}" ] && [ ! -z "${KASM_RENDERD}" ] && [ -O "${KASM_RENDERD}" ] && [ -O "${KASM_EGL_CARD}" ] ; then
    START_COMMAND="/opt/VirtualGL/bin/vglrun -d ${KASM_EGL_CARD} $START_COMMAND"
fi

kasm_startup() {

    if [ -z "$DISABLE_CUSTOM_STARTUP" ] ||  [ -n "$FORCE" ] ; then

        echo "Entering process startup loop"
        set +x
        while true
        do
            if ! pgrep -x $PGREP > /dev/null
            then
                /usr/bin/filter_ready
                /usr/bin/desktop_ready
                set +e
                bash ${MAXIMIZE_SCRIPT} &
                $START_COMMAND $ARGS $URL
                set -e
            fi
            sleep 1
        done
        set -x

    fi
}

kasm_startup
