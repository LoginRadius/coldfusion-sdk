<cfset testSuite = createObject( "component", "mxunit.framework.TestSuite" ) />


<cfset testSuite.addAll( "tests.authenticatonapitest" ) />
<cfset results = testSuite.run() />


<cfoutput>
	#results.getHtmlResults( "../mxunit/" )#
</cfoutput>