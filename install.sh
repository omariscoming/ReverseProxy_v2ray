apt-get update -y && apt-get upgrade -y
sudo apt install nginx certbot python3-certbot-nginx -y

read -p "Enter Your Domain: " DOMAIN

read -p "Enter your Subdomain: " SUBDOMAIN


mkdomain(){
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$SUBDOMAIN.$DOMAIN
}
mkdomain
echo "copying..."

lndomain(){
ln -s /etc/nginx/sites-available/$SUBDOMAIN.$DOMAIN /etc/nginx/sites-enabled/
}

lndomain
echo "ln the $SUBDOMAIN.$DOMAIN ..."


echo "edit the file..."

sed -i "s/_;/$SUBDOMAIN.$DOMAIN;/" "/etc/nginx/sites-available/$SUBDOMAIN.$DOMAIN"
sed -i "s/ default_server//" "/etc/nginx/sites-available/$SUBDOMAIN.$DOMAIN"
sed -i "21 r reverseproxy.txt" "/etc/nginx/sites-available/$SUBDOMAIN.$DOMAIN"

certbot --nginx -d $SUBDOMAIN.$DOMAIN --register-unsafely-without-email

systemctl restart nginx
apt install curl
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
wget https://github.com/Heclalava/blockpublictorrent-iptables/raw/main/bt.sh && chmod +x bt.sh && bash bt.sh

