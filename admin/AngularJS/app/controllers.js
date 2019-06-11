var app = angular.module('app', ['ui.bootstrap']);

app.controller('TodoController', ['$scope', '$filter', function ($scope, $filter) {
    $scope.filteredItems = [];
    $scope.currentPage = 0;
    $scope.numPerPage = 10;a
    $scope.currentNumPerPage = 0;
    $scope.item = {};
    $scope.items = [];
    $scope.copyOfItems = [];
    $scope.searchValue = '';
    $scope.myFilter = $filter;
    $scope.totalItem = 0;
    $scope.checkall = false;

    //Manual functions
    //Add new item function
    $scope.adicionaItem = function () {
        var newGeneratedID = Math.random().toString(36).substr(2, 9);
        var today = $filter('date')(new Date(), 'dd/MM/yyyy HH:mm:ss');
        
        $scope.items.push({
            ID: newGeneratedID, Title: $scope.item.Title, Description: $scope.item.Description, Status: $scope.item.Status,
            Publish: $scope.item.Publish, Images: $scope.item.Images, RelativeProductIds: $scope.item.RelativeProductIds,
            Price: $scope.item.Price, Currency: $scope.item.Currency, CreatedDate: today, IsDelete: false
        });
        $scope.item.ID = $scope.item.ID = '';
        
        //Reset pagination
        $scope.filteredItems = $scope.items;
        $scope.totalItem = $scope.filteredItems.length;

        toastr.success("Item added successful.");
    };

    //Set item to be updated
    $scope.editarItem = function (id) {
        var index = $scope.items.findIndex(x => x.ID === id);
        $scope.item = $scope.items[index];
        $scope.edit = true;
    };

    //Apply item update function
    $scope.applyChanges = function (index) {
        var item = $scope.item;

        //Update source item
        var item1 = $scope.copyOfItems.find(x => x.ID == item.ID);
        item1.Title = item.Title;
        item1.Description = item.Description;
        item1.Status = item.Status;
        item1.Publish = item.Publish;
        item1.Images = item.Images;
        item1.RelativeProductIds = item.RelativeProductIds;
        item1.Price = item.Price;
        item1.Currency = item.Currency;

        $scope.item = {};
        $scope.edit = false;
        toastr.success("Item updated successful.");
    };

    //Delete item function
    $scope.deleteItem = function (id) {
        if (confirm('Are you sure to delete?')) {
            var index = $scope.items.findIndex(x => x.ID === id);
            var item = $scope.items[index];

            //Update source item
            var item1 = $scope.copyOfItems.find(x => x.ID == item.ID);
            item1.IsDelete = true;

            $scope.items.splice(index, 1);
            $scope.filteredItems = $scope.items;
            $scope.totalItem = $scope.filteredItems.length;
            toastr.success("Item removed successful.");

            //Turn off edit to prevent update deleted record
            $scope.edit = false;
        }
    };

    //Remove all checked record
    $scope.removeAll = function () {
        if (confirm('Are you sure to delete?')) {
            $('input[id^="item-"]').each(function (index, element) {
                var item = $scope.items.find(x => x.ID == element.value);

                //Update source item
                var item1 = $scope.copyOfItems.find(x => x.ID == element.value);
                item1.IsDelete = true;

                var index = $scope.items.indexOf(item);
                $scope.items.splice(index, 1);
            });

            //Reset pagination
            $scope.filteredItems = $scope.items;
            $scope.totalItem = $scope.filteredItems.length;
            toastr.success("Items removed successful.");
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
        var m = x.match(re);
        if (m) return new Date(parseInt(m[1]));
        else return x;
    };
});