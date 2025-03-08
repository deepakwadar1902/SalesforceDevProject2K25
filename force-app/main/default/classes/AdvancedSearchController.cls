public with sharing class AdvancedSearchController {
    @AuraEnabled(cacheable=true)
    public static Map<String, Object> searchRecords(String objectName, String keyword, Integer pageNumber) {
        Integer pageSize = 10;
        Integer offset = (pageNumber - 1) * pageSize;

        String query = 'SELECT Name, CreatedDate FROM ' + objectName +
                       ' WHERE Name LIKE \'%' + String.escapeSingleQuotes(keyword) + '%\' ' +
                       'ORDER BY CreatedDate LIMIT ' + pageSize + ' OFFSET ' + offset;

        List<SObject> records = Database.query(query);
        Integer totalRecords = [SELECT COUNT() FROM Account WHERE Name LIKE :('%' + keyword + '%')];

        Map<String, Object> result = new Map<String, Object>();
        result.put('records', records);
        result.put('totalPages', (Integer) Math.ceil((Double) totalRecords / pageSize));

        return result;
    }
}
