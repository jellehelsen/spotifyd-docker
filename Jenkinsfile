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
                    sh 'docker context create build --docker "host=tcp://localhost:2376,ca=/certs/ca/cert.pem,cert=/certs/client/cert.pem,key=/certs/client/key.pem" && docker context use build'
                    sh 'docker buildx create --name container --driver=docker-container --use'
                    sh 'docker buildx build --platform linux/amd64,linux/arm64 --push -t registry.hcode.be/spotifyd:latest .'
                }
            }
        }
    }
}
