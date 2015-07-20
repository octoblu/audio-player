_ = require 'lodash'
React = require 'react'
Howl = require('howler').Howl
Meshblu = require 'meshblu'
MessageSchema =
  type : 'object'
  properties :
    audioUrl :
      type : 'string',

Player = React.createClass
  getInitialState: ->
    audioUrl: ''

  componentWillMount: ->
    uuid = localStorage.deviceUUID || undefined
    token = localStorage.deviceToken || undefined

    @connection = Meshblu.createConnection
                    uuid : uuid
                    token : token

    @connection.on 'ready', (device) =>
      localStorage.deviceUUID = device.uuid
      localStorage.deviceToken = device.token

      @connection.update
        type : 'meshblu:audio-player'
        messageSchema : MessageSchema

  componentDidMount: ->
    @connection.on 'message', (message) =>
      console.log 'message', message
      audioUrl =  if message.payload? then message.payload.audioUrl else message.audioUrl
      @playAudio(audioUrl)

  playAudio:  (audioUrl) =>
    console.log 'Play ', audioUrl
    @sound = new Howl
      urls: [audioUrl]
      volume: 1.0
      buffer: true
      autoplay: true

  render: ->
    <div>
      <h1>Auto Play</h1>
    </div>

module.exports = Player
