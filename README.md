# Build you own image

```
docker build -t nginx-phalcon .
```

# Nginx + Phalcon

- nginx 
- php5-fpm
- phalcon extension
- composer
- phpunit
- php extension: php5-xdebug php5-dev php5-fpm php5-mysql php5-mcrypt php5-curl php5-mongodb php5-imagick php5-gd

## Usage:

	docker run --name my-nginx-phalcon -d -v="/pathto/to/your/code":"/var/www" -p 8888:80 nginx-phalcon

## Options
### Document root
Additionally you can define the public folder for each instance by passing an env variable called WEBPUBLIC for example adding `-e "WEBPUBLIC=public/es"`

	docker run --name my-nginx-phalcon -d -v="/pathto/to/your/code":"/var/www" -e "WEBPUBLIC=public/api" -p 8888:80 nginx-phalcon

Will mount your folder /pathto/to/your/code  as /var/www and the document root will be /var/www/public/api

### Port
Change -p 8888:80
Where 80 is the port exposed by the container and 8888 your choice port.
