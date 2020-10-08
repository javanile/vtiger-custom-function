<?php

/*
 * This file is part of Composer.
 *
 * (c) Nils Adermann <naderman@naderman.de>
 *     Jordi Boggiano <j.boggiano@seld.be>
 *
 * For the full copyright and license information, please view the LICENSE
 * file that was distributed with this source code.
 */

namespace Javanile\VtigerCustomFunction;

use Javanile\VtigerPsr4\CrmExtension;
use Javanile\VtigerComposer\Installer as ComposerInstaller;

/**
 * @author Francesco Bianco <bianco@javanile.org>
 */
class CustomFunctionExtension extends CrmExtension
{
    /**
     * @param $moduleName
     * @param $eventType
     */
    public function vtlibHandler($moduleName, $eventType)
    {
        $composerInstaller = new ComposerInstaller($moduleName, __DIR__.'/composer.json');

        if ($eventType == 'module.postinstall') {
            $composerInstaller->install();
        } else if ($eventType == 'module.postupdate') {
            $composerInstaller->update();
            //$composerInstaller->install();
        } else if ($eventType == 'module.preupdate') {

        } else if ($eventType == 'module.preuninstall') {

        } else if ($eventType == 'module.enabled') {

        } else if ($eventType == 'module.disabled') {

        }
    }
}
