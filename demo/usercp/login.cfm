<cfif structkeyexists(form, "mtoken")>
<cfset SdkObject = createObject("component","sdk.loginradiussdk").init(
        raas_api_key = RAAS_API_KEY,
        raas_api_secret = RAAS_API_SECRET
      )>
<cftry>
<cfset userProfileResult = SdkObject.loginradiusGetUserProfiledata(form.mtoken)>
<cfif structkeyexists(userProfileResult, "Uid")>

<cfset Session.user_id = userProfileResult.Uid> 
<cfset Session.userProfile = userProfileResult> 
</cfif>
<cfcatch type = "LoginRadiusException"> 
<cfset message ='#cfcatch.message#'>
</cfcatch> 
</cftry>

</cfif>