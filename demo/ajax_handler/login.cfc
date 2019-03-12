<cfcomponent displayname="login" hint="This is the before login api handler.">
<cfinclude template="config.cfm">

  <cfset authObject = createObject("component","lrsdk.authenticationapi").init(
        lr_api_key = '#LR_API_KEY#',
        lr_api_secret = '#LR_API_SECRET#',
        lr_api_signing = '#API_REQUEST_SIGNING#'
      )>

  <cfset mfaObject = createObject("component","lrsdk.multifactorauthenticationapi").init(
        lr_api_key = '#LR_API_KEY#',
        lr_api_secret = '#LR_API_SECRET#'
      )>

  <cffunction name="getProfile" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="token" type="string" required="true" hint="access token"/>
    <cftry>
    <cfset result = authObject.getProfileByToken(arguments.token)>
        <cfset stcRetVal["data"] = result>
        <cfset stcRetVal["status"] = "success"> 
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.message#'>   
       <cfset stcRetVal["message"] = message>
       <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>      

 <cfreturn stcRetVal />
 </cffunction>

<cffunction name="loginByEmail" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="email" type="string" required="true" hint="email"/>
    <cfargument name="password" type="string" required="true" hint="password"/>
    <cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>

    <cfset payload = "{'Email': '#arguments.email#', 'Password': '#arguments.password#'}">
    <cftry>
    <cfset result = authObject.loginByEmail(payload, arguments.verificationurl)>
    <cfset stcRetVal["data"] = result>
    <cfset stcRetVal["status"] = "success">
   
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'> 
    <cfset stcRetVal["message"] = message>
    <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>

 <cfreturn stcRetVal />
 </cffunction>

<cffunction name="registration" access="remote" output="true" returntype="struct" returnformat="json" hint="handle registration request.">
    <cfargument name="email" type="string" required="true" hint="email"/>
    <cfargument name="password" type="string" required="true" hint="password"/>
    <cfargument name="verificationurl" type="string" required="false" default="" hint="verification url"/>

   <cfset payload = "{'Email': [{'Type': 'Primary', 'Value': '#arguments.email#'}], 'Password': '#arguments.password#'}">
    <cftry>
    <cfset result = authObject.registerByEmail(payload, arguments.verificationurl)>
    <cfif structkeyexists(result, "EmailVerified")>
          <cfset stcRetVal["result"] = result>
          <cfset stcRetVal["message"] = "You have successfully registered.">
          <cfset stcRetVal["status"] = "success">
    <cfelse>
	  <cfset stcRetVal["message"] = "You have successfully registered, Please check your email.">
          <cfset stcRetVal["status"] = "registered">
    </cfif>
   
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'> 
    <cfset stcRetVal["message"] = message>
    <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>

 <cfreturn stcRetVal />
 </cffunction>

<cffunction name="pwLessLogin" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="email" type="string" required="true" hint="email"/>
    <cfargument name="verificationurl" type="string" required="true" hint="verification url"/>
   
    <cftry>
    <cfset result = authObject.passwordLessLoginByEmail(arguments.email, '', arguments.verificationurl)>
      <cfif structkeyexists(result, "IsPosted")>
          <cfset stcRetVal["message"] = "One time login link has been sent to your provided email id, check email for further instruction.">
          <cfset stcRetVal["status"] = "success">
     </cfif>   
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'> 
    <cfset stcRetVal["message"] = message>
    <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>

 <cfreturn stcRetVal />
 </cffunction>

<cffunction name="pwLessLinkVerify" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="token" type="string" required="true" hint="vtoken"/>
   
    <cftry>
    <cfset result = authObject.passwordLessLoginVerification(arguments.token)>
      <cfif structkeyexists(result, "access_token")>
          <cfset stcRetVal["data"] = result>
          <cfset stcRetVal["status"] = "success">
     </cfif>   
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'> 
    <cfset stcRetVal["message"] = message>
    <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>

 <cfreturn stcRetVal />
 </cffunction>

<cffunction name="emailVerify" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="vtoken" type="string" required="true" hint="vtoken"/>
   
    <cftry>
    <cfset result = authObject.varifyEmail(arguments.vtoken)>
      <cfif structkeyexists(result, "IsPosted")>
          <cfset stcRetVal["message"] = "Your email has been verified successfully.">
          <cfset stcRetVal["status"] = "success">
     </cfif>   
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'> 
    <cfset stcRetVal["message"] = message>
    <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>

 <cfreturn stcRetVal />
 </cffunction>

<cffunction name="mfaLogin" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="email" type="string" required="true" hint="email"/>
    <cfargument name="password" type="string" required="true" hint="password"/>

    <cfset payload = "{'Email': '#arguments.email#', 'Password': '#arguments.password#'}">    
    <cftry>
    <cfset result = mfaObject.mfaEmailLogin(payload)>
    <cfset stcRetVal["data"] = result>
    <cfset stcRetVal["status"] = "success">
   
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'> 
    <cfset stcRetVal["message"] = message>
    <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>

 <cfreturn stcRetVal />
 </cffunction>

<cffunction name="mfaValidate" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="secondFactorAuthenticationToken" type="string" required="true" hint="second factor auth token"/>
    <cfargument name="googleAuthCode" type="string" required="true" hint="google auth code"/>

    <cftry>
    <cfset result = mfaObject.mfaValidateGoogleAuthCode(arguments.secondFactorAuthenticationToken, arguments.googleAuthCode)>

     <cfif structkeyexists(result, "access_token")>
            <cfset stcRetVal["data"] = result>
            <cfset stcRetVal["status"] = "success">
     </cfif>
   
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'> 
    <cfset stcRetVal["message"] = message>
    <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>

 <cfreturn stcRetVal />
 </cffunction>

<cffunction name="forgotPassword" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="email" type="string" required="true" hint="email"/>
    <cfargument name="resetPasswordUrl" type="string" required="true" hint="reset password url"/>
   
    <cftry>
    <cfset result = authObject.forgotPassword(arguments.email, arguments.resetPasswordUrl)>
      <cfif structkeyexists(result, "IsPosted")>
          <cfset stcRetVal["message"] = "We'll email you an instruction on how to reset your password.">
          <cfset stcRetVal["status"] = "success">
     </cfif>   
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'> 
    <cfset stcRetVal["message"] = message>
    <cfset stcRetVal["status"] = "error">  
    </cfcatch></cftry>
 <cfreturn stcRetVal />
 </cffunction>

<cffunction name="resetPassword" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="resettoken" type="string" required="true" hint="reset token"/>
    <cfargument name="password" type="string" required="true" hint="password"/>
   
    <cftry>
    <cfset result = authObject.resetPasswordByResetToken(arguments.resettoken, arguments.password)>
      <cfif structkeyexists(result, "IsPosted")>
          <cfset stcRetVal["message"] = "Password has been reset successfully.">
          <cfset stcRetVal["status"] = "success">
     </cfif>   
    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'> 
    <cfset stcRetVal["message"] = message>
    <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>

 <cfreturn stcRetVal />
 </cffunction>

</cfcomponent>