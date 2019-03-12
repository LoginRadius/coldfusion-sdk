<cfcomponent displayname="customobjectapitest" extends="mxunit.framework.TestCase">
<cfinclude template="testconfig.cfm">

<cfset customObject = createObject("component","lrsdk.customobjectapi").init(
        lr_api_key = LR_TEST_API_KEY,
        lr_api_secret = LR_TEST_API_SECRET,
        lr_api_signing = TEST_API_REQUEST_SIGNING
      )>

<cffunction name="testCreateCustomObjectByUid" hint="This API is used to write information in JSON format to the custom object.">
	<cfset response = customObject.createCustomObjectByUid( ACCOUNT_ID, OBJECT_NAME, CUSTOM_OBJECT_PAYLOAD)>
	<cfif structkeyexists(response, "CustomObject")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testCreateCustomObjectByToken" hint="This API is used to write information in JSON format to the custom object.">
	<cfset response = customObject.createCustomObjectByToken( ACCESS_TOKEN, OBJECT_NAME, CUSTOM_OBJECT_PAYLOAD)>
	<cfif structkeyexists(response, "CustomObject")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testCustomObjectByObjectRecordIdAndUid" hint="This API is used to retrieve the Custom Object data.">
	<cfset response = customObject.customObjectByObjectRecordIdAndUid( ACCOUNT_ID, OBJECT_RECORD_ID, OBJECT_NAME)>
	<cfif structkeyexists(response, "CustomObject")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testCustomObjectByObjectRecordIdAndToken" hint="This API is used to retrieve the Custom Object data.">
	<cfset response = customObject.customObjectByObjectRecordIdAndToken( ACCESS_TOKEN, OBJECT_RECORD_ID, OBJECT_NAME)>
	<cfif structkeyexists(response, "CustomObject")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetCustomObjectByToken" hint="This API is used to retrieve the Custom Object data.">
	<cfset response = customObject.getCustomObjectByToken( ACCESS_TOKEN, OBJECT_NAME)>
	<cfif structkeyexists(response, "data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetCustomObjectByUid" hint="This API is used to retrieve all the custom objects by UID from cloud storage.">
	<cfset response = customObject.getCustomObjectByUid( ACCOUNT_ID, OBJECT_NAME)>
	<cfif structkeyexists(response, "data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testUpdateCustomObjectByUid" hint="This API is used to update the specified custom object data by uid.">
	<cfset response = customObject.updateCustomObjectByUid( ACCOUNT_ID, OBJECT_RECORD_ID, OBJECT_NAME, UPDATE_TYPE, CUSTOM_OBJECT_PAYLOAD)>
	<cfif structkeyexists(response, "CustomObject")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testUpdateCustomObjectByToken" hint="This API is used to update the specified custom object data by token.">
	<cfset response = customObject.updateCustomObjectByToken( ACCESS_TOKEN, OBJECT_RECORD_ID, OBJECT_NAME, UPDATE_TYPE, CUSTOM_OBJECT_PAYLOAD)>
	<cfif structkeyexists(response, "CustomObject")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testDeleteCustomObjectByUid" hint="This API is used to remove the specified Custom Object data using ObjectRecordId.">
	<cfset response = customObject.deleteCustomObjectByUid( ACCOUNT_ID, OBJECT_RECORD_ID, OBJECT_NAME)>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testDeleteCustomObjectByToken" hint="This API is used to remove the specified Custom Object data using token.">
	<cfset response = customObject.deleteCustomObjectByToken( ACCESS_TOKEN, OBJECT_RECORD_ID, OBJECT_NAME)>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

</cfcomponent>