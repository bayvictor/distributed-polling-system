rm -fr *.mf *.ovf *-disk1.vmdk  # clean up otherwise below conversion freaked out
cd "/home/huaxi06/Documents/Virtual Machines/Rhel6-64-bit"
ovftool.exe Rhel6-64-bit.vmx Rhel6-64-bit.ovf
