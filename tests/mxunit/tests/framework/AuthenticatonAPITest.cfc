<cfcomponent displayname="authenticatonapitest" extends="mxunit.framework.TestCase">

<cfset SdkObject = createObject("component","sdk.authenticationapi").init(
        lr_api_key = '772fa065-0795-411d-b773-399f027a58ed',
        lr_api_secret = 'ec34feef-9ac1-4ecb-ace4-90913aa60bf3',
        lr_api_signing = 'false'
      )>

	<cffunction name="TestSuite" access="public" returntype="TestSuite" hint="Constructor">
		<cfreturn this />
	</cffunction>

 <cffunction name="init" hint="sets up an instance of the component" output="false">

    <cfargument name="lr_api_key" required="true" hint="API key provided by LoginRadius" type="string" />
    <cfargument name="lr_api_secret" required="true" hint="API secret provided by LoginRadius" type="string" />
    <cfargument name="LR_USER_AUTH_API_ENDPOINT" required="false" default="https://api.loginradius.com/identity/v2/auth" hint="LoginRadius user registration endpoint" type="string" />

    <cfset variables.lr_api_key = arguments.lr_api_key />
    <cfset variables.lr_api_secret = arguments.lr_api_secret />
    <cfset variables.LR_USER_AUTH_API_ENDPOINT = arguments.LR_USER_AUTH_API_ENDPOINT />

    <cfreturn this />
 </cffunction>


<cffunction name="testCheckEmailExist" hint="To check email exist or not">

	    <cfset result = SdkObject.checkEmailExist("abc@mailazy.com")>

	 <cfset var expected = 'ok'>
     <cfset var actual = 'heloo' >


 <cfset assert( 1 eq 1,  "Testing a true expression")>


</cffunction>

<cffunction name="testAssert">
    <cfset assert( 1 eq 1,  "Testing a true expression")>
    <cfset assert( not 1 eq 2,  "Testing negated expression")>
</cffunction>



</cfcomponent>