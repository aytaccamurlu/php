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

# Composer kurulumu
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer
RUN composer install --no-interaction --optimize-autoloader --no-dev

# Dosya izinlerini ayarlıyoruz (Apache için)
RUN chown -R www-data:www-data /var/www/html/storage /var/www/html/cache 2>/dev/null || true

# Render'ın beklediği varsayılan port
EXPOSE 80

# Apache'yi başlatıyoruz
CMD ["apache2-foreground"]
