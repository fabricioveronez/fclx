Pra criar o ambiente de teste local, é só executar o comando 
```
k3d cluster create -p "8080:30000@loadbalancer"  -p "8081:30001@loadbalancer" -p "8082:30002@loadbalancer" -p "8083:30003@loadbalancer"
```