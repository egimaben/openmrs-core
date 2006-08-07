<%@ include file="/WEB-INF/template/include.jsp" %>

<openmrs:require privilege="View Encounters" otherwise="/login.htm" redirect="/admin/encounters/index.htm" />

<%@ include file="/WEB-INF/template/header.jsp" %>
<%@ include file="localHeader.jsp" %>

<script type="text/javascript" src="<%= request.getContextPath() %>/scripts/dojo/dojo.js"></script>

<script type="text/javascript">
	dojo.require("dojo.widget.openmrs.EncounterSearch");

	var eSearch;
	
	dojo.addOnLoad( function() {
		
		eSearch = dojo.widget.manager.getWidgetById('eSearch');
		
		dojo.event.topic.subscribe("eSearch/select", 
			function(msg) {
				document.location = "encounter.form?encounterId=" + msg.objs[0].encounterId + "&phrase=" + eSearch.getPhraseSearched();
			}
		);
		
		<request:existsParameter name="phrase">
			searchBox.value = '<request:parameter name="phrase" />';
		</request:existsParameter>
	
	});
		
</script>

<h2><spring:message code="Encounter.title"/></h2>

<a href="encounter.form"><spring:message code="Encounter.add"/></a><br/><br/>

<div id="findEncounter">
	<b class="boxHeader"><spring:message code="Encounter.find"/></b>
	<div class="box">
		<div dojoType="EncounterSearch" widgetId="eSearch" showIncludeVoided="true" <request:existsParameter name="autoJump">allowAutoJump='true'</request:existsParameter> encounterId='<request:parameter name="encounterId" />'></div>
	</div>
</div>

<%@ include file="/WEB-INF/template/footer.jsp" %>