config = require './config'
fs = require 'fs'
signUtil = require "./sign_util"
wget = require 'wgetjs'
async = require "async"
shell = require "shelljs"
path = require "path"

JOB_LOCK = 0
MAX_OVERTIME = 60*60*1000

#不同类型对应的asset类型
ASSET_TYPE =
  desktop: 'png_jpg'
  ios: 'pvrct_1_4'
  android: 'etc1_pkm'

#不同类型对应的下载目录
FOLDER_BY_TYPE =
  desktop: 'gama'
  ios: 'gama_ios'
  android: 'gama_android'


$(document).ready ->
  name = config.getProjectName()
  unless name? and name.length>0
    window.location.href = "./index.html"
    return
  $('#project_name').text(config.getProjectName())
  #$('#project_id').val(config.getProjectId())
  #$('#serial').val(config.getProjectName())

#本地项目路径
selectProjectPath = () ->
  projectPath = $("#select_file").val()
  if projectPath? and projectPath.length>0
    $("#project_path").val(projectPath)

#开始下载asset
startDown = (type, group) ->
  projectPath = $('#project_path').val().trim()
  unless projectPath? and projectPath.length>0
    bootbox.alert('下载之前，请选择你本地的项目目录')
    return
  isDir = fs.existsSync projectPath
  unless isDir
    bootbox.alert('选择的本地目录不存在，请重新选择')
    return
  if isLock()
    bootbox.alert('当前有下载任务正在进行，请等待。')
    return
  #开始加锁
  locking()
  ARIA_VALUEMAX = 0
  _loadAssetList ASSET_TYPE[type]||'all', (err, results) ->
    if err?
      bootbox.alert("error:#{err}")
      return
    unless Array.isArray(results) and results.length>0
      bootbox.alert("还没有相关素材")
      return
    ids = []
    switch group
      when "all"
        ids = results
        break
      when "csx"
        results.map (id) ->
          if id.indexOf('.csx')>=0
            return ids.push id
        break
    _initProgressBar type, ids.length
    _fetchAssets projectPath, type, group, ids

locking = () ->
  JOB_LOCK = Date.now() + MAX_OVERTIME

deblocking = () ->
  JOB_LOCK = 0

isLock = () ->
  return JOB_LOCK>Date.now()

ARIA_VALUEMAX = 0
_initProgressBar = (type, sum) ->
  ARIA_VALUEMAX = sum
  $("##{type}_progressbar").attr('aria-valuemax', sum)
  $("##{type}_progressbar").attr('aria-valuenow', 0)
  $("##{type}_progressbar").attr('aria-valuemin', 0)
  $("##{type}_progressbar").attr('style', "width: 0%;")
  $("##{type}_progressbar").text("0/#{ARIA_VALUEMAX}")

_upProgressBar = (type, now) ->
  plan = Math.ceil(now/ARIA_VALUEMAX*100)
  #console.log "now: #{now}  plan: #{plan}"
  $("##{type}_progressbar").attr('aria-valuenow', now)
  $("##{type}_progressbar").attr('style', "width: #{plan}%;")
  $("##{type}_progressbar").text("#{now}/#{ARIA_VALUEMAX}")

_fetchAssets = (projectPath, type, group, ids, callback) ->
  folder = FOLDER_BY_TYPE[type]
  unless folder
    bootbox.alert('不知道对应的素材目录。')
    return
  folder = path.join(projectPath, folder)
  #console.log "folder:  #{folder}"
  shell.mkdir('-p', folder)
  if group == "csx"
    shell.rm '-rf', "#{folder}/*.csx"
  else
    shell.rm '-rf', "#{folder}/*"
  sum_ids = ids.length
  i = 0
  async.eachSeries ids, (id, next) ->
    projectId = config.getProjectId()
    serial = config.getProjectSerial()
    uri = "#{config.loadWebUrlRoot()}/projects/#{projectId}/assets/#{id}"
    signData = signUtil.sign("GET", uri, projectId, serial)
    wget {url: "#{uri}?timestamp=#{encodeURIComponent(signData.timestamp)}&signature=#{encodeURIComponent(signData.signature)}", dest:"#{folder}/"}, (err, data) ->
      return next err if err?
      _upProgressBar type, ++i
      next()
      return
  ,(err) ->
    deblocking()
    if err?
      bootbox.alert "error:#{err}"
      return
    bootbox.alert("下载完成")


#获取asset 的列表
_loadAssetList = (type, callback) ->
  id = config.getProjectId()
  serial = config.getProjectSerial()
  uri = "#{config.loadWebUrlRoot()}/projects/#{id}/assets_list/#{type}"
  signData = signUtil.sign("GET", uri, id, serial)
  $.ajax uri,
    type: 'GET'
    dataType: 'json'
    data:signData
    success: (result)->
      #console.dir result
      if result.success
        callback null, result.data
      else
        callback result.msg
    error: (jqXHR, textStatus, err) ->
      callback "error:(#{textStatus}): #{err}"






