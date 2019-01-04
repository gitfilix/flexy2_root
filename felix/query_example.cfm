

<cfquery name="getFelix">
SELETC * FROM felix
</cfquery>


<cfoutput query="getFelix">
	Name: #name_des_feldes_in_der_db#
</cfoutput>

----------------


<cfquery name="getFelix">
SELETC * FROM felix
</cfquery>


<cfoutput>
	Name: #getFelix.name_des_feldes_in_der_db#
</cfoutput>