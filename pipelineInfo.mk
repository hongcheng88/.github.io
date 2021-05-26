## pipline

#### 并行子任务，用parallel

    pipeline {
       agent any
       stages {
           stage('Stage1') {
               agent { label "test1" }
               steps {
                   timestamps {
     echo '这是第一个被执行的 stage.'
     sleep 5
                   }
               }
           }
           stage('并行执行的 Stage') {
               parallel {
                   stage('Stage2.1') {
                       agent { label "test2" }
                       steps {
                           timestamps {
     echo "在 agent test2 上执行的并行任务 1."
     sleep 5
     echo "在 agent test2 上执行的并行任务 1 结束."
                           }
                       }
                   }
                   stage('Stage2.2') {
                       agent { label "test3" }
                       steps {
                           timestamps {
     echo "在 agent test3 上执行的并行任务 2."
     sleep 10
     echo "在 agent test3 上执行的并行任务 2 结束."
                           }
                       }
                   }
               }
           }
           stage('Stage3') {
               agent { label "test1" }
               steps {
                   timestamps {
     echo '这是最后一个被执行的 stage.'
                   }
               }
           }
       }
    }
