<cfcomponent displayname="socialloginapi" hint="This is the CFC for Social Login APIs">
	<cfinclude template="init.cfm">
	<!---
	
	    Initialise in to your application using:
	
	    <cfset SdkObject = createObject("component","lrsdk.socialloginapi").init(
	        lr_api_key = "Your API Key",
	        lr_api_secret = "Your Secret Key"
	      )>
	
	   --->
	
	<cffunction name="init" hint="sets up an instance of the component" output="false">
	
		<cfargument name="lr_api_key" required="true" hint="API key provided by LoginRadius" type="string"/>
		<cfargument name="lr_api_secret" required="true" hint="API secret provided by LoginRadius" 
		            type="string"/>
		<cfargument name="LR_API_ENDPOINT" required="false" default="https://api.loginradius.com/api/v2" 
		            hint="LoginRadius endpoint" type="string"/>
		<cfargument name="LR_SHORTEN_API_ENDPOINT" required="false" 
		            default="https://api.loginradius.com/sharing/v1" 
		            hint="LoginRadius shorten api endpoint" type="string"/>
	
		<cfset variables.lr_api_key = arguments.lr_api_key/>
		<cfset variables.lr_api_secret = arguments.lr_api_secret/>
		<cfset variables.LR_API_ENDPOINT = arguments.LR_API_ENDPOINT/>
		<cfset variables.LR_SHORTEN_API_ENDPOINT = arguments.LR_SHORTEN_API_ENDPOINT/>
	
		<cfreturn this/>
	</cffunction>
	
	<cffunction name="loginradiusExchangeAccessToken" 
	            hint="Fetch LoginRadius access token after authentication. It will be valid for the specific duration of time specified in the response">
	
		<cfargument name="token" type="string" required="false" default="#form.token#"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/access_token">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="token" value="#arguments.token#" type="URL">
			<cfhttpparam name="secret" value="#variables.lr_api_secret#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusTokenValidate" 
	            hint="This API is used to validate access_token, check it is valid, expired or active.">
	
		<cfargument name="accessToken" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/access_token/Validate">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="key" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="secret" value="#variables.lr_api_secret#" type="URL">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusTokenInvalidate" 
	            hint="Used to invalidate access token, means expiring token. After this API call passed access_token no longer be active and will not accepted by LoginRadius APIs.">
	
		<cfargument name="accessToken" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/access_token/invalidate">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="key" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="secret" value="#variables.lr_api_secret#" type="URL">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetUserProfiledata" 
	            hint="To fetch social profile data from the user's social account after authentication. The social profile will be retrieved via oAuth and OpenID protocols. The data is normalized into LoginRadius' standard data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/userprofile/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/userprofile">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusTrackableStatusPosting" 
	            hint="The Trackable Status API is used to update the status on the user�s wall and return an Post ID value.">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="status" type="string" required="true"/>
		<cfargument name="title" type="string" required="true"/>
		<cfargument name="url" type="string" required="true"/>
		<cfargument name="imageurl" type="string" required="true"/>
		<cfargument name="caption" type="string" required="true"/>
		<cfargument name="description" type="string" required="true"/>
	
		<cfset payload = "{ 'status': '#arguments.status#', 'title': '#arguments.title#', 'url': '#arguments.url#', 'imageurl': '#arguments.imageurl#', 'caption': '#arguments.caption#', 'description': '#arguments.description#' }"/>
	
		<cfhttp method="POST" url="#variables.LR_API_ENDPOINT#/status/trackable">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam value="#payload#" type="body">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusSendMessagePost" 
	            hint="The Message API is used to post messages to the user�s contacts. After using the Contact API, you can send messages to the retrieved contacts">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="to" type="string" required="true"/>
		<cfargument name="subject" type="string" required="false" default=""/>
		<cfargument name="message" type="string" required="false" default=""/>
	
		<cfhttp method="POST" url="#variables.LR_API_ENDPOINT#/message">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="to" value="#arguments.to#" type="URL">
			<cfhttpparam name="subject" value="#arguments.subject#" type="URL">
			<cfhttpparam name="message" value="#arguments.message#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetTrackableStatusStats" 
	            hint="The Trackable Status API is used to update the status on the user�s wall and return an Post ID value.">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="status" type="string" required="true"/>
		<cfargument name="title" type="string" required="true"/>
		<cfargument name="url" type="string" required="true"/>
		<cfargument name="imageurl" type="string" required="true"/>
		<cfargument name="caption" type="string" required="true"/>
		<cfargument name="description" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/status/trackable/js">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="status" value="#arguments.status#" type="URL">
			<cfhttpparam name="title" value="#arguments.title#" type="URL">
			<cfhttpparam name="url" value="#arguments.url#" type="URL">
			<cfhttpparam name="imageurl" value="#arguments.imageurl#" type="URL">
			<cfhttpparam name="caption" value="#arguments.caption#" type="URL">
			<cfhttpparam name="description" value="#arguments.description#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusTrackableStatusFetching" 
	            hint="This API is used to retrieve a tracked post based on the passed in post ID value.">
	
		<cfargument name="postid" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/status/trackable">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="secret" value="#variables.lr_api_secret#" type="URL">
			<cfhttpparam name="postid" value="#arguments.postid#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusShortenUrl" 
	            hint="The Shorten URL API is used to convert your URLs to the LoginRadius short URL - ish.re.">
	
		<cfargument name="url" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_SHORTEN_API_ENDPOINT#/shorturl">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="key" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="url" value="#arguments.url#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetActiveSessionDetail" 
	            hint="API retrieves Active Session Details by Access Token.">
	
		<cfargument name="accessToken" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/access_token/activeSession">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="key" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="secret" value="#variables.lr_api_secret#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetPhotoAlbums" 
	            hint="To get the Albums data from the user's social account.">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/album/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/album">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetAudio" 
	            hint="To fetch user's audio files data from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/audio/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/audio">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetCheckins" 
	            hint="To fetch check-ins data from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/checkin/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/checkin">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetFollowedCompanies" 
	            hint="To get the followed company's data in the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/company/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/company">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetContacts" 
	            hint="To fetch user's contacts/friends/connections data from the user's social account. The data will normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="nextCursor" type="string" required="false" default=""/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/contact/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/contact">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="nextcursor" value="#arguments.nextCursor#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetEvents" 
	            hint="To get the event data from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/event/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/event">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetFollowing" 
	            hint="To get mention data from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/following/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/following">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetGroups" 
	            hint="To get group data from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/group/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/group">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetLikes" 
	            hint="To get likes data from the user's social account. The data will be normalized into LoginRadius' data format ">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/like/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/like">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetMentions" 
	            hint="To get mention data from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/mention/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/mention">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetPages" 
	            hint="To get the page data from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="pageName" type="string" required="false"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/page/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/page">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="pagename" value="#arguments.pageName#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetPhotos" 
	            hint="To fetch photo data from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="albumId" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/photo/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/photo">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="albumid" value="#arguments.albumId#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetPosts" 
	            hint="To get posted messages from the user's social account. The data will be normalized into LoginRadius' data format ">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/post/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/post">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusStatusFetching" 
	            hint=" To get the status messages from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/status/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/status">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusStatusPosting" hint="To update the status on the user's wall">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="title" type="string" required="true"/>
		<cfargument name="url" type="string" required="false" default=""/>
		<cfargument name="imageurl" type="string" required="false" default=""/>
		<cfargument name="status" type="string" required="true"/>
		<cfargument name="caption" type="string" required="false" default=""/>
		<cfargument name="description" type="string" required="false" default=""/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/status/js">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="title" value="#arguments.title#" type="URL">
			<cfhttpparam name="url" value="#arguments.url#" type="URL">
			<cfhttpparam name="imageurl" value="#arguments.imageurl#" type="URL">
			<cfhttpparam name="status" value="#arguments.status#" type="URL">
			<cfhttpparam name="caption" value="#arguments.caption#" type="URL">
			<cfhttpparam name="description" value="#arguments.description#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusGetVideo" 
	            hint="To get videos data from the user's social account. The data will be normalized into LoginRadius' data format">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="raw" type="string" required="false" default="false"/>
	
		<cfif #arguments.raw# eq "true">
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/video/raw">
		<cfelse>
			<cfset apiurl = "#variables.LR_API_ENDPOINT#/video">
		</cfif>
		<cfhttp url="#apiurl#">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusPostingStatusPost" hint="To update the status on the user's wall">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="title" type="string" required="true"/>
		<cfargument name="url" type="string" required="false" default=""/>
		<cfargument name="imageurl" type="string" required="false" default=""/>
		<cfargument name="status" type="string" required="true"/>
		<cfargument name="caption" type="string" required="false" default=""/>
		<cfargument name="description" type="string" required="false" default=""/>
	
		<cfhttp method="POST" url="#variables.LR_API_ENDPOINT#/status">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="title" value="#arguments.title#" type="URL">
			<cfhttpparam name="url" value="#arguments.url#" type="URL">
			<cfhttpparam name="imageurl" value="#arguments.imageurl#" type="URL">
			<cfhttpparam name="status" value="#arguments.status#" type="URL">
			<cfhttpparam name="caption" value="#arguments.caption#" type="URL">
			<cfhttpparam name="description" value="#arguments.description#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="loginradiusSendMessage" 
	            hint="Post messages to the user's contacts. After using the Contact API, you can send messages to the retrieved contacts">
	
		<cfargument name="accessToken" type="string" required="true"/>
		<cfargument name="to" type="string" required="true"/>
		<cfargument name="subject" type="string" required="false" default=""/>
		<cfargument name="message" type="string" required="false" default=""/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/message">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="to" value="#arguments.to#" type="URL">
			<cfhttpparam name="subject" value="#arguments.subject#" type="URL">
			<cfhttpparam name="message" value="#arguments.message#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="getAccessTokenByPassingFacebookToken" 
	            hint="The API is used to get LoginRadius access token by sending Facebook's access token.">
		<cfargument name="fbaccesstoken" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/access_token/facebook">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="key" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="fb_access_token" value="#arguments.fbaccesstoken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="getAccessTokenByPassingTwitterToken" 
	            hint="The API is used to get LoginRadius access token by sending  Twitter's access token.">
		<cfargument name="twitteraccesstoken" type="string" required="true"/>
		<cfargument name="twittertokensecret" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/access_token/twitter">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="key" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="tw_access_token" value="#arguments.twitteraccesstoken#" type="URL">
			<cfhttpparam name="tw_token_secret" value="#arguments.twittertokensecret#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="getAccessTokenByPassingVkontakteToken" 
	            hint="The API is used to get LoginRadius access token by sending Vkontakte's access token.">
		<cfargument name="vkaccesstoken" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/access_token/vkontakte">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="key" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="vk_access_token" value="#arguments.vkaccesstoken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="getAccessTokenByPassingGoogleJWT" 
	            hint="This API is used to get a LoginRadius access_token by passing in the Google JWT id_token to be used for the Google login/registration.">
		<cfargument name="jwtToken" type="string" required="true"/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/access_token/googlejwt">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="key" value="#variables.lr_api_key#" type="URL">
			<cfhttpparam name="id_token" value="#arguments.jwtToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="refreshUserProfile" 
	            hint="The User Profile API is used to get the latest updated social profile data from the user's social account after authentication.">
	
		<cfargument name="accessToken" type="string" required="true" default=""/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/userprofile/refresh">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
	<cffunction name="refreshToken" 
	            hint="The Refresh Access Token API is used to refresh the LoginRadius Access Token or the Provider Access Token, after authentication.">
	
		<cfargument name="accessToken" type="string" required="true" default=""/>
		<cfargument name="expiresIn" type="string" required="false" default=""/>
	
		<cfhttp url="#variables.LR_API_ENDPOINT#/access_token/refresh">
			<cfhttpparam type="header" name="Accept-Encoding" value="*"/>
			<cfhttpparam type="Header" name="TE" value="deflate;q=0">
			<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
			<cfhttpparam name="secret" value="#variables.lr_api_secret#" type="URL">
			<cfhttpparam name="expiresIn" value="#arguments.expiresIn#" type="URL">
		</cfhttp>
	
		<cfreturn loginradiusGetResponse(cfhttp)>
	</cffunction>
	
</cfcomponent>