<cfset error = $.rc.error>

<cfoutput>
	<div class="btn-group header">
		<a class="btn" href="?action=admin.errorlist"><i class="icon-backward"></i> Back</a>
		<a class="btn" href="?action=admin.acterrordelete&logid=#error.getLogID()#"><i class="icon-trash"></i> Delete</a>
	</div>

	<!--- Get the actual error message from our logger bean --->
	<cfset getErrorMessage = #deserializeJSON(error.getErrorData())# >
	<!--- Because we use the same display page for CFML or JSON we will use this simple conditional to shoel the error and line number seperatley below --->
	<cfset errorMessage = error.getSource() == 'CFML' ? getErrorMessage.exception.message : getErrorMessage.body.message>
	<cfset lineNumber = error.getSource() == 'CFML' ? getErrorMessage.exception.tagcontext[1]['line'] : getErrorMessage.body.linenumber>

	<script type="text/javascript">
		// set our error data var
		var errorData = #error.getErrorData()#;
		// set our system data var
		var systemData = #error.getSystemData()#;

		$(document).ready(function() {
					// load the error data into the pretty json plugin
					var eNode = new PrettyJSON.view.Node({
                el:$('##errorData'),
                data: errorData,
                dateFormat:"DD/MM/YYYY - HH24:MI:SS"
            });
					// load the system data into the pretty json plugin
					var sNode = new PrettyJSON.view.Node({
                el:$('##systemData'),
                data: systemData,
                dateFormat:"DD/MM/YYYY - HH24:MI:SS"
            });

		});
	</script>


	<dl>
		<dt class="itemHeader">Log ID</dt>
		<dd>#error.getLogID()#</dd>
		<dt class="itemHeader">User ID</dt>
		<dd>#error.getUserID()#</dd>
		<dt class="itemHeader">Source</dt>
		<dd>#error.getSource()#</dd>
		<dt class="itemHeader">dateAdded</dt>
		<dd>#dateTimeFormat(error.getDateAdded())#</dd>
		<dt class="itemHeader">Error Message & Line Number</dt>
		<dd id="errorMessage">#errorMessage#<br />
		Line Number: #lineNumber#</dd>
		<dt class="itemHeader">Full Error</dt>
		<dd id="errorData">
			<!--- standard lucee/cf dumps --->
			<!--- <cfif isJSON(error.getErrorData())>
				<cfdump var="#deserializeJSON(error.getErrorData())#">
			<cfelse>
				#error.getErrorData()#
			</cfif> --->
		</dd>
		<dt class="itemHeader">System Data</dt>
		<dd id="systemData">
			<!--- standard lucee/cf dumps --->
			<!--- <cfif isJSON(error.getSystemData())>
				<cfdump var="#deserializeJSON(error.getSystemData())#">
			<cfelse>
				#error.getSystemData()#
			</cfif> --->
		</dd>
</cfoutput>
