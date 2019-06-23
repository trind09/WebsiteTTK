﻿var app = angular.module('app', ['ui.bootstrap']);

app.controller('TodoController', ['$scope', '$filter', function ($scope, $filter) {
    $scope.filteredItems = [];
    $scope.currentPage = 0;
    $scope.numPerPage = 10;
    $scope.currentNumPerPage = 0;
    $scope.item = {};
    $scope.items = [];
    $scope.copyOfItems = [];
    $scope.addedOrUpdatedItems = [];
    $scope.deletedIds = [];
    $scope.searchValue = '';
    $scope.myFilter = $filter;
    $scope.totalItem = 0;
    $scope.checkall = false;
    $scope.reverseOrder = true;
    $scope.sortField = 'create_date';

    $scope.getRandomId = function (min) {
        min = Math.ceil(min);
        return Math.floor(Math.random() * (min + 1)) + min;
    }

    $scope.isIdExisted = function (newGeneratedcustomer_id) {
        var index = $scope.items.findIndex(x => x.customer_id === newGeneratedcustomer_id);
        console.log(index);
        if (index < 0) {
            return false;
        }
        return true;
    }

    //Manual functions
    //Add new item function
    $scope.adicionaItem = function () {
        var newGeneratedcustomer_id = $scope.getRandomId($scope.items.length);
        do {
            newGeneratedcustomer_id = $scope.getRandomId($scope.items.length);
        }
        while ($scope.isIdExisted(newGeneratedcustomer_id));
        console.log(newGeneratedcustomer_id);
        var today = $filter('date')(new Date(), 'dd/MM/yyyy HH:mm:ss');

        $scope.items.push({
            customer_id: newGeneratedcustomer_id, first_name: $scope.item.first_name, last_name: $scope.item.last_name,
            phone: $scope.item.phone, email: $scope.item.email, street: $scope.item.street,
            city: $scope.item.city, zip_code: $scope.item.zip_code, address: $scope.item.address
        });

        $scope.addedOrUpdatedItems.push({
            customer_id: newGeneratedcustomer_id, first_name: $scope.item.first_name, last_name: $scope.item.last_name,
            phone: $scope.item.phone, email: $scope.item.email, street: $scope.item.street,
            city: $scope.item.city, zip_code: $scope.item.zip_code, address: $scope.item.address
        });

        $scope.item.customer_id = '';

        //Reset pagination
        $scope.filteredItems = $scope.items;
        $scope.totalItem = $scope.filteredItems.length;

        toastr.success("Item added successful.");
    };

    //Set item to be updated
    $scope.editarItem = function (id) {
        var index = $scope.items.findIndex(x => x.customer_id === id);
        $scope.item = $scope.items[index];
        $scope.edit = true;
    };

    //Apply item update function
    $scope.applyChanges = function (index) {
        var item = $scope.item;

        //Update source item
        var item1 = $scope.items.find(x => x.customer_id == item.customer_id);
        item1.first_name = item.first_name;
        item1.last_name = item.last_name;
        item1.phone = item.phone;
        item1.email = item.email;
        item1.street = item.street;
        item1.city = item.city;
        item1.zip_code = item.zip_code;
        item1.address = item.address;
        var existedUpdatedItem = $scope.addedOrUpdatedItems.find(x => x.customer_id == item.customer_id);
        if (existedUpdatedItem != null) {
            existedUpdatedItem = item1;
        } else {
            $scope.addedOrUpdatedItems.push(item1);
        }

        $scope.item = {};
        $scope.edit = false;
        toastr.success("Item updated successful.");
    };

    //Delete item function
    $scope.deleteItem = function (id) {
        if (confirm('Are you sure to delete?')) {
            var index = $scope.items.findIndex(x => x.customer_id === id);
            var item = $scope.items[index];



            $scope.items.splice(index, 1);
            $scope.filteredItems = $scope.items;
            $scope.totalItem = $scope.filteredItems.length;
            toastr.success("Item removed successful.");
            $scope.deletedIds.push(id);

            //Turn off edit to prevent update deleted record
            $scope.edit = false;
        }
    };

    //Remove all checked record
    $scope.removeAll = function () {
        if (confirm('Are you sure to delete?')) {
            $('input[id^="item-"]').each(function (index, element) {
                if (element.checked) {
                    var item = $scope.items.find(x => x.customer_id == element.value);

                    if (item != null) {
                        $scope.deletedIds.push(item.customer_id);
                        var index = $scope.items.indexOf(item);
                        $scope.items.splice(index, 1);
                    }
                }
            });

            //Reset pagination
            $scope.filteredItems = $scope.items;
            $scope.totalItem = $scope.filteredItems.length;
            toastr.success("Items removed successful.");
        }
    };

    //Sort function
    $scope.sortBy = function (sortField) {
        $scope.reverseOrder = ($scope.sortField === sortField) ? !$scope.reverseOrder : false;
        $scope.sortField = sortField;
    };

    //Convert database date to jquery datetime function. Used for scope only
    $scope.GetDate = function (x) {
        if (x != null) {
            var re = /\/Date\(([0-9]*)\)\//;
            if (x instanceof Date) {
                return x;
            } else {
                var m = x.match(re);
                if (m) return new Date(parseInt(m[1]));
                else return x;
            }
        } else {
            return null;
        }
    };
}]);

app.filter('startFrom', function () {
    return function (input, start) {
        if (start < 0) {
            start = 0;
        }
        return input.slice(start);
    }
});

app.filter("filterdate", function () {
    var re = /\/Date\(([0-9]*)\)\//;
    return function (x) {
        if (x != null) {
            if (x instanceof Date) {
                return x;
            } else {
                var m = x.match(re);
                if (m) return new Date(parseInt(m[1]));
                else return x;
            }
        } else {
            return "";
        }
    };
});

