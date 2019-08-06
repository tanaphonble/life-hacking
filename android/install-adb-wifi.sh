echo '#!/bin/bash
cmd=$1

device_ip=$(adb shell ifconfig rmnet0 | grep "inet addr" | awk "{print $2}" | cut -d ":" -f2 | cut -d " " -f1)
tcp_port=5555
socket=$device_ip:$tcp_port

if [[ $cmd == "start" ]]; then
  echo connect to $socket
  adb tcpip $tcp_port
  adb connect $socket
elif [[ $cmd == "stop" ]]; then
  echo disconnect from $socket
  adb -s $socket usb
elif [[ $cmd == "restart" ]]; then
  adb kill-server
  adb start-server
fi
' > /usr/local/bin/adb-wifi
chmod 755 /usr/local/bin/adb-wifi