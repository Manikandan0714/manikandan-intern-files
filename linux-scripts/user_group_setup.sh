echo "----------------------"
echo "Create and check user "
echo "----------------------"

id -u intern_user || useradd -m -G intern_team intern_user

echo "----------------------"
echo "Create and Check Group"
echo "----------------------"

getent group intern_team || groupadd intern_team

echo "-----------------"
echo "Add User To Group"
echo "-----------------"

usermod -aG intern_team intern_user
echo "User Added Already"

echo "-----------------"
echo "ROOT CHECK"
echo "-----------------"

if [ "$EUID" -ne 0 ]; then
    echo "Run as root!"
    exit 1




