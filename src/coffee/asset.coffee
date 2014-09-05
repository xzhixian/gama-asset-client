config = require './config'
fs = require 'fs'
mkdirp = require 'mkdirp'
signUtil = require "./sign_util"

ASSET_TYPE =
  desktop: 'png_jpg'
  ios: 'pvrct_1_4'
  android: 'etc1_pkm'

$(document).ready ->
  name = config.getProjectName()
  unless name? and name.length>0
    window.location.href = "./index.html"
    return
  $('#project_name').text(config.getProjectName())
  #$('#project_id').val(config.getProjectId())
  #$('#serial').val(config.getProjectName())

selectProjectPath = () ->
  projectPath = $("#select_file").val()
  if projectPath? and projectPath.length>0
    $("#project_path").val(projectPath)

startDown = (type, group) ->
  projectPath = $('#project_path').val().trim()
  unless projectPath? and projectPath.length>0
    bootbox.alert('下载之前，请选择你本地的项目目录')
    return
  isDir = fs.existsSync projectPath
  unless isDir
    bootbox.alert('选择的本地目录不存在，请重新选择')
    returnn
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
    #console.dir ids
    alert("请等待接口实现!")

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




