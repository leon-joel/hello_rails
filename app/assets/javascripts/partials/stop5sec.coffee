isStarted = false
startTime = null
diff = null

msg = "Stop! 5 sec!"
result = document.getElementById('result')
btn = document.getElementById('btn')

btn.addEventListener 'click', ->
  if !isStarted
    isStarted = true
    this.innerHTML = 'STOP'
    startTime = Date.now()
    result.innerHTML = msg
  else
    isStarted = false
    this.innerHTML = 'START'
    diff = (Date.now() - startTime) / 1000 - 5

    # coffeescriptなら区間条件をちょっと簡単に書けるよ
    if -0.1 <= diff <= 0.1
      result.innerHTML = "Perfect!!!"
    else if 0 < diff
      result.innerHTML = "You are " + diff.toFixed(2) + ' seconds late!'
    else
      result.innerHTML = "You are " + Math.abs(diff).toFixed(2) + ' seconds early!'
