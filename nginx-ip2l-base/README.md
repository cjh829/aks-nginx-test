# nginx with ip2Location module

### 因為build的過程太冗長，所以預先build好，並上傳ACR

直接到azue pipeline後台去import azpl-build-nginx-ip2l-base.yml，再run即可，會自動build並把image push到 

```
{ACR name}.azurecr.io/nginx-ip2l:base
```

在ACR建立後，只要跑一次就好，後面應該也不用再動，除非ACR重建，才要重新再推


---

###管理歸屬問題，azure應該沒權限，仍然要透過azure-pipeline去跑，下面的指令，只能個人帳號測試用

### 先build docker image

```sh
cd nginx-ip2l  //<==切到本目錄
docker build -t mktfeacr.azurecr.io/nginx-ip2l:base .  //<==記得最後有個點，版本號記得改
```

### 把 docker image 上傳到 ACR

```sh
docker push mktfeacr.azurecr.io/nginx-ip2l:base  //<==版本號一樣要記得改
```

### ACR權限問題可以參考根目錄的HOWTO.md
