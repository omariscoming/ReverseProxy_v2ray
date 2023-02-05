apt-get update -y && apt-get upgrade -y
sudo apt install nginx certbot python3-certbot-nginx -y

read -p "Enter Your Domain: " DOMAIN
mkdomain(){
cp /etc/nginx/sites-available/default /etc/nginx/sites-available/$DOMAIN
}
mkdomain
echo "copying..."

lndomain(){
ln -s /etc/nginx/sites-available/$DOMAIN /etc/nginx/sites-enabled/
}

lndomain
echo "ln the $DOMAIN ..."


echo "edit the file..."

sed -i "s/_;/$DOMAIN;/" "/etc/nginx/sites-available/$DOMAIN"
cp reverse.txt newreverse.txt
sed -i "21 r newreverse.txt" "/etc/nginx/sites-available/$DOMAIN"

certbot --nginx -d $DOMAIN --register-unsafely-without-email

systemctl restart nginx
apt install curl
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
wget https://github.com/Heclalava/blockpublictorrent-iptables/raw/main/bt.sh && chmod +x bt.sh && bash bt.sh
