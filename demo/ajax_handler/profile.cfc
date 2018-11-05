<cfcomponent displayname="profile" hint="This is the after login api handler.">
<cfinclude template="config.cfm">

  <cfset authObject = createObject("component","lrsdk.authenticationapi").init(
        lr_api_key = '#LR_API_KEY#',
        lr_api_secret = '#LR_API_SECRET#',
        lr_api_signing = '#API_REQUEST_SIGNING#'
      )>

  <cfset accountObject = createObject("component","lrsdk.accountapi").init(
        lr_api_key = '#LR_API_KEY#',
        lr_api_secret = '#LR_API_SECRET#',
        lr_api_signing = '#API_REQUEST_SIGNING#'
      )>

  <cfset customObject = createObject("component","lrsdk.customobjectapi").init(
        lr_api_key = '#LR_API_KEY#',
        lr_api_secret = '#LR_API_SECRET#',
        lr_api_signing = '#API_REQUEST_SIGNING#'
      )>

  <cfset roleObject = createObject("component","lrsdk.roleapi").init(
        lr_api_key = '#LR_API_KEY#',
        lr_api_secret = '#LR_API_SECRET#',
        lr_api_signing = '#API_REQUEST_SIGNING#'
      )>

  <cffunction name="getProfileByUid" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="uid" type="string" required="true" hint="uid"/>
    <cftry>
    <cfset result = accountObject.getProfileByUid(arguments.uid)>
      <cfif structkeyexists(result, "Uid")>
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

 <cffunction name="updateAccount" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="token" type="string" required="true" hint="token"/>
    <cfargument name="firstname" type="string" required="false" default="" hint="first name"/>
    <cfargument name="lastname" type="string" required="false" default="" hint="last name"/>
    <cfargument name="about" type="string" required="false" default="" hint="about"/>

    <cfset payload = "{'FirstName': '#arguments.firstname#', 'LastName': '#arguments.lastname#', 'About': '#arguments.about#'}">
    <cftry>
    <cfset result = authObject.updateProfileByToken(arguments.token, payload)>
      <cfif structkeyexists(result, "IsPosted")>
            <cfset stcRetVal["message"] = "Profile has been updated successfully.">
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

 <cffunction name="changePassword" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="token" type="string" required="true" hint="access token"/>
    <cfargument name="oldpassword" type="string" required="false" default="" hint="old password"/>
    <cfargument name="newpassword" type="string" required="false" default="" hint="new password"/>
 
    <cftry>
    <cfset result = authObject.changePassword(arguments.token, arguments.oldpassword, arguments.newpassword)>
      <cfif structkeyexists(result, "IsPosted")>
            <cfset stcRetVal["message"] = "Password has been changed successfully.">
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

 <cffunction name="setPassword" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="uid" type="string" required="true" hint="uid"/>
    <cfargument name="newpassword" type="string" required="true" hint="new password"/>
 
    <cftry>
    <cfset result = accountObject.setPassword(arguments.uid, arguments.newpassword)>
      <cfif structkeyexists(result, "PasswordHash")>
            <cfset stcRetVal["message"] = "Password has been set successfully.">
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

 <cffunction name="createCustomObjects" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="uid" type="string" required="true" hint="uid"/>
    <cfargument name="objectName" type="string" required="true" hint="object name"/>
    <cfargument name="payload" type="any" required="true" hint="data in json format"/>

    <cftry>
    <cfset result = customObject.createCustomObjectByUid(arguments.uid, arguments.objectName, arguments.payload)>
      <cfif structkeyexists(result, "Uid")>
            <cfset stcRetVal["message"] = "Custom object created successfully.">
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

 <cffunction name="getCustomObjects" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="uid" type="string" required="true" hint="uid"/>
    <cfargument name="objectName" type="string" required="true" hint="object name"/>

    <cftry>
    <cfset result = customObject.getCustomObjectByUid(arguments.uid, arguments.objectName)>
      <cfif structkeyexists(result, "Count")>
            <cfset stcRetVal["result"] = result>
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

 <cffunction name="updateCustomObjects" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="uid" type="string" required="true" hint="uid"/>
    <cfargument name="objectName" type="string" required="true" hint="object name"/>
    <cfargument name="objectRecordId" type="string" required="true" hint="object record Id"/>
    <cfargument name="payload" type="any" required="true" hint="data in json format"/>
    <cftry>
    <cfset result = customObject.updateCustomObjectByUid(arguments.uid, arguments.objectRecordId, arguments.objectName, 'replace', arguments.payload)>
      <cfif structkeyexists(result, "Uid")>
            <cfset stcRetVal["message"] = "Custom object has been updated successfully.">
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

 <cffunction name="deleteCustomObjects" access="remote" output="true" returntype="struct" returnformat="json" hint="This API is used to create an account.">
    <cfargument name="uid" type="string" required="true" hint="uid"/>
    <cfargument name="objectName" type="string" required="true" hint="object name"/>
    <cfargument name="objectRecordId" type="string" required="true" hint="object record Id"/>
 
    <cftry>
    <cfset result = customObject.deleteCustomObjectByUid(arguments.uid, arguments.objectRecordId, arguments.objectName)>
      <cfif structkeyexists(result, "IsDeleted")>
            <cfset stcRetVal["message"] = "Custom object has been deleted successfully.">
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

 <cffunction name="handleCreateRole" access="remote" output="true" returntype="struct" returnformat="json" hint="handle create role.">
    <cfargument name="roles" type="string" required="true" hint="roles"/>

    <cftry>
    <cfset result = roleObject.rolesCreate(arguments.roles)>
      <cfif structkeyexists(result, "Count")>
            <cfset stcRetVal["message"] = "Roles has been created.">
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

 <cffunction name="handleDeleteRole" access="remote" output="true" returntype="struct" returnformat="json" hint="handle create role.">
    <cfargument name="roles" type="string" required="true" hint="roles"/>

    <cftry>
    <cfset result = roleObject.deleteRole(arguments.roles)>
      <cfif structkeyexists(result, "IsDeleted")>
            <cfset stcRetVal["message"] = "Roles has been deleted.">
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

 <cffunction name="handleAssignUserRole" access="remote" output="true" returntype="struct" returnformat="json" hint="handle create role.">
    <cfargument name="uid" type="string" required="true" hint="uid"/>
    <cfargument name="roles" type="string" required="true" hint="roles"/>

    <cftry>
    <cfset result = roleObject.assignRolesByUid(arguments.uid, arguments.roles)>
      <cfif structkeyexists(result, "Roles")>
            <cfset stcRetVal["message"] = "Role assigned successfully.">
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

 <cffunction name="getAllRoles" access="remote" output="true" returntype="struct" returnformat="json" hint="handle create role.">
    <cftry>
     <cfset result = roleObject.rolesList()>    
      <cfif structkeyexists(result, "Count")>
            <cfset stcRetVal["result"] = result>
            <cfset stcRetVal["status"] = "success"> 
     <cfelse>
            <cfset stcRetVal["message"] = "Roles is empty">
            <cfset stcRetVal["status"] = "rolesempty"> 
     </cfif>

    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'>   
       <cfset stcRetVal["message"] = message>
       <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>
 
 <cfreturn stcRetVal />
 </cffunction>

 <cffunction name="getUserRoles" access="remote" output="true" returntype="struct" returnformat="json" hint="handle create role.">
    <cfargument name="uid" type="string" required="true" hint="uid"/>
    <cftry>
    <cfset result = roleObject.getRolesByUid(arguments.uid)>
      <cfif structkeyexists(result, "Roles")>
            <cfset stcRetVal["data"] = result>
            <cfset stcRetVal["status"] = "success"> 
     <cfelse>
            <cfset stcRetVal["message"] = "User roles is empty">
            <cfset stcRetVal["status"] = "userrolesempty"> 
     </cfif>

    <cfcatch type = "LoginRadiusException">
    <cfset message ='#cfcatch.detail#'>   
       <cfset stcRetVal["message"] = message>
       <cfset stcRetVal["status"] = "error">  
    </cfcatch>
    </cftry>  

 <cfreturn stcRetVal />
 </cffunction>

 <cffunction name="resetMultifactor" access="remote" output="true" returntype="struct" returnformat="json" hint="handle create role.">
     <cfargument name="uid" type="string" required="true" hint="uid"/>
    <cftry>
    <cfset result = accountObject.mfaResetGoogleAuthenticatorByUid(arguments.uid, true)>
    <cfif structkeyexists(result, "IsDeleted")>
            <cfset stcRetVal["message"] = "Reset successfully.">
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