PROJECT=$1
PORT=$2

echo 'Listen '${PORT}'

<VirtualHost *:'${PORT}'>
    ServerName '${PROJECT}'.local
    DocumentRoot /var/www/html/web

    <Directory /var/www/html/web>
        Options Indexes FollowSymLinks MultiViews
        AllowOverride All
        Require all granted
    </Directory>

    ErrorLog /var/log/error.log

    LogLevel warn

    CustomLog /var/log/access.log combined
</VirtualHost>' > /etc/apache2/sites-available/${PROJECT}.local.conf

echo "ServerName localhost" >> /etc/apache2/apache2.conf
a2ensite ${PROJECT}.local
exec /usr/sbin/apache2 -D FOREGROUND
