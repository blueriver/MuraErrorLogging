<cfset rs = $.rc.rsErrorList>

<cfif rs.recordcount>
	<script type="text/javascript">
		$(document).ready(function(){
			$('#error-log-dt').DataTable({
				"order": [[ 2, "desc" ]]
			});
		});
	</script>
	<cfoutput>
		<div class="btn-group header">
			<a class="btn" href="?action=admin.acterrordeleteall"><i class="icon-trash"></i> Delete All</a>
		</div>
		<table id="error-log-dt" class="display nowrap dataTable dtr-inline">
			<thead>
				<tr>
					<th>Source</th>
					<th>User</th>
					<th>Date Added</th>
				</tr>
			</thead>
			<tbody>
				<cfloop query="rs">
					<tr>
						<td>
							<a href="?action=admin.error&logID=#rs.logID#">#rs.source#</a>
						</td>
						<td>
							<cfif len(rs.fname) && len(rs.lname)>
								#rs.fname# #rs.lname#
							<cfelse>
								Guest User
							</cfif>
						</td>
						<td>
							#dateTimeFormat(rs.dateAdded)#
						</td>
					</tr>
				</cfloop>
			</tbody>
		</table>
	</cfoutput>
</cfif>
