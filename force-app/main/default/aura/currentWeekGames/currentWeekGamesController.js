({        
    init: function (cmp, event, helper) {
        cmp.set('v.columns', [
            {label: 'Name', fieldName: 'Name', type: 'Text'},
            {label: 'Total Money Bet', fieldName: 'Total_Money_Bet__c', type: 'Number'},
            {label: 'Total Income', fieldName: 'Total_Income__c', type: 'Number'},
            {label: 'Start Date', fieldName: 'Start_Date__c', type: 'DateTime'}
        ]);
        helper.getData(cmp);
    }
    
});