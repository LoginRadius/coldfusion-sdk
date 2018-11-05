<cfcomponent displayname="configurationapi" hint="This is the CFC for Configuration APIs">
<cfinclude template="init.cfm">
<!---

    Initialise in to your application using:

    <cfset SdkObject = createObject("component","lrsdk.configurationapi").init(
        lr_api_key = "Your API Key",
        lr_api_secret = "Your Secret Key"
      )>

   --->

  <cffunction name="init" hint="sets up an instance of the component" output="false">

    <cfargument name="lr_api_key" required="true" hint="API key provided by LoginRadius" type="string" />
    <cfargument name="lr_api_secret" required="true" hint="API secret provided by LoginRadius" type="string" />
    <cfargument name="LR_CONFIG_API_ENDPOINT" required="false" default="https://config.lrcontent.com/ciam" hint="LoginRadius configuration api endpoint" type="string" />
	<cfargument name="LR_SERVER_API_ENDPOINT" required="false" default="https://api.loginradius.com/identity/v2" hint="LoginRadius server api endpoint" type="string" />
   
    <cfset variables.lr_api_key = arguments.lr_api_key />
    <cfset variables.lr_api_secret = arguments.lr_api_secret />
    <cfset variables.LR_CONFIG_API_ENDPOINT = arguments.LR_CONFIG_API_ENDPOINT />
    <cfset variables.LR_SERVER_API_ENDPOINT = arguments.LR_SERVER_API_ENDPOINT />

    <cfreturn this />
  </cffunction>

  <!-- Configuration API -->

 <cffunction name="getConfigurations" hint="This API is used to get the configurations which are set in the LoginRadius Dashboard.">

	<cfhttp url="#variables.LR_CONFIG_API_ENDPOINT#/appinfo">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>
  
  <cffunction name="getServerTime" hint="This API allows you to query your LoginRadius account for basic server information and server time information which is useful when generating an SOTT token.">
	    <!--- Define arguments. --->
    <cfargument name="timedifference" type="string" required="false" default="10" hint="time difference"/>

	<cfhttp url="#variables.LR_SERVER_API_ENDPOINT#/serverinfo">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="timedifference" value="#arguments.timedifference#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
   </cffunction>

</cfcomponent>