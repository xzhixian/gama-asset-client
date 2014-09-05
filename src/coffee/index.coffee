config = require "./config"
signUtil = require "./sign_util"

enterProject = () ->
  id = $("#project_id").val().trim()
  serial = $("#serial").val().trim()
  uri = "#{config.loadWebUrlRoot()}/projects/#{id}"
  signData = signUtil.sign("GET", uri, id, serial)
  $.ajax uri,
    type: 'GET'
    dataType: 'json'
    data:signData
    success: (result)->
      #console.dir result
      if result.success
        config.setProjectSerial serial
        config.setProjectId result.data.id
        config.setProjectName result.data.name
        window.location.href = "./asset.html"
      else
        bootbox.alert(result.msg)
    error: (jqXHR, textStatus, err) ->
      bootbox.alert("error:(#{textStatus}): #{err}")
