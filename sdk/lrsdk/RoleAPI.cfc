<cfcomponent displayname="roleapi" hint="This is the CFC for Role Management APIs">
<cfinclude template="init.cfm">
<!---

    Initialise in to your application using:

    <cfset SdkObject = createObject("component","lrsdk.roleapi").init(
        lr_api_key = "Your API Key",
        lr_api_secret = "Your Secret Key",
	lr_api_signing = "true/false"
      )>

   --->

  <cffunction name="init" hint="sets up an instance of the component" output="false">

    <cfargument name="lr_api_key" required="true" hint="API key provided by LoginRadius" type="string" />
    <cfargument name="lr_api_secret" required="true" hint="API secret provided by LoginRadius" type="string" />
	<cfargument name="lr_api_signing" required="true" hint="API request signing option" type="string" />
    <cfargument name="LR_ROLE_API_ENDPOINT" required="false" default="https://api.loginradius.com/identity/v2/manage" hint="LoginRadius role api endpoint" type="string" />

	<cfset variables.lr_api_key = arguments.lr_api_key />
    <cfset variables.lr_api_secret = arguments.lr_api_secret />
	<cfset variables.lr_api_signing = arguments.lr_api_signing />
    <cfset variables.LR_ROLE_API_ENDPOINT = arguments.LR_ROLE_API_ENDPOINT />

    <cfreturn this />
  </cffunction>


  <cffunction name="rolesCreate" hint="This API creates a role with permissions.">

   <cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfif #variables.lr_api_signing# EQ "true">
		    <cfset params['apikey']= "#variables.lr_api_key#">
		    <cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/role">
			<cfset arrayval= "#getHash(requestURL, params, payload)#">
	</cfif>

	<cfhttp method="POST" url="#variables.LR_ROLE_API_ENDPOINT#/role">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="getContext" hint="This API Gets the contexts that have been configured and the associated roles and permissions.">

	<cfargument name="uid" type="string" required="true" />
	<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey']= "#variables.lr_api_key#">
			<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/rolecontext">
			<cfset arrayval= "#getHash(requestURL, params)#">
	</cfif>
	<cfhttp url="#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/rolecontext">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
       <cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	   <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	   </cfif>
     </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="rolesList" hint="This API retrieves the complete list of created roles with permissions of your app.">

 	<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey']= "#variables.lr_api_key#">
			<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/role">
			<cfset arrayval= "#getHash(requestURL, params)#">
	</cfif>

	<cfhttp url="#variables.LR_ROLE_API_ENDPOINT#/role">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
		 <cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	     <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	     </cfif>
     </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="getRolesByUid" hint="This API is used to retrieve all the assigned roles of a particular User.">

    <cfargument name="uid" type="string" required="true" />
	<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey']= "#variables.lr_api_key#">
			<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/role">
			<cfset arrayval= "#getHash(requestURL, params)#">
	</cfif>

	<cfhttp url="#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/role">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
     </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="addPermissionToRole" hint="This API is used to add permissions to the role.">

	<cfargument name="role" type="string" required="true" />
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
    <cfif #variables.lr_api_signing# EQ "true">
		    <cfset params['apikey']= "#variables.lr_api_key#">
			<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/role/#arguments.role#/permission">
			<cfset arrayval= "#getHash(requestURL, params, payload)#">
	</cfif>

	<cfhttp method="PUT" url="#variables.LR_ROLE_API_ENDPOINT#/role/#arguments.role#/permission">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
		 <cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	     <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	     </cfif>
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam value="#arguments.payload#" type="body">
     </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="assignRolesByUid" hint="This API is used to assign created roles to the user.">

	<cfargument name="uid" type="string" required="true" />
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfif #variables.lr_api_signing# EQ "true">
		    <cfset params['apikey']= "#variables.lr_api_key#">
			<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/role">
			<cfset arrayval= "#getHash(requestURL, params, payload)#">
	</cfif>

	<cfhttp method="PUT" url="#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/role">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam value="#arguments.payload#" type="body">
     </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="upsertContext" hint="This API creates a Context with a set of Roles.">

	<cfargument name="uid" type="string" required="true" />
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfif #variables.lr_api_signing# EQ "true">
		    <cfset params['apikey']= "#variables.lr_api_key#">
			<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/rolecontext">
			<cfset arrayval= "#getHash(requestURL, params, payload)#">
	</cfif>

	<cfhttp method="PUT" url="#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/rolecontext">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam value="#arguments.payload#" type="body">
     </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="deleteRole" hint="This API is used to delete the role.">

	<cfargument name="role" type="string" required="true" />
 	<cfargument name="payload" type="any" required="false" default="" hint ="data in json format"/>
	<cfif #variables.lr_api_signing# EQ "true">
		    <cfset params['apikey']= "#variables.lr_api_key#">
			<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/role/#arguments.role#">
			<cfset arrayval= "#getHash(requestURL, params, payload)#">
	</cfif>

	<cfhttp method="DELETE" url="#variables.LR_ROLE_API_ENDPOINT#/role/#arguments.role#">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
		 <cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	     <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	     </cfif>
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam value="#arguments.payload#" type="body">
     </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="unassignRolesByUid" hint="This API is used to unassign roles to the user.">

	<cfargument name="uid" type="string" required="true" />
 	<cfargument name="payload" type="any" required="true" hint="data in json format"/>

        <cfobject type="java" class="RestRequest" name="myObj"> 
	<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/role?apikey=#variables.lr_api_key#">
	<cfset result = myObj.delete(requestURL, "", payload, "#variables.lr_api_secret#", #variables.lr_api_signing#)> 

        <cfreturn loginradiusDeleteResponse(result)>
  </cffunction>

  <cffunction name="removePermission" hint="This API is used to remove permissions to the role.">

	<cfargument name="rolename" type="string" required="true" />
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>

        <cfobject type="java" class="RestRequest" name="myObj"> 
	<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/role/#arguments.rolename#/permission?apikey=#variables.lr_api_key#">
	<cfset result = myObj.delete(requestURL, "", payload, "#variables.lr_api_secret#", #variables.lr_api_signing#)> 

        <cfreturn loginradiusDeleteResponse(result)>
  </cffunction>

  <cffunction name="deleteContext" hint="This API Deletes the specified Role Context.">

	<cfargument name="uid" type="string" required="true" />
    <cfargument name="rolecontextname" type="string" required="true" />
 	<cfargument name="payload" type="any" required="false" default="" hint ="data in json format"/>
	<cfif #variables.lr_api_signing# EQ "true">
		    <cfset params['apikey']= "#variables.lr_api_key#">
			<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/rolecontext/#arguments.rolecontextname#">
			<cfset arrayval= "#getHash(requestURL, params, payload)#">
	</cfif>

	<cfhttp method="DELETE" url="#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/rolecontext/#arguments.rolecontextname#">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
		<cfif #variables.lr_api_signing# EQ "true">
		      <cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
		      <cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
	    <cfelse>
	    	<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
	    </cfif>
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam value="#arguments.payload#" type="body">
     </cfhttp>

	<cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="deleteRoleFromContext" hint="This API Deletes the specified Role from a Context.">

	<cfargument name="uid" type="string" required="true" />
        <cfargument name="rolecontextname" type="string" required="true" />
 	<cfargument name="payload" type="any" required="true" hint="data in json format"/>
	
        <cfobject type="java" class="RestRequest" name="myObj"> 
	<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/rolecontext/#arguments.rolecontextname#/role?apikey=#variables.lr_api_key#">
	<cfset result = myObj.delete(requestURL, "", payload, "#variables.lr_api_secret#", #variables.lr_api_signing#)> 

        <cfreturn loginradiusDeleteResponse(result)>
  </cffunction>

  <cffunction name="deletePermissionFromContext" hint="This API Deletes Additional Permissions from Context.">

	<cfargument name="uid" type="string" required="true" />
        <cfargument name="rolecontextname" type="string" required="true" />
 	<cfargument name="payload" type="any" required="true" hint="data in json format"/>	

        <cfobject type="java" class="RestRequest" name="myObj"> 
	<cfset requestURL= "#variables.LR_ROLE_API_ENDPOINT#/account/#arguments.uid#/rolecontext/#arguments.rolecontextname#/additionalpermission?apikey=#variables.lr_api_key#">
	<cfset result = myObj.delete(requestURL, "", payload, "#variables.lr_api_secret#", #variables.lr_api_signing#)> 

        <cfreturn loginradiusDeleteResponse(result)>
  </cffunction>

</cfcomponent>