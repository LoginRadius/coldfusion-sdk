<!DOCTYPE html>
<html>
<head>
 <title>User Registration Demo</title>
<link rel="stylesheet" href="css/style.css" />
<link href='http://fonts.googleapis.com/css?family=Open+Sans' rel='stylesheet' type='text/css'>
<link rel="stylesheet" href="http://code.jquery.com/ui/1.10.3/themes/smoothness/jquery-ui.css">
 <link rel="stylesheet" type="text/css" href="css/social-icons.css">
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.8.3/jquery.min.js"></script>
    <script src="https://hub.loginradius.com/include/js/LoginRadius.js"></script>
        <script src="http://cdn.loginradius.com/hub/prod/js/LoginRadiusRaaS.js"></script>
        <script src="http://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
    <script src="js/LoginRadiusSDK.js"></script>

    <script src="js/script.js"></script>
     <script type="text/javascript">
        //initialize raas options
        var raasoption = {};
        var LocalDomain = '<cfoutput>#YOUR_DOMAIN#</cfoutput>';
        raasoption.apikey = '<cfoutput>#RAAS_API_KEY#</cfoutput>';
        raasoption.inFormvalidationMessage = true;
        raasoption.templatename = "loginradiuscustom_tmpl";
        raasoption.hashTemplate = true;
        raasoption.emailVerificationUrl = '<cfoutput>#YOUR_DOMAIN#</cfoutput>';
        raasoption.forgotPasswordUrl = '<cfoutput>#YOUR_DOMAIN#</cfoutput>';
        

    </script>
</head>
<body>