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
		    script{
		    def changeLogSets = currentBuild.changeSets
			for (int i = 0; i < changeLogSets.size(); i++) {
    				def entries = changeLogSets[i].items
    				for (int j = 0; j < entries.length; j++) {
        				def entry = entries[j]
        				echo "${entry.commitId} by ${entry.author} on ${new Date(entry.timestamp)}: ${entry.msg}"
        				def files = new ArrayList(entry.affectedFiles)
        				for (int k = 0; k < files.size(); k++) {
            					def file = files[k]
            					echo "  ${file.editType.name} ${file.path}"
        				}
    				}
			}
		    }
            }
        }
    }
}
