###
# 配置文件
###

PROJECT_ID = ''
PROJECT_NAME = ''
PROJECT_SERIAL = ""

WEB_URL_ROOT = "http://192.168.1.131:3007"
#WEB_URL_ROOT = "http://gamagama.cn"

exports.loadWebUrlRoot = () ->
  return WEB_URL_ROOT

exports.setProjectId = (projectId) ->
  PROJECT_ID = projectId
  return

exports.setProjectName = (projectName) ->
  PROJECT_NAME = projectName
  return

exports.setProjectSerial = (projectSerial) ->
  PROJECT_SERIAL = projectSerial

exports.getProjectId = () ->
  return PROJECT_ID

exports.getProjectName = () ->
  return PROJECT_NAME

exports.getProjectSerial = () ->
  return PROJECT_SERIAL
