LogJS = function(message, url, lineNumber, columnNumber, error) {
	try {
		var clientSideErrorInfo = {
			message: message,
			url: url,
			lineNumber: lineNumber,
			columnNumber: columnNumber,
			error: error,
			// EDB: make sure this works, consider using the XSS tokens?
			key: 'MuraLogJS'
		};

		// look at browser compatibility to see if this assumption is ok
		// if not, then look at using MuraJS to make the Ajax request
		var xhr = new XMLHttpRequest();
		xhr.open("POST", '/', true);
		xhr.setRequestHeader("Content-Type", "application/json");
		xhr.send(JSON.stringify(clientSideErrorInfo));
	} catch (e) {
		// Don't allow for infinitely recursively unhandled errors
		return true;
	}
};

// This handler is used to log all client-side errors on server. 
window.onerror = LogJS;