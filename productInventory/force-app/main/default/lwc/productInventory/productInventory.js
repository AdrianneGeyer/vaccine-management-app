import { LightningElement, track, wire } from 'lwc';
import getInventory from '@salesforce/apex/ProductController.getInventory';

const COLUMNS = [
    { label: 'Product Name', fieldName: 'Name' },
    { label: 'Manufacturer', fieldName: 'Manufacturer__c' },
    { label: 'Quantity Available', fieldName: 'Quantity__c', type: 'number' }
];

export default class ProductInventory extends LightningElement {
    @track searchKey = '';
    @track products;
    @track error;
    columns = COLUMNS;

    @wire(getInventory, { searchKey: '$searchKey' })
    wiredProducts({ error, data }) {
        if (data) {
            this.products = data;
            this.error = undefined;
        } else if (error) {
            this.error = error.body.message;
            this.products = undefined;
        }
    }

    handleSearchChange(event) {
        this.searchKey = event.target.value;
    }
}
