
<cfif structkeyexists(form, "lr_update")>
    <cfset SdkObject = createObject("component","sdk/loginradiussdk")>
        <cfscript>
            serializer = new lib.JsonSerializer()
            .asString( "firstname" )
            .asString( "lastname" )
            .asString( "birthdate" )
            .asString( "country" )
            .asString( "city" )
            ;
        </cfscript>
        <cfset Params = StructNew() />
        <cfif structkeyexists(form, "birthdate")>
            <cfset Params.birthdate ="#form.birthdate#" />
        </cfif>
        <cfif structkeyexists(form, "firstname")>
            <cfset Params.firstname ="#form.firstname#" />
        </cfif>
        <cfif structkeyexists(form, "lastname")>
            <cfset Params.lastname ="#form.lastname#" />
        </cfif>
        <cfif structkeyexists(form, "country")>
            <cfset Params.country ="#form.country#" />
        </cfif>
        <cfif structkeyexists(form, "city")>
            <cfset Params.city ="#form.city#" />
        </cfif>
        <cftry>
            <cfset Result = SdkObject.loginradiusUpdateProfile(RAAS_API_KEY, RAAS_SECRET_KEY, Session.userProfile.ID, serializer.serialize( Params ))>
             
                <cfif structkeyexists(Result, "isPosted")>
                    <cfif Result.isPosted EQ true>
                        <cftry>
                            <cfset profile = SdkObject.loginradiusGetProfileData(RAAS_API_KEY, RAAS_SECRET_KEY, Session.userProfile.ID)>
                                <cfset Session.userProfile = profile> 
                                    <cfcatch type = "LoginRadiusException"> 

                                    </cfcatch> 
                                </cftry>
                                <cfset message ='Your Profile updated successfully'>
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