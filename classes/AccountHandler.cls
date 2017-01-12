public class AccountHandler {
        public static account insertNewAccount(String Name)
        {    
            Account acc = new Account();
            acc.Name  = Name;
            try{
                insert acc;
             }
            catch(DMLException e)
            {
                System.debug('A DML exception has occurred: ' + e.getMessage());
                return null;
            }
            return acc;
        }
 
}