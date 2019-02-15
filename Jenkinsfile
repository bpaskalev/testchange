pipeline {
	agent  any 
    parameters {
        booleanParam(name: 'INFRA',  defaultValue: false, description: 'Force build and push infrastructure')
    }
//    environment {
//    }
    stages {
        stage("Infrastructure Images") {
            when {
                anyOf {
                    expression { return params.INFRA }
                    changeset "infrastructure/**" 
                } 
            }
            steps {
                dir ('infrastructure') {
			sh ' echo changed'
                }

            }
        }
    }
}
