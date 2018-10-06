#!/bin/sh
IP=`kubectl get pod -lapp=nginx-ingress -lcomponent=controller -o jsonpath="{.items[0].status.podIP}"`
insert() {
sudo iptables -t nat -I PREROUTING -p tcp -m comment --comment hwchiu -m tcp --dport 5565 -j DNAT --to-destination $IP:443
sudo iptables -t nat -I POSTROUTING -p tcp -m comment --comment hwchiu -m tcp --sport 5565 -j MASQUERADE
sudo iptables -t nat -I PREROUTING -p tcp -m comment --comment hwchiu -m tcp --dport 5566 -j DNAT --to-destination $IP:80
sudo iptables -t nat -I POSTROUTING -p tcp -m comment --comment hwchiu -m tcp --sport 5566 -j MASQUERADE
}
delete() {
sudo iptables -t nat -D PREROUTING -p tcp -m comment --comment hwchiu -m tcp --dport 5565 -j DNAT --to-destination $IP:443
sudo iptables -t nat -D POSTROUTING -p tcp -m comment --comment hwchiu -m tcp --sport 5565 -j MASQUERADE
sudo iptables -t nat -D PREROUTING -p tcp -m comment --comment hwchiu -m tcp --dport 5566 -j DNAT --to-destination $IP:80
sudo iptables -t nat -D POSTROUTING -p tcp -m comment --comment hwchiu -m tcp --sport 5566 -j MASQUERADE
}

if [ "$1" = "D" ]; then
delete
else
insert
fi
