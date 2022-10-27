import { LightningElement, api, wire} from 'lwc';
import getBetsByPlayerIds from '@salesforce/apex/StatusWonController.getBetsByPlayerIds';


const columns = [
    {label: 'Bet name',fieldName:'Name',type:'Auto Number'},
    {label: 'Game', fieldName:'Game__c',type:'Master-Detail(Game)'},
    {label: 'Status', fieldName: 'Status__c', type: 'Picklist'}
]

export default class StatusWonRelated extends LightningElement {
    error;
    columns=columns;
    @api recordId;

    @wire(getBetsByPlayerIds, {playerRecordId: '$recordId'})
    bets;
}