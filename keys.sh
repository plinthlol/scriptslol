#!/usr/bin/env bash

HWDB_FILE=/etc/udev/hwdb.d/90-keys.hwdb

sudo rm -f /etc/udev/hwdb.d/90-block-broken-key.hwdb
sudo rm -f "$HWDB_FILE"

sudo tee "$HWDB_FILE" << 'HWDB'
evdev:atkbd:dmi:*
 KEYBOARD_KEY_2d=reserved
 KEYBOARD_KEY_37=x

evdev:input:b*v*p*e*
 KEYBOARD_KEY_35=r
 KEYBOARD_KEY_b5=slash
HWDB

sudo udevadm hwdb --update && sudo udevadm trigger

echo "Done! Rules applied from $HWDB_FILE"
