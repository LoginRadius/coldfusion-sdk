<cfif structkeyexists(Session.userProfile, "Uid")>
<cfset SdkObject = createObject("component","sdk.loginradiussdk").init(
        raas_api_key = RAAS_API_KEY,
        raas_api_secret = RAAS_API_SECRET
      )>

<cfset accounUnLinkParams = StructNew() />
<cfset accounUnLinkParams.accountid ="#Session.userProfile.Uid#" />
<cfset accounUnLinkParams.provider = "#form.provider#" />
<cfset accounUnLinkParams.providerid = "#form.providerid#" />
<cfset message ='Account is not unlinked'>

<cftry>
<cfscript>
serializer = new lib.JsonSerializer()
		.asString( "accountid" )
		.asString( "provider" )
		.asString( "providerid" )
	;
	</cfscript>
<cfset accountUnLinkingResult = SdkObject.loginradiusAccountUnLink(serializer.serialize( accounUnLinkParams ))>
<cfif structkeyexists(accountUnLinkingResult, "isPosted")>
<cfif accountUnLinkingResult.isPosted EQ true>
<cfset message ='Account unlinked Successfully'>
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