$(document).on 'ready page:load', ->
  isStarted = false
  startTime = null
  diff = null

  msg = "Stop! 5 sec!"
  result = $('#result')
  btn = $('#btn')

  btn.click ->
    if !isStarted
      isStarted = true
      $(this).html('STOP')
      startTime = Date.now()
      result.html(msg)
    else
      isStarted = false
      $(this).html('START')     # this.innerHTML = "xxx" は $(this).html("xxx") にする！頻出問題！！！
      diff = (Date.now() - startTime) / 1000 - 5

      # coffeescriptなら区間条件をちょっと簡単に書けるよ
      if -0.1 <= diff <= 0.1
        result.html("Perfect!!!")
      else if 0 < diff
        result.html("You are " + diff.toFixed(2) + ' seconds late!')
      else
        result.html("You are " + Math.abs(diff).toFixed(2) + ' seconds early!')
