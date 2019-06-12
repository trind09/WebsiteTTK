<%@ Page Title="Order" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="Order.aspx.cs" Inherits="admin_Order" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<form id="form1" runat="server">
        <asp:Button ID="btnApplyAllChanges" runat="server" Text="Apply all changes"" CssClass="btn btn-success" OnClientClick="return AskForApplyAllChange();" OnClick="btnApplyAllChanges_Click"/>
    </form>--%>
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
                            <th>ID</th>
                            <th>ProductID</th>
                            <th>CreatedBy</th>
                            <th>PriceTotal</th>
                            <th>CreatedDate</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="item in filteredItems | filter:searchValue | startFrom:(currentPage - 1) * numPerPage | limitTo:numPerPage" class="comprado-{{ item.Title }}">
                            <td><input type='checkbox' ng-checked="checkall" id="item-{{ item.ID }}" value="{{ item.ID }}"></td>
                            <td><strong>{{ item.ID }}</strong></td>
                            <td>{{ item.ProductID }}</td>
                            <td>{{ item.CreatedBy }}</td>
                            <td>{{ item.PriceTotal }}</td>
                            <td>{{ item.CreatedDate | filterdate | date:'dd/MM/yyyy hh:mm:ss' }}</td>
                            <td>
                                <button class="btn btn-warning btn-small" ng-click="editarItem(item.ID)">
                                    <i class="icon-pencil icon-white"></i>Edit
                                </button>
                                <button class="btn btn-danger btn-small" ng-click="deleteItem(item.ID)">
                                    <i class="icon-trash icon-white"></i>Delete
                                </button>
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

            <form class="row form-inline" name="validarValoresPreenchidos">
                <table style="width: 100%">
                    <thead>
                        <tr>
                            <th colspan="2">Product form</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>ID: </td>
                            <td><input type="text" readonly="readonly" ng-model="item.ID" placeholder="ID" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>ProductID: </td>
                            <td><input type="text" ng-model="item.ProductID" placeholder="ProductID" required style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>CreatedBy: </td>
                            <td><textarea type="text" ng-model="item.CreatedBy" placeholder="CreatedBy" class="input-small" cols="69" rows="1"></textarea></td>
                        </tr>
                        <tr>
                            <td>PriceTotal: </td>
                            <td><input type="number" ng-model="item.PriceTotal" placeholder="PriceTotal" class="input-small" required style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td colspan="2">
                                <button ng-hide="edit" class="btn btn-success" ng-disabled="validarValoresPreenchidos.$invalid" ng-click="adicionaItem()">
                                    <i class="icon-plus icon-white"></i>Add
                                </button>
                                <button ng-show="edit" class="btn btn-success" ng-disabled="validarValoresPreenchidos.$invalid" ng-click="applyChanges()">
                                    <i class="icon-ok icon-white"></i>Update
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </form>
        </div>
        <script>
            var Server_Daa = {};
            $(document).ready(function () {
                var data = $("#<%=Server_Data.ClientID%>").text();
                Server_Data = jQuery.parseJSON(data);
                var TodoController = 'div[ng-controller="TodoController"]';
                var scope = angular.element(TodoController).scope();
                var myFilter = scope.myFilter;
                scope.items = Server_Data;
                scope.copyOfItems = Server_Data;
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
            });

            function AskForApplyAllChange() {
                if (confirm('Are you sure to apply all change?')) {
                    var TodoController = 'div[ng-controller="TodoController"]';
                    var scope = angular.element(TodoController).scope();
                    $("#<%=Server_Data1.ClientID%>").text(JSON.stringify(scope.copyOfItems));
                    return true;
                }
                return false;
            }
        </script>
        <script src="AngularJS/lib/toastr.min.js"></script>
        <script src="AngularJS/app/Orderr.js"></script>
        <div runat="server" id="Server_Data" style="display: none;"></div>
        <div runat="server" id="Server_Data1" style="display: none;"></div>
    </div>
</asp:Content>

