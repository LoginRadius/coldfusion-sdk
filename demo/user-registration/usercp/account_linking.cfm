<cfif structkeyexists(form, "mtoken")>
<cfif structkeyexists(form, "linked")>
<cfoutput>
     <script type="text/javascript">
        window.onload=function () {
            handleResponse(true, 'Account Linked Successfully', true);
        }
    </script>

</cfoutput>
<cfelse>

<cfset LRSdkObject = createObject("component","sdk/loginradiussdk")>

<cfset userProfileResult = LRSdkObject.loginradiusGetUserProfiledata(form.mtoken)>
<cfif structkeyexists(userProfileResult, "ID")>
<cfset accountLinkParams = StructNew() />
<cfset accountLinkParams.accountid ="#Session.userProfile.Uid#" />
<cfset accountLinkParams.provider = "#userProfileResult.Provider#" />
<cfset accountLinkParams.providerid = "#userProfileResult.ID#" />
<cfset message ='You cannot link this account as it is already linked with another account'>
<cftry>
<cfscript>
serializer = new lib.JsonSerializer()
		.asString( "accountid" )
		.asString( "provider" )
		.asString( "providerid" )
	;
	</cfscript>
<cfset accountLinkingResult = LRSdkObject.loginradiusAccountLink(RAAS_API_KEY, RAAS_SECRET_KEY, serializer.serialize( accountLinkParams ))>
<cfif structkeyexists(accountLinkingResult, "isPosted")>
<cfif accountLinkingResult.isPosted EQ true>
<cfset message ='Account Linked Successfully'>
</cfif>
</cfif>

<cfcatch type = "LoginRadiusException"> 
<cfset message ='#cfcatch.message#'>
</cfcatch> 
</cftry>


<cfoutput>
     <script type="text/javascript">
        window.onload=function () {
            handleResponse(true, '#message#', true);
        }
    </script>

</cfoutput>
</cfif>
</cfif>
</cfif>