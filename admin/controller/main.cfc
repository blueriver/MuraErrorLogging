component extends="mura.cfobject" output=false {
	public void function default(required struct $) {
		
	}
	
	public void function errorlist(required struct $) {
		$.rc.rsErrorList = $.rc.model.getErrorListQuery($);
	}
	
	public void function error(required struct $) {
		$.rc.error = $.getBean('errorLog').loadBy(logID=$.event('logID'));
	}
	
	public void function actErrorDeleteAll(required struct $) {
		$.rc.model.cleanErrorLog(now());
		
		location(url='?action=admin.errorlist', addtoken='false');
	}
	
	public void function actErrorDelete(required struct $) {
		$.rc.error = $.getBean('errorLog').loadBy(logID=$.event('logID'));
		$.rc.error.delete();
		
		location(url='?action=admin.errorlist', addtoken='false');
	}
}