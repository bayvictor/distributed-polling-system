#vhuang@vhuang-Aspire-5552:~/srp-1.3$ cat README |grep "^-"|sed 's/^-/aptseek.sh /g;s/$/ >> aptget_srp_depending_src.sh/g'
aptseek.sh  libevent >> aptget_srp_depending_src.sh
aptseek.sh  libxml2 >> aptget_srp_depending_src.sh
aptseek.sh  openssl >> aptget_srp_depending_src.sh
aptseek.sh  glib >> aptget_srp_depending_src.sh
aptseek.sh  libunwind >> aptget_srp_depending_src.sh
aptseek.sh  gsoap >> aptget_srp_depending_src.sh

gedit aptget_srp*.sh & 



