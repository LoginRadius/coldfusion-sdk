<cfinclude template="config.cfm">
<link rel="stylesheet" href="css/styles.css" />
<cfif structkeyexists(form, "title") && structkeyexists(form, "status")>
<cfset SdkObject = createObject("component","loginradiussdk")>
<cfscript>
try{
lr_url = '';
if(structkeyexists(form, "url")){
	lr_url = form.url;
}
imageurl = '';
if(structkeyexists(form, "imageurl")){
	imageurl = form.imageurl;
}
imageurl = '';
if(structkeyexists(form, "imageurl")){
	imageurl = form.imageurl;
}
description = '';
if(structkeyexists(form, "description")){
	description = form.description;
}
output = SdkObject.loginradiusPostStatus(form.lraccesstoken, form.title, lr_url, imageurl, form.status, '', description);
writeDump(output);
}
catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
</cfscript>
<cfelseif structkeyexists(form, "to") && structkeyexists(form, "subject") && structkeyexists(form, "message")>
<cfset SdkObject = createObject("component","loginradiussdk")>
<cfscript>
try{
output = SdkObject.loginradiusSendMessage(form.lraccesstoken, form.to, form.subject,form.message);
writeDump(output);
}
catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 

</cfscript>
<cfelseif !structkeyexists(form, "token")>
    <script src="https://hub.loginradius.com/include/js/LoginRadius.js"></script>
<script type="text/javascript"> var options={}; options.login=true; LoginRadius_SocialLogin.util.ready(function () { $ui = LoginRadius_SocialLogin.lr_login_settings;$ui.interfacesize = "";$ui.apikey = "<cfoutput>#LR_APIKEY#</cfoutput>";$ui.callback="<cfoutput>#YOUR_DOMAIN#</cfoutput>"; $ui.lrinterfacecontainer ="interfacecontainerdiv"; LoginRadius_SocialLogin.init(options); }); </script>
<h1>LoginRadius Demo</h1>
<div id="interfacecontainerdiv" class="interfacecontainerdiv"></div>
<cfelse>
<cfinclude template="callback.cfm">
</cfif>
