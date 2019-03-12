<cfcomponent displayname="socialloginapitest" extends="mxunit.framework.TestCase">
<cfinclude template="testconfig.cfm">

<cfset socialLoginObject = createObject("component","lrsdk.socialloginapi").init(
        lr_api_key = LR_TEST_API_KEY,
        lr_api_secret = LR_TEST_API_SECRET,
        lr_api_signing = TEST_API_REQUEST_SIGNING
      )>

<cffunction name="testLoginradiusExchangeAccessToken" hint="To translate the Request Token returned during authentication into an Access Token that can be used with other API calls.">
	<cfset response = socialLoginObject.loginradiusExchangeAccessToken( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "access_token")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusTokenValidate" hint="This API validates access_token.">
	<cfset response = socialLoginObject.loginradiusTokenValidate( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "access_token")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusTokenInvalidate" hint="This api invalidates the active access token.">
	<cfset response = socialLoginObject.loginradiusTokenInvalidate( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "isPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetUserProfiledata" hint="To get social profile data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetUserProfiledata( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Uid")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusTrackableStatusPosting" hint="The Trackable Status API is used to update the status on the user’s wall and return an Post ID value.">
	<cfset response = socialLoginObject.loginradiusTrackableStatusPosting( ACCESS_TOKEN, STATUS, TITLE, URLOFSTATUS, IMAGEURL, CAPTION, DESCRIPTION )>
	<cfif structkeyexists(response, "Url")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusSendMessagePost" hint="Post Message API is used to post messages to the user’s contacts.">
	<cfset response = socialLoginObject.loginradiusSendMessagePost( ACCESS_TOKEN, TO, SUBJECT, MESSAGE )>
	<cfif structkeyexists(response, "isPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetTrackableStatusStats" hint="The Trackable Status API is used to update the status on the user’s wall and return an Post ID value.">
	<cfset response = socialLoginObject.loginradiusGetTrackableStatusStats( ACCESS_TOKEN, STATUS, TITLE, URLOFSTATUS, IMAGEURL, CAPTION, DESCRIPTION )>
	<cfif structkeyexists(response, "Url")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusTrackableStatusFetching" hint="Post Message API is used to post messages to the user’s contacts.">
	<cfset response = socialLoginObject.loginradiusTrackableStatusFetching( POSTID )>
	<cfif structkeyexists(response, "Shares")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusShortenUrl" hint="The Shorten URL API is used to convert your URLs to the LoginRadius short URL - ish.re.">
	<cfset response = socialLoginObject.loginradiusShortenUrl( URLTOSHORT )>
	<cfif structkeyexists(response, "ShortUrl")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetActiveSessionDetail" hint="This api is used to get all active sessions by Access Token.">
	<cfset response = socialLoginObject.loginradiusGetActiveSessionDetail( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetPhotoAlbums" hint="To get the Albums data from the user's social account.">
	<cfset response = socialLoginObject.loginradiusGetPhotoAlbums( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Title")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetAudio" hint="The Audio API is used to get audio files data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetAudio( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Title")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetCheckins" hint="The CheckIn API is used to get check Ins data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetCheckins( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Message")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetFollowedCompanies" hint="The Company API is used to get the followed companies data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetFollowedCompanies( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Name")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetContacts" hint="The Contact API is used to get contacts/friends/connections data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetContacts( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Name")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetEvents" hint="The Event API is used to get the event data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetEvents( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "OwnerId")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetFollowing" hint="Get the following user list from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetFollowing( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "EmailID")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetGroups" hint="The Group API is used to get group data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetGroups( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Email")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetLikes" hint="The Like API is used to get likes data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetLikes( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Category")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetMentions" hint="The Mention API is used to get mentions data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetMentions( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Text")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetPages" hint="The Page API is used to get page data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetPages( ACCESS_TOKEN, PAGENAME )>
	<cfif structkeyexists(response, "ID")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetPhotos" hint="The Photo API is used to get photo data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetPhotos( ACCESS_TOKEN, ALBUMID )>
	<cfif structkeyexists(response, "ID")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetPosts" hint="The Post API is used to get post message data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetPosts( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "ID")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusStatusFetching" hint="The Status API is used to get the status messages from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusStatusFetching( ACCESS_TOKEN )>
	<cfif structkeyexists(response, "Id")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusStatusPosting" hint="The Status API is used to update the status on the user’s wall.">
	<cfset response = socialLoginObject.loginradiusStatusPosting( ACCESS_TOKEN, TITLE, URLTOCLICK, IMAGEURL, STATUS, CAPTION, DESCRIPTION )>
	<cfif structkeyexists(response, "isPosted")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

<cffunction name="testLoginradiusGetVideo" hint="The Video API is used to get video files data from the user’s social account.">
	<cfset response = socialLoginObject.loginradiusGetVideo( ACCESS_TOKEN, NEXTCURSOR )>
	<cfif structkeyexists(response, "Data")>
	 	<cfset assert( 1 eq 1,  "Testing a true expression")>
	<cfelse>
 		<cfset assertEquals( "true",  response)>
	</cfif>
</cffunction>

</cfcomponent>