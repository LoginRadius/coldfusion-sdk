<cfcomponent displayname="webhookapi" hint="This is the CFC for Web Hook APIs">
<cfinclude template="init.cfm">
<!---

    Initialise in to your application using:

    <cfset SdkObject = createObject("component","lrsdk.webhookapi").init(
        lr_api_key = "Your API Key",
        lr_api_secret = "Your Secret Key"
      )>
   --->

  <cffunction name="init" hint="sets up an instance of the component" output="false">

    <cfargument name="lr_api_key" required="true" hint="API key provided by LoginRadius" type="string" />
    <cfargument name="lr_api_secret" required="true" hint="API secret provided by LoginRadius" type="string" />
    <cfargument name="LR_WEB_HOOK_API_ENDPOINT" required="false" default="http://api.loginradius.com/api/v2/webhook" hint="LoginRadius web hook api endpoint" type="string" />

    <cfset variables.lr_api_key = arguments.lr_api_key />
    <cfset variables.lr_api_secret = arguments.lr_api_secret />
    <cfset variables.LR_WEB_HOOK_API_ENDPOINT = arguments.LR_WEB_HOOK_API_ENDPOINT />

    <cfreturn this />
  </cffunction>


  <cffunction name="webHookSubscribe" hint="API can be used to configure a WebHook on your LoginRadius site.">

    <cfargument name="targeturl" type="string" required="true" hint="targeturl"/>
    <cfargument name="event" type="string" required="true" hint="event"/>
    <cfset payload =  "{ 'targeturl': '#arguments.targeturl#', 'event': '#arguments.event#' }" />

    <cfhttp method="POST" url="#variables.LR_WEB_HOOK_API_ENDPOINT#">
	 <cfhttpparam type="header" name="Content-Type" value="application/json" />
         <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
         <cfhttpparam name="apisecret" value="#variables.lr_api_secret#" type="URL">
         <cfhttpparam value="#payload#" type="body">    
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

 <cffunction name="webHookTest" hint="API can be used to test a subscribed WebHook.">
	
    <cfhttp url="#variables.LR_WEB_HOOK_API_ENDPOINT#/test">
         <cfhttpparam type="header" name="Content-Type" value="application/json" />
         <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
         <cfhttpparam name="apisecret" value="#variables.lr_api_secret#" type="URL">     
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="getWebHookSubscribedUrl" hint="This API is used to fatch all the subscribed URLs, for particular event.">
	
    <cfargument name="event" type="string" required="true" hint="event"/>
    <cfhttp url="#variables.LR_WEB_HOOK_API_ENDPOINT#">
         <cfhttpparam type="header" name="Content-Type" value="application/json" />
         <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
         <cfhttpparam name="apisecret" value="#variables.lr_api_secret#" type="URL">     
  	 <cfhttpparam name="event" value="#arguments.event#" type="URL">  
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

   <cffunction name="webHookUnsubscribe" hint="This API can be used to unsubscribe a WebHook configured on your LoginRadius site.">
		    <!--- Define arguments. --->
        <cfargument name="targeturl" type="string" required="true" hint="targeturl"/>
        <cfargument name="event" type="string" required="true" hint="event"/>
        <cfset payload =  "{ 'targeturl': '#arguments.targeturl#', 'event': '#arguments.event#' }" />
		
	<cfobject type="java" class="RestRequest" name="myObj"> 
	<cfset requestURL= "#variables.LR_WEB_HOOK_API_ENDPOINT#?apikey=#variables.lr_api_key#&apisecret=#variables.lr_api_secret#">
	<cfset result = myObj.delete(requestURL, "", payload, "", false)> 
	
	    <!--- Get Response --->
	<cfreturn loginradiusDeleteResponse(result)>
  </cffunction>

</cfcomponent>