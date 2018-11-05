<cfcomponent displayname="customobjectapi" hint="This is the CFC for Customer Identity Management APIS">
<cfinclude template="init.cfm">
<!---

    Initialise in to your application using:

    <cfset SdkObject = createObject("component","lrsdk.customobjectapi").init(
        lr_api_key = "Your API Key",
        lr_api_secret = "Your Secret Key",
	lr_api_signing = "true/false"
      )>

   --->

  <cffunction name="init" hint="sets up an instance of the component" output="false">

    <cfargument name="lr_api_key" required="true" hint="API key provided by LoginRadius" type="string" />
    <cfargument name="lr_api_secret" required="true" hint="API secret provided by LoginRadius" type="string" />
	<cfargument name="lr_api_signing" required="true" hint="API request signing option" type="string" />
    <cfargument name="LR_AUTH_CUSTOM_OBJECT_API_ENDPOINT" required="false" default="https://api.loginradius.com/identity/v2/auth" hint="LoginRadius custom object auth api endpoint" type="string" />
	<cfargument name="LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT" required="false" default="https://api.loginradius.com/identity/v2/manage/account" hint="LoginRadius custom object account api endpoint" type="string" />

    <cfset variables.lr_api_key = arguments.lr_api_key />
    <cfset variables.lr_api_secret = arguments.lr_api_secret />
	<cfset variables.lr_api_signing = arguments.lr_api_signing />
    <cfset variables.LR_AUTH_CUSTOM_OBJECT_API_ENDPOINT = arguments.LR_AUTH_CUSTOM_OBJECT_API_ENDPOINT />
    <cfset variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT = arguments.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT />

    <cfreturn this />
  </cffunction>

  <cffunction name="createCustomObjectByUid" hint="This API is used to write information in JSON format to the custom object for the specified account.">

   <cfargument name="uid" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
   <cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey']= "#variables.lr_api_key#">
		    <cfset params['objectname']= "#arguments.objectname#">
			<cfset requestURL= "#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject">
			<cfset arrayval= "#getHash(requestURL, params, payload)#">
	</cfif>

	<cfhttp method="POST" url="#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="createCustomObjectByToken" hint="This API is used to write information in JSON format to the custom object for the specified account.">

   <cfargument name="accesstoken" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
   <cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfhttp method="POST" url="#variables.LR_AUTH_CUSTOM_OBJECT_API_ENDPOINT#/customobject">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="customObjectByObjectRecordIdAndUid" hint="This API is used to retrieve the Custom Object data for the specified account.">

   <cfargument name="uid" type="string" required="true" />
   <cfargument name="objectrecordid" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey']= "#variables.lr_api_key#">
		    <cfset params['objectname']= "#arguments.objectname#">
			<cfset requestURL= "#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject/#arguments.objectrecordid#">
			<cfset arrayval= "#getHash(requestURL, params)#">
	   </cfif>

	<cfhttp url="#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject/#arguments.objectrecordid#">
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
	  <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="customObjectByObjectRecordIdAndToken" hint="This API is used to retrieve the Custom Object data for the specified account.">

   <cfargument name="accesstoken" type="string" required="true" />
   <cfargument name="objectrecordid" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
	<cfhttp url="#variables.LR_AUTH_CUSTOM_OBJECT_API_ENDPOINT#/customobject/#arguments.objectrecordid#">
      <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="getCustomObjectByToken" hint="This API is used to retrieve the Custom Object data for the specified account.">

   <cfargument name="accesstoken" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
	<cfhttp url="#variables.LR_AUTH_CUSTOM_OBJECT_API_ENDPOINT#/customobject">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="getCustomObjectByUid" hint="This API is used to retrieve all the custom objects by UID from cloud storage.">

   <cfargument name="uid" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey']= "#variables.lr_api_key#">
		    <cfset params['objectname']= "#arguments.objectname#">
			<cfset requestURL= "#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject">
			<cfset arrayval= "#getHash(requestURL, params)#">
	   </cfif>

	<cfhttp url="#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="updateCustomObjectByUid" hint="This API is used to update the specified custom object data by uid.">

   <cfargument name="uid" type="string" required="true" />
   <cfargument name="objectrecordid" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
   <cfargument name="updatetype" type="string" required="true"  hint="updatetype"/>
   <cfargument name="payload" type="any" required="true" hint ="data in json format"/>
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey']= "#variables.lr_api_key#">
		    <cfset params['objectname']= "#arguments.objectname#">
		    <cfset params['updatetype']= "#arguments.updatetype#">
			<cfset requestURL= "#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject/#arguments.objectrecordid#">
			<cfset arrayval= "#getHash(requestURL, params, payload)#">
	   </cfif>

	<cfhttp method="PUT" url="#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject/#arguments.objectrecordid#">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
	  <cfhttpparam name="updatetype" value="#arguments.updatetype#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="updateCustomObjectByToken" hint="This API is used to update the specified custom object data by token.">

   <cfargument name="accesstoken" type="string" required="true" />
   <cfargument name="objectrecordid" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
   <cfargument name="updatetype" type="string" required="false" default=""  hint="updatetype"/>
   <cfargument name="payload" type="any" required="true" hint ="data in json format"/>

	<cfhttp method="PUT" url="#variables.LR_AUTH_CUSTOM_OBJECT_API_ENDPOINT#/customobject/#arguments.objectrecordid#">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
	  <cfhttpparam name="updatetype" value="#arguments.updatetype#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="deleteCustomObjectByUid" hint="This API is used to remove the specified Custom Object data using ObjectRecordId of specified account.">

   <cfargument name="uid" type="string" required="true" />
   <cfargument name="objectrecordid" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
   <cfargument name="payload" type="any" required="false" default="" hint ="data in json format"/>
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey']= "#variables.lr_api_key#">
		    <cfset params['objectname']= "#arguments.objectname#">
			<cfset requestURL= "#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject/#arguments.objectrecordid#">
			<cfset arrayval= "#getHash(requestURL, params, payload)#">
	   </cfif>

	<cfhttp method="DELETE" url="#variables.LR_ACCOUNT_CUSTOM_OBJECT_API_ENDPOINT#/#arguments.uid#/customobject/#arguments.objectrecordid#">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="deleteCustomObjectByToken" hint="This API is used to remove the specified Custom Object data using token of specified account.">

   <cfargument name="accesstoken" type="string" required="true" />
   <cfargument name="objectrecordid" type="string" required="true" />
   <cfargument name="objectname" type="string" required="true" />
   <cfargument name="payload" type="any" required="false" default="" hint ="data in json format"/>

	<cfhttp method="DELETE" url="#variables.LR_AUTH_CUSTOM_OBJECT_API_ENDPOINT#/customobject/#arguments.objectrecordid#">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="objectname" value="#arguments.objectname#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 </cfcomponent>