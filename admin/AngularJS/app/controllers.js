function ListaComprasController($scope) {

    $scope.item = {};

    $scope.itens = [];

    $scope.adicionaItem = function () {
        $scope.itens.push({
            ID: $scope.item.ID, Title: $scope.item.Title, Description: $scope.item.Description, Status: $scope.item.Status,
            Publish: $scope.item.Publish, Images: $scope.item.Images, RelativeProductIds: $scope.item.RelativeProductIds,
            Prices: $scope.item.Price, Currency: $scope.item.Currency, CreatedDate: $scope.item.CreatedDate
        });
        $scope.item.ID = $scope.item.ID = '';
        toastr.success("Item adicionado com sucesso.");
    };

    $scope.editarItem = function(index){
        $scope.item = $scope.itens[index];
        $scope.edit = true;
    };

    $scope.applyChanges = function(index){
        $scope.item = {};
        $scope.edit = false;
        toastr.success("Item alterado com sucesso.");
    };

    $scope.deleteItem = function(index){
        $scope.itens.splice(index, 1);
        toastr.success("Item removido com sucesso.");
    };
}