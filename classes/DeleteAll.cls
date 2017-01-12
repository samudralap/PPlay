public class DeleteAll{

public DeleteAll(){}

public void deleteprimaryobjs(){

//delete all primary objs like Cases, Leads, Opps, Contact & Accounts

    list<Case> cas = [select id from Case];
    delete cas;

    list <Lead> leads = [select id from Lead];
    delete leads;

    list <Opportunity> Opps = [select id from Opportunity];
    delete Opps;

    list <Contact> con = [select id from Contact];
    delete con;

    list <Account> acc = [select id from Account];
    delete acc;

}

public void deleterest(){

    Map<String, Schema.SobjectType>globalDescribe = schema.getGlobalDescribe();
    set<String> sobjects =globalDescribe.keyset();

    for (string so : Sobjects) {
            //limits apply.

            if(globalDescribe.get(so).getDescribe().isDeletable() && globalDescribe.get(so).getDescribe().isQueryable() && globalDescribe.get(so).getDescribe().isCustom()

               && so != 'EmailTemplate' && so != 'Vote' && so != 'ContentDocumentLink'

               && so != 'AuthSession' && so != 'ApexLog' && so != 'ObjectPermissions' && so != 'FieldPermissions'

               && so != 'IdeaComment' && so != 'CollaborationGroup' && so != 'CollaborationGroupRecord' && so != 'Activity' && so != 'Case' && so != 'Account' && so != 'Contact' && so != 'Lead' && so != 'Opportunity'&& so != 'Asset'   ) { 

                

                String soql = 'SELECT ID FROM '+so+' limit 50000';

List<SObject> current_objects = Database.query(soql);


                try {

                    delete current_objects;

                } catch (System.DmlException e) {

                    System.debug(so + ' could not be deleted');

                    }

            

            }

            

            

}

}
}