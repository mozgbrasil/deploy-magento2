<?php
$config = array();

$config['backend'] = array('frontName' => '{{MAGENTO_ADMIN_URL}}');

$config['crypt'] = array('key' => '{{MAGENTO_CRYPT}}');

$config['db'] =  array(
    'table_prefix' => '',
    'connection' =>
        array(
            'default' =>
                array(
                    'host' => '{{MAGENTO_DB_HOST}}',
                    'dbname' => '{{MAGENTO_DB_NAME}}',
                    'username' => '{{MAGENTO_DB_USER}}',
                    'password' => '{{MAGENTO_DB_PASSWORD}}',
                    'model' => 'mysql4',
                    'engine' => 'innodb',
                    'initStatements' => 'SET NAMES utf8;',
                    'active' => '1',
                ),
        ),
);

$config['resource'] = array(
        'default_setup' =>
            array(
                'connection' => 'default',
            ),
    );

$config['x-frame-options'] = 'SAMEORIGIN';

//todo: get it from env variable?
$config['MAGE_MODE'] = '{{MAGE_MODE}}';

if (!empty('{{MAGENTO_SESSION_HOST}}') && !empty('{{MAGENTO_SESSION_PORT}}')) {
    $config['session'] =
        array(
            'save' => 'redis',
            'redis' =>
                array(
                    'host' => '{{MAGENTO_SESSION_HOST}}',
                    'port' => '{{MAGENTO_SESSION_PORT}}',
                    'password' => '',
                    'timeout' => '2.5',
                    'persistent_identifier' => '',
                    'database' => '{{MAGENTO_SESSION_DATABASE}}',
                    'compression_threshold' => '2048',
                    'compression_library' => 'gzip',
                    'log_level' => '1',
                    'max_concurrency' => '6',
                    'break_after_frontend' => '5',
                    'break_after_adminhtml' => '30',
                    'first_lifetime' => '600',
                    'bot_first_lifetime' => '60',
                    'bot_lifetime' => '7200',
                    'disable_locking' => '0',
                    'min_lifetime' => '60',
                    'max_lifetime' => '2592000'
                )
        );
} else {
    $config['session'] = array('save' => 'files');
}

if (!empty('{{MAGENTO_CACHE_HOST}}') && !empty('{{MAGENTO_CACHE_PORT}}')) {
    $config['cache'] = array(
        'frontend' =>
            array(
                'default' =>
                    array(
                        'backend' => 'Cm_Cache_Backend_Redis',
                        'backend_options' =>
                            array(
                                'server' => '{{MAGENTO_CACHE_HOST}}',
                                'port' => '{{MAGENTO_CACHE_PORT}}',
                                'database' => '{{MAGENTO_CACHE_DATABASE}}',
                                'persistent' => '',
                                'force_standalone' => '0',
                                'connect_retries' => '1',
                                'read_timeout' => '10',
                                'automatic_cleaning_factor' => '0',
                                'compress_data' => '1',
                                'compress_tags' => '1',
                                'compress_threshold' => '20480',
                                'compression_lib' => 'gzip',
                            ),
                    ),
                'page_cache' =>
                    array(
                        'backend' => 'Cm_Cache_Backend_File',
                    )
            )
    );
} else {
    $config['cache'] = array(
        'frontend' =>
            array(
                'default' =>
                    array(
                        'id_prefix' => 'b3a_',
                    ),
                'page_cache' =>
                    array(
                        'id_prefix' => 'b3a_',
                    )
            )
    );
}

$config['cache_types'] =
        array(
            'config' => 0,
            'layout' => 0,
            'block_html' => 0,
            'collections' => 0,
            'reflection' => 0,
            'db_ddl' => 0,
            'compiled_config' => 0,
            'eav' => 0,
            'customer_notification' => 0,
            'config_integration' => 0,
            'config_integration_api' => 0,
            'full_page' => 0,
            'config_webservice' => 0,
            'translate' => 0,
            'vertex' => 0
        );

$config['install'] = array('date' => 'Thu, 25 Apr 2019 22:59:36 +0000');

if (!empty('{{MAGENTO_WEBCACHE_HOST}}')) {
    $config['http_cache_hosts'] = array_map(function ($e) {
        return ['host'=>$e, 'port'=>80];
    }, getHostByNameL('{{MAGENTO_WEBCACHE_HOST}}')?:[]);
}

return $config;
