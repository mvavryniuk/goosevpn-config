#!/bin/bash
echo "========================================================= Stop VPN service, if running ========================================================="
killall -9 openvpn
echo ""

echo "========================================================= Get IP before VPN setup =============================================================="
curl ipinfo.io
echo ""
echo "================================================================================================================================================"

rm -fr /storage/vpn
mkdir /storage/vpn
wget -O /storage/vpn/$1.ovpn "https://raw.githubusercontent.com/mvavryniuk/goosevpn-config/master/$1.ovpn"
echo $2 > /storage/vpn/user.txt
echo $3 >> /storage/vpn/user.txt
echo ""  >> /storage/vpn/$1.ovpn
echo "auth-user-pass /storage/vpn/user.txt" >> /storage/vpn/$1.ovpn
echo "daemon" >> /storage/vpn/$1.ovpn

echo "========================================================= Start VPN service ==================================================================="
openvpn --daemon --config /storage/vpn/$1.ovpn
sleep 10
echo ""

echo "========================================================= Get IP after VPN setup =============================================================="
curl ipinfo.io
echo ""
echo "==============================================================================================================================================="

echo "openvpn --daemon --config /storage/vpn/$1.ovpn" > /storage/.config/autostart.sh