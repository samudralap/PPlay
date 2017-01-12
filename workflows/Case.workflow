<?xml version="1.0" encoding="UTF-8"?>
<Workflow xmlns="http://soap.sforce.com/2006/04/metadata">
    <fieldUpdates>
        <fullName>Update_Currency_field</fullName>
        <field>Bonus__c</field>
        <formula>1000</formula>
        <name>Update Currency field</name>
        <notifyAssignee>false</notifyAssignee>
        <operation>Formula</operation>
        <protected>false</protected>
    </fieldUpdates>
    <rules>
        <fullName>Update Currency Field</fullName>
        <actions>
            <name>Update_Currency_field</name>
            <type>FieldUpdate</type>
        </actions>
        <active>true</active>
        <formula>AND ( Eligible_for_Bonus_c__c = True, ISPICKVAL(Contact.Relationship_Tier__c,&quot;Tier 1&quot;))</formula>
        <triggerType>onCreateOrTriggeringUpdate</triggerType>
    </rules>
</Workflow>
