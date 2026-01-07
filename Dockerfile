# PHP 8.2 ve Apache içeren resmi imajı kullanıyoruz
FROM php:8.2-apache

# Gerekli sistem paketlerini ve PHP eklentilerini kuruyoruz
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip \
    git \
    curl

# PHP eklentilerini yüklüyoruz (ihtiyacına göre ekleme yapabilirsin)
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Apache'nin rewrite modülünü aktif ediyoruz (Laravel/Symfony routing için önemli)
RUN a2enmod rewrite

# Çalışma dizinini belirliyoruz
WORKDIR /var/www/html

# Proje dosyalarını kopyalıyoruz
COPY . .

# Dosya izinlerini ayarlıyoruz (Apache için)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/cache 2>/dev/null || true

# Render'ın beklediği varsayılan port
EXPOSE 80

# Apache'yi başlatıyoruz
CMD ["apache2-foreground"]
FROM php:8.2-apache

# Gerekli sistem paketleri ve PHP eklentileri
RUN apt-get update && apt-get install -y \
    libpng-dev libonig-dev libxml2-dev zip unzip git curl
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Apache modülünü aktif et
RUN a2enmod rewrite

# Çalışma dizini
WORKDIR /var/www/html

# GitHub'daki tüm klasörleri (16 uygulamanın hepsini) kopyalar
COPY . .

# Apache'nin dosyalara erişebilmesi için izinleri ayarla
RUN chown -R www-data:www-data /var/www/html && chmod -R 755 /var/www/html

EXPOSE 80
CMD ["apache2-foreground"]
