component extends="mura.plugin.pluginGenericEventHandler" accessors=true output=false {
	public void function onApplicationLoad(required struct $) output=false {
		variables.pluginConfig.addEventHandler(this);
		variables.package = variables.pluginConfig.getPackage();
		variables.configBean = getBean('configBean');

		$.getServiceFactory().declareBean(beanName='errorLog', dottedPath='#variables.package#.orm.errorLog', isSingleton=false);
		$.getBean('errorLog').checkSchema();

		// set error template to catch CFML errors
		// this will overide the default error page in mura
		variables.configBean.setErrorTemplate('/plugins/logger/assets/message/error.cfm')

		buildModel($);
	}

	private void function buildModel(required struct $) output=false {
		var package = variables.pluginConfig.getPackage();

		application[variables.package] = structNew();
		application[variables.package].framework = createObject("component", "#variables.package#.lib.framework").init(variables.pluginConfig);
		application[variables.package].model = createObject("component", "#variables.package#.model.#package#").init($, variables.pluginConfig);

	}

	public any function onSiteRequestStart(required struct $) {
		var requestData = GetHTTPRequestData();

		if (structKeyExists(requestData.headers, "content-type") && requestData.headers['content-type'] == "application/json") {
			var e = structNew();
			// test this and make sure the "key" works
			// consider using the XSS tokens in Mura
			e.body = deserializeJSON(requestData.content);

			if (e.body.key eq "MuraLogJS") {
				var s = structNew();
				s.form = form;
				s.url = url;
				s.cgi = cgi;
				s.session = session;
				s.cookie = cookie;
				s.requestData = GetHTTPRequestData();
				s.currentUser = getCurrentUser().getAllValues();

				var errorLog = getBean('errorLog');
				errorLog.setLogID(createUUID());
				errorLog.setUserID(getCurrentUser().getUserID());
				errorLog.setSource('JavaScript');
				errorLog.setErrorData(serializeJSON(e));
				errorLog.setSystemData(serializeJSON(s));
				errorLog.setDateAdded(now());
				errorLog.save();

				cfcontent(reset="true");
				abort;
			}
		}
	}

	public any function onRenderStart(required struct $) {
		if (variables.pluginConfig.getSetting('plMode') == "Development") {
			buildModel($);
		}

		// add javascript logging
		variables.pluginConfig.addToHTMLHeadQueue('assets/scripts/stacktrace.cfm');

		// for ajax calls
		if (len($.event('action') gt 4) && right($.event('action'), 4) == "JSON") {
			$.event('contentBean').setOriginalTemplate($.event('contentBean').getTemplate());
			$.event('contentBean').setTemplate('blank.cfm');
		}
	}
}
