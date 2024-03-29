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

    $scope.isIdExisted = function (newGeneratedcolour_id) {
        var index = $scope.items.findIndex(x => x.colour_id === newGeneratedcolour_id);
        if (index < 0) {
            return false;
        }
        return true;
    }

    //Manual functions
    //Add new item function
    $scope.adicionaItem = function () {
        var newGeneratedcolour_id = $scope.getRandomId($scope.items.length);
        do {
            newGeneratedcolour_id = $scope.getRandomId($scope.items.length);
        }
        while ($scope.isIdExisted(newGeneratedcolour_id));
        var today = $filter('date')(new Date(), 'dd/MM/yyyy HH:mm:ss');

        //Because aspx control doesn't allow to post html in textbox. So we will escape the html content.
        var escapedColourDescription = $scope.Escaped($scope.item.colour_description);

        $scope.items.push({
            colour_id: newGeneratedcolour_id, colour_name: $scope.item.colour_name,
            colour_description: escapedColourDescription,
            create_date: today,
        });

        $scope.addedOrUpdatedItems.push({
            colour_id: newGeneratedcolour_id, colour_name: $scope.item.colour_name,
            colour_description: escapedColourDescription,
            create_date: today,
        });

        $scope.item.colour_id = '';

        //Reset pagination
        $scope.filteredItems = $scope.items;
        $scope.totalItem = $scope.filteredItems.length;

        toastr.success("Item added successful.");
    };

    //Set item to be updated
    $scope.editarItem = function (id) {
        var index = $scope.items.findIndex(x => x.colour_id === id);
        $scope.item = $scope.items[index];
        $scope.item.create_date = $scope.GetDate($scope.item.create_date);
        //Because aspx control doesn't allow to post html in textbox. So we will escape the html content.
        $scope.item.colour_description = $scope.Unescaped($scope.item.colour_description);
        //Set data to summernote content to be editing.
        $('#colour_description_textarea').summernote('code', $scope.item.colour_description);
        $scope.edit = true;
    };

    //Apply item update function
    $scope.applyChanges = function (index) {
        var item = $scope.item;

        var escapedColourDescription = $("<div>").text(item.colour_description).html();

        //Update source item
        var item1 = $scope.items.find(x => x.colour_id == item.colour_id);
        item1.colour_name = item.colour_name;
        item1.colour_description = escapedColourDescription;
        item1.create_date = item.create_date;
      ;

        var existedUpdatedItem = $scope.addedOrUpdatedItems.find(x => x.colour_id == item.colour_id);
        if (existedUpdatedItem != null) {
            existedUpdatedItem = item1;
        } else {
            $scope.addedOrUpdatedItems.push(item1);
        }

        $scope.item = {};
        $scope.edit = false;
        toastr.success("Item updated successful.");

        //Remove summernote texarea content after update. This will help other to add new record withou confusing on old data.
        $('#colour_description_textarea').summernote('code', "");
    };

    //Delete item function
    $scope.deleteItem = function (id) {
        if (confirm('Are you sure to delete?')) {
            var index = $scope.items.findIndex(x => x.colour_id === id);

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
            $('input[id^="item-"]:checked').each(function (index, element) {
                var item = $scope.items.find(x => x.colour_id == element.value);

                if (item != null) {
                    $scope.deletedIds.push(item.colour_id);
                    var index = $scope.items.indexOf(item);
                    $scope.items.splice(index, 1);
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

    //Unescape the html content to view on client
    $scope.Unescaped = function (x) {
        var unEscapedStr = $("<div>").html(x).text();
        return unEscapedStr;
    }

    //Escape the html content to post to server
    $scope.Escaped = function (x) {
        var escapedStr = $("<div>").text(x).html();
        return escapedStr;
    }
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

