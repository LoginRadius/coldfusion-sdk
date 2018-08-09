<cfif structkeyexists(Session.userProfile, "Uid")>
<cfset SdkObject = createObject("component","sdk.loginradiussdk").init(
        raas_api_key = RAAS_API_KEY,
        raas_api_secret = RAAS_API_SECRET
      )>
<cfscript>
raas_id ='';
if(Session.userProfile.Provider == 'raas'){
	raas_id = Session.userProfile.Uid;
}
else{
	profileResult = SdkObject.loginradiusGetAccounts(Session.userProfile.Uid);
	if(IsArray(profileResult)){
	for ( key in profileResult )  // for-in loop for struct
  {
if(key.Provider == 'raas'){
raas_Profile_data = 	key;

}
  }
  if (structkeyexists(raas_Profile_data, "Uid")) {
  raas_id  = raas_Profile_data.Uid;
  }

	}
		
}
</cfscript>
<cfif raas_id NEQ ''>
<cfset objActress = StructNew() />
<cfset objActress.newpassword ="#form.newpassword#" />
<cfset objActress.oldpassword = "#form.oldpassword#" />
<cfset message ='Password is not changed'>
<cftry> 
<cfscript>
serializer = new lib.JsonSerializer()
    .asString( "newpassword" )
    .asString( "oldpassword" )
  ;
  </cfscript>
<cfset changePasswordResult = SdkObject.loginradiusChangePassword(raas_id, serializer.serialize( objActress ))>
<cfif structkeyexists(changePasswordResult, "isPosted")>
<cfif changePasswordResult.isPosted EQ true>
<cfset message ='Password changed successfully'>
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