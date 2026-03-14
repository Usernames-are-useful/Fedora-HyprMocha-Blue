#!/bin/bash
# Define paths
CA="pki/ca.crt"
CERT="pki/issued/client1.crt"
KEY="pki/private/client1.key"
TLS="ta.key"

cat <<EOF > client1.ovpn
client
dev tun
proto udp
remote YOUR_SERVER_IP 1194
resolv-retry infinite
nobind
persist-key
persist-tun
remote-cert-tls server
cipher AES-256-GCM
verb 3

<ca>
$(cat $CA)
</ca>
<cert>
$(sed -ne '/-BEGIN CERTIFICATE-/,/-END CERTIFICATE-/p' $CERT)
</cert>
<key>
$(cat $KEY)
</key>
<tls-auth>
$(cat $TLS)
</tls-auth>
key-direction 1
EOF

echo "Done! client1.ovpn created."
