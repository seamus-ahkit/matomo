<script type="text/javascript">

{literal}

$(document).ready(function() {
	var fv = {};
	
	var params = {
		menu: "false",
		scale: "noScale",
		allowscriptaccess: "always",
		wmode: "opaque",
		bgcolor: "#FFFFFF",
		allowfullscreen: "true"
		
	};
	
{/literal}

	{* this hacks helps jquery to distingish between safari and chrome. *}
	$.browser.chrome = /chrome/.test(navigator.userAgent.toLowerCase());
	if ($.browser.chrome) $.browser.safari = false;
	
	fv.dataUrl = encodeURIComponent("{$dataUrl}");
	fv.hueMin = {$hueMin};
	fv.hueMax = {$hueMax};
	fv.satMin = {$satMin};
	fv.satMax = {$satMax};
	fv.lgtMin = {$lgtMin};
	fv.lgtMax = {$lgtMax};
	{* we need to add 22 pixel for safari due to wrong width calculation for the select *}
	fv.iconOffset = $('#userCountryMapSelectMetrics').width() + 22 + ($.browser.safari ? 22 : 0);
	fv.defaultMetric = "{$defaultMetric}";
	
	fv.txtLoading = encodeURIComponent("{'General_Loading_js'|translate}");
	fv.txtLoadingData = encodeURIComponent("{'General_LoadingData'|translate}");
	fv.txtToggleFullscreen = encodeURIComponent("{'UserCountryMap_toggleFullscreen'|translate}");
	fv.txtExportImage = encodeURIComponent("{'General_ExportAsImage_js'|translate}");

{literal}	
	
	var attr = { id:"UserCountryMap" };
{/literal}	
	swfobject.embedSWF("plugins/UserCountryMap/PiwikMap.swf?piwik={$version}", "UserCountryMap_map", "100%", "300", 
{literal}	
	"9.0.0", "libs/swfobject/expressInstall.swf", fv, params, attr, function (e) {
		//e.ref.height = Math.round($('#widgetUserCountryMapworldMap').width() *.55);
	});
	
	$("#userCountryMapSelectMetrics").change(function(el) {
		$("#UserCountryMap")[0].changeMode(el.currentTarget.value);
	});
	$("#userCountryMapSelectMetrics").keypress(function(e) { 
		var keyCode = e.keyCode || e.which; 
		if (keyCode == 38 || keyCode == 40) { // if up or down key is pressed
			$(this).change(); // trigger the change event
		} 
	});
	
	$(".userCountryMapFooterIcons a.tableIcon[var=fullscreen]").click(function() {
		$("#UserCountryMap")[0].setFullscreenMode();	
	});
	
	$(".userCountryMapFooterIcons a.tableIcon[var=export_png]").click(function() {
		$("#UserCountryMap")[0].exportPNG();
	});
	
	$(window).resize(function() {
		$("#UserCountryMap")[0].height = Math.round($('#UserCountryMap').width() *.55);
		$("#UserCountryMap")[0].setIconOffset($('#userCountryMapSelectMetrics').width()+22+($.browser.safari ? 22 : 0));
	});
	
});

{/literal}

</script>
<div id="UserCountryMap_content" style="position:relative; overflow:hidden;">
	<div id="UserCountryMap_map">{'General_RequiresFlash'|translate}</div>
	<div style="height:3px"></div>
	<select id="userCountryMapSelectMetrics" style="position:absolute; left: 5px; bottom: 0px;">
		{foreach from=$metrics item=metric}
			<option value="{$metric[0]}" {if $metric[0] == $defaultMetric}selected="selected"{/if}>{$metric[1]}</option>
		{/foreach}
	</select>
</div>