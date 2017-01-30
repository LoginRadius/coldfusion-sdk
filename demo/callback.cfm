
<cfif !structkeyexists(Session, "user_id")>
<cfinclude template="usercp/login.cfm">
<cfelseif structkeyexists(form, "mtoken") AND structkeyexists(form, "value") >
	<cfif form.value EQ "accountLink">
<cfinclude template="usercp/account_linking.cfm">
</cfif>
<cfelseif structkeyexists(form, "value")>
<cfif form.value EQ "accountUnLink">
<cfinclude template="usercp/account_unlink.cfm">
<cfelseif form.value EQ "logout">
<cfinclude template="usercp/logout.cfm">
</cfif>
<cfelseif structkeyexists(form, "lr_update")>
<cfinclude template="usercp/update_profile.cfm">
<cfelseif structkeyexists(form, "password")>
<cfinclude template="usercp/set_paasword.cfm">
<cfelseif structkeyexists(form, "newpassword")>
<cfinclude template="usercp/change_paasword.cfm">
</cfif>

