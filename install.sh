
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
sed -i "s/ default_server//" "/etc/nginx/sites-available/$DOMAIN"
sed -i "21 r /root/ReverseProxy_v2ray/reverse.txt" "/etc/nginx/sites-available/$DOMAIN"

certbot --nginx -d $DOMAIN --register-unsafely-without-email

systemctl restart nginx
