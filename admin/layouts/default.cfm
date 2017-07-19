<cfset $.rc.pluginConfig.addToHTMLHeadQueue('assets/scripts/admin.cfm')>
<cfset $.rc.baseURL = cgi.script_name>

<cfsavecontent variable="body"><cfoutput>
	<h2><i class="icon-list"></i> Logger</h2>
	<div class="btn-group header">
		<a class="btn" href="?action=admin.errorlist">Error Log</a>
	</div>
	<hr>
	<div class="plugin-admin-container">#$.rc.bodyContent#</div>
</cfoutput></cfsavecontent>

<cfoutput>#application.pluginManager.renderAdminTemplate(body=body,pageTitle='Admin')#</cfoutput>