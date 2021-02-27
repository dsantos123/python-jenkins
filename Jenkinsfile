pipeline {
    agent any

    stages {
        stage('Construir') {
            when {
              expression { true == true }
            }
            steps {
                echo "          -------------CONSTRUYENDO MI SOFTWARE/CODE"
                echo "          Creando entorno virtual"
                //bat 'virtualenv entorno_virtual'
                bat 'python3 -m venv entorno_virtual'
                echo "          Activando el entorno_virtual"
                bat '. entorno_virtual/bin/activate'
                //sh 'pip3 --version'
                //echo "          Instalando los requerimientos concretos de este proyecto"
                //sh 'pip3 install -r requirements.txt'
                echo "          Instalando aplicación para testear"
                bat 'pip3 install pytest'
                echo "           Instalado aplicación/libreria necesaria para este proyecto concreto"
                bat 'pip3 install flask'
                echo "           Terminando de instalar requerimientos"
            }
        }
        stage('Test') {
            when {
              expression { true == true }
            }
            steps {
                echo "Ejecutando y probando"
                bat 'python3 src/main.py &'
                //sh 'pytest src/test_main.py'
                //echo "            Puedes probarla durante 20 segundos esta aplicación en modo local"   
            }
        }
        stage('Build Docker') {
            when {
              expression { true == true }
            }
            steps {
                echo "			  Construyendo la imagen de "
                bat 'docker build -t dsantos123/python-jenkins:latest .'
                //echo "			Tageando la imagen para poderla subir posteriormente"
                //docker tag $Imagen franciscomelero/$Imagen         
                echo "			Subiendo la imagen repositorio de docker hub"
                bat' docker push dsantos123/python-jenkins:latest'
                echo "			Borrando la imagen en modo local, aunque la dejamos para que no tarde tanto"
                bat 'docker rmi dsantos123/python-jenkins:latest'
            }
        }
        stage('Desplegando un único servidor') {
            when {
              expression { true == true }
            }
            steps {
                echo "			  Enviando el fichero docker-compose "           
                bat 'scp -i /home/jenkins/keyHLC docker-compose.yml root@192.168.15.128/HLC-Francisco/santosgarrido/python-jenkins/docker-compose.yml'
                //echo "			  Descargando imagen nueva en el servidor de producción"
                //sh 'ssh -i /home/jenkins/keyHLC root@192.168.15.128 docker pull $Imagen'
                echo "Parando servicios "
                bat 'ssh -i /home/jenkins/keyHLC root@192.168.15.128 docker-compose -f /HLC-Francisco/santosgarrido/python-jenkins/docker-compose.yml down'
                echo "           Arrancando nueva imagen "
                bat 'ssh -i /home/jenkins/keyHLC root@192.168.15.128 docker-compose -f /HLC-Francisco/santosgarrido/python-jenkins/docker-compose.yml up -d'
            }
          }  
          stage('Desplegando con un bucle muchos servidores') {
            steps {
             echo "Hola"                
            }
          }
        }   
    
post {
   failure {  
            echo "Se enviará un correo para informar del fallo."
             mail bcc: '', body: "<b>Build failed</b><br>Project: ${env.JOB_NAME} <br>Build Number: ${env.BUILD_NUMBER} <br> URL de build: ${env.BUILD_URL}", cc: '', charset: 'UTF-8', from: 'dsantosgarrido01@gmail.com', mimeType: 'text/html', replyTo: '', subject: "ERROR CI: Project name -> ${env.JOB_NAME}", to: "dsantosgarrido01@gmail.com";  
         }    
    }
}
