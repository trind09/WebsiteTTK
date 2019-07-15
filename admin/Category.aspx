﻿<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="Category.aspx.cs" Inherits="admin_Category" %>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder0" runat="Server">
    <title>Category Management</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <!--SummerNote rich text box library-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
    <!--SummerNote rich text box library-->
    <form id="form1" runat="server">
        <asp:linkbutton runat="server" CssClass="btn btn-success" OnClientClick="return AskForApplyAllChange();" OnClick="btnApplyAllChanges_Click">Apply all changes</asp:linkbutton>
        <asp:textbox id="Category_Data_To_Post_To_Server" runat="server" enable="false"></asp:textbox>
        <asp:textbox id="txtDeletedIds" runat="server" enable="false"></asp:textbox>
        <link rel="stylesheet" href="AngularJS/css/toastr.css">
        <link rel="stylesheet" href="AngularJS/css/application.css">
        <div>
            <div class="container" ng-app="app" ng-controller="TodoController">
                <div class="row">
                    <div class="page-header">
                        <div class="span9">
                            <h1>List of categories</h1>
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
                                <th ng-click="sortBy('category_id')" style="text-decoration: underline; cursor: pointer;">Category ID</th>
                                <th ng-click="sortBy('category_name')" style="text-decoration: underline; cursor: pointer;">Name</th>
                                <th>Images</th>
                                <th>URL</th>
                                <th>Parent ID</th>
                                <th ng-click="sortBy('create_date')" style="text-decoration: underline; cursor: pointer;">Create Date</th>
                                <th title="If this is true, this category can be shown to client!">Publish</th>
                                <th title="If this is true, this category is used on Mega Menu of Home Page">Is Menu?</th>
                                <th title="If this is true, this category is used as a label on Mega Menu of Home Page">Is Label?</th>
                                <th title="Store that this category belong to">Store</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="item in filteredItems | orderBy:sortField:reverseOrder | filter:searchValue | startFrom:(currentPage - 1) * numPerPage | limitTo:numPerPage" class="comprado-{{ item.category_name }}">
                                <td><input type='checkbox' ng-checked="checkall" id="item-{{ item.category_id }}" value="{{ item.category_id }}"></td>
                                <td><strong>{{ item.category_id }}</strong></td>
                                <td>{{ item.category_name }}</td>
                                <td><a style="cursor: pointer;" ng-click="openUploadImagePanel(item.category_id)">Show Images</a></td>
                                <td>{{ item.category_url }}</td>
                                <td>{{ item.parent_id }}</td>
                                <td>{{ item.create_date | filterdate | date:'dd/MM/yyyy hh:mm:ss' }}</td>
                                <td>{{ item.is_publish }}</td>
                                <td>{{ item.is_menu }}</td>
                                <td>{{ item.is_label }}</td>
                                <td>{{ convertStoreIDToStoreName(item.store_id) }}</td>
                                <td>
                                    <a class="btn btn-warning btn-small" ng-click="editarItem(item.category_id)">
                                        <i class="icon-pencil icon-white"></i>Edit
                                    </a>
                                    <a class="btn btn-danger btn-small" ng-click="deleteItem(item.category_id)">
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
                            <th colspan="3">Category form</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Category ID: </td>
                            <td><input type="number" readonly="readonly" ng-model="item.category_id" placeholder="Category ID" style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Category Name: </td>
                            <td><input type="text" ng-model="item.category_name" placeholder="Category Name" required style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Category Description: </td>
                            <td><textarea id="category_description_textarea" name="editordata" ng-model="item.category_description"></textarea></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Category Images: </td>
                            <td><a style="cursor: pointer;" ng-show="edit" ng-click="openUploadImagePanel(item.category_id)">Show Images</a></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Category URL: </td>
                            <td><input type="text" ng-model="item.category_url" placeholder="Category URL" required style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Parent ID: </td>
                            <td><input type="text" readonly ng-model="item.parent_id" placeholder="Parent_Category ID" class="input-small" required style="width: 500px;"></td>
                            <td>Select parent category: 
                                <select ng-model="item.parent_id">
                                  <option ng-repeat="x in parentCategories" value="{{x.category_id}}">{{x.category_name}}</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Store ID: </td>
                            <td><input type="text" readonly ng-model="item.store_id" placeholder="Store ID" class="input-small" required style="width: 500px;"></td>
                            <td>Select store: 
                                <select ng-model="item.store_id">
                                  <option ng-repeat="x in stores" value="{{x.store_id}}">{{x.store_name}}</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>Create Date: </td>
                            <td><input type="date" ng-model="item.create_date" placeholder="Create Date" class="input-small" style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td title="If this is true, this category can be shown to client">Publish: </td>
                            <td><input type="checkbox" ng-model="item.is_publish" class="input-small"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td title="If this is true, this category is used on Mega Menu of Home Page.">Is Menu: </td>
                            <td><input type="checkbox" ng-model="item.is_menu" class="input-small"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td title="If this is true, this category is used as a label on Mega Menu of Home Page.">Is Label: </td>
                            <td><input type="checkbox" ng-model="item.is_label" class="input-small"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td colspan="3">
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
                var Category_Data_lList = {};
                $(document).ready(function () {
                    var categoryDataJson = $("#<%=Categories_Data.ClientID%>").text();
                    Category_Data_lList = jQuery.parseJSON(categoryDataJson);
                    var TodoController = 'div[ng-controller="TodoController"]';
                    var scope = angular.element(TodoController).scope();

                    var myFilter = scope.myFilter;
                    scope.items = Category_Data_lList;
                    
                    //trigger summoer note rich text editor
                    $('#category_description_textarea').summernote({
                        callbacks: {
                            onBlur: function () {
                                SetTextToCategoryDescription();
                            }
                        }
                    });

                    //Copy a new item from existing object. This could help to reduce from update to this list when you are updated orginal list
                    //scope.copyOfItems = Object.assign([], Server_Data);
                    scope.totalItem = scope.items.length;

                    var parentCategoryDataJson = $("#<%=Parent_Category_Data.ClientID%>").text();
                    scope.parentCategories = jQuery.parseJSON(parentCategoryDataJson);

                    var storesDataJson = $("#<%=Stores_Data.ClientID%>").text();
                    scope.stores = jQuery.parseJSON(storesDataJson);

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

                    scope.openUploadImagePanel = function (category_id) {
                        $('#popup_container').append('<iframe src="ImageUpload.aspx?id=' + category_id + '&table_name=categories" id="ImageUpload" style="width: 100%; height: 100%;"></iframe>');
                        jQuery('.popup').show();
                        return false;
                    };

                    scope.convertStoreIDToStoreName = function (store_id) {
                        var store = scope.stores.find(x => x.store_id == store_id);
                        if (store) {
                            return store.store_name;
                        }
                        return "";
                    };

                    scope.$apply();

                    DisableSeverControls();
                });

                //Set text to category description when user enter text to category description rich text editor (summernote editor)
                function SetTextToCategoryDescription() {
                    var TodoController = 'div[ng-controller="TodoController"]';
                    var scope = angular.element(TodoController).scope();
                    scope.item.category_description = $('.note-editable.card-block').html();
                }

                function AskForApplyAllChange() {
                    if (confirm('Are you sure to apply all change?')) {
                        var TodoController = 'div[ng-controller="TodoController"]';
                        var scope = angular.element(TodoController).scope();
                        
                        $("#<%=Category_Data_To_Post_To_Server.ClientID%>").val(JSON.stringify(scope.addedOrUpdatedItems));
                        $("#<%=txtDeletedIds.ClientID%>").val(JSON.stringify(scope.deletedIds));
                        return true;
                    }
                    return false;
                }

                function DisableSeverControls() {
                    $("#<%=Category_Data_To_Post_To_Server.ClientID%>").keypress(function(e) {
                        e.preventDefault();
                    });

                    $("#<%=txtDeletedIds.ClientID%>").keypress(function(e) {
                        e.preventDefault();
                    });
                }

                function ClosePopup() {
                    $('#ImageUpload').remove();
                    jQuery('.popup').fadeOut();
                    return false;
                }
            </script>
            <script src="AngularJS/lib/toastr.min.js"></script>
            <script src="AngularJS/app/category.js"></script>
            <div runat="server" id="Categories_Data" style="display: none;"></div>
            <div runat="server" id="Parent_Category_Data" style="display: none;"></div>
            <div runat="server" id="Stores_Data" style="display: none;"></div>

            <div class="popup" style="display: none; z-index: 10001">
                <div class="container"><div class="text" id="popup_container">
                    <p class="close" id="close_window_popup"><a style="cursor: pointer;position: absolute;top: 0;right: 0;padding: 10px; color: red;" onclick="return ClosePopup();">Close Window</a></p>
                </div></div>
                <div class="bg"></div>
            </div>
        </div>
    </form>
</asp:Content>