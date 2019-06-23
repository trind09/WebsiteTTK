<%@ Page Title="Orders" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="Orders.aspx.cs" Inherits="admin_Orders" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <form id="form1" runat="server">
        <asp:linkbutton runat="server" CssClass="btn btn-success" OnClientClick="return AskForApplyAllChange();" OnClick="btnApplyAllChanges_Click">Apply all changes</asp:linkbutton>
        <asp:textbox id="Server_Data1" runat="server" enable="false"></asp:textbox>
        <asp:textbox id="txtDeletedIds" runat="server" enable="false"></asp:textbox>
        <link rel="stylesheet" href="AngularJS/css/toastr.css">
        <link rel="stylesheet" href="AngularJS/css/application.css">
        <div>
            <div class="container" ng-app="app" ng-controller="TodoController">
                <div class="row">
                    <div class="page-header">
                        <div class="span9">
                            <h1>List of Orders</h1>
                        </div>
                        <div class="span3">
                            <table>
                                <tr>
                                    <td>Search: </td>
                                    <td><input ng-model="searchValue" id="search" class="form-control" placeholder="Filter text"></td>
                                </tr>
                                <tr>
                                    <td>&nbsp;</td>
                                    <td>&nbsp;</td>
                                </tr>
                                <tr>
                                    <td>Numper per page</td>
                                    <td>
                                        <select ng-model="numPerPage" id="numPerPage" class="form-control">
                                            <option value="5">5</option>
                                            <option value="10">10</option>
                                            <option value="15">15</option>
                                            <option value="20">20</option>
                                         </select>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="row">
                    <a ng-click="removeAll()" style="cursor: pointer;">Delete all</a>
                    <table id="lista-compras" class="table table-striped">
                        <thead>
                            <tr>
                                <th><input type='checkbox' value='' ng-model='checkall'></th>
                                <th >Order ID</th>
                                <th>Customer ID</th>
                                <th>Order Status</th>
                                <th ng-click="sortBy('order_date')" style="text-decoration: underline; cursor: pointer;">Order Date</th>
                                <th ng-click="sortBy('required_date')" style="text-decoration: underline; cursor: pointer;">Required Date</th>
                                <th>Shipped Date</th>
                                <th>Store ID</th>
                                <th>Staff ID<th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="item in filteredItems | orderBy:sortField:reverseOrder | filter:searchValue | startFrom:(currentPage - 1) * numPerPage | limitTo:numPerPage" class="comprado-{{ item.order_id }}">
                                <td><input type='checkbox' ng-checked="checkall" id="item-{{ item.order_id }}" value="{{ item.order_id }}"></td>
                                <td><strong>{{ item.order_id }}</strong></td>
                                <td>{{ item.customer_id }}</td>
                                <td>{{ item.order_status }}</td>
                                <td>{{ item.order_date | filterdate | date:'dd/MM/yyyy hh:mm:ss' }}</td>
                                <td>{{ item.required_date | filterdate | date:'dd/MM/yyyy hh:mm:ss'}}</td>
                                <td>{{ item.shipped_date | filterdate | date:'dd/MM/yyyy hh:mm:ss'}}</td>
                                <td>{{ item.store_id }}</td>
                                <td>{{ item.staff_id }}</td>
                                <td>
                                    <a class="btn btn-warning btn-small" ng-click="editarItem(item.order_id)">
                                        <i class="icon-pencil icon-white"></i>Edit
                                    </a>
                                    <a class="btn btn-danger btn-small" ng-click="deleteItem(item.order_id)">
                                        <i class="icon-trash icon-white"></i>Delete
                                    </a>
                                </td>
                            </tr>
                            <tr>
                                <td colspan="12">
                                    <h4>{{filteredItems.length}} total</h4>
                                    <!-- pager -->
                                    <pagination 
                                      ng-model="currentPage"
                                      total-items="totalItem"
                                      items-per-page="numPerPage"  
                                      class="pagination-sm">
                                    </pagination>
                                </td>
                            </tr>
                        </tbody>
                    </table>
                </div>

                <table style="width: 100%">
                    <thead>
                        <tr>
                            <th colspan="2">Order form</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Order ID: <span style="color:red">*</span></td>
                            <td><input type="number" ng-model="item.order_id" placeholder="Order ID" style="width: 500px;" required></td>
                        </tr>
                        <tr>
                            <td>Customer ID: <span style="color:red">*</span></td>
                            <td><input type="text" ng-model="item.customer_id" placeholder="Customer Name" required style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Order Status: </td>
                            <td><input type="text" ng-model="item.order_status" placeholder="Order Status" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>order_date: </td>
                            <td><input type="date" ng-model="item.order_date" placeholder="Order date" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Required Date: </td>
                            <td><input type="date" ng-model="item.required_date" placeholder="Required date" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Shipped Date: </td>
                            <td><input type="date" ng-model="item.shipped_date" placeholder="Shipped date" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Store ID: </td>
                            <td><input type="text" ng-model="item.store_id" placeholder="Store ID" class="input-small" style="width: 500px;"></td>
                        </tr>
                         <tr>
                            <td>Staff ID: </td>
                            <td><input type="text" ng-model="item.staff_id" placeholder="Staff ID" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <a ng-hide="edit" class="btn btn-success" ng-disabled="validarValoresPreenchidos.$invalid" ng-click="adicionaItem()">
                                    <i class="icon-plus icon-white"></i>Add
                                </a>
                                <a ng-show="edit" class="btn btn-success" ng-disabled="validarValoresPreenchidos.$invalid" ng-click="applyChanges()">
                                    <i class="icon-ok icon-white"></i>Update
                                </a>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>
            <script>
                var Server_Data = {};
                $(document).ready(function () {
                    var data = $("#<%=Server_Data.ClientID%>").text();
                    Server_Data = jQuery.parseJSON(data);
                    var TodoController = 'div[ng-controller="TodoController"]';
                    var scope = angular.element(TodoController).scope();
                    var myFilter = scope.myFilter;
                    scope.items = Server_Data;
                    //Copy a new item from existing object. This could help to reduce from update to this list when you are updated orginal list
                    //scope.copyOfItems = Object.assign([], Server_Data);
                    scope.totalItem = scope.items.length;

                    scope.$watch('searchValue', function () {
                        scope.filteredItems = myFilter('filter')(scope.items, scope.searchValue);
                        scope.totalItem = scope.filteredItems.length;
                    });

                    scope.$watch('numPerPage', function () {
                        if (scope.currentNumPerPage != scope.numPerPage) {
                            scope.currentPage = 0;
                            scope.currentNumPerPage = scope.numPerPage;
                            scope.filteredItems = myFilter('filter')(scope.items, scope.searchValue);
                            scope.totalItem = scope.filteredItems.length;
                        }
                    });

                    scope.$apply();

                    DisableSeverControls();
                });

                function AskForApplyAllChange() {
                    if (confirm('Are you sure to apply all change?')) {
                        var TodoController = 'div[ng-controller="TodoController"]';
                        var scope = angular.element(TodoController).scope();
                        $("#<%=Server_Data1.ClientID%>").val(JSON.stringify(scope.addedOrUpdatedItems));
                        $("#<%=txtDeletedIds.ClientID%>").val(JSON.stringify(scope.deletedIds));
                        return true;
                    }
                    return false;
                }

                function DisableSeverControls() {
                    $("#<%=Server_Data1.ClientID%>").keypress(function(e) {
                        e.preventDefault();
                    });

                    $("#<%=txtDeletedIds.ClientID%>").keypress(function(e) {
                        e.preventDefault();
                    });
                }
            </script>
            <script src="AngularJS/lib/toastr.min.js"></script>
            <script src="AngularJS/app/orders.js"></script>
            <div runat="server" id="Server_Data" style="display: none;"></div>
        </div>
    </form>
</asp:Content>

