*Batch Class Example Used case*
Create at least 10 Accounts and each should have an Email associated with it in your Org first. (If the Email field is not there then create a custom one.)
	Then, create 100 Contacts for Each Account and leave the Email field as it is in you Org.
	Above 2 steps should be performed in your Org before start writing the Batch class.
	Then RUN the Batch(batch should be able to take List of Accounts using which you'll be Querying the Account/Contact Records)
	Batch is going to Update all the Contact's Email(Account's child) with Account.Email
	In the end, from Finish send an Email using the SingleEmail to the Account's Email Address which should say that 100 Contacts got created on the Account.
	Also, write a test class for the Same batch Class which should cover at least 85% code of your batch class.
	Cheers............
	   
