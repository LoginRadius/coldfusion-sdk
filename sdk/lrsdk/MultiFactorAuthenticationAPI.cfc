<cfcomponent displayname="multifactorauthenticationapi" hint="This is the CFC for Multi Factor Authentication APIs">
<cfinclude template="init.cfm">
<!---

    Initialise in to your application using:

    <cfset SdkObject = createObject("component","lrsdk.multifactorauthenticationapi").init(
        lr_api_key = "Your API Key",
        lr_api_secret = "Your Secret Key"
      )>

   --->

  <cffunction name="init" hint="sets up an instance of the component" output="false">

    <cfargument name="lr_api_key" required="true" hint="API key provided by LoginRadius" type="string" />
    <cfargument name="lr_api_secret" required="true" hint="API secret provided by LoginRadius" type="string" />
    <cfargument name="LR_MULTI_FACTOR_AUTH_API_ENDPOINT" required="false" default="https://api.loginradius.com/identity/v2/auth" hint="LoginRadius multi factor endpoint" type="string" />

    <cfset variables.lr_api_key = arguments.lr_api_key />
    <cfset variables.lr_api_secret = arguments.lr_api_secret />
    <cfset variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT = arguments.LR_MULTI_FACTOR_AUTH_API_ENDPOINT />

    <cfreturn this />
  </cffunction>

 <cffunction name="mfaEmailLogin" hint="This API can be used to login by emailid on a Multi-Factor Authentication enabled LoginRadius site.">
	    <!--- Define arguments. --->
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfargument name="loginurl" type="string" required="false" default="" hint="login url" />
	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>
	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>
	<cfargument name="smstemplate2fa" type="string" required="false" default="" hint="sms template 2fa" />
	
	<cfhttp method="POST" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/login/2fa">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
         <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
          <cfhttpparam value="#payload#" type="body">
	  <cfhttpparam name="loginurl" value="#arguments.loginurl#" type="URL">
	  <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
	  <cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
	  <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaUserNameLogin" hint="This API can be used to login by username on a Multi-Factor Authentication enabled LoginRadius site.">
	    <!--- Define arguments. --->
	<cfargument name="payload" type="any" required="true" hint="data in json format"/>
	<cfargument name="loginurl" type="string" required="false" default="" hint="login url" />
	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>
	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>
    <cfargument name="smstemplate" type="string" required="false" default="" hint="sms template"/>
	<cfargument name="smstemplate2fa" type="string" required="false" default="" hint="sms template 2fa" />

	<cfhttp method="POST" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/login/2fa">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
            <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
            <cfhttpparam value="#payload#" type="body">
	  <cfhttpparam name="loginurl" value="#arguments.loginurl#" type="URL">
	  <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
	  <cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
	  <cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
	  <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaPhoneLogin" hint="This API is used to log in by phone on Multi-Factor Authentication enabled LoginRadius site.">
	    <!--- Define arguments. --->
	<cfargument name="payload" type="any" required="true" hint="data in json format"/>
	<cfargument name="loginurl" type="string" required="false" default="" hint="login url" />
	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>
	<cfargument name="emailTemplate" type="string" required="false" default="" hint="email template"/>
        <cfargument name="smsTemplate" type="string" required="false" default="" hint="sms template"/>
	<cfargument name="smstemplate2fa" type="string" required="false" default="" hint="sms template 2fa" />
 
	<cfhttp method="POST" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/login/2fa">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
         <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
         <cfhttpparam value="#payload#" type="body">
	  <cfhttpparam name="loginurl" value="#arguments.loginurl#" type="URL">
	  <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
	  <cfhttpparam name="smsTemplate" value="#arguments.smsTemplate#" type="URL">
	  <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
	  <cfhttpparam name="emailTemplate" value="#arguments.emailTemplate#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaValidateToken" hint="This API is used to configure the Multi-factor authentication after login by using the access_token when MFA is set as optional on the LoginRadius site.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
	<cfargument name="smstemplate2fa" type="string" required="false" default=""/>

    <cfhttp url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/2fa">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaBackupCodeByToken" hint="This API is used to get a set of backup codes via access token.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />

    <cfhttp url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/2fa/backupcode">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaResetBackupCodeByToken" hint="This API is used to reset the backup codes on a given account via the access token.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />

    <cfhttp url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/2fa/backupcode/reset">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaValidateBackupCode" hint="This API is used to validate the backup code.">
	    <!--- Define arguments. --->
	<cfargument name="secondfactorauthenticationtoken" type="string" required="true" />
	<cfargument name="backupcode" type="string" required="true" />

	<cfset payload = "{ 'backupcode': '#arguments.backupcode#' }" />

    <cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/login/2fa/verification/backupcode">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
      <cfhttpparam name="secondfactorauthenticationtoken" value="#arguments.secondfactorauthenticationtoken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaValidateOTP" hint="This API is used to login via Multi-factor authentication by passing the One Time Password received via SMS.">
	    <!--- Define arguments. --->
	<cfargument name="secondfactorauthenticationtoken" type="string" required="true" />
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfargument name="smstemplate2fa" type="string" required="false" default="" hint="sms template two factor"/>

    <cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/login/2fa/verification/otp">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
      <cfhttpparam name="secondfactorauthenticationtoken" value="#arguments.secondfactorauthenticationtoken#" type="URL">
	  <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaValidateGoogleAuthCode" hint="This API is used to login via Multi-factor authentication by passing the google authenticator code.">
	    <!--- Define arguments. --->
	<cfargument name="secondfactorauthenticationtoken" type="string" required="true" />
	<cfargument name="googleauthenticatorcode" type="string" required="true"/>
    <cfargument name="smstemplate2fa" type="string" required="false" default=""/>

    <cfset payload = "{ 'googleauthenticatorcode': '#arguments.googleauthenticatorcode#' }" />

    <cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/login/2fa/verification/googleauthenticatorcode">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
      <cfhttpparam name="secondfactorauthenticationtoken" value="#arguments.secondfactorauthenticationtoken#" type="URL">
      <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaUpdatePhone" hint="This API is used to update the Multi-factor authentication phone number.">
	    <!--- Define arguments. --->
	<cfargument name="secondfactorauthenticationtoken" type="string" required="true" hint="second factor authentication token"/>
    <cfargument name="phoneno2fa" type="string" required="true" hint="phoneno2fa"/>
	<cfargument name="smstemplate2fa" type="string" required="false" default="" hint="sms template multi factor"/>
    <cfset payload = "{ 'phoneno2fa': '#arguments.phoneno2fa#' }" />

      <cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/login/2fa">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
      <cfhttpparam name="secondfactorauthenticationtoken" value="#arguments.secondfactorauthenticationtoken#" type="URL">
      <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaUpdatePhoneByToken" hint="This API is used to update the Multi-factor authentication phone number.">
	    <!--- Define arguments. --->
    <cfargument name="phoneno2fa" type="string" required="true" hint="phoneno2fa"/>
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
    <cfargument name="smstemplate2fa" type="string" required="false" default="" hint="sms template multi factor"/>
    <cfset payload = "{ 'phoneno2fa': '#arguments.phoneno2fa#' }" />

	<cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/2fa">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
	  <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="updateMfaByGoogleAuthCode" hint="This API is used to Enable Multi-factor authentication by access token on user login.">
	    <!--- Define arguments. --->
    <cfargument name="googleauthenticatorcode" type="string" required="true" hint="googleauthenticatorcode"/>
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
    <cfargument name="smstemplate" type="string" required="false" default="" hint="sms template"/>
    <cfset payload = "{ 'googleauthenticatorcode': '#arguments.googleauthenticatorcode#' }" />

	<cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/2fa/verification/googleauthenticatorcode">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
	  <cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="updateMfaByOtp" hint="This API is used to trigger the Multi-factor authentication settings after login for secure actions.">
	    <!--- Define arguments. --->
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>

	<cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/2fa/verification/otp">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="mfaResetGoogleAuthenticatorByToken" hint="This API Resets the Google Authenticator configurations on a given account via the access token.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="googleauthenticator" type="string" required="true" hint="google authenticator"/>
    <cfset payload = "{ 'googleauthenticator': '#arguments.googleauthenticator#' }" />
    
    <cfobject type="java" class="RestRequest" name="myObj"> 
	<cfset requestURL= "#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/2fa/authenticator?apikey=#variables.lr_api_key#">
	<cfset result = myObj.delete(requestURL, "#arguments.accesstoken#", payload, "", false)> 
	    
	    <!--- Get Response --->
    <cfreturn loginradiusDeleteResponse(result)>
  </cffunction>

  <cffunction name="mfaResetSMSAuthenticatorByToken" hint="This API Resets the SMS Authenticator configurations on a given account via the access token.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="otpauthenticator" type="string" required="true" hint="otp authenticator"/>
    <cfset payload = "{ 'otpauthenticator': '#arguments.otpauthenticator#' }" />
    
    <cfobject type="java" class="RestRequest" name="myObj"> 
	<cfset requestURL= "#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/2fa/authenticator?apikey=#variables.lr_api_key#">
	<cfset result = myObj.delete(requestURL, "#arguments.accesstoken#", payload, "", false)>
	   
	    <!--- Get Response --->
    <cfreturn loginradiusDeleteResponse(result)>
  </cffunction>
  
  <cffunction name="mfaReAuthenticate" hint="This API is used to trigger the Multi-Factor Autentication workflow for the provided access token.">
	    <!--- Define arguments. --->
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
    <cfargument name="smstemplate2fa" type="string" required="false" default="" hint="sms template 2fa"/>

	<cfhttp url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/reauth/2fa">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
   </cffunction>

  <cffunction name="validateMfaByGoogleAuthCode" hint="This API is used to re-authenticate via Multi-factor-authentication by passing the google authenticator code.">
	    <!--- Define arguments. --->
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
    <cfargument name="googleauthenticatorcode" type="string" required="true" hint="otp authenticator"/>
    <cfset payload = "{ 'googleauthenticatorcode': '#arguments.googleauthenticatorcode#' }" />

	<cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/reauth/2fa/googleauthenticatorcode">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="validateMfaByBackupCode" hint="This API is used to re-authenticate by set of backup codes via access token.">
	    <!--- Define arguments. --->
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="backupcode" type="string" required="true" hint="otp authenticator"/>

    <cfset payload = "{ 'backupcode': '#arguments.backupcode#' }" />

	<cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/reauth/2fa/backupcode">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="validateMfaByOtp" hint="This API is used to re-authenticate via Multi-factor authentication by passing the One Time Password received via SMS.">
	    <!--- Define arguments. --->
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfargument name="smstemplate2fa" type="string" required="false" default="" hint="sms template 2fa"/>

	<cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/reauth/2fa/otp">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="validateMfaByPassword" hint="This API is used to re-authenticate via Multi-factor-authentication by passing the password.">
	    <!--- Define arguments. --->
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfargument name="smstemplate2fa" type="string" required="false" default="" hint="sms template 2fa"/>

	<cfhttp method="PUT" url="#variables.LR_MULTI_FACTOR_AUTH_API_ENDPOINT#/account/reauth/password">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="smstemplate2fa" value="#arguments.smstemplate2fa#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

</cfcomponent>