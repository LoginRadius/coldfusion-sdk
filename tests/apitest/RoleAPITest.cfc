<cfcomponent displayname="roleapitest" extends="mxunit.framework.TestCase">
<cfinclude template="testconfig.cfm">

<cfset roleObject = createObject("component","lrsdk.roleapi").init(
        lr_api_key = LR_TEST_API_KEY,
        lr_api_secret = LR_TEST_API_SECRET,
        lr_api_signing = TEST_API_REQUEST_SIGNING
      )>

<cffunction name="testRolesCreate" hint="This API creates a role with permissions.">
	<cfset response = roleObject.rolesCreate( ROLES_CREATE_PAYLOAD )>
	<cfif structkeyexists(response, "data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetContext" hint="This API Gets the contexts that have been configured and the associated roles and permissions.">
	<cfset response = roleObject.getContext( ACCOUNT_ID )>
	<cfif structkeyexists(response, "data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testRolesList" hint="This API retrieves the complete list of created roles with permissions of your app.">
	<cfset response = roleObject.rolesList()>
	<cfif structkeyexists(response, "data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetRolesByUid" hint="This API is used to retrieve all the assigned roles of a particular User.">
	<cfset response = roleObject.getRolesByUid( ACCOUNT_ID )>
	<cfif structkeyexists(response, "Roles")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAddPermissionToRole" hint="This API is used to add permissions to the role.">
	<cfset response = roleObject.addPermissionToRole( ROLE, ADD_PERMISSION_PAYLOAD )>
	<cfif structkeyexists(response, "Permissions")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testAssignRolesByUid" hint="This API is used to assign created roles to the user.">
	<cfset response = roleObject.assignRolesByUid( ACCOUNT_ID, ROLES_PAYLOAD )>
	<cfif structkeyexists(response, "Roles")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testUpsertContext" hint="This API creates a Context with a set of Roles.">
	<cfset response = roleObject.upsertContext( ACCOUNT_ID, ROLES_PAYLOAD )>
	<cfif structkeyexists(response, "Roles")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testDeleteRole" hint="This API is used to delete the role.">
	<cfset response = roleObject.deleteRole( ROLE )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testUnassignRolesByUid" hint="This API is used to unassign roles to the user.">
	<cfset response = roleObject.unassignRolesByUid( ACCOUNT_ID, ROLES_PAYLOAD )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testRemovePermission" hint="This API is used to remove permissions to the role.">
	<cfset response = roleObject.removePermission( ROLE_NAME, ROLES_PAYLOAD )>
	<cfif structkeyexists(response, "Permissions")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testDeleteContext" hint="This API Deletes the specified Role Context.">
	<cfset response = roleObject.deleteContext( ACCOUNT_ID, ROLE_CONTEXT_NAME )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testDeleteRoleFromContext" hint="This API Deletes the specified Role from a Context.">
	<cfset response = roleObject.deleteRoleFromContext( ACCOUNT_ID, ROLE_CONTEXT_NAME, ROLES_PAYLOAD )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testDeletePermissionFromContext" hint="This API Deletes Additional Permissions from Context.">
	<cfset response = roleObject.deletePermissionFromContext( ACCOUNT_ID, ROLE_CONTEXT_NAME, ROLES_PAYLOAD )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

</cfcomponent>