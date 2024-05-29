<?php

/**
 * Matomo - free/libre analytics platform
 *
 * @link    https://matomo.org
 * @license https://www.gnu.org/licenses/gpl-3.0.html GPL v3 or later
 */

namespace Piwik\Plugins\CurrentLocalTime\Widgets;

use Piwik\Common;
use Piwik\Date;
use Piwik\Site;
use Piwik\Widget\Widget;
use Piwik\Widget\WidgetConfig;

/**
 * This class displays the local website time. 
 * It will also display the local user time if the use is in a different timezone to the website.
 */
class GetCurrentlocaltimeinwebsitestimezone extends Widget
{
    public static function configure(WidgetConfig $config)
    {
        $config->setCategoryId('General_Visitors');
        $config->setSubcategoryId('General_Overview');
        $config->setName('CurrentLocalTime_Currentlocaltimeinwebsitestimezone');
        $config->setOrder(99);
    }

    /**
     * @return string
     */
    public function render()
    {
        $idSite = Common::getRequestVar('idSite');
        $siteTimezone = Site::getTimezoneFor($idSite);

        return $this->renderTemplate('index', array(
            'siteTimezone' => $siteTimezone,
        ));
    }
}
