# **Error:** Error starting domain: Requested operation is not valid: network 'default' is not active.

## Temporary Fix
First confirm the default network is indeed active:
``` sudo virsh net-list --all ```
If so, start the default network:
``` sudo virsh net-start default ```
Rerun: 
``` sudo virsh net-list --all ```

## Autostart Virsh:
``` sudo virsh net-autostart default ```
