<cfcomponent displayname="webhookapitest" extends="mxunit.framework.TestCase">
<cfinclude template="testconfig.cfm">

<cfset webHookObject = createObject("component","lrsdk.webhookapi").init(
        lr_api_key = LR_TEST_API_KEY,
        lr_api_secret = LR_TEST_API_SECRET
      )>

<cffunction name="testWebHookSubscribe" hint="This API can be used to configure a WebHook on your LoginRadius site.">
	<cfset response = webHookObject.webHookSubscribe( TARGET_URL, EVENT)>
	<cfif structkeyexists(response, "IsPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testWebHookTest" hint="API can be used to test a subscribed WebHook.">
	<cfset response = webHookObject.webHookTest()>
	<cfif structkeyexists(response, "IsAllowed")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetWebHookSubscribedUrl" hint="This API is used to fatch all the subscribed URLs.">
	<cfset response = webHookObject.getWebHookSubscribedUrl( EVENT )>
	<cfif structkeyexists(response, "Count")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testWebHookUnsubscribe" hint="This API can be used to unsubscribe a WebHook.">
	<cfset response = webHookObject.webHookUnsubscribe( TARGET_URL, EVENT )>
	<cfif structkeyexists(response, "IsDeleted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

</cfcomponent>