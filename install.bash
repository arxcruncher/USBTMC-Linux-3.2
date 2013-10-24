#!/bin/bash

module=usbtmc

rmmod ${module}
echo "Installing module ..."
insmod ./${module}.ko

# Find major number used
major=$(cat /proc/devices | grep USBTMCCHR | awk '{print $1}')
echo "Creating char devices using major number $major..."
# Remove old device files
rm -f /dev/${module}[0-9]
# Ceate new device files
mknod /dev/${module}0 c $major 0
mknod /dev/${module}1 c $major 1

echo "Setting char device permissions..."
chmod 666 /dev/${module}0
chmod 666 /dev/${module}1

echo "Testing device ..."
cat /dev/usbtmc0

