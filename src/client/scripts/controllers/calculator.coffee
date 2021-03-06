(angular.module 'ctrl.calculator', []).controller 'ctrlCalculator',
    ($scope, facSiteCfg) ->
        $scope.calc =
            users: 10
            files: 100

        $scope.total =
            plan: 0
            users:
                inc: 0
                add: 0
            cost:
                plan: 0
                add: 0
            year: 0
            month: 0
            store:
                total: 0
                inc: 0
                add: 0
                extra: 0
        
        CONST =
            fileGB: 0.05
            userGB: 5
            storeGB: 5

            userCost: facSiteCfg.price.factor*5*12
            storeCost: facSiteCfg.price.factor*5

            singleCost: facSiteCfg.price.factor*10*12
            officeCost: facSiteCfg.price.factor*25*12


        calc = () ->
            if $scope.calc.users > 0
                $scope.total.plan = if $scope.calc.users is 1 then 0 else 1

                $scope.total.users.inc = if $scope.calc.users is 1 then 1 else 5
                $scope.total.users.add = Math.max 0, $scope.calc.users - $scope.total.users.inc
                $scope.total.cost.plan = if $scope.calc.users is 1 then CONST.singleCost else CONST.officeCost
                $scope.total.cost.add = $scope.total.users.add*CONST.userCost
                $scope.total.year = $scope.total.cost.plan + $scope.total.cost.add

                $scope.total.store.inc = 1*CONST.userGB*$scope.total.users.inc
                $scope.total.store.add = 1*CONST.userGB*$scope.total.users.add
                $scope.total.store.total = $scope.calc.files*CONST.fileGB
                $scope.total.store.extra = Math.ceil Math.max 0, ($scope.total.store.total - ($scope.total.store.inc + $scope.total.store.add))/CONST.storeGB
                $scope.total.month = $scope.total.store.extra*CONST.storeCost


        $scope.$watch 'calc.users', calc
        $scope.$watch 'calc.files', calc


        @