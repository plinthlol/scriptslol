#!/bin/bash


HWDB_FILE="/etc/udev/hwdb.d/90-keys.hwdb"


if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root (sudo)." 
   exit 1
fi

echo "--- Initializing udev hardware database update ---"


echo "Writing configuration to $HWDB_FILE..."
cat <<EOF > "$HWDB_FILE"
evdev:input:b*v*p*e*
 KEYBOARD_KEY_35=r
 KEYBOARD_KEY_b5=slash

EOF


echo "Updating the binary hwdb..."
udevadm hwdb --update

echo "Triggering udev reload for keyboard events..."
udevadm trigger --sysname-match="event*"

echo "--- Success! / should now map to 'R' ---"
