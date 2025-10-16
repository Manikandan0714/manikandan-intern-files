
echo "----------------------------"
echo "OS Information"
echo "----------------------------"
head -1 /etc/os-release

echo "----------------------------"
echo "Installing Nginx"
echo "----------------------------"
apt install -y nginx

echo "----------------------------"
echo "Nginx Version"
echo "----------------------------"
nginx -v
