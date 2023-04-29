Pra criar o ambiente de teste local, é só executar o comando 
```
k3d cluster create -p "8080:30000@loadbalancer"  -p "8081:30001@loadbalancer"
```