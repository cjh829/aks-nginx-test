# 先build docker image

```sh
docker build -t cjh829.azurecr.io/aks-nginx-test:v2 .  //<==記得最後有個點
```

# 然後上傳到 azure 的 docker image 庫，即 CR (container registry)

```sh
docker push cjh829.azurecr.io/aks-nginx-test:v2
```
##### 這個cjh829是預先開好的 CR，要下az命令去開，順序是 
* **Resource Group(RG)**
  * **Container Registry(CR)**

##### 下指令時可能還會遇到權限/登入態問題，要下

```sh
az login
和
az acr login --name cjh829
```
去處理

##### docker push 也會需要權限，印象中是打

```sh
docker login cjh829.azurecr.io
```
然後去後台 **容器登錄 => 存取金鑰 => 管理使用者** 打勾，再把產生的帳號密碼打上去就可以

# 如果有改 default.conf 要先更新設定

```sh
kubectl create configmap nginxconfigmap --from-file=default.conf -o yaml --dry-run | kubectl apply -f -
```

# 修改 nginx-app.yaml，改成新的 image 版本，然後發布

```sh
kubectl apply -f nginx-app.yaml
```
######(這個kubectl好像也有權限，但是怎麼處理我忘了，下次遇到再補)

