<cfinclude template="../front/header.cfm">
<div class="lr-profile-frame lr-input-style">
<div class="lr-profile-header">
<span class="lr-image-frame">
<cfif structkeyexists(Session.userProfile, "ImageUrl")>
<img src="<cfoutput>#Session.userProfile.ImageUrl#</cfoutput>">
<cfelse>
<img src="images/user.png">
</cfif>

</span>
<div class="lr-heading">Hello, <span class="lr-user-name"><cfoutput>#Session.userProfile.FirstName#</cfoutput></span></div>

<div class="lr-profile-info">

<div class="lr-email-info">
<cfif structkeyexists(Session.userProfile, "Email")>
<span class="lr-value lr-em"><cfoutput>#Session.userProfile.Email[1].Value#</cfoutput></span>
</cfif>
</div>

<div class="lr-uid-info">
<span class="lr-label">UID: </span>
<span class="lr-value"><cfoutput>#Session.userProfile.Uid#</cfoutput></span>
</div>
</div>

<div class="lr-menu-buttons">
<span class="lr-buttons" data-tab="lr-profile">Profile</span>
<span class="lr-buttons" data-tab="lr-account-prov">Account Providers</span>
<span class="lr-buttons" id="lr-password-tab" data-tab="lr-set-pw">Set Password</span>
<span class="lr-logout" onclick='login_radius_log_out();'>Logout</span>
</div>
</div>
<div id="lr-profile" class="lr-frame lr-input-style lr-align-left">
<form action="" method="post">
<cfset FirstName ="" />
<cfif structkeyexists(Session.userProfile, "FirstName")>
<cfset FirstName ="#Session.userProfile.FirstName#" />
</cfif>
<label class="lr-input-frame lr-inline">
<span class="lr-input-label">FirstName</span>
<input type="text" name="firstname" class="lr-input-value" value="<cfoutput>#FirstName#</cfoutput>"></input>
</label>
<cfset LastName ="" />
<cfif structkeyexists(Session.userProfile, "LastName")>
<cfset LastName ="#Session.userProfile.LastName#" />
</cfif>
<label class="lr-input-frame lr-inline">
<span class="lr-input-label">LastName</span>
<input type="text" name="lastname" class="lr-input-value" value="<cfoutput>#LastName#</cfoutput>"></input>
</label>
<cfset BirthDate ="" />

<cfif structkeyexists(Session.userProfile, "BirthDate")>
<cfset BirthDate ="#Replace(Session.userProfile.BirthDate, "/", "-", "all")#" />
</cfif>
<label class="lr-input-frame lr-inline">
<span class="lr-input-label">BirthDate</span>
<input type="text" name="birthdate" class="lr-input-value loginradius-raas-birthdate" value="<cfoutput>#BirthDate#</cfoutput>"></input>
</label>
<cfset Email ="" />
<cfif structkeyexists(Session.userProfile, "Email")>
<cfset Email ="#Session.userProfile.Email[1].Value#" />
</cfif>
<label class="lr-input-frame lr-inline">
<span class="lr-input-label">Email</span>
<input type="text" disabled class="lr-input-value" value="<cfoutput>#Email#</cfoutput>"></input>
</label>
<cfset Country ="" />
<cfif structkeyexists(Session.userProfile, "Country")>
<cfif structkeyexists(Session.userProfile.Country, "Name")>
<cfset Country ="#Session.userProfile.Country.Name#" />
</cfif>
</cfif>
<label class="lr-input-frame lr-inline">
<span class="lr-input-label">Country</span>
<input type="text" name="country" class="lr-input-value" value="<cfoutput>#Country#</cfoutput>"></input>
</label>
<cfset City ="" />
<cfif structkeyexists(Session.userProfile, "City") && Session.userProfile.City NEQ "unknown">
<cfset City ="#Session.userProfile.City#" />
</cfif>
<label class="lr-input-frame lr-inline">
<span class="lr-input-label">City</span>
<input type="text" name="city" class="lr-input-value" value="<cfoutput>#City#</cfoutput>"></input>
</label>

<input type="submit" name="lr_update" value="Save" />
</form>
</div>
<div id="lr-account-prov" class="lr-frame lr-account-prov lr-align-left">
<!-- Login social icons -->
<!-- Spans are easier to manage than divs. But remember to not nest a div inside a span -->
<div class="lr-login-buttons-frame lr-space-fix">
<script type="text/html" id="loginradiuscustom_tmpl">

<# if(isLinked) { #>
<div class="lr-linked">
<div style="width:100%">
<span class="lr-icon-frame">
<span class="lr-icon lr-raas-<#= Name.toLowerCase() #>">
</span>
</span>

<span class="lr-linked-label"><#= Name #> is connected</span>
<span class="lr-unlink lr-pull-right lr-tooltip" data-title="Unlink" onclick='return unLinkAccount(\"<#= Name.toLowerCase() #>\",\"<#= providerId #>\")'>&#215;</span>
</div>
</div>
<# }  else {#>
<div class="lr-unlinked">

<span class="lr-icon-frame">
<span class="lr-icon lr-raas-<#= Name.toLowerCase() #>" title="<#= Name #>" onclick="return $SL.util.openWindow('<#= Endpoint #>&is_access_token=true&callback=<cfoutput>#YOUR_DOMAIN#</cfoutput>');">
</span>
</span>
</div>

<# } #>

</script>

<div class="lr_account_linking">
<div id="interfacecontainerdiv" class="interfacecontainerdiv"></div>
<div style="clear:both"></div>
</div>
<div class="lr-linked-data"></div>
<div style="clear:both"></div>
<div class="lr-unlinked-data"></div>
<div style="clear:both"></div>

</div>
</div>
<div id="lr-set-pw" class="lr-frame lr-set-pw lr-align-left">
<div  id="setpasswordbox">
</div>
<div class="lr-submit-frame lr-align-right">
<span class="lr-link-frame">
<span class="lr-link lr-show-pw">Show Password</span>
</span>

</div>

</div>
<div id="lr-change-pw" class="lr-frame lr-change-pw lr-align-left">
<div  id="changepasswordbox">
</div>
<div class="lr-submit-frame lr-align-right">
<span class="lr-link-frame">
<span class="lr-link lr-show-pw">Show Password</span>
</span>

</div>

</div>
</div>
<footer>
<cfinclude template="../front/footer.cfm">
</footer>
</div>
<!---//End-wrap---->

<script>

show_birthdate_date_block();
LoginRadiusRaaS.$hooks.setProcessHook(function () {

$('#fade').show();
}, function () {

if($('.lr_account_linking') && $('#interfacecontainerdiv').text() != ''){
linking();
}
$('#fade').hide();
});
LoginRadiusRaaS.init(raasoption, 'accountlinking', function(response, token) {
token =  token ? token : false;
if (response.isPosted && !token) {
window.location.href=window.location;
} else {


var array = {};
array['value'] = 'accountLink';
if(token){
array['linked'] = 1;
}
array['mtoken'] = response;
get_form_for_hidden_value(array);
//handle_ajax_functionality(send_data, handle);
}

}, function(response) {
}, "interfacecontainerdiv");


LoginRadiusRaaS.passwordHandleForms("setpasswordbox", "changepasswordbox", function (israas) {
if (israas) {

$('#lr-password-tab').attr("data-tab", "lr-change-pw");
$('#lr-password-tab').html("Change Password");
$("#changepasswordbox").show();
} else {

$('#lr-password-tab').attr("data-tab", "lr-set-pw");
$('#lr-password-tab').attr("Set Password");
$("#setpasswordbox").show();
}
}, function () {
document.forms['setpassword'].action = '';
document.forms['setpassword'].submit();
}, function () {

}, function () {
document.forms['changepassword'].action = '';
document.forms['changepassword'].submit();
}, function () {

});
</script>





