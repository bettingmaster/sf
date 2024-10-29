global with sharing class AccountValidator {
  global class AccountValidatorException extends Exception {
  }

  global List<Account> accountsToValidate;

  global AccountValidator() {
  }

  global AccountValidator(List<Account> accounts) {
    this.accountsToValidate = accounts;
  }

  global void validateAccounts() {
    for (Account account : this.accountsToValidate) {
      if (account.Name.left(6) != 'ABC - ') {
        throw new AccountValidatorException(
          'Acccount must be pre-pended with "ABC - "'
        );
      }
    }
  }
}
