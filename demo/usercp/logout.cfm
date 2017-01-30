<cfif structkeyexists(Session, "user_id")>
<cfset StructDelete(Session, "user_id")>
</cfif>
