component extends='mura.cfobject' accessors=true output=false {
	public any function init(required struct $, required struct pluginConfig) output='false' {
		variables.pluginConfig = arguments.pluginConfig;
		variables.configBean = getBean('configBean');

		return this;
	}

	public void function cleanErrorLog(required date since=dateAdd('d', -14, now())) output='false' {
		var q = new Query();
		var sql = 'delete from errorlog where dateAdded <= :since';
		q.addParam(name="since", value=since, cfsqltype='cf_sql_timestamp');
		q.setSql(sql).execute();
	}
	
	public query function getErrorListQuery($) output='false' {
		var q = new Query();
		var sql = "select errorlog.*, tusers.fname, tusers.lname from errorlog ";
		sql &= "left join tusers on errorlog.userID = tusers.userID ";
		sql &= "order by errorlog.dateAdded desc";
		
		return q.setSql(sql).execute().getResult();
	}
	
}
