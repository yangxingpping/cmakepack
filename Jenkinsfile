pipeline {
  agent any
  stages {
    stage('') {
      steps {
        sh '''mkdir build;
cd build;
~/cmake/bin/cmake ..;
make clean;
make;'''
      }
    }

  }
}