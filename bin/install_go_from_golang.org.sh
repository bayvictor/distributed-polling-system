sudo mkdir /usr/local/go 
sudo chown $USER /usr/local/go -R
 cd /usr/local/go  
 wget https://storage.googleapis.com/golang/go1.4.2.linux-amd64.tar.gz
tar -zxf go1.4.2.linux-amd64.tar.gz
echo "

export GOROOT=/usr/local/go
export PATH=$PATH:/usr/local/go/bin" >> ~/.bashrc

echo "
package main

import \"fmt\"

func main() {
    fmt.Printf(\"hello, world\n\")
}
" > hello.go

go run hello.go

