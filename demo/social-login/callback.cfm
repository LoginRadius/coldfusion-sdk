 <script src="js/jquery.js" type="text/javascript"></script>
        <script src="js/tabcontent.js" type="text/javascript"></script>
        <link href="css/tabs.css" rel="stylesheet" type="text/css"/>
<cfset SdkObject = createObject("component","loginradiussdk")>
<cftry>
<cfset accessTokenResult = SdkObject.loginradiusExchangeAccessToken(LR_SECRETKEY)>
<cfcatch type = "LoginRadiusException"> 
                <cfdump var = 'Error: #cfcatch.message#'>
                </cfcatch> 
              </cftry>
<cfif IsStruct(accessTokenResult) && structkeyexists(accessTokenResult, "access_token")>
<cfset userProfileResult = ''>
<cftry>
<cfset userProfileResult = SdkObject.loginradiusGetUserProfiledata(accessTokenResult.access_token)>
<cfcatch type = "LoginRadiusException"> 
                <cfdump var = 'Error: #cfcatch.message#'>
                </cfcatch> 
              </cftry>

<cfif IsStruct(userProfileResult) && structkeyexists(userProfileResult, "Provider")>
<cfscript>
function showformatdata(val){
value ='';
//writeDump(val);
for (d in val)  // for-in loop for array
{
  for ( key in d )  // for-in loop for struct
  {
 // writeDump(d);  
 
	   try {
    value = value & (key & ":"  & d[key] & "<br/>");
  }
  catch(Expression exceptionVariable) {
  // value = value & (key & ":"  );
  }
  }
}
return value;
}
showOuput ='';
ShowData ='';
showOuput = showOuput & "<div style='margin: 0 auto; padding: 40px'>";

 showOuput = showOuput & "<ul class='tabs'><li><a href='##view1'>Profile</a></li>";
  if (ArrayContains( ["foursquare"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view15'>Photos</a></li>";
 }
 if (ArrayContains( ["facebook", "google", "live", "vkontakte", "renren"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view2'>Albums</a></li>";
 }
 if (ArrayContains( ["foursquare", "vkontakte"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view3'>Check-Ins</a></li>";
 }
 if (ArrayContains( ["live", "vkontakte"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view4'>Audio</a></li>";
 }
 if (ArrayContains( ["facebook", "google", "twitter", "linkedin", "yahoo", "live", "vkontakte", "foursquare", "renren"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view5'>Contacts</a></li>";
 }
 if (ArrayContains( ["twitter"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view6'>Mentions</a></li>";
 }
 if (ArrayContains( ["twitter"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view7'>Followings</a></li>";
 }
 if (ArrayContains( ["facebook","live"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view8'>Events</a></li>";
 }
 if (ArrayContains( ["facebook"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view9'>Get Post</a></li>";
 }
 if (ArrayContains( ["facebook",  "linkedin"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view10'>Followed Companies</a></li>";
 }
 if (ArrayContains( ["facebook",  "linkedin", "vkontakte"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view11'>Groups</a></li>";
 }
 if (ArrayContains( ["facebook", "twitter", "linkedin", "vkontakte", "renren"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view12'>Get Status</a></li>";
 }
 if (ArrayContains( ["facebook", "google", "live", "vkontakte"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view13'>Get Video</a></li>";
 }
 if (ArrayContains( ["facebook"], userProfileResult.Provider)) {
 showOuput = showOuput & "<li><a href='##view14'>Likes</a></li>";
 }
 post_status = false;
send_message = false;
	 if (ArrayContains(['facebook', 'twitter', 'linkedin'], userProfileResult.Provider)) {
                        post_status = true;
                         showOuput = showOuput & "<li><a href='##view17'>Post Status</a></li>";
                    }
                    if (ArrayContains(['twitter', 'linkedin'], userProfileResult.Provider)) {
                        send_message = true;
                         showOuput = showOuput & "<li><a href='##view18'>Send Message</a></li>";
                    }

 WriteOutput(showOuput);WriteOutput("</ul>");
  WriteOutput("<div class='tabcontents'><div id='view1'>");
  	 writeDump(userProfileResult);
	 WriteOutput("</div>");
   if (ArrayContains( ["foursquare"], userProfileResult.Provider)) {
   //WriteOutput("<h1>Photos</h1>");
   
        WriteOutput("<div id='view15'>");
        try {
 UserPhotos = SdkObject.loginradiusGetPhotos(accessTokenResult.access_token);
  writeDump(UserPhotos);
} catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
		//writeDump(UserPhotos);
		
	
		WriteOutput("</div>");
    }
	if (ArrayContains( ["facebook", "google", "live", "vkontakte", "renren"], userProfileResult.Provider)) {
	
	//WriteOutput("<h1>Photos Albums</h1>");
      WriteOutput("<div id='view2'>");
		   try {
   UserPhotoalbums = SdkObject.loginradiusGetPhotoAlbums(accessTokenResult.access_token);
   writeDump(UserPhotoalbums);
} catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
		
		
		WriteOutput("</div>");
    }
	if (ArrayContains( ["foursquare", "vkontakte"], userProfileResult.Provider)) {
	//WriteOutput("<h1>Check-Ins</h1>");
	
         WriteOutput("<div id='view3'>");
		     try {
    UserCheckins = SdkObject.loginradiusGetCheckins(accessTokenResult.access_token);
    writeDump(UserCheckins);
} catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
 
   
   WriteOutput("</div>");
   }
	if (ArrayContains( ["live", "vkontakte"], userProfileResult.Provider)) {
	
	//WriteOutput("<h1>Audio</h1>");
       
WriteOutput("<div id='view4'>");
         try {
   GetAudio = SdkObject.loginradiusGetAudio(accessTokenResult.access_token);
   writeDump(GetAudio);
} catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
		
   
   WriteOutput("</div>");
    }
	if (ArrayContains( ["facebook", "google", "twitter", "linkedin", "yahoo", "live", "vkontakte", "foursquare", "renren"], userProfileResult.Provider)) {
	
	//WriteOutput("<h1>Contacts</h1>");
       WriteOutput("<div id='view5'>");
               try {
    GetContacts = SdkObject.loginradiusGetContacts(accessTokenResult.access_token);
     writeDump(GetContacts);
} catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
		//writeDump(GetContacts);
		
		
  
   WriteOutput("</div>");
    }
	if (ArrayContains( ["twitter"], userProfileResult.Provider)) {
	
	//WriteOutput("<h1>Mentions</h1>");
    WriteOutput("<div id='view6'>");
  try{
        UserMentions = SdkObject.loginradiusGetMentions(accessTokenResult.access_token);
           writeDump(UserMentions);
        }
        catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
		//writeDump(UserMentions);
	

   WriteOutput("</div>");
    }
	if (ArrayContains( ["twitter"], userProfileResult.Provider)) {
	
	//WriteOutput("<h1>Followings</h1>");
  WriteOutput("<div id='view7'>");
  try{
        UserFollowing = SdkObject.loginradiusGetFollowing(accessTokenResult.access_token);
        writeDump(UserFollowing);
		  }
        catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
		
		
   
   WriteOutput("</div>");
    }
	if (ArrayContains( ["facebook","live"], userProfileResult.Provider)) {
	
	//WriteOutput("<h1>Events</h1>");
  WriteOutput("<div id='view8'>");
  try{
        UserEvents = SdkObject.loginradiusGetEvents(accessTokenResult.access_token);
           writeDump(UserEvents);
		}
        catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
		

   WriteOutput("</div>");
    }
	if (ArrayContains( ["facebook"], userProfileResult.Provider)) {
	WriteOutput("<div id='view9'>");
  try{
	//WriteOutput("<h1>Get Post</h1>");
        UserGetPost = SdkObject.loginradiusGetPosts(accessTokenResult.access_token);
         writeDump(UserGetPost);
	}
		   catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
  
   WriteOutput("</div>");
    }
	if (ArrayContains( ["facebook",  "linkedin"], userProfileResult.Provider)) {
      WriteOutput("<div id='view10'>");
	try{

    //WriteOutput("<h1>Followed Companies</h1>");
        UserFollowedCompanies = SdkObject.loginradiusGetFollowedCompanies(accessTokenResult.access_token);
         writeDump(UserFollowedCompanies);
  }
       catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
		

  
   WriteOutput("</div>");
    }
	if (ArrayContains( ["facebook",  "linkedin", "vkontakte"], userProfileResult.Provider)) {
	WriteOutput("<div id='view11'>");
  try{
	//WriteOutput("<h1>Groups</h1>");
        UserGroups = SdkObject.loginradiusGetGroups(accessTokenResult.access_token);
	 writeDump(UserGroups);
		}
    catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
} 
  
   WriteOutput("</div>");
    }
	if (ArrayContains( ["facebook", "twitter", "linkedin", "vkontakte", "renren"], userProfileResult.Provider)) {
    WriteOutput("<div id='view12'>");
	try{
	//WriteOutput("<h1>Get Status</h1>");
        UserGetStatus = SdkObject.loginradiusGetStatus(accessTokenResult.access_token);
         writeDump(UserGetStatus);
		}
       catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
	
  }
   WriteOutput("</div>");
    }
	if (ArrayContains( ["facebook", "google", "live", "vkontakte"], userProfileResult.Provider)) {
	
	//WriteOutput("<h1>Get Video</h1>");
    WriteOutput("<div id='view13'>");
  try{
        UserVideos = SdkObject.loginradiusGetVideo(accessTokenResult.access_token);
           writeDump(UserVideos);
        }
		 catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
  
  }
	

   WriteOutput("</div>");
    }
	if (ArrayContains( ["facebook"], userProfileResult.Provider)) {
	
	//WriteOutput("<h1>Likes</h1>");
  WriteOutput("<div id='view14'>");
  try {
        UserLikes = SdkObject.loginradiusGetLikes(accessTokenResult.access_token);
         writeDump(UserLikes);
        }
		 catch (LoginRadiusException e) {
  WriteOutput("Error: " & e.message);
 
  
  }
		
  
   WriteOutput("</div>");
    }

      if(post_status)  {          
	poststatus = '<div id="view17" style=" margin: 0 auto;width: 350px;">';
poststatus  &= '<input type="hidden" value="" id="connection_url">';
poststatus  &= '<input type="hidden" value="#userProfileResult.Provider#" id="provider">';
poststatus  &= '<input type="hidden" value="#accessTokenResult.access_token#" id="lraccesstoken">';
 poststatus  &= '<label for="title" class="faclable">Title :</label>';
 poststatus  &= '<input type="text" id="title" value="" class="factextbox"><br/>';
 if (!ArrayContains( ["twitter"], userProfileResult.Provider)) {
poststatus  &='<label for="url" class="faclable">URL :</label>';
poststatus  &='<input type="text" id="url" value="" class="factextbox"><br/>';
 poststatus  &='<label for="imageurl" class="faclable">Image URL :</label>';

 poststatus  &='<input type="text" id="imageurl" value=""class="factextbox"><br/>';
 }
 poststatus  &='<label for="status" class="faclable">Message :</label>';
 poststatus  &='<textarea id="status" class="facetextarea"></textarea><br/>';
 if (!ArrayContains( ["twitter"], userProfileResult.Provider)) {
poststatus  &='<label for="description" class="faclable">Description :</label>';
poststatus  &='<textarea id="description" class="facetextarea"></textarea>';
}
poststatus  &='<button onClick="lrpoststratus();" class="facesend">Send</button>
<div style="  margin-left: 100px;margin-top: 5px;"  id="poststratus"></div>

</div>';
                                
	WriteOutput(poststatus);
	}
	if (send_message) {
                                
sendmessage = '<div id="view18" style=" margin: 0 auto;width: 350px;">';
sendmessage &= '<h2>Send Message</h2>';



sendmessage &= '<input type="hidden" value="#accessTokenResult.access_token#"id="sendlraccesstoken">';
sendmessage &= '<label for="sendto" class="faclable">To :</label><select class="twilist" name="sendto" id="sendto">';
                                       
                                    if(IsStruct(GetContacts) && structkeyexists(GetContacts, "Data")  ) {
                                            for (usercontactvalue in GetContacts.Data) {
                                               
      sendmessage &='<option value="#usercontactvalue.ID#">#usercontactvalue.Name#</option>';
                                            
                                            }
                                        }
                                       
                                    sendmessage &= '</select>';                                  
                                   
                                   sendmessage &= '<label for="sendsub" class="faclable">Subject :</label>';
                                    sendmessage &= '<input type="text" id="sendsub" value="" class="factextbox">';
                                    sendmessage &= '<label for="sendstatus" class="faclable">Message :</label>';
                                    sendmessage &= '<textarea id="sendstatus" class="facetextarea"></textarea>';
                                    sendmessage &= '<button onClick="lrsendmessage();" class="facesend">Send</button>';
                                    sendmessage &= '<div style="  margin-left: 100px;margin-top: 5px;" id="sendmessage"></div>';
                                sendmessage &= '</div>';
                                WriteOutput(sendmessage);
                                }
     WriteOutput("</div>");
</cfscript>
</cfif>
<cfelse>
<cfdump var="#accessTokenResult#">
</cfif>
