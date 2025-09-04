#!/usr/bin/env bash
set -ex
SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

mkdir -p /opt/doom3
cd /opt/doom3
wget https://github.com/dhewm/dhewm3/releases/download/1.5.4/dhewm3-1.5.4_Linux_amd64.tar.gz
tar -xvf dhewm3-1.5.4_Linux_amd64.tar.gz
rm dhewm3-1.5.4_Linux_amd64.tar.gz
cd dhewm3
wget https://files.holarse-linuxgaming.de/native/Spiele/Doom%203/Demo/doom3-linux-1.1.1286-demo.x86.run
sh doom3-linux-1.1.1286-demo.x86.run --tar xf demo/
rm doom3-linux-1.1.1286-demo.x86.run

cat >/usr/bin/desktop_ready <<EOL
#!/usr/bin/env bash
until pids=\$(pidof Thunar); do sleep .5; done
EOL
chmod +x /usr/bin/desktop_ready

mkdir -p $HOME/.config/dhewm3/demo
cp $SCRIPT_PATH/dhewm.cfg $HOME/.config/dhewm3/demo/
chown -R 1000:1000 $HOME/.config


echo "/opt/doom3/dhewm3/dhewm3" > $HOME/Desktop/doom3.sh
chmod +x $HOME/Desktop/doom3.sh
chown 1000:1000 $HOME/Desktop/doom3.sh