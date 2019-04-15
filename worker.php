<?php

error_log('#@@# worker.php');

/*while(true) {
    error_log('Log a cada 10 segundos');

    sleep(10);
}*/

//

$autoload_path = dirname(__FILE__) . "/magento/vendor/autoload.php";
//echo $autoload_path;exit;
require_once($autoload_path);
//echo '<pre>';print_r(spl_autoload_functions());exit;

//

if ( empty($argc) || ($argc < 2) )
{
    exit( "Usage: php worker.php 'ls -lah' " );
    // php worker.php 'bash -x app.sh release_host'
}

//var_dump($argc); // O número de argumentos
//var_dump($argv); // Array de argumentos
//exit;

use Symfony\Component\Process\Process;
use Symfony\Component\Process\Exception\ProcessFailedException;

$process = new Process($argv[1]);
$process->start();

while ($process->isRunning()) {
  echo ' waiting for process to finish \n ...';
}

if (!$process->isSuccessful()) {
    throw new ProcessFailedException($process);
}

echo '<pre>';
print_r($process->getOutput());

//
