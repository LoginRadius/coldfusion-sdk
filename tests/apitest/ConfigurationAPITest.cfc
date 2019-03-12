<cfcomponent displayname="configurationapitest" extends="mxunit.framework.TestCase">
<cfinclude template="testconfig.cfm">

<cfset configObject = createObject("component","lrsdk.configurationapi").init(
        lr_api_key = LR_TEST_API_KEY,
        lr_api_secret = LR_TEST_API_SECRET
      )>

<cffunction name="testGetConfigurations" hint="This API is used to get the configurations.">
	<cfset response = configObject.getConfigurations()>
	<cfif structkeyexists(response, "SocialSchema")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testGetServerTime" hint="This API allows you to query your LoginRadius account for basic server information and server time information which is useful when generating an SOTT token.">
	<cfset response = configObject.getServerTime( TIME_DIFFERENCE )>
	<cfif structkeyexists(response, "ServerName")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

</cfcomponent>