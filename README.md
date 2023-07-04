# NFT合约Demo

实现两种形式的nft
- 一种是通过上传到ipfs上通过文件hash定位的nft
- 一种是svg文件，能够真正的把数据存在链上的nft

步骤：
1. 第一种需要在[pinata](https://www.pinata.cloud/)官网上传想要做成nft的图片获取CID
2. 第二种需要做svg到Base64的编码转化


## 要求
- [git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
  - You'll know you did it right if you can run `git --version` and you see a response like `git version x.x.x`
- [foundry](https://getfoundry.sh/)
  - You'll know you did it right if you can run `forge --version` and you see a response like `forge 0.2.0 (816e00b 2023-03-16T00:05:26.396218Z)`
 
## Quickstart
```
git clone https://github.com/solnex/svg-nft
cd svg-nft
make install
forge build
```

## 用法1（Anvil本地节点）

### 创建本地测试网

```
make anvil
```

### 部署
This will default to your local node. You need to have it running in another terminal in order for it to deploy.

```
make deploy
```
### 测试 
```
forge test
```
### 代码覆盖 
```
forge coverage
```

## 用法2（Sepolia测试网）
### 添加.env文件
```
SEPOLIA_RPC_URL=
PRIVATE_KEY=
ETHERSCAN_API_KEY=
DEFAULT_ANVIL_KEY
```
### 部署
``` 
make deploy ARGS="--network sepolia"
```
### mint
内置了svg文件，可以调用以下脚本mint随机nft，如果你有svg文件可以在`imgs/svgNfts/ `下替换
```
make mintNft ARGS="--network sepolia"
```

### view

去[Opensea测试网](https://testnets.opensea.io/zh-CN)查看你的nft吧

## 相关知识
### SVG
SVG格式文件是可缩放矢量图形文件的缩写，是一种标准的图形文件类型，用于在互联网上渲染二维图像。 与其他流行的图像文件格式不同，SVG格式文件将图像存储为矢量，这是一种基于数学公式由点、线、曲线和形状组成的图形。

将jpg转化为SVG图片：
[vectorizer工具](https://vectorizer.ai/?utm_source=appinn.com)

可以看到我的头像转化成svg的样子：
<br/>
<p align="center">
<img src="./imgs/me.svg" width="225" alt="uri&url">
<br/>

注意：交易有最高gaslimit，限制在8000000左右，如果文件过大是无法发出交易的。

### IPFS和FilCoin的关系
FIl是IPFS的激励层代币，是一个区块链项目。IPFS是分布式存储协议，是技术层，不是区块链！filcoin是利用IPFS技术开发的一个区块链生态系统。

- ipfs://QmVFPvu8aeJHXyNVxpfftVHaKjRsbtH6dXWscJ2TukM3xi 这个是去中心化的网络，用的ipfs协议 
- https://ipfs.io/ipfs/QmVFPvu8aeJHXyNVxpfftVHaKjRsbtH6dXWscJ2TukM3xi 
  这个是中心的网络，用的是https协议
### URI与URL
- URI:Uniform Resource Identifier 统一资源标识符
- URL：Uniform Resource Locator，统一资源定位符；
- URN：Uniform Resource Name，统一资源名称。


 URI一定是URL,  URN + URL 就是 URI