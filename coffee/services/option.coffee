timeTracker.factory("Option", (Chrome) ->

  OPTIONS = "OPTIONS"
  NULLFUNC = () ->

  _options = null

  return {

    ###
     get all option data.
    ###
    getOptions: (callback) ->
      callback = callback or NULLFUNC
      if _options isnt null then callback _options; return

      Chrome.storage.sync.get OPTIONS, (item) ->
        if Chrome.runtime.lastError? or not item[OPTIONS]?
          callback null
        else
          _options = item[OPTIONS]
          callback _options


    ###
     set all option data.
    ###
    setOptions: (options, callback) ->
      callback = callback or NULLFUNC
      _options = options
      Chrome.storage.sync.set OPTIONS: options, () ->
        if Chrome.runtime.lastError?
          callback false
        else
          callback true


    ###
     clear all data.
    ###
    clearAllData: (callback) ->
      callback = callback or NULLFUNC
      Chrome.storage.local.clear()
      Chrome.storage.sync.clear () ->
        if Chrome.runtime.lastError?
          callback false
        else
          callback true
  }
)
