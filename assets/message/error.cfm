<!--- Edit this file to change the Edit what happens when a CF error is encountered --->
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta name="description" content="">
		<meta name="author" content="">
		<title>Error</title>
		<style media="screen">
			body {
				background-color: #bbbbbb;
				background-image: -moz-radial-gradient(center, ellipse cover, #aaa 0%, #333333 100%);
				background-image: -webkit-radial-gradient(center, ellipse cover, #aaa 0%, #333333 100%);
				background-image: -o-radial-gradient(center, ellipse cover, #aaa 0%, #333333 100%);
				background-image: -ms-radial-gradient(center, ellipse cover, #aaa 0%, #333333 100%);
				background-image: radial-gradient(center, ellipse cover, #aaa 0%, #333333 100%);
				filter: progid:DXImageTransform.Microsoft.gradient(startColorstr =  '#aaa', endColorstr = '#333', GradientType = 0);
				font-family: "Helvetica Neue",Helvetica,Arial,sans-serif;
				font-size: 14px;
				line-height: 1.42857143;
			}
			html {
				height: 100%;
			}
			div.jumbotron {
				background-color: #eee;
				position: absolute;
				top: 40%;
				left: 50%;
				padding: 15px;
				-ms-transform: translateX(-50%) translateY(-50%);
				-webkit-transform: translate(-50%,-50%);
				transform: translate(-50%,-50%);
				border-radius: 6px;
				box-shadow: 0 1px 18px -2px black;
			}

			div.jumbotron h1 {
				font-size: 63px;
				margin-top: 20px;
				margin-bottom: 10px;
			}

			div.jumbotron {
				padding-right: 60px;
				padding-left: 60px;

			}

			.jumbotron p {
				margin-bottom: 15px;
				font-size: 21px;
				font-weight: 200;
			}

			.btn {
				display: inline-block;
				padding: 6px 12px;
				margin-bottom: 0;
				font-size: 14px;
				font-weight: 400;
				line-height: 1.42857143;
				text-align: center;
				white-space: nowrap;
				vertical-align: middle;
				-ms-touch-action: manipulation;
				touch-action: manipulation;
				cursor: pointer;
				-webkit-user-select: none;
				-moz-user-select: none;
				-ms-user-select: none;
				user-select: none;
				background-image: none;
				border: 1px solid transparent;
				border-radius: 4px;
			}

			.btn-primary {
				color: #fff;
				text-decoration: none;
				background-color: #337ab7;
				border-color: #2e6da4;
			}

			.btn-lg {
				padding: 10px 16px;
				font-size: 18px;
				line-height: 1.3333333;
				border-radius: 6px;
			}

		</style>
	</head>
	<body>
		<div class="jumbotron">
			<h1>We're sorry...</h1>
			<p>An Error Occurred.</p>
			<p><a href="/" class="btn btn-primary btn-lg" role="button">Home</a></p>
		</div>
	</body>
</html>

<cfset e=structNew()>
<cfset e.exception=arguments.exception>
<cfset s=structNew()>
<cfset s.form=form>
<cfset s.url=url>
<cfset s.cgi=cgi>
<cfset s.session=session>
<cfset s.cookie=cookie>
<cfset s.key='MuraLogCFML'/>
<cfset s.requestData=GetHTTPRequestData()>
<cfset s.currentUser=application.configBean.getCurrentUser().getAllValues()>

<cfset errorLog=application.configBean.getBean('errorLog')>
<cfset errorLog.setLogID(createUUID())>
<cfset errorLog.setUserID(application.configBean.getCurrentUser().getUserID())>
<cfset errorLog.setSource('CFML')>
<cfset errorLog.setErrorData(serializeJSON(e))>
<cfset errorLog.setSystemData(serializeJSON(s))>
<cfset errorLog.setDateAdded(now())>
<cfset errorLog.save()>
