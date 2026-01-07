<?php
echo "<h1>Benim PHP Uygulamalarım</h1>";
$dizin = array_filter(glob('*'), 'is_dir'); // Tüm klasörleri listeler

echo "<ul>";
foreach ($dizin as $uygulama) {
    echo "<li><a href='/$uygulama/'>$uygulama</a></li>";
}
echo "</ul>";
?>
