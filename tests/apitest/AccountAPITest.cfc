<cfcomponent displayname="accountapitest" extends="mxunit.framework.TestCase">
<cfinclude template="testconfig.cfm">

<cfset accountObject = createObject("component","lrsdk.accountapi").init(
        lr_api_key = LR_TEST_API_KEY,
        lr_api_secret = LR_TEST_API_SECRET,
        lr_api_signing = TEST_API_REQUEST_SIGNING
      )>

<cffunction name="testAccountCreate" hint="To create user">
	<cfset response = accountObject.accountCreate( USER_REGISTER_PAYLOAD )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetEmailVerificationToken" hint="This API Returns an Email Verification token.">
	<cfset response = accountObject.getEmailVerificationToken( EMAIL )>
	<cfif structkeyexists(response, "VerificationToken")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetForgotPasswordToken" hint="This API Returns a forgot password token.">
	<cfset response = accountObject.getForgotPasswordToken( EMAIL )>
	<cfif structkeyexists(response, "ForgotToken")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAccountIdentitiesByEmail" hint="This API is used to retrieve all of the identities.">
	<cfset response = accountObject.accountIdentitiesByEmail( EMAIL )>
	<cfif structkeyexists(response, "Data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAccountImpersonationAPI" hint="This API is used to get LoginRadius access token based on UID.">
	<cfset response = accountObject.accountImpersonationAPI( ACCOUNT_ID )>
	<cfif structkeyexists(response, "access_token")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetPassword" hint="The API is used to retrieve the hashed password of a specified account.">
	<cfset response = accountObject.getPassword( ACCOUNT_ID )>
	<cfif structkeyexists(response, "PasswordHash")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetProfileByEmail" hint="This API is used to retrieve all of the profile data by email.">
	<cfset response = accountObject.getProfileByEmail( EMAIL )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetProfileByUsername" hint="This API is used to retrieve all of the profile data by username.">
	<cfset response = accountObject.getProfileByUsername( USERNAME )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetProfileByPhone" hint="This API is used to retrieve all of the profile data by phone no.">
	<cfset response = accountObject.getProfileByPhone( PHONE_ID )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetProfileByUid" hint="This API is used to retrieve all of the profile data by UID.">
	<cfset response = accountObject.getProfileByUid( ACCOUNT_ID )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSetPassword" hint="This API is used to set the password of an account.">
	<cfset response = accountObject.setPassword( ACCOUNT_ID, PASSWORD )>
	<cfif structkeyexists(response, "PasswordHash")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAccountUpdate" hint="This API is used to update the information of existing account.">
	<cfset response = accountObject.accountUpdate( ACCOUNT_ID, UPDATE_USER_PROFILE_DATA )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testUpdateSecurityQuestion" hint="This API is used to update security questions configuration.">
	<cfset response = accountObject.updateSecurityQuestion( ACCOUNT_ID, SECURITY_QUESTION_ANSWER_PAYLOAD )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testInvalidateVerificationEmail" hint="This API is used to invalidate the Email Verification status on an account.">
	<cfset response = accountObject.invalidateVerificationEmail( ACCOUNT_ID )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAccountEmailDelete" hint="Use this API to Remove emails from a user Account.">
	<cfset response = accountObject.accountEmailDelete( ACCOUNT_ID, EMAIL )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAccountDelete" hint="This API deletes the Users account and allows them to re-register for a new account.">
	<cfset response = accountObject.accountDelete( ACCOUNT_ID )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGenerateSott" hint="This API allows you to generate SOTT with a given expiration time.">
	<cfset response = accountObject.generateSott( TIME_DIFFERENCE )>
	<cfif structkeyexists(response, "Sott")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testResetPhoneIdVerification" hint="This API Allows you to reset the phone no verification.">
	<cfset response = accountObject.resetPhoneIdVerification( ACCOUNT_ID, RESET_PHONE_ID_PAYLOAD )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaGetBackupCodeByUid" hint="This API is used to get a set of backup codes.">
	<cfset response = accountObject.mfaGetBackupCodeByUid( ACCOUNT_ID )>
	<cfif structkeyexists(response, "BackUpCodes")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaResetBackupCodeByUid" hint="This API is used to reset the backup codes.">
	<cfset response = accountObject.mfaResetBackupCodeByUid( ACCOUNT_ID )>
	<cfif structkeyexists(response, "BackUpCodes")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaResetGoogleAuthenticatorByUid" hint="This API resets the Google Authenticator configurations on a given account via the UID.">
	<cfset response = accountObject.mfaResetGoogleAuthenticatorByUid( ACCOUNT_ID, GOOGLE_AUTHENTICATOR )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaResetSMSAuthenticatorByUid" hint="This API resets the SMS Authenticator configurations on a given account via the UID.">
	<cfset response = accountObject.mfaResetSMSAuthenticatorByUid( ACCOUNT_ID, OTP_AUTHENTICATOR )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

</cfcomponent>