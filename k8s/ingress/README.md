# 安裝ingress

來源 https://docs.microsoft.com/en-us/azure/aks/ingress-own-tls?tabs=azure-cli

### 修改並執行ingress_install.sh即可

```sh
cd k8s/ingress;
./ingress_install.sh
```

##### 第一步 az acr import 3行命令，是把docker image推到acr，已經先註解起來，沒推過的話需要把註解去掉
##### 第二步 helm repo add 命令也是增加本地repo，一樣只要執行一次，沒跑過才把註解去掉
##### 第三步 ACR_URL 參數填入第一步推到的 acr url
##### 第四步 helm install 動作就是實際的安裝
 - 注意!!! namespace 要和對接的內部 service 的 namespace 一樣，不然會連不上，這裡改成默認(default)
 - 有增加 --set controller.service.externalTrafficPolicy=Local 用來獲取用戶真實ip

### 問題處理心得
##### 第一次按教學下去安裝，默認namespace是ingress-basic，裝上之後，發現連不上，刪除是用

```sh
kubectl delete namespace ingress-basic
```

##### 但是刪完之後，再用default安裝還是會報錯，查到可以用下面這個命令，補刪漏掉的東西

```sh
helm template nginx-ingress ingress-nginx/ingress-nginx --namespace ingress-nginx-internal | kubectl delete -f -
```
(來源: https://github.com/MicrosoftDocs/azure-docs/issues/73310)

##### 這個跑完就可以正常安裝新的了

---

# 自建tls key
##### 測試用的key和crt文件(和教學不同，這裡做的是wildcard domain)

```sh
openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -out aks-ingress-tls-f1demo.crt \
    -keyout aks-ingress-tls-f1demo.key \
    -subj "/CN=*.f1demo.com/O=aks-ingress-tls"
```


##### 導入用下面的命令(namespace一樣要換成default)

```sh
kubectl create secret tls aks-ingress-tls-f1demo \
    --namespace default \
    --key aks-ingress-tls-f1demo.key \
    --cert aks-ingress-tls-f1demo.crt
```
---

# 發布ingress

##### kubectl apply yaml就可以，沒啥特別(一樣注意要改namespace)

# 測試ingress

```sh
curl -v -k --resolve stag.f1demo.com:443:{EXTERNAL_IP} https://stag.f1demo.com
```
