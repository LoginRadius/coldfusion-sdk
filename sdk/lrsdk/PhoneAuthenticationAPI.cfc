<cfcomponent displayname="phoneauthenticationapi" 
             hint="This is the CFC for Phone Authentication APIs">
	<cfinclude template="init.cfm">
	<!---
	
	    Initialise in to your application using:
	
	    <cfset SdkObject = createObject("component","lrsdk.phoneauthenticationapi").init(
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
		<cfargument name="LR_PHONE_AUTH_API_ENDPOINT" required="false" 
		            default="https://api.loginradius.com/identity/v2/auth" 
		            hint="LoginRadius phone Authentication endpoint" type="string"/>
	
		<cfset variables.lr_api_key = arguments.lr_api_key/>
		<cfset variables.lr_api_secret = arguments.lr_api_secret/>
		<cfset variables.lr_api_signing = arguments.lr_api_signing/>
		<cfset variables.LR_PHONE_AUTH_API_ENDPOINT = arguments.LR_PHONE_AUTH_API_ENDPOINT/>
	
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="loginByPhone" hint="To login by phone">
		<!--- Define arguments. --->
		<cfargument name="payload" type="any" required="true" hint="data in json format"/>
		<cfargument name="loginurl" type="string" required="false" default=""
		            hint="login url"/>
		<cfargument name="smstemplate" type="string" required="false" default=""
		            hint="sms template"/>
		<cfargument name="grecaptcharesponse" type="string" required="false" default=""
		            hint="g recaptcha response"/>
	
		<cfhttp method="POST" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/login">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#arguments.payload#" type="body">
			<cfhttpparam name="loginurl" value="#arguments.loginurl#" type="URL">
			<cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
			<cfhttpparam name="g-recaptcha-response" value="#arguments.grecaptcharesponse#" type="URL">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="phoneForgotPasswordByOtp" 
	            hint="This API is used to send the OTP to reset the account password.">
		<!--- Define arguments. --->
		<cfargument name="phone" type="string" required="true" hint="phone"/>
		<cfargument name="smstemplate" type="string" required="false" default=""
		            hint="sms template"/>
	
		<cfset payload = "{ 'phone': '#arguments.phone#' }"/>
	
		<cfhttp method="POST" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/password/otp">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#payload#" type="body">
			<cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="phoneResendOtp" hint="This API is used to resend a verification OTP.">
		<!--- Define arguments. --->
		<cfargument name="phone" type="string" required="true" hint="phone"/>
		<cfargument name="smstemplate" type="string" required="false" default=""
		            hint="sms template"/>
	
		<cfset payload = "{ 'phone': '#arguments.phone#' }"/>
	
		<cfhttp method="POST" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/phone/otp">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#payload#" type="body">
			<cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="phoneResendOtpByToken" 
	            hint="This API is used to resend a verification OTP using an active token.">
		<!--- Define arguments. --->
		<cfargument name="accesstoken" type="string" required="true" hint="phone"/>
		<cfargument name="phone" type="string" required="true" hint="phone"/>
		<cfargument name="smstemplate" type="string" required="false" default=""
		            hint="sms template"/>
	
		<cfset payload = "{ 'phone': '#arguments.phone#' }"/>
	
		<cfhttp method="POST" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/phone/otp">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#payload#" type="body">
			<cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="registerByPhone" hint="To register user by phone">
		<!--- Define arguments. --->
		<cfargument name="payload" type="any" required="true" hint="data in json format"/>
		<cfargument name="verificationurl" type="string" required="false" default=""
		            hint="verification url"/>
		<cfargument name="smstemplate" type="string" required="false" default=""
		            hint="sms template"/>
		<cfargument name="options" type="string" required="false" default=""
		            hint="prevent verification email"/>
	
		<cfset SdkObject = createObject("component", "lrsdk.accountapi").init(lr_api_key="#variables.lr_api_key#", 
		                                                                      lr_api_secret="#variables.lr_api_secret#",
		                                                                      lr_api_signing="#variables.lr_api_signing#")>
	
		<cfset result = SdkObject.generateSott("10")>
	
		<cfhttp method="POST" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/register">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam type="header" name="X-LoginRadius-Sott" value="#result.Sott#">
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#arguments.payload#" type="body">
			<cfhttpparam name="verificationurl" value="#arguments.verificationurl#" type="URL">
			<cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
			<cfhttpparam name="options" value="#arguments.options#" type="URL">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="checkPhoneNumberAvailability" 
	            hint="This API is used to check the Phone Number exists or not.">
		<!--- Define arguments. --->
		<cfargument name="phone" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/phone">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="phone" value="#arguments.phone#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="phoneNumberUpdate" 
	            hint="This API is used to update the login Phone Number of users.">
		<!--- Define arguments. --->
		<cfargument name="accesstoken" type="string" required="true" hint="phone"/>
		<cfargument name="phone" type="string" required="true" hint="phone"/>
		<cfargument name="smstemplate" type="string" required="false" default=""
		            hint="sms template"/>
	
		<cfset payload = "{ 'phone': '#arguments.phone#' }"/>
	
		<cfhttp method="PUT" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/phone">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#payload#" type="body">
			<cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="phoneResetPasswordByOtp" hint="This API is used to reset the password.">
		<!--- Define arguments. --->
		<cfargument name="phone" type="string" required="true" hint="phone"/>
		<cfargument name="otp" type="string" required="true" hint="otp"/>
		<cfargument name="password" type="string" required="true" hint="password"/>
		<cfargument name="smstemplate" type="string" required="false" default=""
		            hint="sms template"/>
		<cfargument name="resetpasswordemailtemplate" type="string" required="false" default=""
		            hint="reset password email template"/>
	
		<cfset payload = "{ 'phone': '#arguments.phone#', 'otp': '#arguments.otp#', 'password': '#arguments.password#', 'smstemplate': '#arguments.smstemplate#', 'resetpasswordemailtemplate': '#arguments.resetpasswordemailtemplate#' }"/>
	
		<cfhttp method="PUT" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/password/otp">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#payload#" type="body">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="phoneVerificationByOtp" 
	            hint="This API is used to validate the verification code sent to verify a user's phone number.">
		<!--- Define arguments. --->
		<cfargument name="phone" type="string" required="true" hint="phone"/>
		<cfargument name="otp" type="string" required="true" hint="phone"/>
		<cfargument name="smstemplate" type="string" required="false" default=""
		            hint="sms template"/>
	
		<cfset payload = "{ 'phone': '#arguments.phone#' }"/>
	
		<cfhttp method="PUT" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/phone/otp">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#payload#" type="body">
			<cfhttpparam name="otp" value="#arguments.otp#" type="URL">
			<cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="phoneVerificationOtpByToken" 
	            hint="This API is used to consume the verification code sent to verify a user's phone number.">
		<!--- Define arguments. --->
		<cfargument name="accesstoken" type="string" required="true" hint="access token"/>
		<cfargument name="otp" type="string" required="true" hint="otp"/>
		<cfargument name="smstemplate" type="string" required="false" default=""
		            hint="sms template"/>
		<cfargument name="payload" type="any" required="false" default=""
		            hint="data in json format"/>
	
		<cfhttp method="PUT" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/phone/otp">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#arguments.payload#" type="body">
			<cfhttpparam name="otp" value="#arguments.otp#" type="URL">
			<cfhttpparam name="smstemplate" value="#arguments.smstemplate#" type="URL">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="removePhoneIdByAccessToken" 
	            hint="This API is used to delete the Phone ID on a user's account via the access token.">
		<!--- Define arguments. --->
		<cfargument name="accessToken" type="string" required="true" hint="access token"/>
		<cfargument name="payload" type="any" required="false" default=""
		            hint="data in json format"/>
	
		<cfhttp method="DELETE" url="#variables.LR_PHONE_AUTH_API_ENDPOINT#/phone">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam type="header" name="Content-Type" value="application/json"/>
			<cfhttpparam type="header" name="Authorization" value="Bearer #arguments.accesstoken#">
			<cfhttpparam name="apikey" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam value="#arguments.payload#" type="body">
		</cfhttp>
	
		<!--- Get Response --->
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
</cfcomponent>