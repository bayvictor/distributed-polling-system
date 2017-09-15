echo "usage: $0 <new_machine_name>"
echo "e.g.: $0 devvictor"

echo "^C to break, anykey to continue...";read readline

docker-machine create --driver virtualbox $1

