<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="admin_Product" %>
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
                            <h1>List of products</h1>
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
                                <th ng-click="sortBy('product_id')" style="text-decoration: underline; cursor: pointer;">Product ID</th>
                                <th ng-click="sortBy('product_name')" style="text-decoration: underline; cursor: pointer;">Name</th>
                                <th>Description</th>
                                <th>Images</th>
                                <th>Brand ID</th>
                                <th>Category ID</th>
                                <th>Model Year</th>
                                <th>List Price</th>
                                <th ng-click="sortBy('create_date')" style="text-decoration: underline; cursor: pointer;">Create Date</th>
                                <th>Create By</th>
                                <th>Publish</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="item in filteredItems | orderBy:sortField:reverseOrder | filter:searchValue | startFrom:(currentPage - 1) * numPerPage | limitTo:numPerPage" class="comprado-{{ item.product_name }}">
                                <td><input type='checkbox' ng-checked="checkall" id="item-{{ item.product_id }}" value="{{ item.product_id }}"></td>
                                <td><strong>{{ item.product_id }}</strong></td>
                                <td>{{ item.product_name }}</td>
                                <td><div style="width: 100%; height: 50px; overflow-y:auto;">{{ item.product_description }}</div></td>
                                <td>{{ item.product_images }}</td>
                                <td>{{ item.brand_id }}</td>
                                <td>{{ item.category_id }}</td>
                                <td>{{ item.model_year }}</td>
                                <td>{{ item.list_price }}</td>
                                <td>{{ item.create_date | filterdate | date:'dd/MM/yyyy hh:mm:ss' }}</td>
                                <td>{{ item.create_by }}</td>
                                <td>{{ item.is_publish }}</td>
                                <td>
                                    <a class="btn btn-warning btn-small" ng-click="editarItem(item.product_id)">
                                        <i class="icon-pencil icon-white"></i>Edit
                                    </a>
                                    <a class="btn btn-danger btn-small" ng-click="deleteItem(item.product_id)">
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
                            <th colspan="2">Product form</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Product ID: </td>
                            <td><input type="number" readonly="readonly" ng-model="item.product_id" placeholder="Product ID" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Product Name: </td>
                            <td><input type="text" ng-model="item.product_name" placeholder="Product Name" required style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Product Description: </td>
                            <td><textarea type="text" ng-model="item.product_description" placeholder="Product Description" class="input-small" cols="69" rows="10"></textarea></td>
                        </tr>
                        <tr>
                            <td>Product Images: </td>
                            <td><input type="text" ng-model="item.product_images" placeholder="Product Images" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Brand ID: </td>
                            <td><input type="number" ng-model="item.brand_id" placeholder="Brand ID" class="input-small" required style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Category ID: </td>
                            <td><input type="number" ng-model="item.category_id" placeholder="Category ID" class="input-small" required style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Model Year: </td>
                            <td><input type="number" ng-model="item.model_year" placeholder="Model Year" class="input-small" required style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>List Price: </td>
                            <td><input type="number" ng-model="item.list_price" placeholder="List Price" class="input-small" required style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Create Date: </td>
                            <td><input type="date" ng-model="item.create_date" placeholder="Create Date" class="input-small" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Create By: </td>
                            <td><input type="text" ng-model="item.create_by" placeholder="Create By" class="input-small" style="width: 500px;"></td>
                        </tr>
                        <tr>
                            <td>Publish: </td>
                            <td><input type="checkbox" ng-model="item.is_publish" class="input-small"></td>
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
            <script src="AngularJS/app/product.js"></script>
            <div runat="server" id="Server_Data" style="display: none;"></div>
        </div>
    </form>
</asp:Content>

