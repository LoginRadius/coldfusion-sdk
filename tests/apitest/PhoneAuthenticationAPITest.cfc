<cfcomponent displayname="phoneauthenticationapitest" extends="mxunit.framework.TestCase">
<cfinclude template="testconfig.cfm">

<cfset phoneAuthObject = createObject("component","lrsdk.phoneauthenticationapi").init(
        lr_api_key = LR_TEST_API_KEY,
        lr_api_secret = LR_TEST_API_SECRET
      )>


<cffunction name="testLoginByPhone" hint="To login user via phone">
	<cfset response = phoneAuthObject.loginByPhone( PHONE_LOGIN_PAYLOAD )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPhoneForgotPasswordByOtp" hint="This API is used to send the OTP to reset the account password.">
	<cfset response = phoneAuthObject.phoneForgotPasswordByOtp( PHONE_ID )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPhoneResendOtp" hint="This API is used to resend a verification OTP.">
	<cfset response = phoneAuthObject.phoneResendOtp( PHONE_ID )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPhoneResendOtpByToken" hint="This API is used to resend a verification OTP using an active token.">
	<cfset response = phoneAuthObject.phoneResendOtpByToken( ACCESS_TOKEN, PHONE_ID )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testCheckPhoneNumberAvailability" hint="This API is used to check the Phone Number exists or not.">
	<cfset response = phoneAuthObject.checkPhoneNumberAvailability( PHONE_ID )>
	 <cfset assertEquals( "true",  response.IsExist)>
</cffunction>

<cffunction name="testPhoneNumberUpdate" hint="This API is used to update the login Phone Number of users.">
	<cfset response = phoneAuthObject.phoneNumberUpdate( ACCESS_TOKEN, PHONE_ID )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPhoneResetPasswordByOtp" hint="This API is used to reset the password.">
	<cfset response = phoneAuthObject.phoneResetPasswordByOtp( PHONE_ID, OTP, PASSWORD )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPhoneVerificationByOtp" hint="This API is used to validate the verification code sent to verify a user's phone number.">
	<cfset response = phoneAuthObject.phoneVerificationByOtp( PHONE_ID, OTP )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPhoneVerificationOtpByToken" hint="This API is used to consume the verification code sent to verify a user's phone number.">
	<cfset response = phoneAuthObject.phoneVerificationOtpByToken( ACCESS_TOKEN, OTP )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testRemovePhoneIdByAccessToken" hint="This API is used to delete the Phone ID.">
	<cfset response = phoneAuthObject.removePhoneIdByAccessToken( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

</cfcomponent>