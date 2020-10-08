<?php

namespace Javanile\VtigerCustomFunction\Models;

use Javanile\VtigerPsr4\Models\ModuleModel;

class CustomFunctionModuleModel extends ModuleModel
{
    public function __construct()
    {
        if (!file_exists('modules/Composer/Composer.php')) {
            echo '';
        }
    }
}
