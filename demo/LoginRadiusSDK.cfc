<cfcomponent displayname="loginradiussdk" hint="This is the CFC for Social Login APIS">  
<!--- PRIVATE VARIABLES --->
<cfset variables.LR_API_ENDPOINT = 'https://api.loginradius.com/api/v2'>

<cffunction name="loginradiusExchangeAccessToken" hint=" Fetch LoginRadius access token after authentication. It will be valid for the specific duration of time specified in the response">
<cfargument name="secret_key" type="string" required="true" />

<cfhttp url="#variables.LR_API_ENDPOINT#/access_token">
<cfhttpparam name="token" value="#form.token#" type="URL">
<cfhttpparam name="secret" value="#secret_key#" type="URL">
</cfhttp>

<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>  

<cffunction name="loginradiusGetUserProfiledata" hint="To fetch social profile data from the user's social account after authentication. The social profile will be retrieved via oAuth and OpenID protocols. The data is normalized into LoginRadius' standard data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/userprofile">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction> 


<cffunction name="loginradiusGetPhotoAlbums" hint="To get the Albums data from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/album">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction> 

<cffunction name="loginradiusGetPhotos" hint="To fetch photo data from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfargument name="albumId" type="int" required="false" />
<cfhttp url="#variables.LR_API_ENDPOINT#/photo">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
<cfhttpparam name="albumid" value="#arguments.albumId#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction> 

<cffunction name="loginradiusGetCheckins" hint="To fetch check-ins data from the user's social account. The data will be normalized into LoginRadius' data format">   
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/checkin">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction> 


<cffunction name="loginradiusGetAudio" hint="To fetch user's audio files data from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/audio">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction> 


<cffunction name="loginradiusGetContacts" hint="To fetch user's contacts/friends/connections data from the user's social account. The data will normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfargument name="nextCursor" type="string" required="false" default=""/>
<cfhttp url="#variables.LR_API_ENDPOINT#/contact">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
<cfhttpparam name="nextcursor" value="#arguments.nextCursor#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction> 


<cffunction name="loginradiusGetMentions" hint="To get mention data from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/mention">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction> 


<cffunction name="loginradiusGetFollowing" hint="To get mention data from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/following">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>

<cffunction name="loginradiusGetEvents" hint="To get the event data from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/event">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>  

<cffunction name="loginradiusGetPosts" hint="To get posted messages from the user's social account. The data will be normalized into LoginRadius' data format ">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/post">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>


<cffunction name="loginradiusGetFollowedCompanies" hint="To get the followed company's data in the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/company">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>


<cffunction name="loginradiusGetGroups" hint="To get group data from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/group">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>


<cffunction name="loginradiusGetStatus" hint=" To get the status messages from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/status">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>


<cffunction name="loginradiusGetVideo" hint="To get videos data from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/video">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>


<cffunction name="loginradiusGetLikes" hint="To get likes data from the user's social account. The data will be normalized into LoginRadius' data format ">  
<cfargument name="accessToken" type="string" required="true" />
<cfhttp url="#variables.LR_API_ENDPOINT#/like">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>

 
<cffunction name="loginradiusGetPages" hint="To get the page data from the user's social account. The data will be normalized into LoginRadius' data format">  
<cfargument name="accessToken" type="string" required="true" />
<cfargument name="pageName" type="string" required="false" />
<cfhttp url="#variables.LR_API_ENDPOINT#/page">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
<cfhttpparam name="pagename" value="#arguments.pageName#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>


<cffunction name="loginradiusPostStatus" hint="To update the status on the user's wall">  
<cfargument name="accessToken" type="string" required="true" />
<cfargument name="title" type="string" required="true" />
<cfargument name="url" type="string" required="false" default=""/>
<cfargument name="imageurl" type="string" required="false" default="" />
<cfargument name="status" type="string" required="true" />
<cfargument name="caption" type="string" required="false" default="" />
<cfargument name="description" type="string" required="false" default="" />
<cfhttp method="Post"  url="#variables.LR_API_ENDPOINT#/status">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
<cfhttpparam name="title" value="#arguments.title#" type="URL">
<cfhttpparam name="url" value="#arguments.url#" type="URL">
<cfhttpparam name="imageurl" value="#arguments.imageurl#" type="URL">
<cfhttpparam name="status" value="#arguments.status#" type="URL">
<cfhttpparam name="caption" value="#arguments.caption#" type="URL">
<cfhttpparam name="description" value="#arguments.description#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>


<cffunction name="loginradiusSendMessage" hint="Post messages to the user's contacts. After using the Contact API, you can send messages to the retrieved contacts">  
<cfargument name="accessToken" type="string" required="true" />
<cfargument name="to" type="string" required="true" />
<cfargument name="subject" type="string" required="false" default=""/>
<cfargument name="message" type="string" required="false" default="" />
<cfhttp method="Post"  url="#variables.LR_API_ENDPOINT#/message">
<cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
<cfhttpparam name="to" value="#arguments.to#" type="URL">
<cfhttpparam name="subject" value="#arguments.subject#" type="URL">
<cfhttpparam name="message" value="#arguments.message#" type="URL">
</cfhttp>
<cfreturn loginradiusGetReponse(cfhttp)>
</cffunction>

<cffunction name="loginradiusGetReponse" hint="I read json response of APIs">  
<cfargument name="cfhttp"  required="true" />
<cfset response =  Deserializejson(arguments.cfhttp.filecontent)>

<!--- check errorcode exist in response --->
<cfif IsStruct(response) && structkeyexists(response, "errorCode")>

<!--- throw exception --->
<cfthrow  
    message = "#response.message#"
    type = "LoginRadiusException"   
    detail = "#response.description#"
    errorCode = "#response.errorCode#"
> 
</cfif>
<cfreturn response>
</cffunction>
</cfcomponent>