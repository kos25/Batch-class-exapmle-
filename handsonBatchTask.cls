public class handsonBatchTask implements Database.Batchable<sObject> , Database.Stateful {
    public List<String> AccId ; 
    public List<String> accEmail;   
    public MAP<Id,String> accIdEmail ;
    public handsonBatchTask(){
        accEmail = new List<String>();
        accIdEmail = new Map<Id, String>();
    }  
    public Database.QueryLocator start(Database.BatchableContext bc) {
        List<Account> accList = [Select ID , NAme , Email__c  From Account where Email__c != null and ID IN :  AccId ];
        if(!accList.isEmpty()){
            for(Account acc : accList){
                accIdEmail.put(acc.Id , acc.Email__c);
            }	  
        }
        String Query = 'Select Id , Name , Email, AccountId  from contact Where  AccountId  IN : AccID ';
        return Database.getQueryLocator(Query);
    }  
    public void execute(Database.BatchableContext BC,List<contact> Conlist){
        List<contact> contactToUpdate = new List<Contact>();
        try{ 
            for(Contact  con : Conlist ){
                  con.email = accIdEmail.get(con.AccountId);
                  contactToUpdate.add(con);
                }
            Database.SaveResult[] srList = Database.update(contactToUpdate, false); 
        }
        catch(exception e ){
            system.debug(e.getMessage());
        }
    }
    public void finish(Database.BatchableContext BC){
        if(!accEmail.isEmpty()){
            for(string e : accEmail){
                Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                String[] toAddresses = new String[] {e};
                    mail.setToAddresses(toAddresses);
                mail.setSubject('Match Merge Batch ');
                mail.setPlainTextBody('100 Updated got created on the Account');
                Messaging.sendEmail(new Messaging.SingleEmailMessage[] {mail});
            }
        }
    }
}