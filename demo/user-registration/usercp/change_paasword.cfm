<cfif structkeyexists(Session.userProfile, "Uid")>
<cfset SdkObject = createObject("component","sdk/loginradiussdk")>
<cfscript>
raas_id ='';
if(Session.userProfile.Provider == 'raas'){
	raas_id = Session.userProfile.ID;
}
else{
	profileResult = SdkObject.loginradiusGetAccounts(RAAS_API_KEY, RAAS_SECRET_KEY, Session.userProfile.Uid);
	if(IsArray(profileResult)){
	for ( key in profileResult )  // for-in loop for struct
  {
if(key.Provider == 'raas'){
raas_Profile_data = 	key;

}
  }
  if (structkeyexists(raas_Profile_data, "ID")) {
  raas_id  = raas_Profile_data.ID;
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
<cfset changePasswordResult = SdkObject.loginradiusChangePassword(RAAS_API_KEY, RAAS_SECRET_KEY, raas_id, serializer.serialize( objActress ))>
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