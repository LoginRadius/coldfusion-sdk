<cffunction name="generatURL" hint="generate url">

	<cfargument name="domain" type="any" required="true" hint ="data in json format"/>
	<cfargument name="params" type="any" required="true" hint ="data in json format"/>
        <cfargument name="expirytime" type="any" required="true" hint ="data in json format"/>
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>

	<cfset html = ''/>
	<cfloop collection="#params#" item="key">
		<cfset html = html & key & '=' & params[key] & '&'/>
	</cfloop>
	
	<cfif len(payload) EQ 0>
		<cfreturn #expirytime# & ':' & #LCase(EncodeForURL(#domain# & '?' & #left(html,len(html)-1)#))#>
	<cfelse>
	  	<cfreturn #expirytime# & ':' & #LCase(EncodeForURL(#domain# & '?' & #left(html,len(html)-1)#))# & ':' & #payload#>
	</cfif>
 </cffunction>

<cffunction name="getHash" hint="generate url">
	<cfargument name="domain" type="any" required="true" hint ="data in json format"/>
	<cfargument name="params" type="any" required="true" hint ="data in json format"/>
    <cfargument name="payload" type="any" required="false" default="" hint ="data in json format"/>

	<cfset crypto = new lib.Crypto() />
	<cfset secret = "#variables.lr_api_secret#" />

	<cfset date = "#dateFormat(now(),"yyyy-mm-dd")#">
    <cfset time = "#TimeFormat(DateAdd('h', 2, now()),'HH:mm:ss')#">
	<cfset expirytime = "#date# #time#">	
	<cfset hashvalue = #crypto.hmacSha256( secret, generatURL(domain, params, expirytime, payload), "base64" )# />
	<cfreturn [expirytime, hashvalue]>
  </cffunction>

 <cffunction name="loginradiusGetResponse" hint="I read json response of APIs">

    <cfargument name="cfhttp" required="true" />
    <cfset response =  Deserializejson(arguments.cfhttp.filecontent)>

    <!--- check errorcode exist in response --->
    <cfif IsStruct(response) && structkeyexists(response, "ErrorCode")>

      <!--- throw exception --->
      <cfthrow
      message = "#response.Message#"
      type = "LoginRadiusException"
      detail = "#response.Description#"
      errorCode = "#response.ErrorCode#"
      >
  	</cfif>

   <cfreturn response>
  </cffunction>
  
   <cffunction name="loginradiusDeleteResponse" hint="I read json response of APIs">

    <cfargument name="cfhttp" required="true" />
    <cfset response = Deserializejson(arguments.cfhttp)>

    <!--- check errorcode exist in response --->
    <cfif IsStruct(response) && structkeyexists(response, "ErrorCode")>

      <!--- throw exception --->
      <cfthrow
      message = "#response.Message#"
      type = "LoginRadiusException"
      detail = "#response.Description#"
      errorCode = "#response.ErrorCode#"
      >
  	</cfif>

   <cfreturn response>
  </cffunction>