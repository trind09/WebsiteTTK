<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="Colour.aspx.cs" Inherits="admin_Colour" %>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder0" runat="Server">
    <title>Colour Management</title>
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <!--SummerNote rich text box library-->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.11.0/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.css" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/summernote/0.8.12/summernote-bs4.js"></script>
    <!--SummerNote rich text box library-->
    <form id="form1" runat="server">
        <asp:linkbutton runat="server" CssClass="btn btn-success" OnClientClick="return AskForApplyAllChange();" OnClick="btnApplyAllChanges_Click">Apply all changes</asp:linkbutton>
        <asp:textbox id="Colour_Data_To_Post_To_Server" runat="server" enable="false"></asp:textbox>
        <asp:textbox id="txtDeletedIds" runat="server" enable="false"></asp:textbox>
        <link rel="stylesheet" href="AngularJS/css/toastr.css">
        <link rel="stylesheet" href="AngularJS/css/application.css">
        <div>
            <div class="container" ng-app="app" ng-controller="TodoController">
                <div class="row">
                    <div class="page-header">
                        <div class="span9">
                            <h1>List of colours</h1>
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
                                <th ng-click="sortBy('colour_id')" style="text-decoration: underline; cursor: pointer;">Colour ID</th>
                                <th ng-click="sortBy('colour_name')" style="text-decoration: underline; cursor: pointer;">Colour Name</th>
                                <th ng-click="sortBy('create_date')" style="text-decoration: underline; cursor: pointer;">Create Date</th>
                                <th></th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr ng-repeat="item in filteredItems | orderBy:sortField:reverseOrder | filter:searchValue | startFrom:(currentPage - 1) * numPerPage | limitTo:numPerPage" class="comprado-{{ item.product_name }}">
                                <td><input type='checkbox' ng-checked="checkall" id="item-{{ item.colour_id }}" value="{{ item.colour_id }}"></td>
                                <td><strong>{{ item.colour_id }}</strong></td>
                                <td>{{ item.colour_name }}</td>
                                <td>{{ item.create_date | filterdate | date:'dd/MM/yyyy hh:mm:ss' }}</td>
                                <td>
                                    <a class="btn btn-warning btn-small" ng-click="editarItem(item.colour_id)">
                                        <i class="icon-pencil icon-white"></i>Edit
                                    </a>
                                </td>
                                <td>
                                    <a class="btn btn-danger btn-small" ng-click="deleteItem(item.colour_id)">
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
                            <th colspan="3">Colour form</th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Colour ID: </td>
                            <td><input type="number" readonly="readonly" ng-model="item.colour_id" placeholder="Colour ID" style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Colour Name: </td>
                            <td><input type="text" ng-model="item.colour_name" placeholder="Colour Name" required style="width: 500px;"></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Colour Description: </td>
                            <td><textarea id="colour_description_textarea" name="editordata" ng-model="item.colour_description"></textarea></td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>Create Date: </td>
                            <td><input type="date" ng-model="item.create_date" placeholder="Create Date" class="input-small" style="width: 500px;"></td>
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
                var Colour_Data_lList = {};
                $(document).ready(function () {
                    var colourDataJson = $("#<%=Colour_Data.ClientID%>").text();
                    Colour_Data_lList = jQuery.parseJSON(colourDataJson);
                    var TodoController = 'div[ng-controller="TodoController"]';
                    var scope = angular.element(TodoController).scope();

                    var myFilter = scope.myFilter;
                    scope.items = Colour_Data_lList;
                    
                    //trigger summoer note rich text editor
                    $('#colour_description_textarea').summernote({
                        callbacks: {
                            onBlur: function () {
                                SetTextToColourDescription();
                            }
                        }
                    });

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

                //Set text to product description when user enter text to product description rich text editor (summernote editor)
                function SetTextToColourDescription() {
                    var TodoController = 'div[ng-controller="TodoController"]';
                    var scope = angular.element(TodoController).scope();
                    scope.item.colour_description = $('.note-editable.card-block').html();
                }

                function AskForApplyAllChange() {
                    if (confirm('Are you sure to apply all change?')) {
                        var TodoController = 'div[ng-controller="TodoController"]';
                        var scope = angular.element(TodoController).scope();
                        $("#<%=Colour_Data_To_Post_To_Server.ClientID%>").val(JSON.stringify(scope.addedOrUpdatedItems));
                        $("#<%=txtDeletedIds.ClientID%>").val(JSON.stringify(scope.deletedIds));
                        return true;
                    }
                    return false;
                }

                function DisableSeverControls() {
                    $("#<%=Colour_Data_To_Post_To_Server.ClientID%>").keypress(function(e) {
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
            <script src="AngularJS/app/colour.js"></script>
            <div runat="server" id="Colour_Data" style="display: none;"></div>

            <div class="popup" style="display: none; z-index: 10001">
                <div class="container"><div class="text" id="popup_container">
                    <p class="close" id="close_window_popup"><a style="cursor: pointer;position: absolute;top: 0;right: 0;padding: 10px; color: red;" onclick="return ClosePopup();">Close Window</a></p>
                </div></div>
                <div class="bg"></div>
            </div>
        </div>
    </form>
</asp:Content>


