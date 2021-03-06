timeTracker.factory "Message", ($rootScope, $timeout) ->

  MESSAGE_DURATION = 1500
  ANIMATION_DURATION = 1000
  W_PADDING = 40
  H_PADDING = 8
  STYLE_HIDDEN = 'height': 0

  _strScale = (str) ->
    e = $("#ruler")
    width = e.text(str).get(0).offsetWidth
    height = e.text(str).get(0).offsetHeight
    e.empty()
    return w: width, h: height

  return {

    ###
     show message page bottom.
    ###
    toast: (text, duration) ->
      duration = duration or MESSAGE_DURATION
      msg = {
        text: text
        style: STYLE_HIDDEN
      }
      scale = _strScale(text)
      rows = Math.ceil(scale.w / ($(window).width() - W_PADDING))

      $rootScope.messages.push msg
      $timeout ->
        msg.style = 'height': H_PADDING + rows * scale.h
      , 50
      $timeout ->
        msg.style = STYLE_HIDDEN
      , duration
      $timeout ->
        $rootScope.messages.shift()
      , duration + ANIMATION_DURATION

  }
