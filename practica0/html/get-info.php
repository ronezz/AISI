<?php
  $id = exec('uname -nrs');
  $ver = exec('cat /etc/debian_version');
  $cpu = exec('cat /proc/cpuinfo | grep "model name" | head -1 | cut -d ":" -f 2');
  echo "<p>Debian $ver $id</p>";
  echo "<p>$cpu</p>";
  include 'db-get-data.php' ;
?>
