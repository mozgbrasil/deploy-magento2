#!/usr/bin/php
<?php

# Copyright © 2016-2019 Mozg. All rights reserved.

# php app.php

if (false === in_array(\PHP_SAPI, ['cli', 'phpdbg', 'embed'], true)) {
    echo 'Warning: The console should be invoked via the CLI version of PHP, not the '.\PHP_SAPI.' SAPI'.\PHP_EOL;
}

set_time_limit(0);

$file_path = __DIR__.'/magento/app/etc/env.php';

$_include = include $file_path;

//print_r($_include);

$crypt_key = $_include['crypt']['key'];

echo $crypt_key;
