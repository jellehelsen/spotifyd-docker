pipeline {
    agent {
        kubernetes {
            yaml '''
              apiVersion: v1
              kind: Pod
              spec:
                serviceAccountName: jenkins
                containers:
                  - name: dind
                    image: docker:dind
                    imagePullPolicy: Always
                    securityContext:
                      privileged: true
                    volumeMounts:
                      - name: dind-storage
                        mountPath: /var/lib/docker
                      - name: dind-certs
                        mountPath: /certs
                    env:
                      - name: DOCKER_TLS_CERTDIR
                        value: /certs
                  - name: docker
                    image: docker
                    imagePullPolicy: Always
                    command:
                      - cat
                    env:
                      - name: DOCKER_HOST
                        value: tcp://localhost:2376
                      - name: DOCKER_CERT_PATH
                        value: /certs/server
                      - name: DOCKER_TLS_VERIFY
                        value: "1"
                    tty: true
                    volumeMounts:
                      - name: dind-certs
                        mountPath: /certs
                volumes:
                  - name: dind-storage
                    emptyDir: {}
                  - name: dind-certs
                    emptyDir: {}

            '''
            inheritFrom 'default'
        }
    }

    options {
        ansiColor('xterm')
    }

    stages {
        stage("Build") {
            steps {
                container("docker") {
                    sh 'docker build . -t registry.hcode.be/spotifyd:latest'
                }
            }
        }
        stage("Push") {
            steps {
                container("docker") {
                    sh 'docker push registry.hcode.be/spotifyd:latest'
                }
            }
        }
    }
}
