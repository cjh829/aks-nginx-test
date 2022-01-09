# 先build docker image

```sh
docker build -t cjh829.azurecr.io/aks-nginx-test:v22010901 .  //<==記得最後有個點，版本號記得改
```

# 本地測試


### 修改 docker-compose.yml 改成剛才build的版本，然後起服務
```sh
docker-compose up -d
```
### 服務啟動後，就可以直接改conf等配置去測，改完需要重起
```sh
docker-compose down
docker-compose up -d
```


# 雲端測試

### 把 docker image 上傳到 azure 的 CR 庫 (container registry)

```sh
docker push cjh829.azurecr.io/aks-nginx-test:v22010901  //<==版本號一樣要記得改
```
##### 補充：這個cjh829是預先開好的 CR，要下az命令去開，建立順序是 
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

### image上傳到CR後，修改 nginx-app.yaml，改成新的 image 版本，然後發布

```sh
kubectl apply -f nginx-app.yaml
```
######(這個kubectl好像也有權限，但是怎麼處理我忘了，下次遇到再補)

### 發布之後會自動重起，如果要手動重起，用調整節點數的方式，去強制啟動(切成0再切回來)
```sh
kubectl scale deployment my-nginx --replicas=0
kubectl scale deployment my-nginx --replicas=1
```



