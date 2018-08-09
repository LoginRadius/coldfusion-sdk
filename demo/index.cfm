<cfinclude template="config.cfm">
<cfinclude template="front/head.cfm">
<cfinclude template="callback.cfm">
<cfif structkeyexists(Session, "user_id")>
<cfinclude template="front/profile.cfm">
<cfelse>
<cfinclude template="front/registration.cfm">
</cfif>
