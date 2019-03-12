<cfcomponent displayname="accountapi" hint="This is the CFC for Customer Identity Management APIs">
	<cfinclude template="init.cfm">
	<!---
	    Initialise in to your application using:
	
	    <cfset SdkObject = createObject("component","lrsdk.accountapi").init(
	        lr_api_key = "Your API Key",
	        lr_api_secret = "Your Secret Key",
	    lr_api_signing = "true/false"
	      )>
	   --->
	
	<cffunction name="init" hint="sets up an instance of the component" output="false">
	
		<cfargument name="lr_api_key" required="true" hint="API key provided by LoginRadius" type="string"/>
		<cfargument name="lr_api_secret" required="true" hint="API secret provided by LoginRadius" 
		            type="string"/>
		<cfargument name="lr_api_signing" required="false" default="false" 
		            hint="API request signing option" type="string"/>
		<cfargument name="LR_ACCOUNT_API_ENDPOINT" required="false" 
		            default="https://api.loginradius.com/identity/v2/manage/account" 
		            hint="LoginRadius account api endpoint" type="string"/>
		<cfargument name="LR_REGISTRATION_DATA_ENDPOINT" required="false" 
		            default="https://api.loginradius.com/identity/v2/manage" 
		            hint="LoginRadius registration data api endpoint" type="string"/>
	
		<cfset variables.lr_api_key = arguments.lr_api_key/>
		<cfset variables.lr_api_secret = arguments.lr_api_secret/>
		<cfset variables.lr_api_signing = arguments.lr_api_signing/>
		<cfset variables.LR_ACCOUNT_API_ENDPOINT = arguments.LR_ACCOUNT_API_ENDPOINT/>
		<cfset variables.LR_REGISTRATION_DATA_ENDPOINT = arguments.LR_REGISTRATION_DATA_ENDPOINT/>
	
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="accountCreate" hint="This API is used to create an account.">
	
		<cfargument name="payload" type="any" required="true" hint="data in json format"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset arrayval = "#getHash(variables.LR_ACCOUNT_API_ENDPOINT, params, payload)#">
		</cfif>
		<cfhttp method="POST" url="#variables.LR_ACCOUNT_API_ENDPOINT#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
		
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
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
	
	<cffunction name="getEmailVerificationToken" hint="This API Returns an Email Verification token.">
	
		<cfargument name="email" type="string" required="true" hint="email"/>
	
		<cfset payload = "{ 'email': '#arguments.email#' }"/>
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/verify/token">
			<cfset arrayval = "#getHash(requestURL, params, payload)#">
		</cfif>
		<cfhttp method="POST" url="#variables.LR_ACCOUNT_API_ENDPOINT#/verify/token">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#payload#" type="body">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="getForgotPasswordToken" hint="This API Returns a forgot password token.">
	
		<cfargument name="email" type="string" required="true" hint="email"/>
	
		<cfset payload = "{ 'email': '#arguments.email#' }"/>
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/forgot/token">
			<cfset arrayval = "#getHash(requestURL, params, payload)#">
		</cfif>
		<cfhttp method="POST" url="#variables.LR_ACCOUNT_API_ENDPOINT#/forgot/token">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#payload#" type="body">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="accountIdentitiesByEmail" 
	            hint="This API is used to retrieve all of the identities.">
	
		<cfargument name="email" type="string" required="true"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['email'] = "#arguments.email#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/identities">
			<cfset arrayval = "#getHash(requestURL, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#/identities">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="email" value="#arguments.email#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="accountImpersonationAPI" 
	            hint="This API is used to get LoginRadius access token based on UID.">
	
		<cfargument name="uid" type="string" required="true"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['uid'] = "#arguments.uid#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/access_token">
			<cfset arrayval = "#getHash(requestURL, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#/access_token">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="uid" value="#arguments.uid#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="getPassword" 
	            hint="The API is used to retrieve the hashed password of a specified account.">
	
		<cfargument name="uid" type="string" required="true"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#/password">
			<cfset arrayval = "#getHash(requestURL, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#/password">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="getProfileByEmail" 
	            hint="This API is used to retrieve all of the profile data, associated with the specified account by email.">
	
		<cfargument name="email" type="string" required="true"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['email'] = "#arguments.email#">
			<cfset arrayval = "#getHash(variables.LR_ACCOUNT_API_ENDPOINT, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="email" value="#arguments.email#" type="URL">
		</cfhttp>
		<cfreturn loginradiusGetResponse(cfhttp)>
	
	</cffunction>
	
	<cffunction name="getProfileByUsername" 
	            hint="This API is used to retrieve all of the profile data, associated with the specified account by username.">
	
		<cfargument name="username" type="string" required="true"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['username'] = "#arguments.username#">
			<cfset arrayval = "#getHash(variables.LR_ACCOUNT_API_ENDPOINT, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="username" value="#arguments.username#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="getProfileByPhone" 
	            hint="This API is used to retrieve all of the profile data, associated with the specified account by phone number.">
	
		<cfargument name="phone" type="string" required="true"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['phone'] = "#arguments.phone#">
			<cfset arrayval = "#getHash(variables.LR_ACCOUNT_API_ENDPOINT, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="phone" value="#arguments.phone#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="getProfileByUid" 
	            hint="This API is used to retrieve all of the profile data, associated with the specified account by UID .">
	
		<cfargument name="uid" type="string" required="true"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#">
			<cfset arrayval = "#getHash(requestURL, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="setPassword" hint="This API is used to set the password of an account.">
		<!--- Define arguments. --->
		<cfargument name="uid" type="string" required="true"/>
		<cfargument name="password" type="string" required="true" hint="password"/>
	
		<cfset payload = "{ 'password': '#arguments.password#' }"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#/password">
			<cfset arrayval = "#getHash(requestURL, params, payload)#">
		</cfif>
		<cfhttp method="PUT" url="#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#/password">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#payload#" type="body">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="accountUpdate" 
	            hint="This API is used to update the information of existing account.">
		<!--- Define arguments. --->
		<cfargument name="uid" type="string" required="true"/>
		<cfargument name="payload" type="any" required="true" hint="data in json format"/>
		<cfargument name="nullsupport" type="string" required="false" default="false"
		            hint="is null support"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['uid'] = "#arguments.uid#">
			<cfset params['nullsupport'] = "#arguments.nullsupport#">
			<cfset arrayval = "#getHash(variables.LR_ACCOUNT_API_ENDPOINT, params, payload)#">
		</cfif>
		<cfhttp method="PUT" url="#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="nullsupport" value="#arguments.nullsupport#" type="URL">
			<cfhttpparam value="#arguments.payload#" type="body">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="updateSecurityQuestion" 
	            hint="This API is used to update security questions configuration on an existing account.">
	
		<cfargument name="uid" type="string" required="true"/>
		<cfargument name="payload" type="any" required="true" hint="data in json format"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#">
			<cfset arrayval = "#getHash(requestURL, params, payload)#">
		</cfif>
		<cfhttp method="PUT" url="#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#arguments.payload#" type="body">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="invalidateVerificationEmail" 
	            hint="This API is used to invalidate the Email Verification status on an account.">
	
		<cfargument name="uid" type="string" required="true"/>
		<cfargument name="verificationurl" type="string" required="false" default=""
		            hint="verification url"/>
		<cfargument name="emailtemplate" type="string" required="false" default=""
		            hint="email template"/>
		<cfargument name="payload" type="any" required="false" dafault=""
		            hint="data in json format"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#/invalidateemail">
			<cfset arrayval = "#getHash(requestURL, params)#">
		</cfif>
		<cfhttp method="PUT" url="#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#/invalidateemail">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="" type="body">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="accountEmailDelete" hint="Use this API to Remove emails from a user Account.">
	
		<cfargument name="uid" type="string" required="true"/>
		<cfargument name="email" type="string" required="true"/>
	
		<cfset payload = "{ 'email': '#arguments.email#' }"/>
	
		<cfobject type="java" class="RestRequest" name="myObj">
		<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#/email?apikey=#variables.lr_api_key#">
		<cfset result = myObj.delete(requestURL, "", payload, "#variables.lr_api_secret#", 
		                             #variables.lr_api_signing#)>
	
		<!--- Get Response --->
		<cfreturn loginradiusDeleteResponse(result)>
	</cffunction>
	
	<cffunction name="accountDelete" 
	            hint="This API deletes the Users account and allows them to re-register for a new account.">
	
		<cfargument name="uid" type="string" required="true"/>
		<cfargument name="payload" type="any" required="false" default=""
		            hint="data in json format"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#">
			<cfset arrayval = "#getHash(requestURL, params, payload)#">
		</cfif>
		<cfhttp method="DELETE" url="#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
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
	
	<cffunction name="generateSott" 
	            hint="This API allows you to generate SOTT with a given expiration time.">
	
		<cfargument name="timedifference" type="string" default="10" required="false"
		            hint="timedifference"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['timedifference'] = "#arguments.timedifference#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/sott">
			<cfset arrayval = "#getHash(requestURL, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#/sott">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="timedifference" value="#arguments.timedifference#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="resetPhoneIdVerification" 
	            hint="This API Allows you to reset the phone no verification of an end user�s account.">
		<!--- Define arguments. --->
		<cfargument name="uid" type="string" required="true"/>
		<cfargument name="payload" type="any" required="false" default=""
		            hint="data in json format"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#/invalidatephone">
			<cfset arrayval = "#getHash(requestURL, params, payload)#">
		</cfif>
		<cfhttp method="PUT" url="#variables.LR_ACCOUNT_API_ENDPOINT#/#arguments.uid#/invalidatephone">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#arguments.payload#" type="body">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="mfaGetBackupCodeByUid" hint="This API is used to get a set of backup codes.">
		<!--- Define arguments. --->
		<cfargument name="uid" type="string" required="true"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['uid'] = "#arguments.uid#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/2fa/backupcode">
			<cfset arrayval = "#getHash(requestURL, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#/2fa/backupcode">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="uid" value="#arguments.uid#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="mfaResetBackupCodeByUid" 
	            hint="This API is used to reset the backup codes on a given account via the uid.">
		<!--- Define arguments. --->
		<cfargument name="uid" type="string" required="true"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['uid'] = "#arguments.uid#">
			<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/2fa/backupcode/reset">
			<cfset arrayval = "#getHash(requestURL, params)#">
		</cfif>
		<cfhttp url="#variables.LR_ACCOUNT_API_ENDPOINT#/2fa/backupcode/reset">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="uid" value="#arguments.uid#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="mfaResetGoogleAuthenticatorByUid" 
	            hint="This API resets the Google Authenticator configurations on a given account via the UID.">
		<!--- Define arguments. --->
		<cfargument name="uid" type="string" required="true" hint="uid"/>
		<cfargument name="googleauthenticator" type="any" required="true" hint="google authenticator"/>
	
		<cfset payload = "{ 'googleauthenticator': '#arguments.googleauthenticator#' }"/>
	
		<cfobject type="java" class="RestRequest" name="myObj">
		<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/2fa/authenticator?apikey=#variables.lr_api_key#&uid=#arguments.uid#">
		<cfset result = myObj.delete(requestURL, "", payload, "#variables.lr_api_secret#", 
		                             #variables.lr_api_signing#)>
	
		<cfreturn loginradiusDeleteResponse(result)>
	</cffunction>
	
	<cffunction name="mfaResetSMSAuthenticatorByUid" 
	            hint="This API resets the SMS Authenticator configurations on a given account via the UID.">
		<!--- Define arguments. --->
		<cfargument name="uid" type="string" required="true" hint="uid"/>
		<cfargument name="otpauthenticator" type="string" required="true" hint="otp authenticator"/>
	
		<cfset payload = "{ 'otpauthenticator': '#arguments.otpauthenticator#' }"/>
	
		<cfobject type="java" class="RestRequest" name="myObj">
		<cfset requestURL = "#variables.LR_ACCOUNT_API_ENDPOINT#/2fa/authenticator?apikey=#variables.lr_api_key#&uid=#arguments.uid#">
		<cfset result = myObj.delete(requestURL, "", payload, "#variables.lr_api_secret#", 
		                             #variables.lr_api_signing#)>
	
		<cfreturn loginradiusDeleteResponse(result)>
	</cffunction>
	
	<cffunction name="addRegistrationData" 
	            hint="This API allows you to fill data in dropDownList which you have created for user Registeration.">
	
		<cfargument name="payload" type="any" required="true" hint="data in json format"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_REGISTRATION_DATA_ENDPOINT#/registrationdata">
			<cfset arrayval = "#getHash(requestURL, params, payload)#">
		</cfif>
		<cfhttp method="POST" url="#variables.LR_REGISTRATION_DATA_ENDPOINT#/registrationdata">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
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
	
	<cffunction name="getRegistrationData" hint="This API is used to retrieve dropdown data.">
		<cfargument name="type" type="string" required="true" hint="type"/>
		<cfargument name="parentid" type="string" required="false" default=""
		            hint="parentid"/>
		<cfargument name="skip" type="string" required="false" default=""
		            hint="skip"/>
		<cfargument name="limit" type="string" required="false" default=""
		            hint="limit"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset params['parentid'] = "#arguments.parentid#">
			<cfset params['skip'] = "#arguments.skip#">
			<cfset params['limit'] = "#arguments.limit#">
			<cfset requestURL = "#variables.LR_REGISTRATION_DATA_ENDPOINT#/registrationdata/#arguments.type#">
			<cfset arrayval = "#getHash(requestURL, params)#">
		</cfif>
		<cfhttp url="#variables.LR_REGISTRATION_DATA_ENDPOINT#/registrationdata/#arguments.type#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="parentid" value="#arguments.parentid#" type="URL">
			<cfhttpparam name="skip" value="#arguments.skip#" type="URL">
			<cfhttpparam name="limit" value="#arguments.limit#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="updateRegistrationData" hint="This API allows you to update member of dropDown.">
		<!--- Define arguments. --->
		<cfargument name="recordid" type="string" required="true" hint="recordid"/>
		<cfargument name="payload" type="any" required="true" hint="data in json format"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_REGISTRATION_DATA_ENDPOINT#/registrationdata/#arguments.recordid#">
			<cfset arrayval = "#getHash(requestURL, params, payload)#">
		</cfif>
		<cfhttp method="POST" 
		        url="#variables.LR_REGISTRATION_DATA_ENDPOINT#/registrationdata/#arguments.recordid#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfif #variables.lr_api_signing# EQ "true">
				<cfhttpparam type="header" name="X-Request-Expires" value="#arrayval[1]#">
				<cfhttpparam type="header" name="digest" value="SHA-256=#arrayval[2]#">
			<cfelse>
				<cfhttpparam type="header" name="X-LoginRadius-ApiSecret" value="#variables.lr_api_secret#">
			</cfif>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#arguments.payload#" type="body">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="deleteRegistrationData" 
	            hint="his API allows you to delete a member from dropDownList.">
	
		<cfargument name="recordid" type="string" required="true"/>
		<cfargument name="payload" type="any" required="false" default=""
		            hint="data in json format"/>
	
		<cfif #variables.lr_api_signing# EQ "true">
			<cfset params['apikey'] = "#variables.lr_api_key#">
			<cfset requestURL = "#variables.LR_REGISTRATION_DATA_ENDPOINT#/registrationdata/#arguments.recordid#">
			<cfset arrayval = "#getHash(requestURL, params, payload)#">
		</cfif>
		<cfhttp method="DELETE" 
		        url="#variables.LR_REGISTRATION_DATA_ENDPOINT#/registrationdata/#arguments.recordid#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
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
	
</cfcomponent>