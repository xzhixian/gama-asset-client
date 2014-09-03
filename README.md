# Gama Asset Client

A GUI application to manage gama assets on the client side, can be run on Windows, Mac and Linux

## 客户端目录结构

```
.
├── LICENSE
├── README.md
├── app.nw
│   ├── bootstrap                           // 依赖 bootstrap
│   ├── index.html                          // 入口
│   ├── js                                  // 程序相关的 js 文件
│   ├── package.json
├── package.json
├── src
│   ├── coffee                              // 本项目的 js 文件的 coffee 源代码
│   └── jade                                // 本项目的 html 文件的 jade 源代码
├── test
│   └── name_test.js

```


## Gama 网站提供的API 服务

### 客户端访问服务器的请求数据签名方式

  使用oauth-sign module 的hmacsign 加密数据签名。
 
  具体参数如下：
  
    * method: http请求的方式（GET或POST）
    * baseUri: 请求的uri地址 （例：http://gamagama.cn/projects）
    * timestamp:请求时的时间戳。（秒值， 超过xx秒的请求将被视为违法）
    * clientID: Gama 项目 ID
    * clientSecret: Gama 项目 KEY
    
### 获取项目的相关信息

 * URL: http://gamagama.cn/projects/{project_id}
 * Method: GET
 * AuthorizatioN: required
 * Request Parameters: null

### 获取项目发包时的素材列表

 * URL: http://gamagama.cn/projects/{project_id}/assets_list/{type}
     * type 变量的可能内容：
       * all:  [默认]所有素材
       * png_jpg: 以位图格式输出的素材，其中 png 都采用 png 8bit with alpha 方式压缩
       * etc1_pkm: 以 ETC1 格式压缩的GPU纹理，并且采用 Mali PKM 格式，将纹理的 alpha 通道打包
       * pvrct_1_4: 以 PowerVR 的 pvrct_1_4 格式压缩的GPU纹理
 * Method: GET
 * AuthorizatioN: required
 * Request Parameters: nil

### 获取项目发包时的素材列表

 * URL: http://gamagama.cn/projects/{project_id}/assets/{asset_id}
 * Method: GET
 * AuthorizatioN: required
 * Request Parameters: null

## 开发相关

### 在 node-webkit 中运行本程序

`npm start`


### 将 jade 编译成 html

在项目根目录下执行 `npm run-script jade`

### 将 coffee 编译成 javascript

在项目根目录下执行 `npm run-script coffee`



