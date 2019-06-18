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

    $scope.isIdExisted = function (newGeneratedproduct_id) {
        var index = $scope.items.findIndex(x => x.product_id === newGeneratedproduct_id);
        console.log(index);
        if (index < 0) {
            return false;
        }
        return true;
    }

    //Manual functions
    //Add new item function
    $scope.adicionaItem = function () {
        var newGeneratedproduct_id = $scope.getRandomId($scope.items.length);
        do {
            newGeneratedproduct_id = $scope.getRandomId($scope.items.length);
        }
        while ($scope.isIdExisted(newGeneratedproduct_id));
        console.log(newGeneratedproduct_id);
        var today = $filter('date')(new Date(), 'dd/MM/yyyy HH:mm:ss');
        
        $scope.items.push({
            product_id: newGeneratedproduct_id, product_name: $scope.item.product_name, product_images: $scope.item.product_images,
            product_description: $scope.item.product_description, brand_id: $scope.item.brand_id,
            category_id: $scope.item.category_id, model_year: $scope.item.model_year, list_price: $scope.item.list_price,
            create_date: today, create_by: $scope.item.create_by, is_publish: $scope.item.is_publish
        });

        $scope.addedOrUpdatedItems.push({
            product_id: newGeneratedproduct_id, product_name: $scope.item.product_name, product_images: $scope.item.product_images,
            product_description: $scope.item.product_description, brand_id: $scope.item.brand_id,
            category_id: $scope.item.category_id, model_year: $scope.item.model_year, list_price: $scope.item.list_price,
            create_date: today, create_by: $scope.item.create_by, is_publish: $scope.item.is_publish
        });

        $scope.item.product_id = '';
        
        //Reset pagination
        $scope.filteredItems = $scope.items;
        $scope.totalItem = $scope.filteredItems.length;

        toastr.success("Item added successful.");
    };

    //Set item to be updated
    $scope.editarItem = function (id) {
        var index = $scope.items.findIndex(x => x.product_id === id);
        $scope.item = $scope.items[index];
        $scope.item.create_date = $scope.GetDate($scope.item.create_date);
        $scope.edit = true;
    };

    //Apply item update function
    $scope.applyChanges = function (index) {
        var item = $scope.item;

        //Update source item
        var item1 = $scope.items.find(x => x.product_id == item.product_id);
        item1.product_name = item.product_name;
        item1.product_description = item.product_description;
        item1.product_images = item.product_images;
        item1.brand_id = item.brand_id;
        item1.category_id = item.category_id;
        item1.product_images = item.product_images;
        item1.list_price = item.list_price;
        item1.create_date = item.create_date;
        item1.create_by = item.create_by;
        item1.is_publish = item.is_publish;

        var existedUpdatedItem = $scope.addedOrUpdatedItems.find(x => x.product_id == item.product_id);
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
            var index = $scope.items.findIndex(x => x.product_id === id);

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
                    var item = $scope.items.find(x => x.product_id == element.value);

                    if (item != null) {
                        $scope.deletedIds.push(item.product_id);
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

