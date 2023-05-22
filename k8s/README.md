Pra criar o ambiente de teste local, é só executar o comando 
```
k3d cluster create -p "8083:30000@loadbalancer"  -p "50051:30001@loadbalancer" -p "8082:30002@loadbalancer" -p "8080:30003@loadbalancer"
```

Criação do Keycloak
https://youtu.be/DuuTuI8ltUQ?t=1434

https://stackoverflow.com/questions/74580379/how-to-pass-environment-variable-to-kubernetes-yaml-deployment-files-using-githu?rq=1

### Anotações importantes

