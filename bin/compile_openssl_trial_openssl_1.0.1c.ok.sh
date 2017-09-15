#./Configure linux-armv4 #--prefix 
cd /home/vhuang/openssl/trial/openssl-1.0.1c


./Configure linux-armv4   --prefix=$HOME/victor/armroot --openssldir=%{_sysconfdir}/pki/tls ${sslflags} zlib enable-camellia enable-seed enable-tlsext enable-rfc3779  enable-cms enable-md2   --with-krb5-flavor=MIT --enginesdir=%{_libdir}/openssl/engines  --with-krb5-dir=/usr shared  ${sslarch} fips

make
make install









