<cfcomponent displayname="loginradiussdk" hint="This is the CFC for Customer Identity Management APIS">

<!--- 

    Initialise in to your application using: 

    <cfset SdkObject = createObject("component","sdk.loginradiussdk").init(
        raas_api_key = "APIKEY",
        raas_api_secret = "APISECRET"
      )>

   --->

  <cffunction name="init" hint="sets up an instance of the component" output="false">

    <cfargument name="raas_api_key" required="true" hint="API key provided by LoginRadius" type="string" />
    <cfargument name="raas_api_secret" required="true" hint="API secret provided by LoginRadius" type="string" />

    <cfargument name="LR_API_ENDPOINT" required="false" default="https://api.loginradius.com/api/v2" hint="LoginRadius endpoint" type="string" />
    <cfargument name="LR_USER_REG_API_ENDPOINT" required="false" default="https://api.loginradius.com" hint="LoginRadius user registration endpoint" type="string" />

    <cfset variables.raas_api_key = arguments.raas_api_key />
    <cfset variables.raas_api_secret = arguments.raas_api_secret />

    <cfset variables.LR_API_ENDPOINT = arguments.LR_API_ENDPOINT />
    <cfset variables.LR_USER_REG_API_ENDPOINT = arguments.LR_USER_REG_API_ENDPOINT />

    <cfreturn this />
  </cffunction>

  <cffunction name="loginradiusExchangeAccessToken" hint=" Fetch LoginRadius access token after authentication. It will be valid for the specific duration of time specified in the response">
    
    <cfargument name="token" type="string" required="false" default="#form.token#" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/access_token">
      <cfhttpparam name="token" value="#arguments.token#" type="URL">
      <cfhttpparam name="secret" value="#variables.raas_api_secret#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusGetUserProfiledata" hint="To fetch social profile data from the user's social account after authentication. The social profile will be retrieved via oAuth and OpenID protocols. The data is normalized into LoginRadius' standard data format">  
    
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/userprofile">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusGetPhotoAlbums" hint="To get the Albums data from the user's social account. The data will be normalized into LoginRadius' data format">  
   
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/album">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusGetPhotos" hint="To fetch photo data from the user's social account. The data will be normalized into LoginRadius' data format">  
    
    <cfargument name="accessToken" type="string" required="true" />
    <cfargument name="albumId" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/photo">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
      <cfhttpparam name="albumid" value="#arguments.albumId#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusGetCheckins" hint="To fetch check-ins data from the user's social account. The data will be normalized into LoginRadius' data format">   
    
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/checkin">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 


  <cffunction name="loginradiusGetAudio" hint="To fetch user's audio files data from the user's social account. The data will be normalized into LoginRadius' data format">  

    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/audio">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 


  <cffunction name="loginradiusGetContacts" hint="To fetch user's contacts/friends/connections data from the user's social account. The data will normalized into LoginRadius' data format">  

    <cfargument name="accessToken" type="string" required="true" />
    <cfargument name="nextCursor" type="string" required="false" default=""/>

    <cfhttp url="#variables.LR_API_ENDPOINT#/contact">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
      <cfhttpparam name="nextcursor" value="#arguments.nextCursor#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 


  <cffunction name="loginradiusGetMentions" hint="To get mention data from the user's social account. The data will be normalized into LoginRadius' data format">  
    
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/mention">
     <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 


  <cffunction name="loginradiusGetFollowing" hint="To get mention data from the user's social account. The data will be normalized into LoginRadius' data format">  
    
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/following">
     <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusGetEvents" hint="To get the event data from the user's social account. The data will be normalized into LoginRadius' data format">  
    
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/event">
    <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>  

  <cffunction name="loginradiusGetPosts" hint="To get posted messages from the user's social account. The data will be normalized into LoginRadius' data format ">  
    
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/post">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>


  <cffunction name="loginradiusGetFollowedCompanies" hint="To get the followed company's data in the user's social account. The data will be normalized into LoginRadius' data format">  
    
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/company">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>


  <cffunction name="loginradiusGetGroups" hint="To get group data from the user's social account. The data will be normalized into LoginRadius' data format">  
    
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/group">
     <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>


  <cffunction name="loginradiusGetStatus" hint=" To get the status messages from the user's social account. The data will be normalized into LoginRadius' data format">  
   
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/status">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>


  <cffunction name="loginradiusGetVideo" hint="To get videos data from the user's social account. The data will be normalized into LoginRadius' data format">  
   
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/video">
     <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>


  <cffunction name="loginradiusGetLikes" hint="To get likes data from the user's social account. The data will be normalized into LoginRadius' data format ">  
    
    <cfargument name="accessToken" type="string" required="true" />

    <cfhttp url="#variables.LR_API_ENDPOINT#/like">
    <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

   
  <cffunction name="loginradiusGetPages" hint="To get the page data from the user's social account. The data will be normalized into LoginRadius' data format">  

  <cfargument name="accessToken" type="string" required="true" />
  <cfargument name="pageName" type="string" required="false" />

  <cfhttp url="#variables.LR_API_ENDPOINT#/page">
    <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
    <cfhttpparam name="pagename" value="#arguments.pageName#" type="URL">
  </cfhttp>

  <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>


  <cffunction name="loginradiusPostStatus" hint="To update the status on the user's wall">  

    <cfargument name="accessToken" type="string" required="true" />
    <cfargument name="title" type="string" required="true" />
    <cfargument name="url" type="string" required="false" default=""/>
    <cfargument name="imageurl" type="string" required="false" default="" />
    <cfargument name="status" type="string" required="true" />
    <cfargument name="caption" type="string" required="false" default="" />
    <cfargument name="description" type="string" required="false" default="" />

    <cfhttp method="POST"  url="#variables.LR_API_ENDPOINT#/status">
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


  <cffunction name="loginradiusSendMessage" hint="Post messages to the user's contacts. After using the Contact API, you can send messages to the retrieved contacts">  
    
    <cfargument name="accessToken" type="string" required="true" />
    <cfargument name="to" type="string" required="true" />
    <cfargument name="subject" type="string" required="false" default=""/>
    <cfargument name="message" type="string" required="false" default="" />

    <cfhttp method="POST"  url="#variables.LR_API_ENDPOINT#/message">
      <cfhttpparam name="access_token" value="#arguments.accessToken#" type="URL">
      <cfhttpparam name="to" value="#arguments.to#" type="URL">
      <cfhttpparam name="subject" value="#arguments.subject#" type="URL">
      <cfhttpparam name="message" value="#arguments.message#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusAuthenticateUser"
  hint="Authenticate users and returns the profile data associated with the authenticated user.">

    <!--- Define arguments. --->
    <cfargument name="username" type="string" required="true" hint="username of user"/>
    <cfargument name="password" type="string" required="true" hint="password of user" />

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="username" value="#arguments.username#" type="URL">
      <cfhttpparam name="password" value="#arguments.password#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusAddRemoveEmail"
  hint="Add or remove a particular email from one user's account.">

    <!--- Define arguments. --->
    <cfargument name="accountid" type="string" required="true" />
    <cfargument name="action" type="string" required="true" hint="add or remove"/>
    <cfargument name="emailid" type="string" required="true" hint="Email Address to action"/>
    <cfargument name="emailtype" type="string" required="false" default="Personal" hint="Email Type like 'Business' or Personal"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/email">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.accountid#" type="URL">
      <cfhttpparam name="action" value="#arguments.action#" type="URL">
      <cfhttpparam name="emailid" value="#arguments.emailid#" type="formfield">
      <cfhttpparam name="emailtype" value="#arguments.emailtype#" type="formfield">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusSetUsername"
  hint="This API is used for set user name by user Id.">

    <!--- Define arguments. --->
    <cfargument name="accountid" type="string" required="true" />
    <cfargument name="newusername" type="string" required="true" hint="New username"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/setusername">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.accountid#" type="URL">
      <cfhttpparam name="newusername" value="#arguments.newusername#" type="formfield">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusSetStatus"
  hint="Block or un-block a user account using the users unique UserID (UID).">

    <!--- Define arguments. --->
    <cfargument name="uid" type="string" required="true" hint="unique UserID (UID)" />
    <cfargument name="isblock" type="boolean" required="false" default=true hint="pass false to unblock the user." />

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/status">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.uid#" type="URL">
      <cfhttpparam name="isblock" value="#arguments.isblock#" type="FormField">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <!--- Example of  params (valid json)

  params =  â€œ{'emailid' : 'example@domain.com', 'password' : 'xxxxxxxxxxx', 'firstname' : 'firstname', 'lastname' : 'last name',  'gender' :'m', 'birthdate' : 'MM-DD-YYYY',
   ....................
   ....................}â€?
  --->  
  <cffunction name="loginradiusCreateUser" 
  hint="Create a new user on your site. This API bypasses the normal email verification process and manually creates the user for your system.">

    <!--- Define arguments. --->
    <cfargument name="params" type="any" required="true" hint ="data in json format"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam value="#arguments.params#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>


  <!--- Example of params (valid json)

 params = â€œ { 'accountid' : 'xxxxxxxxx', 'password' : 'xxxxxxxxxxx', 'emailid' :'example@domain.com'}â€?
  ---> 
  <cffunction name="loginradiusCreateRegistrationProfile"
  hint="Create Raas profile">

    <!--- Define arguments. --->
    <cfargument name="params" type="any" required="true" hint="data should be in json format"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/profile">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam value="#arguments.params#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 


  <cffunction name="loginradiusDeleteAccountWithEmailConfirmation"
  hint="This API deletes the User account with email confirmation and allows them to re-register for a new account.">

    <!--- Define arguments. --->
    <cfargument name="uid" type="string" required="true" hint="unique UserID (UID)" />
    <cfargument name="deleteuserlink" type="string" required="true" hint="Link that handles the delete logic" />
    <cfargument name="template" type="string" required="false" default="" hint="Name of the email template to be send for the delete confirmation" />

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/deleteuseremail">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.uid#" type="URL">
      <cfhttpparam name="deleteuserlink" value="#arguments.deleteuserlink#" type="URL">
      <cfhttpparam name="template" value="#arguments.template#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusDeleteAccount"
  hint="Delete user using the users unique account id (UID).">

    <!--- Define arguments. --->
    <cfargument name="uid" type="string" required="true" hint="unique UserID (UID)" />

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/delete">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.uid#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusResendVerificationEmail"
  hint="This API is used to generate an email-token that can be sent out to a user in a link in order to verify their email.">

    <!--- Define arguments. --->
    <cfargument name="emailid" type="string" required="true" hint="User's email address" />
    <cfargument name="link" type="string" required="true" hint="Verification Url link address" />
    <cfargument name="template" type="string" required="false" default="" hint="Verification Email Template" />

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/verificationemail">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="emailid" value="#arguments.emailid#" type="URL">
      <cfhttpparam name="link" value="#arguments.link#" type="URL">
      <cfhttpparam name="template" value="#arguments.template#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusTokenInvalidate" hint="Used to invalidate access token, means expiring token. After this API call passed access_token no longer be active and will not accepted by LoginRadius APIs." >
   
    <cfargument name="access_token" type="string" required="true" />
    
    <cfhttp url="#variables.LR_API_ENDPOINT#/access_token/invalidate">
      <cfhttpparam name="access_token" value="#arguments.access_token#" type="URL">
      <cfhttpparam name="key" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="secret" value="#variables.raas_api_secret#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusTokenValidate" hint="This API is used to validate access_token, check it is valid, expired or active.">
    
    <cfargument name="access_token" type="string" required="true" />
    
    <cfhttp url="#variables.LR_API_ENDPOINT#/access_token/Validate">
      <cfhttpparam name="access_token" value="#arguments.access_token#" type="URL">
      <cfhttpparam name="key" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="secret" value="#variables.raas_api_secret#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusGetActiveSessionDetail" hint="API retrieves Active Session Details by Access Token.">
    
    <cfargument name="access_token" type="string" required="true" />
    
    <cfhttp url="#variables.LR_API_ENDPOINT#/access_token/activeSession">
      <cfhttpparam name="token" value="#arguments.access_token#" type="URL">
      <cfhttpparam name="key" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="secret" value="#variables.raas_api_secret#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusGetHashedPassword"
  hint="Retrieve the password(hashed) from the user profile based on account ID">

    <!--- Define arguments. --->
    <cfargument name="id" type="string" required="true" hint="Raas Account ID"/>

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/password">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.id#" type="URL">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <!--- Example of params (valid json) 

  params =  "{'oldpassword' :'xxxxxxxxx','newpassword' : 'xxxxxxxxxxx'}"
    ---> "
  <cffunction name="loginradiusChangePassword"
  hint="Update/Change the password of account.">

    <!--- Define arguments. --->
    <cfargument name="uid" type="string" required="true" hint="unique accountid (UID)"/>
    <cfargument name="params" type="any" required="true" hint="data should be in json format"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/password">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.uid#" type="URL">
      <cfhttpparam  value="#arguments.params#" type="body">
    </cfhttp>

    <!--- Get Response --->
    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <!--- Example of params (valid json)
  params =  "{'password' : 'xxxxxxxxx'}";
  ---> 
  <cffunction name="loginradiusSetPassword"
  hint="Set the password of acount, used in admin section.">

    <!--- Define arguments. --->
    <cfargument name="accountid" type="string" required="true" hint="Raas Account ID"/>
    <cfargument name="params" type="any" required="true" hint="data should be in json format"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/password">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.accountid#" type="URL">
      <cfhttpparam name="action" value="set" type="URL">
      <cfhttpparam value="#arguments.params#" type="body">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 


  <cffunction name="loginradiusGetProfileData" 
  hint="Retrieves the profile data associated with the specific user using the users unique UserID">

    <!--- Define arguments. --->
    <cfargument name="id" type="string" required="true" />

    <cfhttp  url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="userid" value="#arguments.id#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusGetProfileDataByEmail" 
  hint="This API retrieves the profile data associated with the specific user using the passing in email address.">

    <!--- Define arguments. --->
    <cfargument name="emailid" type="string" required="true" />

    <cfhttp  url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="emailid" value="#arguments.emailid#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <!--- Example of params (valid json)
  params =  â€œ{'emailid' : 'example@domain.com', 'password' : 'xxxxxxxxxxx', 'firstname' : 'firstname', 'lastname' : 'last name',  'gender' :'m', 'birthdate' : 'MM-DD-YYYY',
   ....................
   ....................}â€?
  ---> 
  <cffunction name="loginradiusUserRegistration"
  hint="Register user from server side, verification email will be send to provided email address">
    
    <!--- Define arguments. --->
    <cfargument name="params" type="any" required="true" hint="Data should be in json format"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/register">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam value="#arguments.params#" type="body">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <!--- Example of  params (valid json)
params =  â€œ{'firstname' : 'firstname', 'lastname' : 'last name',  'gender' :'m', 'birthdate' : 'MM-DD-YYYY',
   ....................
   ....................}â€?  --->  
  <cffunction name="loginradiusUpdateUserProfile"
  hint="This API is used to Modify/Update details of an existing user">

    <!--- Define arguments. --->
    <cfargument name="userid" type="string" required="true" />
    <cfargument name="params" type="any" required="true" hint ="data in json format"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="userid" value="#arguments.userid#" type="URL">
      <cfhttpparam value="#arguments.params#" type="body">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <!--- Example of  params (valid json)
params =  â€œ{ 'firstname' : 'firstname', 'lastname' : 'last name',  'gender' :'m', 'birthdate' : 'MM-DD-YYYY',
   ....................
   ....................}â€?  --->  
  <cffunction name="loginradiusUpdateAccountProfile"
  hint="This API updates an existing Account information in your Cloud Storage with the specified account based on the account ID(UID).">

    <!--- Define arguments. --->
    <cfargument name="accountId" type="string" required="true" />
    <cfargument name="params" type="any" required="true" hint ="data in json format"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/edit">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountId" value="#arguments.accountId#" type="URL">
      <cfhttpparam value="#arguments.params#" type="body">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <!--- Example of  params (valid json)
params =  â€œ{'firstname' : 'firstname', 'lastname' : 'last name',  'gender' :'m', 'birthdate' : 'MM-DD-YYYY',
   ....................
   ....................}â€?
  --->  
  <cffunction name="loginradiusUpdateProfileByAccessToken"
  hint="API updates the user profile by the access token, It meant to fill in the required fields of user profile.">

    <!--- Define arguments. --->
    <cfargument name="token" type="string" required="true" hint ="Uniquely generated identifier key by LoginRadius that is activated after successful authentication." />
    <cfargument name="params" type="any" required="true" hint ="data in json format"/>
    <cfargument name="template" type="string" required="false" default="" hint ="email template name" />
     <cfargument name="emailverificationurl" type="string" required="false" default="" hint ="URL where email verification will be handled" />
   
    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/update">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="token" value="#arguments.token#" type="URL">
      <cfhttpparam name="emailverificationurl" value="#arguments.emailverificationurl#" type="URL">
      <cfhttpparam name="template" value="#arguments.template#" type="URL">
      <cfhttpparam value="#arguments.params#" type="body">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <!--- Example of params (valid json)
  params = â€œ {'accountid' : 'abc', 'provider' : 'xyz','provideridâ€™:'xyz'}â€?
  ---> 
  <cffunction name="loginradiusAccountLink"
  hint="Link a user account with a specified providers user account.">

    <!--- Define arguments. --->
    <cfargument name="params" type="any" required="true" hint="Data should ne in json format"/>

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/link">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam  value="#arguments.params#" type="body">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <!--- Example of params (valid json)
  params =  â€œ{'accountid' : 'abc', 'provider' : 'xyz', 'providerid':'xyz'}â€?
  ---> 
  <cffunction name="loginradiusAccountUnLink"
  hint="Unlink a user account with a specified providers user account.">

    <!--- Define arguments. --->
    <cfargument name="params" type="any" required="true" />

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/unlink">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam  value="#arguments.params#" type="body">
    </cfhttp>


    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <!--- Example of params (valid json)
  params = â€œ{  'oldusername' : 'abc', 'newusername' : 'xyz'}â€?
  ---> 
  <cffunction name="loginradiusChangeUsername"
  hint="This API is used for changing user name by account Id.">

    <!--- Define arguments. --->
    <cfargument name="accountId" type="string" required="true" hint="Account ID, UID"/>
    <cfargument name="params" type="any" required="true" />

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/changeusername">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountId" value="#arguments.accountId#" type="URL">
      <cfhttpparam  value="#arguments.params#" type="body">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusCheckUsername"
  hint="This API is used to check username(Server) exists or not on your site">

    <!--- Define arguments. --->
    <cfargument name="username" type="string" required="true" hint="Username that you want to validate"/>

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/checkusername">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="username" value="#arguments.username#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusDeleteUserWithEmailConfirmation"
  hint="Remove an user's account from LoginRadius system. For security and mis-click concerns, it will send a delete confirmation email to user's email inbox to ask user to confirm the action.">

    <!--- Define arguments. --->
    <cfargument name="userid" type="string" required="true" hint="User Id"/>
    <cfargument name="deleteuserlink" type="string" required="true"   hint="The link handles the delete logic" />
    <cfargument name="template" type="string" required="false"  default=""  hint="Name of email template" />

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/deleteuseremail">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="userid" value="#arguments.userid#" type="URL">
      <cfhttpparam name="deleteuserlink" value="#arguments.deleteuserlink#" type="URL">
      <cfhttpparam name="template" value="#arguments.template#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusCheckEmailAvailablity"
  hint="This API checks for the existence of the specified email address in your Cloud Storage.">

    <!--- Define arguments. --->
    <cfargument name="emailid" type="string" required="true" hint="
    Email address you want to check"/>

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/checkemail">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="emailid" value="#arguments.emailid#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusGetForgotPasswordToken"
  hint="This API generates a forgot password token so you can manually pass into the reset password page and reset some's password">

    <!--- Define arguments. --->
    <cfargument name="email" type="string" required="true" hint="User's email"/>

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/password/forgot">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="email" value="#arguments.email#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction>

  <cffunction name="loginradiusResetAccountPassword"
  hint="This API is used to reset the password for an account. It does not require to know the previous(old) password.">

    <!--- Define arguments. --->
     <cfargument name="VerificationToken" type="string" required="true" hint="LoginRadius' verification token to reset password"/>
     <cfargument name="password" type="any" required="true" hint= "New Password to be set" />   
     <cfargument name="welcomeEmailTemplate" type="string" required="false" default = ":welcomeEmailTemplate" hint="Welcome Email email template name."/>
   
   <cfset params = "{'password' : '#arguments.password#'}">
    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account/password/reset">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="welcomeEmailTemplate" value="#arguments.welcomeEmailTemplate#" type="URL">
      <cfhttpparam name="vtoken" value="#arguments.VerificationToken#" type="URL">
       <cfhttpparam  value="#params#" type="body">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusGetAccounts"
  hint="Retrieve all of the profile data from each of the linked social provider accounts associated with the account. For ex: A user has linked facebook and google account then this api will retrieve both profile data.">

    <!--- Define arguments. --->
    <cfargument name="accountid" type="string" required="true" hint="unique UserID (UID)"/>

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/account">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.accountid#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <!--- Example of params (vaild json)
  params =  '{  "firstname" : "xxxxxxxxxxx","lastname" : "xxxxxxxxxxxxxxxxx" }';
  ---> 

  <cffunction name="loginradiusUpsertCustomObjects"
  hint="Create custom objects, by providing ID of object, to a specified account if the object is not exist it will create a new object.">

    <!--- Define arguments. --->
    <cfargument name="accountid" type="string" required="true" hint="unique UserID (UID)"/>
    <cfargument name="objectid" type="string" required="true" hint="LoginRadius Custom Object ID"/>
    <cfargument name="params" type="any" required="true" hint= "Valid JSON obj as per your schema" />

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/customObject/upsert">
      <cfhttpparam type="header" name="Content-Type" value="application/json" />
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.accountid#" type="URL">
      <cfhttpparam name="objectid" value="#arguments.objectid#" type="URL">
      <cfhttpparam  value="#arguments.params#" type="body">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 


  <cffunction name="loginradiusRetrieveCustomObjectsByAccountId"
  hint="Retrieve all of the custom objects by account ID (UID).">

    <!--- Define arguments. --->
    <cfargument name="accountid" type="string" required="true" hint="unique UserID (UID)"/>
    <cfargument name="objectid" type="string" required="true" hint="LoginRadius Custom Object ID"/>


    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/customObject">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.accountid#" type="URL">
      <cfhttpparam name="objectid" value="#arguments.objectid#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusCreateCustomObjectsByMultipleAccountIds"
  hint="Retrieve all of the custom objects by account IDs (UID).">

    <!--- Define arguments. --->
    <cfargument name="accountids" type="string" required="true" hint="Uid of the users separated by comma"/>
    <cfargument name="objectid" type="string" required="true" hint="LoginRadius Custom Object ID"/>


    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/customObject">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="accountids" value="#arguments.accountids#" type="URL">
      <cfhttpparam name="objectid" value="#arguments.objectid#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <!--- 
  query = "<Expression LogicalOperation='AND'>
  <Field Name='Provider' ComparisonOperator='Equal'>facebook</Field>
  <Expression LogicalOperation='OR'>
  <Field Name='Gender' ComparisonOperator='Equal'>M</Field>
  <Field Name='Gender' ComparisonOperator='Equal'>U</Field>
  </Expression>
  </Expression>";
  ------------------ OR ------------------
  query = "<Field Name='Gender' ComparisonOperator='Equal'>F</Field>";
  --->

  <cffunction name="loginradiusRetrieveCustomObjectsByQuery"
  hint="Retrieve all of the custom objects by an objectï¿½s unique ID and filtered by a query.">

    <!--- Define arguments. --->
    <cfargument name="query" type="string" required="true" hint="query to filter data"/>
    <cfargument name="objectid" type="string" required="true" hint="LoginRadius Custom Object ID"/>
    <cfargument name="indexvalue" type="string" required="false" default = 1 hint="Cursor value in case the data is large" />

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/customObject">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="q" value="#arguments.query#" type="URL">
      <cfhttpparam name="objectid" value="#arguments.objectid#" type="URL">
      <cfhttpparam name="cursor" value="#arguments.indexvalue#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusRetrieveRecordsByObjectId"
  hint="Retrieve all of the custom objects by an objectï¿½s unique ID and filtered by a query.">

    <!--- Define arguments. --->
    <cfargument name="objectid" type="string" required="true" hint="LoginRadius Custom Object ID"/>
    <cfargument name="indexvalue" type="string" required="false" default= 1 hint="Cursor value in case the data is large" />

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/customObject">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="objectid" value="#arguments.objectid#" type="URL">
      <cfhttpparam name="cursor" value="#arguments.indexvalue#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusRetrieveStatsCustomObjects"
  hint="Retrieve stats associated with a custom object">

    <!--- Define arguments. --->
    <cfargument name="objectid" type="string" required="true" hint="LoginRadius Custom Object ID"/>

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/customObject/stats">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="objectid" value="#arguments.objectid#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusCheckCustomObject"
  hint="This API is used to check the presence of a Custom Object for the specified account ID(UID)">

    <!--- Define arguments. --->
    <cfargument name="objectid" type="string" required="true" hint="LoginRadius Custom Object ID"/>
    <cfargument name="accountid" type="string" required="true" hint="UID, the identifier for each user account, it may have multiple IDs(identifier for each social platform) attached with" />

    <cfhttp url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/customObject">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="objectid" value="#arguments.objectid#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.accountid#" type="URL">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

    <cffunction name="loginradiusDeleteCustomObject"
  hint="delete custom objects">

    <!--- Define arguments. --->
    <cfargument name="objectid" type="string" required="true" hint="LoginRadius Custom Object ID"/>
    <cfargument name="accountid" type="string" required="true" hint="Uniques user id (Uid)" />
    <cfargument name="isblock" type="boolean" required="false" default=true hint="pass false to unblock the customobjects." />

    <cfhttp method="POST" url="#variables.LR_USER_REG_API_ENDPOINT#/raas/v1/user/customObject/status">
      <cfhttpparam name="appkey" value="#variables.raas_api_key#" type="URL">
      <cfhttpparam name="appsecret" value="#variables.raas_api_secret#" type="URL">
      <cfhttpparam name="objectid" value="#arguments.objectid#" type="URL">
      <cfhttpparam name="accountid" value="#arguments.accountid#" type="URL">
      <cfhttpparam name="isblock" value="#arguments.isblock#" type="FormField">
    </cfhttp>

    <cfreturn loginradiusGetResponse(cfhttp)>
  </cffunction> 

  <cffunction name="loginradiusGetResponse" hint="I read json response of APIs">  

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