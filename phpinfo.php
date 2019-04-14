<?php

//

//
// any ini_set() for session configuration goes here when not using .user.ini

session_start();
if (!isset($_SESSION['count'])) {
    $_SESSION['count'] = 0;
}
$_SESSION['count']++;

echo '<h2>session</h2>';

echo "Hello #" . $_SESSION['count'];

//

echo '<h2>umask</h2>';

$umask = umask();          //- returns the current umask, which is a "int"
$umask = decoct($umask);   //- Now, $umask is a "string"
echo $umask;

//

echo '<h2> magento/app/etc/env.php </h2>';

$data = file_get_contents("magento/app/etc/env.php"); //read the file

echo '<pre>';
echo $data;
echo '</pre>';

echo '<h2>getenv</h2>';

echo '<pre>';
print_r(getenv());
print_r(getenv('RDS_HOSTNAME'));
echo '</pre>';

//

echo '<h2>autoload</h2>';

$autoload_path = dirname(__FILE__) . "/magento/vendor/autoload.php";
//echo $autoload_path;exit;
require_once($autoload_path);
//echo '<pre>';print_r(spl_autoload_functions());exit;

//

echo '<h2>phpinfo</h2>';

phpinfo();
