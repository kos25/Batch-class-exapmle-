@isTest
public class handsonBatchTask_Tc {
    static testMethod void testbatchMethod()
    {   List<String> accId ; 
        List<Account> accountList = new List<Account>();
        List<Contact> contactList= new List<Contact>();
        for(Integer i=0 ; i <10;i++)
        {
            Account acc = new Account();
            acc.Name ='Name'+i;
            acc.First_Name__c = 'demo';
            acc.Last_Name__c = 'demo';
            acc.Email__c = 'test@emailbatch.com';
            accountList.add(acc);           
        }
        insert accountList;
        
       
        for(Account ac : accountList){
            for(Integer j=0 ;j <100;j++){
                Contact con = new Contact();
                con.AccountId = ac.Id ;
                con.LastName = ac.Name + j ;
                contactList.add(con);
            }
        }
         
        insert contactList;
     
     List<String> ids = new list<String>();     
     if(!accountList.isEmpty()){
         for(Account  a : accountList){
             ids.add(a.id);
         }  
     }
     
     Test.startTest();
     handsonBatchTask sb = new handsonBatchTask();
     sb.AccId = ids ; 
     Database.executeBatch(sb); 
     Test.stopTest();
    }
}