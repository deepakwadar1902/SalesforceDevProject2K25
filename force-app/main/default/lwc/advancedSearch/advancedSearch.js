import { LightningElement, track } from 'lwc';
import searchRecords from '@salesforce/apex/AdvancedSearchController.searchRecords';

export default class AdvancedSearch extends LightningElement {
    @track selectedObject = '';
    @track records = [];
    @track error = '';
    @track currentPage = 1;
    @track totalPages = 0;
    searchKeyword = '';

    objectOptions = [
        { label: 'Opportunity', value: 'Opportunity' },
        { label: 'Account', value: 'Account' },
        { label: 'Task', value: 'Task' },
    ];

    columns = [
        { label: 'Name', fieldName: 'Name' },
        { label: 'Created Date', fieldName: 'CreatedDate', type: 'date' },
    ];

    handleInputChange(event) {
        this.searchKeyword = event.target.value;
    }

    handleObjectChange(event) {
        this.selectedObject = event.detail.value;
    }

    handleSearch() {
        if (!this.selectedObject || !this.searchKeyword) {
            this.error = 'Please provide search criteria.';
            return;
        }
        this.error = '';
        this.fetchRecords();
    }

    fetchRecords() {
        searchRecords({
            objectName: this.selectedObject,
            keyword: this.searchKeyword,
            pageNumber: this.currentPage,
        })
            .then((result) => {
                this.records = result.records;
                this.totalPages = result.totalPages;
            })
            .catch((error) => {
                this.error = error.body.message;
            });
    }

    handlePreviousPage() {
        if (this.currentPage > 1) {
            this.currentPage -= 1;
            this.fetchRecords();
        }
    }

    handleNextPage() {
        if (this.currentPage < this.totalPages) {
            this.currentPage += 1;
            this.fetchRecords();
        }
    }
}
