<cfoutput>
	<cftry>
		#DateFormat(now(),'MMM dd, yyyy')#
		#hello#
		<!--- Will display the custom error page in the /messages folder and log and error that variable [Hello] does not exist. --->
	<cfcatch type = "any">
		<cfrethrow>
		<h1>Sorry, there was an error.</h1>
	</cfcatch>
	</cftry>
</cfoutput>
