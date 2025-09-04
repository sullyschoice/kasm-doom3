#!/usr/bin/env bash
set -ex
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

apt-get update
apt-get install -y openarena

cp /usr/share/applications/openarena.desktop $HOME/Desktop/
chmod +x $HOME/Desktop/openarena.desktop
chown 1000:1000 $HOME/Desktop/openarena.desktop


cat >/usr/bin/openarena <<EOL
#!/usr/bin/env bash
if [ -f /opt/VirtualGL/bin/vglrun ] && [ ! -z "\${KASM_EGL_CARD}" ] && [ ! -z "\${KASM_RENDERD}" ] && [ -O "\${KASM_RENDERD}" ] && [ -O "\${KASM_EGL_CARD}" ] ; then
    echo "Starting OpenArena with GPU Acceleration on EGL device \${KASM_EGL_CARD}"
    vglrun -d "\${KASM_EGL_CARD}" /usr/games/openarena "\$@"
else
    echo "Starting OpenArena"
    /usr/games/openarena "\$@"
fi
EOL
chmod +x /usr/bin/openarena

mkdir -p $HOME/.openarena/baseoa/
cp $SCRIPT_PATH/q3config.cfg $HOME/.openarena/baseoa/
chown -R 1000:1000 $HOME/.openarena

cat >/usr/bin/desktop_ready <<EOL
#!/usr/bin/env bash
until pids=\$(pidof Thunar); do sleep .5; done
EOL
chmod +x /usr/bin/desktop_ready
