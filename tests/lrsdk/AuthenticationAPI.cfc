<cfcomponent displayname="authenticationapi" hint="This is the CFC for Customer Identity Management APIs">
<cfinclude template="init.cfm">
<!---

    Initialise in to your application using:

    <cfset SdkObject = createObject("component","lrsdk.authenticationapi").init(
        lr_api_key = "Your API Key",
        lr_api_secret = "Your Secret Key",
        lr_api_signing = "true/false"
      )>
   --->

  <cffunction name="init" hint="sets up an instance of the component" output="false">

    <cfargument name="lr_api_key" required="true" hint="API key provided by LoginRadius" type="string" />
    <cfargument name="lr_api_secret" required="true" hint="API secret provided by LoginRadius" type="string" />
    <cfargument name="lr_api_signing" required="false" default="false" hint="API request signing option" type="string" />
    <cfargument name="LR_USER_AUTH_API_ENDPOINT" required="false" default="https://api.loginradius.com/identity/v2/auth" hint="LoginRadius user registration endpoint" type="string" />

    <cfset variables.lr_api_key = arguments.lr_api_key />
    <cfset variables.lr_api_secret = arguments.lr_api_secret />
    <cfset variables.lr_api_signing = arguments.lr_api_signing />
    <cfset variables.LR_USER_AUTH_API_ENDPOINT = arguments.LR_USER_AUTH_API_ENDPOINT />

    <cfreturn this />
  </cffunction>

 <cffunction name="registerByEmail" hint="To register user by email">
	    <!--- Define arguments. --->
 	<cfargument name="payload" type="any" required="true" hint="data in json format"/>
	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>
	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>
	<cfargument name="options" type="string" required="false" default="" hint="prevent verification email"/>

	<cfset SdkObject = createObject("component","lrsdk.accountapi").init(
	        lr_api_key = "#variables.lr_api_key#",
	        lr_api_secret = "#variables.lr_api_secret#",
	        lr_api_signing = "#variables.lr_api_signing#"
	      )>

	<cfset result = SdkObject.generateSott("10")>

	<cfhttp method="POST" url="#variables.LR_USER_AUTH_API_ENDPOINT#/register">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="X-LoginRadius-Sott" value="#result.Sott#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
      <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
	  <cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
	  <cfhttpparam name="options" value="#arguments.options#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
 </cffunction>

 <cffunction name="loginByEmail" hint="To login by email">
	    <!--- Define arguments. --->
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>
	<cfargument name="loginurl" type="string" required="false" default="" hint="login url" />
	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>
	<cfargument name="grecaptcharesponse" type="string" required="false" default="" hint="g recaptcha response" />

	<cfhttp method="POST" url="#variables.LR_USER_AUTH_API_ENDPOINT#/login">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
      <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
	  <cfhttpparam name="loginurl" value="#arguments.loginurl#" type="URL">
	  <cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
	  <cfhttpparam name="g-recaptcha-response" value="#arguments.grecaptcharesponse#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="loginByUsername" hint="To login by user name">
	    <!--- Define arguments. --->
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>
	<cfargument name="loginurl" type="string" required="false" default="" hint="login url" />
	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>
	<cfargument name="grecaptcharesponse" type="string" required="false" default="" hint="g recaptcha response" />

	<cfhttp method="POST" url="#variables.LR_USER_AUTH_API_ENDPOINT#/login">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	<cfhttpparam type="header" name="Content-Type" value="application/json" />
        <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
        <cfhttpparam value="#arguments.payload#" type="body">
	<cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
	<cfhttpparam name="loginurl" value="#arguments.loginurl#" type="URL">
	<cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
	<cfhttpparam name="g-recaptcha-response" value="#arguments.grecaptcharesponse#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="addEmail" hint="To add additional emails to a user's account.">
	    <!--- Define arguments. --->

    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="email" type="string" required="true" hint="email"/>
	<cfargument name="type" type="string" required="true" hint="type"/>
 	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>
 	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>

    <cfset payload = "{ 'email': '#arguments.email#', 'type': '#arguments.type#' }" />

	<cfhttp method="POST" url="#variables.LR_USER_AUTH_API_ENDPOINT#/email">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
	  <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
	  <cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

   <cffunction name="forgotPassword" hint="To send the reset password url to a specified account.">
	    <!--- Define arguments. --->

	<cfargument name="email" type="string" required="true" hint="email"/>
        <cfargument name="resetpasswordurl" type="string" required="true" hint="verification url"/>
 	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>

    <cfset payload = "{ 'email': '#arguments.email#' }" />

    <cfhttp method="POST" url="#variables.LR_USER_AUTH_API_ENDPOINT#/password">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	<cfhttpparam type="header" name="Content-Type" value="application/json" />
        <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
        <cfhttpparam value="#payload#" type="body">
        <cfhttpparam name="resetpasswordurl" value="#arguments.resetpasswordurl#" type="URL">
	<cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="checkEmailExist" hint="To check email availability">
	    <!--- Define arguments. --->
	<cfargument name="email" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/email">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="email" value="#arguments.email#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="checkUsernameExist" hint="To check username availability.">
	    <!--- Define arguments. --->
	<cfargument name="username" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/username">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="username" value="#arguments.username#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="getProfileByToken" hint="To get profile by token">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/account">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="privacyPolicyAccept" hint="Privacy policy accept">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/privacypolicy/accept">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="sendWelcomeEmail" hint="Send Welcome email">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/account/sendwelcomeemail">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="welcomeemailtemplate" value="#arguments.welcomeemailtemplate#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="getSocialIdentity" hint="This API is called just after account linking API and it prevents the raas profile of the second account from getting created">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/socialidentity">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="validateAccessToken" hint="This api validates access token, if valid then returns a response with its expiry otherwise error.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/access_token/validate">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="varifyEmail" hint="This API is used to verify the email of user.">
	    <!--- Define arguments. --->
	<cfargument name="verificationtoken" type="string" required="true" />
	<cfargument name="url" type="string" required="false" default="" hint="url"/>
 	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" hint="welcome email template"/>
 	
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/email">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="verificationtoken" value="#arguments.verificationtoken#" type="URL">
	  <cfhttpparam name="url" value="#arguments.url#" type="URL">
	  <cfhttpparam name="welcomeemailtemplate" value="#arguments.welcomeemailtemplate#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="deleteAccount" hint="This API is used to delete an account by passing it a delete token.">
	    <!--- Define arguments. --->
	<cfargument name="deletetoken" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/account/delete">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="deletetoken" value="#arguments.deletetoken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="invalidateAccessToken" hint="This api call invalidates the active access token or expires an access token's validity.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/access_token/invalidate">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="securityQuestionByToken" hint="This API is used to retrieve the list of questions that are configured on the respective LoginRadius site.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/securityquestion/accesstoken">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="securityQuestionByEmail" hint="This API is used to retrieve the list of questions that are configured on the respective LoginRadius site.">
	    <!--- Define arguments. --->
	<cfargument name="email" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/securityquestion/email">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="email" value="#arguments.email#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="securityQuestionByUsername" hint="This API is used to retrieve the list of questions that are configured on the respective LoginRadius site.">
	    <!--- Define arguments. --->
	<cfargument name="username" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/securityquestion/username">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="username" value="#arguments.username#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="securityQuestionByPhone" hint="This API is used to retrieve the list of questions that are configured on the respective LoginRadius site.">
	    <!--- Define arguments. --->
    <cfargument name="phone" type="string" required="true" />
    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/securityquestion/phone">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="phone" value="#arguments.phone#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="varifyEmailByOtp" hint="This API is used to verify the email of user using otp.">
	    <!--- Define arguments. --->
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfargument name="url" type="string" required="false" default="" hint="url"/>
 	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" hint="welcome email template"/>

    <cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/email">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
	  <cfhttpparam name="url" value="#arguments.url#" type="URL">
	  <cfhttpparam name="welcomeemailtemplate" value="#arguments.welcomeemailtemplate#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="changePassword" hint="This API is used to change the accounts password based on the previous password.">
	    <!--- Define arguments. --->
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="oldpassword" type="string" required="true" hint="old password"/>
	<cfargument name="newpassword" type="string" required="true" hint="new password"/>

    <cfset payload = "{ 'oldpassword': '#arguments.oldpassword#', 'newpassword': '#arguments.newpassword#' }" />

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/password/change">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="accountLink" hint="This API is used to link up a social provider account with the specified account based on the access token and the social providers user access token.">
	    <!--- Define arguments. --->
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="candidatetoken" type="string" required="true" hint="candidate token"/>

    <cfset payload = "{ 'candidatetoken': '#arguments.candidatetoken#' }" />

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/socialidentity">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="resendEmailVerification" hint="This API resends the verification email to the user.">
	    <!--- Define arguments. --->
    <cfargument name="email" type="string" required="true" hint="email"/>
 	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>
 	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>

    <cfset payload = "{ 'email': '#arguments.email#' }" />

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/register">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
      <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
	  <cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="resetPasswordByResetToken" hint="This API is used to set a new password for the specified account.">
	    <!--- Define arguments. --->
	<cfargument name="resettoken" type="string" required="true" hint="reset token"/>
	<cfargument name="password" type="string" required="true" hint="password"/>
 	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" hint="welcome email template"/>
 	<cfargument name="resetpasswordemailtemplate" type="string" required="false" default="" hint="reset password email template"/>

    <cfset payload = "{ 'resettoken': '#arguments.resettoken#', 'password': '#arguments.password#', 'welcomeemailtemplate': '#arguments.welcomeemailtemplate#', 'resetpasswordemailtemplate': '#arguments.resetpasswordemailtemplate#' }" />

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/password/reset">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="resetPasswordByOTP" hint="This API is used to set a new password for the specified account.">
	    <!--- Define arguments. --->
	<cfargument name="email" type="string" required="true" hint="email"/>
	<cfargument name="password" type="string" required="true" hint="password"/>
    <cfargument name="otp" type="string" required="true" hint="otp"/>
 	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" hint="welcome email template"/>
 	<cfargument name="resetpasswordemailtemplate" type="string" required="false" default="" hint="reset password email template"/>

	<cfset payload = "{ 'email': '#arguments.email#', 'password': '#arguments.password#', 'otp': '#arguments.otp#', 'welcomeemailtemplate': '#arguments.welcomeemailtemplate#', 'resetpasswordemailtemplate': '#arguments.resetpasswordemailtemplate#' }" />

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/password/reset">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="resetPasswordByEmail" hint="This API is used to reset password for the specified account by security question.">
	    <!--- Define arguments. --->
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/password/securityanswer">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="resetPasswordByPhone" hint="This API is used to reset password for the specified account by security question.">
	    <!--- Define arguments. --->
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/password/securityanswer">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="resetPasswordByUsername" hint="This API is used to reset password for the specified account by security question.">
	    <!--- Define arguments. --->
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/password/securityanswer">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="changeUsername" hint="To change username">
	    <!--- Define arguments. --->
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="username" type="string" required="true" hint="email"/>

    <cfset payload = "{ 'username': '#arguments.username#' }" />

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/username">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="updateProfileByToken" hint="To update profile by token">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>
	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>
	<cfargument name="smstemplate" type="string" required="false" default="" hint="sms template" />

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/account">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
	  <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
	  <cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
	  <cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="updateSecurityQuestionByToken" hint="This API is used to update security questions by the access token.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" hint="access token"/>
 	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/account">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

 <cffunction name="deleteAccountByEmailConfirmation" hint="This API deletes a user account by passing the user's access token.">
	    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" />
	<cfargument name="deleteurl" type="string" required="false" default="" hint="delete url"/>
	<cfargument name="emailtemplate" type="string" required="false" default="" hint="email template"/>
	<cfargument name="payload" type="any" required="false" default="" hint="data in json format"/>

	<cfhttp method="DELETE" url="#variables.LR_USER_AUTH_API_ENDPOINT#/account">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
	  <cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="deleteurl" value="#arguments.deleteurl#" type="URL">
	  <cfhttpparam name="emailtemplate" value="#arguments.emailtemplate#" type="URL">
	  <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>
  
   <cffunction name="removeEmail" hint="This API deletes the Users account and allows them to re-register for a new account.">
		    <!--- Define arguments. --->
	<cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="email" type="string" required="true" hint="email"/>	
	<cfset payload = "{ 'email': '#arguments.email#' }" />
		
	<cfobject type="java" class="RestRequest" name="myObj"> 
	<cfset requestURL= "#variables.LR_USER_AUTH_API_ENDPOINT#/email?apikey=#variables.lr_api_key#">
	<cfset result = myObj.delete(requestURL, "#arguments.accesstoken#", payload, "", #variables.lr_api_signing#)> 
	
	    <!--- Get Response --->
	<cfreturn loginradiusDeleteResponse(result)>
  </cffunction>

 <cffunction name="accountUnlink" hint="This API is used to unlink up a social provider account with the specified account based on the access token and the social providers user access token..">
	    <!--- Define arguments. --->
    <cfargument name="accesstoken" type="string" required="true" hint="access token"/>
	<cfargument name="provider" type="string" required="true" hint="provider"/>
	<cfargument name="providerid" type="string" required="true" hint="providerid"/>
    <cfset payload = "{ 'provider': '#arguments.provider#', 'providerid': '#arguments.providerid#' }" />
    
   	<cfobject type="java" class="RestRequest" name="myObj"> 
	<cfset requestURL= "#variables.LR_USER_AUTH_API_ENDPOINT#/socialidentity?apikey=#variables.lr_api_key#">
	<cfset result = myObj.delete(requestURL, "#arguments.accesstoken#", payload, "", #variables.lr_api_signing#)> 

    <!--- Get Response --->
    <cfreturn loginradiusDeleteResponse(result)>
  </cffunction>

  <cffunction name="passwordLessLoginByEmail" hint="This API is used to send Passwordless Login verification link by Email ID.">
	    <!--- Define arguments. --->
	<cfargument name="email" type="string" required="true" />
	<cfargument name="passwordlesslogintemplate" type="string" required="false" default="" hint="passwordless login template"/>
	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>

    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/login/passwordlesslogin/email">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="email" value="#arguments.email#" type="URL">
      <cfhttpparam name="passwordlesslogintemplate" value="#arguments.passwordlesslogintemplate#" type="URL">
	  <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
    </cfhttp>
		    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="passwordLessLoginByUsername" hint="This API is used to send Passwordless Login verification link by UserName.">
	    <!--- Define arguments. --->
	<cfargument name="username" type="string" required="true" />
	<cfargument name="passwordlesslogintemplate" type="string" required="false" default="" hint="passwordless login template"/>
	<cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>

    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/login/passwordlesslogin/email">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="username" value="#arguments.username#" type="URL">
      <cfhttpparam name="passwordlesslogintemplate" value="#arguments.passwordlesslogintemplate#" type="URL">
	  <cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
    </cfhttp>
		    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="passwordLessLoginVerification" hint="This API is used to verify Passwordless Login verification link.">
	    <!--- Define arguments. --->
	<cfargument name="verificationtoken" type="string" required="true" />
	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" hint="welcome email template"/>

    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/login/passwordlesslogin/email/verify">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="verificationtoken" value="#arguments.verificationtoken#" type="URL">
      <cfhttpparam name="welcomeemailtemplate" value="#arguments.welcomeemailtemplate#" type="URL">
    </cfhttp>
		    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="phoneSendOtp" hint="This API can be used to send a One-time Passcode.">
	    <!--- Define arguments. --->
	<cfargument name="phone" type="string" required="true" />
	<cfargument name="smstemplate" type="string" required="false" default="" hint="sms template"/>

    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/login/passwordlesslogin/otp">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="phone" value="#arguments.phone#" type="URL">
      <cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
    </cfhttp>
		    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="phoneLoginUsingOtp" hint="This API verifies an account by OTP and allows the user to login.">
	    <!--- Define arguments. --->
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>
	<cfargument name="smstemplate" type="string" required="false" default="" hint="sms template"/>

    <cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/login/passwordlesslogin/otp/verify">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
      <cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
    </cfhttp>
		    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="smartLoginByEmail" hint="This API sends smart login link to the user's Email Id.">
	    <!--- Define arguments. --->
	<cfargument name="email" type="string" required="true" />
	<cfargument name="clientguid" type="string" required="true" />
	<cfargument name="smartloginemailtemplate" type="string" required="false" default="" hint="smart login email template"/>
	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" hint="welcome email template"/>
	<cfargument name="redirecturl" type="string" required="false" default="" hint="redirect url"/>

    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/login/smartlogin">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="email" value="#arguments.email#" type="URL">
	  <cfhttpparam name="clientguid" value="#arguments.clientguid#" type="URL">
      <cfhttpparam name="smartloginemailtemplate" value="#arguments.smartloginemailtemplate#" type="URL">
	  <cfhttpparam name="welcomeemailtemplate" value="#arguments.welcomeemailtemplate#" type="URL">
	  <cfhttpparam name="redirecturl" value="#arguments.redirecturl#" type="URL">
    </cfhttp>
		  <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="smartLoginByUsername" hint="This API sends smart login link to the user's Email Id.">
	    <!--- Define arguments. --->
	<cfargument name="username" type="string" required="true" />
	<cfargument name="clientguid" type="string" required="true" />	
	<cfargument name="smartloginemailtemplate" type="string" required="false" default="" hint="smart login email template"/>
	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" hint="welcome email template"/>
	<cfargument name="redirecturl" type="string" required="false" default="" hint="redirect url"/>

    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/login/smartlogin">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="username" value="#arguments.username#" type="URL">
	  <cfhttpparam name="clientguid" value="#arguments.clientguid#" type="URL">
      <cfhttpparam name="smartloginemailtemplate" value="#arguments.smartloginemailtemplate#" type="URL">
	  <cfhttpparam name="welcomeemailtemplate" value="#arguments.welcomeemailtemplate#" type="URL">
	  <cfhttpparam name="redirecturl" value="#arguments.redirecturl#" type="URL">
    </cfhttp>
	     <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="smartLoginPing" hint="This API is used to check that smart login link has been clicked or not on server.">
	    <!--- Define arguments. --->
	<cfargument name="clientguid" type="string" required="true" />

    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/login/smartlogin/ping">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="clientguid" value="#arguments.clientguid#" type="URL">
    </cfhttp>
	    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="smartLoginVerifyToken" hint="Verifies the provided token for Smart Login.">
	    <!--- Define arguments. --->
	<cfargument name="verificationtoken" type="string" required="true" />
	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" hint="welcome email template"/>

    <cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/email/smartlogin">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam name="verificationtoken" value="#arguments.verificationtoken#" type="URL">
      <cfhttpparam name="welcomeemailtemplate" value="#arguments.welcomeemailtemplate#" type="URL">
    </cfhttp>
	    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="oneTouchLoginByEmail" hint="This API is used to send a link to a specified email for a frictionless login/registration.">
	    <!--- Define arguments. --->
       <cfargument name="payload" type="any" required="true" hint="data in json format"/>
	<cfargument name="redirecturl" type="string" required="false" default="" hint="redirecturl"/>
	<cfargument name="onetouchloginemailtemplate" type="string" required="false" default="" hint="one touch login email template"/>
	<cfargument name="welcomeemailtemplate" type="string" required="false" default="" hint="welcome email template"/>

    <cfhttp method="POST" url="#variables.LR_USER_AUTH_API_ENDPOINT#/onetouchlogin/email">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
<cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">   
	  <cfhttpparam name="redirecturl" value="#arguments.redirecturl#" type="URL">
	  <cfhttpparam name="onetouchloginemailtemplate" value="#arguments.onetouchloginemailtemplate#" type="URL">
      <cfhttpparam name="welcomeemailtemplate" value="#arguments.welcomeemailtemplate#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>
   	 <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="oneTouchLoginByPhone" hint="This API is used to send a link to a specified phone number for a frictionless login/registration.">
	    <!--- Define arguments. --->
    <cfargument name="payload" type="any" required="true" hint="data in json format"/>
	<cfargument name="smstemplate" type="string" required="false" default="" hint="sms template"/>

    <cfhttp method="POST" url="#variables.LR_USER_AUTH_API_ENDPOINT#/onetouchlogin/phone">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
<cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
	  <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>
	    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="oneTouchOtpVerification" hint="This API is used to verify the otp for One Touch Login.">
	    <!--- Define arguments. --->
	<cfargument name="otp" type="string" required="true" hint="otp"/>
	<cfargument name="phone" type="string" required="true" hint="phone"/>
	<cfargument name="smstemplate" type="string" required="false" default="" hint="sms template" />

	<cfset payload = "{ 'phone': '#arguments.phone#' }" />

	<cfhttp method="PUT" url="#variables.LR_USER_AUTH_API_ENDPOINT#/onetouchlogin/phone/verify">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#payload#" type="body">
	  <cfhttpparam name="otp" value="#arguments.otp#" type="URL">
	  <cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="validateCode" hint="This API allows you to validate code for a perticular dropdown member.">
	    <!--- Define arguments. --->
	<cfargument name="payload" type="any" required="true" hint ="data in json format"/>

	<cfhttp method="POST" url="#variables.LR_USER_AUTH_API_ENDPOINT#/registrationdata/validatecode">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
	  <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
      <cfhttpparam value="#arguments.payload#" type="body">
    </cfhttp>
    
	  <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="authGetRegistrationData" hint="This API is used to retrieve dropdown data.">
   		<!--- Define arguments. --->
   	<cfargument name="type" type="string" required="true" hint="type"/>
	<cfargument name="parentid" type="string" required="false" default="" hint="parentid" />
	<cfargument name="skip" type="string" required="false" default="" hint="skip" />
	<cfargument name="limit" type="string" required="false" default="" hint="limit" />

	<cfhttp url="#variables.LR_USER_AUTH_API_ENDPOINT#/registrationdata/#arguments.type#">
<cfhttpparam type="header" name="Accept-Encoding" value="*" />
            <cfhttpparam type="Header" name="TE" value="deflate;q=0">
      <cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
	  <cfhttpparam name="parentid" value="#arguments.parentid#" type="URL">
	  <cfhttpparam name="skip" value="#arguments.skip#" type="URL">
	  <cfhttpparam name="limit" value="#arguments.limit#" type="URL">
    </cfhttp>
    
	  <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

</cfcomponent>