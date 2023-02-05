
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
sed -i "s/ default_server//" "/etc/nginx/sites-available/$DOMAIN"
cat reverse.txt
sed -i "24 r reverse.txt" "/etc/nginx/sites-available/$DOMAIN"

certbot --nginx -d $DOMAIN --register-unsafely-without-email

systemctl restart nginx
apt install curl
bash <(curl -Ls https://raw.githubusercontent.com/vaxilu/x-ui/master/install.sh)
wget https://github.com/Heclalava/blockpublictorrent-iptables/raw/main/bt.sh && chmod +x bt.sh && bash bt.sh
