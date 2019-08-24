var app = angular.module('app', ['ui.bootstrap']);

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

    $scope.isIdExisted = function (newGeneratedorder_id) {
        var index = $scope.items.findIndex(x => x.order_id === newGeneratedorder_id);
        console.log(index);
        if (index < 0) {
            return false;
        }
        return true;
    }

    //Manual functions
    //Add new item function
    $scope.adicionaItem = function () {
        var newGeneratedorder_id = $scope.getRandomId($scope.items.length);
        do {
            newGeneratedorder_id = $scope.getRandomId($scope.items.length);
        }
        while ($scope.isIdExisted(newGeneratedorder_id));
        console.log(newGeneratedorder_id);
        var today = $filter('date')(new Date(), 'dd/MM/yyyy HH:mm:ss');

        $scope.items.push({
            order_id: newGeneratedorder_id, customer_id: $scope.item.customer_id, order_status: $scope.item.order_status,
            order_date: $scope.item.order_date, required_date: $scope.item.required_date, shipped_date: $scope.item.shipped_date,
            store_id: $scope.item.store_id, staff_id: $scope.item.staff_id, order_discount: $scope.item.order_discount, order_discount_is_fixed: $scope.item.order_discount_is_fixed
        });

        $scope.addedOrUpdatedItems.push({
            order_id: newGeneratedorder_id, customer_id: $scope.item.customer_id, order_status: $scope.item.order_status,
            order_date: $scope.item.order_date, required_date: $scope.item.required_date, shipped_date: $scope.item.shipped_date,
            store_id: $scope.item.store_id, staff_id: $scope.item.staff_id, order_discount: $scope.item.order_discount, order_discount_is_fixed: $scope.item.order_discount_is_fixed
        });

        $scope.item.order_id = '';

        //Reset pagination
        $scope.filteredItems = $scope.items;
        $scope.totalItem = $scope.filteredItems.length;

        toastr.success("Item added successful.");
    };

    //Set item to be updated
    $scope.editarItem = function (id) {
        var index = $scope.items.findIndex(x => x.order_id === id);
        $scope.item = $scope.items[index];
        $scope.edit = true;
    };

    //Apply item update function
    $scope.applyChanges = function (index) {
        var item = $scope.item;

        //Update source item
        var item1 = $scope.items.find(x => x.order_id == item.order_id);
        item1.customer_id = item.customer_id;
        item1.order_status = item.order_status;
        item1.order_date = item.order_date;
        item1.required_date = item.required_date;
        item1.shipped_date = item.shipped_date;
        item1.store_id = item.store_id;
        item1.staff_id = item.staff_id;
        item1.order_discount = item.order_discount;
        item1.order_discount_is_fixed = item.order_discount_is_fixed;
        var existedUpdatedItem = $scope.addedOrUpdatedItems.find(x => x.order_id == item.order_id);
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
            var index = $scope.items.findIndex(x => x.order_id === id);
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
                    var item = $scope.items.find(x => x.order_id == element.value);

                    if (item != null) {
                        $scope.deletedIds.push(item.order_id);
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

