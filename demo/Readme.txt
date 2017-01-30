1. Include coldfusion sociallogin demo to your server.
2. Modify the following things in order to work coldfusion raas demo in config.cfm file.
  1. <YOUR_RAAS_API_KEY> //that you got from your LoginRadius account
  2. <YOUR_RAAS_API_SECRET> //that you got from your LoginRadius account
  3.  <YOUR_DOMAIN> //Your website domain example: http://abc.com/
  
File Structure:
-css folder 
  //Contain all required css files.
-js folder 
  //Contain js files
-images folder
  //required images
-sdk (required component file)
 --LoginRadiusRaaSSDK.cfc  //raas sdk file
 --LoginRadiusSDK.cfc //aPI v2 //Use to get user profile data from access token.
 
-front (Show login/registration/forgot password/sociallogin interface)
  -- head.cfm //add required scripts and raas option
  -- header.cfm //add logo and div box for show message.
  -- footer.cfm //add overlay image and footer link.
  -- registration.cfm //Add login/registration/forgot password/social login div.
  -- profile.cfm //Add set password/change password/account linking div.
 
- lib
 -- JsonSerializer.cfc //file to get valid json
 
-usercp (Handle login/registration/change password/account linking/account unlinking/set password/update profile functionality)
 -- account_linking.cfm //Handle account linking functionality. use (LoginRadiusSDK.cfc) file to get user profile data.
 -- account_unlinking.cfm //handle account unlinking functionality
 -- login.cfm //handle login functionality use component file (LoginRadiusSDK.cfc) to get user profile data.
 -- logout.cfm //handle logout user functionality
 -- set_password.cfm //handle set password functionality
 -- change_password.cfm //handle change password functionality
 -- update_profile.cfm //handle update profile functionality

-- callback.cfm //handle complete functionality
-- index.cfm //include templete files
-- config.cfm //add reuired values
-- application.cfm //enable session management
 

  
 



  