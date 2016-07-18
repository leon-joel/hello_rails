# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# http://dotinstall.com/lessons/shindan_js_v2

$(document).on 'ready page:load', ->
#  $("#getResult").click ->
  $(document).on 'click', '#getResult', ->
  # 名前の取得
    name = $("#name").val()   # ここで()を忘れていて大ハマり！
    console.log(name)

    if name == ""
      alert("名前を入力してください!")
      return

    # タイプの生成
    types = ["勇者", "魔法使い", "戦士", "遊び人", "全壊請負人"]
    # 0-n の乱数
    rand = Math.floor(Math.random() * types.length)
    type = types[rand]

    # キャラクターの生成
    charactors = ["賢い", "勇ましい", "かわいい", "情けない", "情け容赦ない", "極めて小さい"]
    # 0-n の乱数
    rand2 = Math.floor(Math.random() * charactors.length)
    chara = charactors[rand2]

    # 結果表示
    result = "山田さんは 「" + chara + type + "」タイプです"
    $("#result").text(result)

    # ツイートリンクの表示
    tweetLink =
      "<a href='https://twitter.com/intent/tweet?text=" +
        encodeURIComponent(result) +
        "&hashtags=dotinstall' target='_blank'>" +
        "ツイートする</a>"
    $("#tweet").html(tweetLink)

  level = 0
  games = [
    ['微', '徴'],
    ['大', '太'],
#    ['菅', '管'],
    ['未', '末'],
#    ['人', '入'],
#    ['旬', '句'],
    ['白', '日'],
#    ['肪', '防'],
    ['吉', '古'],
#    ['稿', '橋'],
#    ['問', '間']
#    ['亡', '七'],
    ['0', 'O']
  ]
  MAX_LEVEL = games.length - 1
  DIM_FIRST = 5
  DIM_DELTA_X = 7
  DIM_DELTA_Y = 2
  dim_x = DIM_FIRST
  dim_y = DIM_FIRST

  $(document).on 'click', '#game_start', ->
    gameStart()

  # 開始時刻 ※CoffeeScriptは全てがローカル変数なので、Javascriptのように★部分での定義だけでOKというわけにはいかない
  t1 = 0
  gameStart = ->
    dummy = games[level][0]
    seikai = games[level][1]

    if level == 0
      $('#score').text('')
      t1 = new Date().getTime() # ★★★★★★★
      console.log "t1 = #{t1}"

    # dim_x * dim_y のspan要素を作って #cells に突っ込む
    cells = ''
    for i in [1..(dim_x * dim_y)]
      cells += """<span class="chars" id="s#{i}"></span>"""
      if i % dim_x == 0
        cells += '<br/>'

    $('#cells').html(cells)

    # dummy で埋められた配列を作る
    chars = []
    for j in [0..(dim_x * dim_y)-1]
      chars.push(dummy)

    # 配列のうち一つをseikaiにする
    offset = Math.floor(Math.random() * chars.length)
    chars.splice(offset, 1, seikai)

    # span要素にそれらの配列の値をはめ込む
    for k in [1..chars.length]
      $('#s'+k).text(chars[k-1])
      $('#s'+k).click(->
        if $(this).text() == seikai
          if (level < MAX_LEVEL)
            level++
            dim_x += DIM_DELTA_X
            dim_y += DIM_DELTA_Y
            gameStart()

          else
            t2 = new Date().getTime()
            console.log "t1 = #{t1}, t2 = #{t2}"
            console.log "diff = #{t2 - t1}"
            $('#score').text("Your score is #{(t2 - t1)/1000} sec")
            level = 0
            dim_x = dim_y = DIM_FIRST
            return false
      )
