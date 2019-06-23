<%@ Page Title="Store" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="Store.aspx.cs" Inherits="admin_Store" %>
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
                            <h1>List of Store</h1>
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
                                <th ng-click="sortBy('store_id')" style="text-decoration: underline; cursor: pointer;">Store ID</th>
                                <th ng-click="sortBy('store_name')" style="text-decoration: underline; cursor: pointer;">Store Name</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Street</th>
                                <th>City</th>
                                <th>Zip Code/th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="item in filteredItems | orderBy:sortField:reverseOrder | filter:searchValue | startFrom:(currentPage - 1) * numPerPage | limitTo:numPerPage" class="comprado-{{ item.store_id }}">
                                <td><input type='checkbox' ng-checked="checkall" id="item-{{ item.store_id }}" value="{{ item.store_id }}"></td>
                                <td><strong>{{ item.store_id }}</strong></td>
                                <td>{{ item.store_name }}</td>
                                <td>{{ item.phone }}</td>
                                <td>{{ item.email}}</td>
                                <td>{{ item.street}}</td>
                                <td>{{ item.city }}</td>
                                <td>{{ item.zip_code }}</td>
                                <td>
                                    <a class="btn btn-warning btn-small" ng-click="editarItem(item.store_id)">
                                        <i class="icon-pencil icon-white"></i>Edit
                                    </a>
                                    <a class="btn btn-danger btn-small" ng-click="deleteItem(item.store_id)">
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
                            <th colspan="2">Store form</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>StoreID: <span style="color:red">*</span></td>
                            <td><input type="number" ng-model="item.store_id" placeholder="Store ID" style="width: 500px;" required></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Store Name: <span style="color:red">*</span></td>
                            <td><input type="text" ng-model="item.store_name" placeholder="Store Name" required style="width: 500px;"></td>
                            <td>
                                 <form>
                                     <label>Store Name:</label>
                                     <select class="country" >
                                         <option value="usa">United States</option>
                                         <option value="india">India</option>
                                         <option value="uk">United Kingdom</option>
                                     </select>
                                 </form>
                            </td>
                        </tr>
                        <tr>
                            <td>Phone: </td>
                            <td><input type="text" ng-model="item.phone" placeholder="Phone" style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Email: </td>
                            <td><input type="email" ng-model="item.email" placeholder="Email" style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Street: </td>
                            <td><input type="text" ng-model="item.street" placeholder="Street" style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>City: </td>
                            <td><input type="text" ng-model="item.city" placeholder="City" style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Zip Code: </td>
                            <td><input type="text" ng-model="item.zip_code" placeholder="Zip Code" class="input-small" style="width: 500px;"></td>
                            <td></td>
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
            <script src="AngularJS/app/store.js"></script>
            <div runat="server" id="Server_Data" style="display: none;"></div>
        </div>
    </form>
</asp:Content>
