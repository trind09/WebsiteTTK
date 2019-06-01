<%@ Page Title="" Language="C#" MasterPageFile="~/admin/admin.master" AutoEventWireup="true" CodeFile="Product.aspx.cs" Inherits="admin_Product" %>

<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <link rel="stylesheet" href="AngularJS/css/toastr.css">
    <link rel="stylesheet" href="AngularJS/css/application.css">
    <div ng-app>
        <div class="container" ng-controller="ListaComprasController">

            <div class="row">
                <div class="page-header">
                    <div class="span9">
                        <h1>List of products</h1>
                    </div>
                    <div class="span3">
                        <input type="search" ng-model="search" placeholder="Search value...">
                    </div>
                </div>
            </div>

            <div class="row">
                <table id="lista-compras" class="table table-striped">
                    <thead>
                        <tr>
                            <th>Check</th>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Description</th>
                            <th>Status</th>
                            <th>Publish</th>
                            <th>Images</th>
                            <th>RelativeProductIds</th>
                            <th>Price</th>
                            <th>Currency</th>
                            <th>CreatedDate</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <tr ng-repeat="item in itens | filter:search" class="comprado-{{ item.Title }}">
                            <td>
                                <input type="checkbox" ng-model="item.ID"></td>
                            <td><strong>{{ item.ID }}</strong></td>
                            <td>{{ item.Title }}</td>
                            <td><div style="width: 100%; height: 30px; overflow-y:auto;">{{ item.Description }}</div></td>
                            <td>{{ item.Status }}</td>
                            <td>{{ item.Publish }}</td>
                            <td>{{ item.Images }}</td>
                            <td>{{ item.RelativeProductIds }}</td>
                            <td>{{ item.Price }}</td>
                            <td>{{ item.Currency }}</td>
                            <td>{{ item.CreatedDate }}</td>
                            <td>
                                <button class="btn btn-warning btn-small" ng-click="editarItem($index)">
                                    <i class="icon-pencil icon-white"></i>Edit
                                </button>
                                <button class="btn btn-danger btn-small" ng-click="deleteItem($index)">
                                    <i class="icon-trash icon-white"></i>Delete
                                </button>
                            </td>
                        </tr>
                    </tbody>
                </table>
            </div>

            <form class="row form-inline" name="validarValoresPreenchidos">
                <input type="text" ng-model="item.Title" placeholder="Title" required>
                <input type="text" ng-model="item.Description" placeholder="Description" class="input-small">
                <input type="text" ng-model="item.Status" placeholder="Status" class="input-small" required>
                <input type="text" ng-model="item.Publish" placeholder="Publish" class="input-small" required>
                <input type="text" ng-model="item.Images" placeholder="Images" class="input-small">
                <input type="text" ng-model="item.RelativeProductIds" placeholder="RelativeProductIds" class="input-small">
                <input type="number" ng-model="item.Price" placeholder="Price" class="input-small" required>
                <input type="text" ng-model="item.Currency" placeholder="Currency" class="input-small" required>
                <input type="date" ng-model="item.CreatedDate" placeholder="CreatedDate" class="input-small" required>
                <button ng-hide="edit" class="btn btn-success" ng-disabled="validarValoresPreenchidos.$invalid" ng-click="adicionaItem()">
                    <i class="icon-plus icon-white"></i>adicionar
                </button>
                <button ng-show="edit" class="btn btn-success" ng-disabled="validarValoresPreenchidos.$invalid" ng-click="applyChanges()">
                    <i class="icon-ok icon-white"></i>salvar
                </button>
            </form>
        </div>
        <script>
            var Server_Data = "";
            $(document).ready(function () {
                var data = $("#<%=Server_Data.ClientID%>").text();
                Server_Data = jQuery.parseJSON(data);
                var ListaComprasController = 'div[ng-controller="ListaComprasController"]';
                var scope = angular.element(ListaComprasController).scope();
                scope.itens = Server_Data;
                scope.$apply();
            });
        </script>
        <script src="AngularJS/lib/toastr.min.js"></script>
        <script src="AngularJS/app/controllers.js"></script>
        <div runat="server" id="Server_Data" style="display: none;"></div>
    </div>
</asp:Content>

