# nginx with ip2Location module

### 因為build的過程太冗長，所以預先build好，並上傳ACR

### 先build docker image

```sh
cd nginx-ip2l  //<==切到本目錄
docker build -t cjh829.azurecr.io/nginx-ip2l:1.20.2v1 .  //<==記得最後有個點，版本號記得改
```

### 把 docker image 上傳到 ACR

```sh
docker push cjh829.azurecr.io/nginx-ip2l:1.20.2v1  //<==版本號一樣要記得改
```

### ACR權限問題可以參考根目錄的HOWTO.md
