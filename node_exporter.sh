#!/bin/bash
sudo useradd --shell /bin/false prometheus
sudo mkdir /var/log/prometheus/
sudo touch /var/log/prometheus/node_exporter.log
sudo chown -R prometheus:prometheus /var/log/prometheus
sudo cat > initscript <<'endmsg'
#!/bin/bash
#
# chkconfig: 2345 20 80 Read
# description: node_exporter will export system metrics in a Prometheus format
# processname: node_exporter

# Source function library.
. /etc/rc.d/init.d/functions

PROGNAME=node_exporter
PROGDIR=/home/prometheus/node_exporter
PROG=$PROGDIR/$PROGNAME
USER=prometheus
LOGFILE=/var/log/prometheus/$PROGNAME.log
LOCKFILE=/var/run/$PROGNAME.pid

start() {
echo -n "Starting $PROGNAME: "
cd $PROGDIR
daemon --user $USER --pidfile="$LOCKFILE" "$PROG &>$LOGFILE &"
echo $(pidofproc $PROGNAME) >$LOCKFILE
echo
}

stop() {
echo -n "Shutting down $PROGNAME: "
killproc $PROGNAME
rm -f $LOCKFILE
echo
}


case "$1" in
start)
start
;;
stop)
stop
;;
status)
status $PROGNAME
;;
restart)
stop
start
;;
reload)
echo "Sending SIGHUP to $PROGNAME"
kill -SIGHUP $(pidofproc $PROGNAME)
;;
*)
echo "Usage: service $PROGNAME {start|stop|status|reload|restart}"
exit 1
;;
esac
endmsg
sudo mv initscript /etc/init.d/node_exporter
sudo chmod +x /etc/init.d/node_exporter
sudo chown prometheus:prometheus /etc/init.d/node_exporter
curl -LO https://github.com/prometheus/node_exporter/releases/download/v0.16.0/node_exporter-0.16.0.linux-amd64.tar.gz
sudo mkdir /home/prometheus/node_exporter
sudo tar -xf node_exporter-*.tar.gz
sudo mv node_exporter-*/* /home/prometheus/node_exporter/
sudo chown -R prometheus:prometheus /home/prometheus/node_exporter
sudo chkconfig --add node_exporter
sudo service node_exporter start
[root@pickapronow-Live scripts]# packet_write_wait: Connection to 52.53.178.88 port 22: Broken pipe
MBA-STICKER-131:keys admin$ #!/bin/bash
MBA-STICKER-131:keys admin$ sudo useradd --shell /bin/false prometheus
sudo mkdir /var/log/prometheus/
sudo touch /var/log/prometheus/node_exporter.log
sudo chown -R prometheus:prometheus /var/log/prometheus
sudo cat > initscript <<'endmsg'
#!/bin/bash
#
# chkconfig: 2345 20 80 Read
# description: node_exporter will export system metrics in a Prometheus format
# processname: node_exporter

# Source function library.
. /etc/rc.d/init.d/functions

PROGNAME=node_exporter
PROGDIR=/home/prometheus/node_exporter
PROG=$PROGDIR/$PROGNAME
USER=prometheus
LOGFILE=/var/log/prometheus/$PROGNAME.log
LOCKFILE=/var/run/$PROGNAME.pid

start() {
echo -n "Starting $PROGNAME: "
cd $PROGDIR
daemon --user $USER --pidfile="$LOCKFILE" "$PROG &>$LOGFILE &"
echo $(pidofproc $PROGNAME) >$LOCKFILE
echo
}

stop() {
echo -n "Shutting down $PROGNAME: "
killproc $PROGNAME
rm -f $LOCKFILE
echo
}


case "$1" in
start)
start
;;
stop)
stop
;;
status)
status $PROGNAME
;;
restart)
stop
start
;;
reload)
echo "Sending SIGHUP to $PROGNAME"
kill -SIGHUP $(pidofproc $PPassword:
rt}"
exit 1
;;
esac
endmsg
sudo mv initscript /etc/init.d/node_exporter
sudo chmod +x /etc/init.d/node_exporter
sudo chown prometheus:prometheus /etc/init.d/node_exporter
curl -LO https://github.com/prometheus/node_exporter/releases/download/v0.16.0/node_exporter-0.16.0.linux-amd64.tar.gz
sudo mkdir /home/prometheus/node_exporter
sudo tar -xf node_exporter-*.tar.gz
sudo mv node_exporter-*/* /home/prometheus/node_exporter/
sudo chown -R prometheus:prometheus /home/prometheus/node_exporter
sudo chkconfig --add node_exporter
sudo service node_exporter start
