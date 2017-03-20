#mmap_err-fix-3_lines_of_vm.vdso_n_net.ipv4_in__etc_sysctl.conf_fix_mmap__no_such_device_or_address


# modified /etc/sysctl.conf:
sudo echo "   
   vm.vdso_enabled = 0
   vm.mmap_min_addr = 4096
   net.ipv4.ip_local_port_range = 1024 65535
" >> /etc/sysctl.conf

