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

echo '<h2>posix_getpwuid</h2>';

$processUser = posix_getpwuid(posix_geteuid());
print $processUser['name'];

echo '<h2>get_current_user</h2>';

echo get_current_user();

echo '<h2>env user</h2>';

$username = getenv('USERNAME') ?: getenv('USER');
echo $username; // e.g. root or www-data

//

echo '<h2>is_writable</h2>';

$filename = 'magento/var';

$stat = stat($filename);

var_dump($stat);

$perms = substr(sprintf('%o', fileperms($filename)), -4);

echo '<pre>';

var_dump( "perms: $perms");

if (is_writable($filename)) {
    var_dump( "$filename is writable");
} else {
    var_dump( "$filename is not writable");
}

echo '</pre>';

//

echo '<h2>getenv</h2>';

echo '<pre>';
print_r(getenv());
print_r(getenv('RDS_HOSTNAME'));
echo '</pre>';

//

echo '<h2>COMPOSER_AUTH</h2>';

// load COMPOSER_AUTH environment variable if set
$composerAuthEnv = getenv('COMPOSER_AUTH');

//$composerAuthEnv = '{"http-basic": {"repo.magento.com": {"username":"46c4de407a700effa4181aa71a887535","password":"1793ac5de43a4d7e1de34a7936abeb31"}},"github-oauth": {"github.com": "23c13f1b2b51acc7474fbf71bae70e9e6e6f614e"}}';

echo '<pre>';
print_r($composerAuthEnv);
echo '</pre>';

if ($composerAuthEnv) {
    $authData = json_decode($composerAuthEnv, true);
    echo '<pre>';
    echo '<h2>authData</h2>';
    print_r($authData);
    echo '<h2>json_last_error</h2>';
    print_r(json_last_error());
    echo '</pre>';
    if (null === $authData) {
        echo('COMPOSER_AUTH environment variable is malformed, should be a valid JSON object');
    }
}

//

echo '<h2>autoload</h2>';

$autoload_path = dirname(__FILE__) . "/magento/vendor/autoload.php";
//echo $autoload_path;exit;
require_once($autoload_path);
//echo '<pre>';print_r(spl_autoload_functions());exit;

//

echo '<h2>phpinfo</h2>';

phpinfo();
