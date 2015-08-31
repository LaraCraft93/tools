#!/bin/bash
VM="/home/lara/vmware/Windows 7 x64/Windows 7 x64.vmx"
RUNNING=$(vmrun list)

if [[ "$RUNNING" == *"$VM"* ]]
then
    vmrun suspend "$VM" soft
else
    vmrun start "$VM" nogui
fi
