public class CustomerRegistration {

    // Functional Feature: Customer Registration
    public static void registerNewCustomer(String firstName, String lastName, String email, String address) {
        try {
            // Check if the provided email is unique and not already registered
            if (!isEmailRegistered(email)) {
                // Create a new Customer record
                Customer__c newCustomer = new Customer__c();
                newCustomer.FirstName__c = firstName;
                newCustomer.LastName__c = lastName;
                newCustomer.Email__c = email;
                newCustomer.Address__c = address;

                // Insert the new customer record into the database
                insert newCustomer;
                
                System.debug('Customer Registration Successful: ' + newCustomer.Id);
            } else {
                System.debug('Customer Registration Failed: Email already in use.');
                throw new Exception('Email already in use.');
            }
        } catch (Exception e) {
            System.debug('Error during Customer Registration: ' + e.getMessage());
        }
    }

    // Check if the provided email is already registered
    private static Boolean isEmailRegistered(String email) {
        Integer existingCustomerCount = [SELECT COUNT() FROM Customer__c WHERE Email__c = :email];
        return existingCustomerCount > 0;
    }
}
