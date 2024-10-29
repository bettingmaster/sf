public class AcccountTriggerHandler {
    public static void beforeInsert(List <Account> newAccounts){
        AccountValidator validator = new AccountValidator(newAccounts);
        validator.validateAccounts();
    }

    public static void beforeUpdate(Map <Id, Account> newAccounts, Map <Id, Account> oldAccounts){
        AccountValidator validator = new AccountValidator(newAccounts.values());
        validator.validateAccounts();
    }

}