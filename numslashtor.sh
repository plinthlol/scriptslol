#!/bin/bash


HWDB_FILE="/etc/udev/hwdb.d/90-f5-to-r.hwdb"


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

echo "--- Initializing udev hardware database update ---"


echo "Writing configuration to $HWDB_FILE..."
cat <<EOF > "$HWDB_FILE"
# Matches all keyboards
evdev:input:b*v*p*e*
 KEYBOARD_KEY_3f=r
EOF


echo "Updating the binary hwdb..."
udevadm hwdb --update

echo "Triggering udev reload for keyboard events..."
udevadm trigger --sysname-match="event*"

echo "--- Success! F5 should now map to 'R' ---"
