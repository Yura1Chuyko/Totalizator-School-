import { LightningElement, wire} from 'lwc';
import getBetsList from '@salesforce/apex/StatusWon/getBetsList';


const columns = [
    {label: 'Bet name',fieldName:'Name',type:'Auto Number'},
    {label: 'Game', fieldName:'Game__c',type:'Master-Detail(Game)'},
    {label: 'Status', fieldName: 'Status__c', type: 'Picklist'}
]

export default class StatusWonRelated extends LightningElement {
    error;
    columns=columns;

    @wire(getBetsList)
    data;
}