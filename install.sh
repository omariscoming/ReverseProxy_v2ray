NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'


mkdomain(){
read -p "Enter Your Domain: " DOMAIN
sudo apt install nginx certbot python3-certbot-nginx -y
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$DOMAIN
}
lndomain(){
ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
}

copying(){
sed -i "s/_;/$DOMAIN;/" "/etc/nginx/sites-available/$DOMAIN"
sed -i "s/ default_server//" "/etc/nginx/sites-available/$DOMAIN"
sed -i "21 r /root/ReverseProxy_v2ray/reverse.txt" "/etc/nginx/sites-available/$DOMAIN"
}

certbot(){
certbot --nginx -d $DOMAIN --register-unsafely-without-email
}

restartnginx(){
systemctl restart nginx
}

xuiinstall(){
apt install curl
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
}

backup(){
read -p "Oldserver: " OLDONE
read -p "USERNAME: " USERNAME
scp $USERNAME@$OLDONE:/etc/x-ui/x-ui.db /etc/x-ui/
}

firstoption(){
mkdomain
lndomain
copying
certbot
restartnginx
}

secondoption(){
mkdomain
lndomain
copying
certbot
restartnginx
xuiinstall
}

echo -e "${RED}1_install Nginx\n${GREEN}2_install Nginx + x-ui\n${YELLOW}3_Backup\n\n${NOCOLOR}chose an option:"
read VAR
case $VAR in
    1)
        firstoption
        ;;
    2)
        secondoption
        ;;
    3)
        backup
        ;;
    esac

