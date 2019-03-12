<cfcomponent displayname="authenticatonapitest" extends="mxunit.framework.TestCase">
<cfinclude template="testconfig.cfm">

<cfset authenticationObject = createObject("component","lrsdk.authenticationapi").init(
        lr_api_key = LR_TEST_API_KEY,
        lr_api_secret = LR_TEST_API_SECRET,
        lr_api_signing = TEST_API_REQUEST_SIGNING
      )>

<cffunction name="testRegister" hint="To register user">
	<cfset response = authenticationObject.register( USER_REGISTER_PAYLOAD )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginByEmail" hint="To login user using email">
	<cfset response = authenticationObject.loginByEmail( EMAIL_LOGIN_PAYLOAD )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginByUsername" hint="To login user using username">
	<cfset response = authenticationObject.loginByUsername( USERNAME_LOGIN_PAYLOAD )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAddEmail" hint="To add additional email">
	<cfset response = authenticationObject.addEmail( ACCESS_TOKEN, ADD_EMAIL, ADD_EMAIL_TYPE )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testForgotPassword" hint="To send the reset password url">
	<cfset response = authenticationObject.forgotPassword( EMAIL, RESET_PASSWORD_URL )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testCheckEmailExist" hint="To check the email exists or not">
	<cfset response = authenticationObject.checkEmailExist( EMAIL )>
 	<cfset assertEquals( "true",  response.IsExist)>
</cffunction>

<cffunction name="testCheckUsernameExist" hint="To check the username exists or not">
	<cfset response = authenticationObject.checkUsernameExist( USERNAME )>
 	<cfset assertEquals( "true",  response.IsExist)>
</cffunction>

<cffunction name="testGetProfileByToken" hint="To get profile by token">
	<cfset response = authenticationObject.getProfileByToken( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPrivacyPolicyAccept" hint="Privacy policy accept">
	<cfset response = authenticationObject.privacyPolicyAccept( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSendWelcomeEmail" hint="Send Welcome email">
	<cfset response = authenticationObject.sendWelcomeEmail( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetSocialIdentity" hint="get profile data">
	<cfset response = authenticationObject.getSocialIdentity( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testValidateAccessToken" hint="This api validates access token">
	<cfset response = authenticationObject.validateAccessToken( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "access_token")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testVarifyEmail" hint="This api verify email">
	<cfset response = authenticationObject.varifyEmail( VERIFICATION_TOKEN )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testDeleteAccount" hint="To delete an account">
	<cfset response = authenticationObject.deleteAccount( DELETE_TOKEN )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testInvalidateAccessToken" hint="This api call invalidates the active access token">
	<cfset response = authenticationObject.invalidateAccessToken( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSecurityQuestionByToken" hint="To retrieve the list of questions">
	<cfset response = authenticationObject.securityQuestionByToken( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "QuestionId")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSecurityQuestionByEmail" hint="To retrieve the list of questions">
	<cfset response = authenticationObject.securityQuestionByEmail( EMAIL )>
	<cfif structkeyexists(response, "QuestionId")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSecurityQuestionByUsername" hint="To retrieve the list of questions">
	<cfset response = authenticationObject.securityQuestionByUsername( USERNAME )>
	<cfif structkeyexists(response, "QuestionId")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSecurityQuestionByPhone" hint="To retrieve the list of questions">
	<cfset response = authenticationObject.securityQuestionByPhone( PHONE_ID )>
	<cfif structkeyexists(response, "QuestionId")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testVarifyEmailByOtp" hint="To verify the email of user using otp">
	<cfset response = authenticationObject.varifyEmailByOtp( VERITY_EMAIL_BY_OTP_PAYLOAD )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testChangePassword" hint="To change password">
	<cfset response = authenticationObject.changePassword( ACCESS_TOKEN, OLD_PASS, NEW_PASS )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAccountLink" hint="To account linking">
	<cfset response = authenticationObject.accountLink( ACCESS_TOKEN, CANDIDATE_TOKEN )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testResendEmailVerification" hint="To resend verification email">
	<cfset response = authenticationObject.resendEmailVerification( EMAIL )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testResetPasswordByResetToken" hint="To set a new password using reset token">
	<cfset response = authenticationObject.resetPasswordByResetToken( RESET_TOKEN, PASSWORD )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testResetPasswordByOTP" hint="To set a new password using otp">
	<cfset response = authenticationObject.resetPasswordByOTP( EMAIL, PASSWORD, OTP )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testResetPasswordByEmail" hint="To set a new password using email">
	<cfset response = authenticationObject.resetPasswordByEmail( PAYLOAD )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testResetPasswordByPhone" hint="To set a new password using phone">
	<cfset response = authenticationObject.resetPasswordByPhone( PAYLOAD )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testResetPasswordByUsername" hint="To set a new password using username">
	<cfset response = authenticationObject.resetPasswordByUsername( PAYLOAD )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testChangeUsername" hint="To change username">
	<cfset response = authenticationObject.changeUsername( ACCESS_TOKEN, USERNAME )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testUpdateProfileByToken" hint="To update profile">
	<cfset response = authenticationObject.updateProfileByToken( ACCESS_TOKEN, PAYLOAD )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testUpdateSecurityQuestionByToken" hint="To update security questions by the access token">
	<cfset response = authenticationObject.updateSecurityQuestionByToken( ACCESS_TOKEN, PAYLOAD )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testDeleteAccountByEmailConfirmation" hint="This API deletes a user account.">
	<cfset response = authenticationObject.deleteAccountByEmailConfirmation( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "IsDeleteRequestAccepted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testRemoveEmail" hint="To remove additional emails.">
	<cfset response = authenticationObject.removeEmail( ACCESS_TOKEN, EMAIL )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAccountUnlink" hint="To remove additional emails.">
	<cfset response = authenticationObject.accountUnlink( ACCESS_TOKEN, PROVIDER, PROVIDER_ID )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPasswordLessLoginByEmail" hint="To send Passwordless Login verification link by email.">
	<cfset response = authenticationObject.passwordLessLoginByEmail( EMAIL )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPasswordLessLoginByUsername" hint="To send Passwordless Login verification link by username.">
	<cfset response = authenticationObject.passwordLessLoginByUsername( USERNAME )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPasswordLessLoginVerification" hint="To verify Passwordless Login verification link.">
	<cfset response = authenticationObject.passwordLessLoginVerification( VERIFICATION_TOKEN )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPhoneSendOtp" hint="This API can be used to send a One-time Passcode.">
	<cfset response = authenticationObject.phoneSendOtp( PHONE_ID )>
	<cfif structkeyexists(response, "Data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testPhoneLoginUsingOtp" hint="This API verifies an account by OTP and allows the user to login.">
	<cfset response = authenticationObject.phoneLoginUsingOtp( PHONE_LOGIN_OTP_PAYLOAD )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSmartLoginByEmail" hint="This API sends smart login link to the user's Email Id.">
	<cfset response = authenticationObject.smartLoginByEmail( CLIENTGUID, EMAIL )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSmartLoginByUsername" hint="This API sends smart login link to the user's Email Id.">
	<cfset response = authenticationObject.smartLoginByUsername( CLIENTGUID, USERNAME )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSmartLoginPing" hint="This API is used to check that smart login link has been clicked or not on server.">
	<cfset response = authenticationObject.smartLoginPing( CLIENTGUID )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testSmartLoginVerifyToken" hint="Verifies the provided token for Smart Login.">
	<cfset response = authenticationObject.smartLoginVerifyToken( VERIFICATION_TOKEN )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testOneTouchLoginByEmail" hint="This API is used to send a link to a specified email for a frictionless login/registration.">
	<cfset response = authenticationObject.oneTouchLoginByEmail( EMAIL, CLIENTGUID )>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testOneTouchLoginByPhone" hint="This API is used to send a link to a specified email for a frictionless login/registration.">
	<cfset response = authenticationObject.oneTouchLoginByPhone( PHONE_ID )>
	<cfif structkeyexists(response, "Data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testOneTouchOtpVerification" hint="This API is used to verify the otp for One Touch Login.">
	<cfset response = authenticationObject.oneTouchOtpVerification( OTP, PHONE_ID )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaEmailLogin" hint="This API can be used to login by emailid on a Multi-Factor Authentication enabled LoginRadius site.">
	<cfset response = authenticationObject.mfaEmailLogin( EMAIL, PASSWORD )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaUserNameLogin" hint="This API can be used to login by username on a Multi-Factor Authentication enabled LoginRadius site.">
	<cfset response = authenticationObject.mfaUserNameLogin( USERNAME, PASSWORD )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaPhoneLogin" hint="This API can be used to login by phone on a Multi-Factor Authentication enabled LoginRadius site.">
	<cfset response = authenticationObject.mfaPhoneLogin( PHONE_ID, PASSWORD )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>


<cffunction name="testMfaValidateToken" hint="This API is used to configure the Multi-factor authentication after login by using the access token.">
	<cfset response = authenticationObject.mfaValidateToken( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "QRCode")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaBackupCodeByToken" hint="This API is used to get a set of backup codes via access token.">
	<cfset response = authenticationObject.mfaBackupCodeByToken( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "BackUpCodes")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaResetBackupCodeByToken" hint="This API is used to reset the backup codes on a given account via the access token.">
	<cfset response = authenticationObject.mfaResetBackupCodeByToken( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "BackUpCodes")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaValidateBackupCode" hint="This API is used to validate the backup code.">
	<cfset response = authenticationObject.mfaValidateBackupCode( SECOND_FACTOR_AUTH_TOKEN, BACKUP_CODE )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaValidateOTP" hint="This API is used to login via Multi-factor authentication by passing the One Time Password received via SMS.">
	<cfset response = authenticationObject.mfaValidateOTP( SECOND_FACTOR_AUTH_TOKEN, MFA_VALIDATE_OTP_PAYLOAD )>
	<cfif structkeyexists(response, "Profile")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaValidateGoogleAuthCode" hint="This API is used to login via Multi-factor authentication by passing the google authenticator code.">
	<cfset response = authenticationObject.mfaValidateGoogleAuthCode( SECOND_FACTOR_AUTH_TOKEN, GOOGLE_AUTH_CODE )>
	<cfif structkeyexists(response, "Identities")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaUpdatePhone" hint="This API is used to update the Multi-factor authentication phone number.">
	<cfset response = authenticationObject.mfaUpdatePhone( SECOND_FACTOR_AUTH_TOKEN, PNONENO_2FA )>
	<cfif structkeyexists(response, "AccountSid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaUpdatePhoneByToken" hint="This API is used to update the Multi-factor authentication phone number.">
	<cfset response = authenticationObject.mfaUpdatePhoneByToken( PNONENO_2FA, ACCESS_TOKEN )>
	<cfif structkeyexists(response, "AccountSid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testUpdateMfaByGoogleAuthCode" hint="This API is used to Enable Multi-factor authentication by access token on user login.">
	<cfset response = authenticationObject.updateMfaByGoogleAuthCode( GOOGLE_AUTH_CODE, ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testUpdateMfaByOtp" hint="This API is used to trigger the Multi-factor authentication settings after login for secure actions.">
	<cfset response = authenticationObject.updateMfaByOtp( UPDATE_MFA_PAYLOAD, ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaResetGoogleAuthenticatorByToken" hint="This API Resets the Google Authenticator configurations on a given account via the access_token.">
	<cfset response = authenticationObject.mfaResetGoogleAuthenticatorByToken( GOOGLE_AUTHENTICATOR, ACCESS_TOKEN )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaResetSMSAuthenticatorByToken" hint="This API Resets the SMS Authenticator configurations on a given account via the access_token.">
	<cfset response = authenticationObject.mfaResetSMSAuthenticatorByToken( OTP_AUTHENTICATOR, ACCESS_TOKEN )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testMfaReAuthenticate" hint="This API is used to trigger the Multi-Factor Autentication workflow for the provided access_token.">
	<cfset response = authenticationObject.mfaReAuthenticate( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "QRCode")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testValidateMfaByGoogleAuthCode" hint="This API is used to re-authenticate via Multi-factor-authentication by passing the google authenticator code.">
	<cfset response = authenticationObject.validateMfaByGoogleAuthCode( ACCESS_TOKEN, GOOGLE_AUTH_CODE )>
	<cfif structkeyexists(response, "SecondFactorValidationToken")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testValidateMfaByBackupCode" hint="This API is used to re-authenticate by set of backup codes via access token.">
	<cfset response = authenticationObject.validateMfaByBackupCode( ACCESS_TOKEN, BACKUP_CODE )>
	<cfif structkeyexists(response, "SecondFactorValidationToken")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testValidateMfaByOtp" hint="This API is used to re-authenticate via Multi-factor authentication by passing the One Time Password received via SMS.">
	<cfset response = authenticationObject.validateMfaByOtp( ACCESS_TOKEN, VALIDATE_MFA_OTP_PAYLOAD )>
	<cfif structkeyexists(response, "SecondFactorValidationToken")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testValidateMfaByPassword" hint="This API is used to re-authenticate via Multi-factor-authentication by passing the password.">
	<cfset response = authenticationObject.validateMfaByPassword( ACCESS_TOKEN, VALIDATE_MFA_PASS_PAYLOAD )>
	<cfif structkeyexists(response, "SecondFactorValidationToken")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testValidateCode" hint="This API allows you to validate code for a perticular dropdown member.">
	<cfset response = authenticationObject.validateCode( VALIDATE_CODE_PAYLOAD )>
	<cfif structkeyexists(response, "IsValid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAuthGetRegistrationData" hint="This API is used to retrieve dropdown data.">
	<cfset response = authenticationObject.authGetRegistrationData( TYPE )>
	<cfif structkeyexists(response, "ParentId")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

</cfcomponent>