#!/bin/bash
# Update and install Apache & PHP
apt-get update -y
apt-get install -y apache2 php libapache2-mod-php

# Start and Enable Apache
systemctl start apache2
systemctl enable apache2

# Remove default index.html and create a custom PHP page
rm /var/www/html/index.html

# Create a simple PHP application with CSS
cat <<EOF > /var/www/html/index.php
<!DOCTYPE html>
<html>
<head>
<title>PHP App</title>
<style>
body { font-family: sans-serif; background:#f0f0f0; text-align:center; padding:40px; }
.box { background:#fff; padding:20px; border-radius:6px; display:inline-block; }
p { margin:6px 0; }
</style>
</head>
<body>

<div class="box">
    <h2>PHP App Running</h2>
    <p>Hostname: <?php echo gethostname(); ?></p>
    <?php
    date_default_timezone_set("Asia/Kolkata");
    ?>
    <p>Time: <?php echo date("Y-m-d H:i:s"); ?></p>
    <hr>
    <small>Done by S Manikandan</small>
</div>

</body>
</html>
EOF

# Restart Apache to ensure PHP loads
systemctl restart apache2