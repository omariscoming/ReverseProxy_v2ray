NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'

mkdomain(){
read -p "Enter Your Domain: " DOMAIN
sudo apt install nginx certbot python3-certbot-nginx -y
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$DOMAIN
ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
sed -i "s/_;/$DOMAIN;/" "/etc/nginx/sites-available/$DOMAIN"
sed -i "s/ default_server//" "/etc/nginx/sites-available/$DOMAIN"
sed -i "21 r /root/ReverseProxy_v2ray/reverse.txt" "/etc/nginx/sites-available/$DOMAIN"
certbot --nginx --agree-tos --no-eff-email --redirect --expand --force-renewal --reinstall --non-interactive -d $DOMAIN --register-unsafely-without-email
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
x-ui restart
}

echo -e "${RED}1_install Nginx\n${GREEN}2_install Nginx + x-ui\n${YELLOW}3_Backup\n\n${NOCOLOR}chose an option:"
read VAR
case $VAR in
    1)
        mkdomain
        ;;
    2)
        mkdomain
        xuiinstall
        ;;
    3)
        backup
        ;;
    esac
