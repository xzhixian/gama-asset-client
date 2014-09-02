# Gama Asset Client

A GUI application to manage gama assets on the client side, can be run on Windows, Mac and Linux

## Gama 网站提供的API 服务

### 客户端访问服务器的请求数据签名方式

{{@东东 请补全}}

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


coffee watch js 运行： cake coffee:watch

jade watch html 运行： cake pages


