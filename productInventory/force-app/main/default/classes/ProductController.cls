public with sharing class ProductController {
    @AuraEnabled(cacheable=true)
    public static List<Product__c> getInventory(String searchKey) {
        String search = '%' + searchKey + '%';

        if (!Schema.sObjecttype.Product__c.isAccessible()) {
            throw new AuraHandledException('You do not have access to Product__c records.');
        }
        if (!Schema.SObjectType.Product__c.fields.Id.isAccessible() || !Schema.SObjectType.Product__c.fields.Name.isAccessible() || !Schema.SObjectType.Product__c.fields.Manufacturer__c.isAccessible() || !Schema.SObjectType.Product__c.fields.Quantity__c.isAccessible()) {
            throw new AuraHandledException('You do not have access to the Id field of Product__c.');
        }
        return [
            SELECT Id, Name, Manufacturer__c, Quantity__c
            FROM Product__c
            WHERE Manufacturer__c LIKE :search
            WITH USER_MODE
            ORDER BY Name 
        ];
    }
}