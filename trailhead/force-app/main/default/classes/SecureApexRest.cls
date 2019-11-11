@RestResource(urlMapping='/secureApexRest')
global with sharing class SecureApexRest {
    @HttpGet
    global static Contact doGet(){
        Id recordId = RestContext.request.params.get('id');
        Contact result;
        List<Contact> results = new List<Contact>();
        if (recordId == null){
            throw new FunctionalException('Id parameter is required');
        }
        Try
        {
            results = [SELECT id, Name, Secret_Key__c FROM Contact WHERE Id = :recordId WITH SECURITY_ENFORCED];
        }
        catch (QueryException e){
            new SecurityException('You don\'t have access to all contact fields required to use this API');
        }
        if (!results.isEmpty()) {
                result = results[0];
            }
        return result;
    }
    public class FunctionalException extends Exception{}
    public class SecurityException extends Exception{}
}