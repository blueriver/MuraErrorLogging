<script type="text/javascript">
$(document).ready(function() {

			$('.createError').on('click', 'a.setError', function(e) {
					e.preventDefault();

					var entityid = $(this).parent().data('entityid');

					mura
						.getEntiy('content')
						.loadBy('contentid', entityid)
						.then(
							function(item) {
								console.log(item);
							})
						.then(
							function(item) {
								console.log(item);
							}
						);
				});

		});

</script>

<cfoutput>
	<table class="createError">
		<tr>
			<td entityid="#$.content('contentid')#">
				<a href="##" class="setError" >Make an Error</a>
			</td>
		</tr>
	</table>
</cfoutput>
