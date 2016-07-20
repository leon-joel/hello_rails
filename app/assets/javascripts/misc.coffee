# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# http://dotinstall.com/lessons/shindan_js_v2

$(document).on 'ready page:load', ->
#  $("#getResult").click ->
  $(document).on 'click', '#getResult', ->
  # 名前の取得
    name = $("#name").val()   # ここで()を忘れていて大ハマり！
#    console.log(name)

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
  # 開始時刻 ※CoffeeScriptは全てがローカル変数なので、Javascriptのように★部分での定義だけでOKというわけにはいかない
  t1 = 0
  penarty = 0

  $(document).on 'click', '#game_start', ->
    init_cells()
    gameStart()

  gameStart = ->
    dummy = games[level][0]
    seikai = games[level][1]

    if level == 0
      $('#score').text('')
      t1 = new Date().getTime() # ★
    #      console.log "t1 = #{t1}"

    $("#target_string").text("#{seikai} を探せ！")

    offset = Math.floor(Math.random() * (dim_x * dim_y))
    console.log "offset = #{offset}"
    dummy_offset = []

    # ヒント有無
    is_hint = $("[name=hint]").prop('checked')
    if is_hint
      for i in [0..(level+1)**2]
        dummy_offset.push Math.floor(Math.random() * (dim_x * dim_y))

    # dim_x * dim_y のspan要素を作って #cells に突っ込む
    cells = ''
    seikai_char = if is_hint then "seikai_char" else "" # scriptでCSS値を変更したかったがなぜか出来なかったので、class属性のON/OFFで切り替える
    for k in [0..(dim_x * dim_y - 1)]
      if k == offset
        cells += """<span class="chars #{seikai_char}" id="s#{k}">#{seikai}</span>"""
      else if k in dummy_offset
        cells += """<span class="chars #{seikai_char}" id="s#{k}">#{dummy}</span>"""
      else
        cells += """<span class="chars" id="s#{k}">#{dummy}</span>"""
      if k % dim_x == (dim_x - 1)
        cells += '<br/>'

    $('#cells').html(cells)

    for l in [0..(dim_x * dim_y - 1)]
      $('#s'+l).click(->
        if $(this).text() == seikai
          if (level < MAX_LEVEL)
            level++
            dim_x += DIM_DELTA_X
            dim_y += DIM_DELTA_Y
            gameStart()

          else
            t2 = new Date().getTime()
            #console.log "t1 = #{t1}, t2 = #{t2}"
            #console.log "diff = #{t2 - t1}"
            elapse = (t2 - t1)/1000
            $('#score').text("#{(elapse + penarty).toFixed(3)} 秒（タイム#{elapse.toFixed(3)}秒 ＋ ペナルティ#{penarty}秒）")
            init_cells()
            return false
        else
          penarty += 1
          $('#penarty').text("（ペナルティ #{penarty} 秒）")
      )

  init_cells = -> (
    $("#target_string").text("")
    $('#penarty').text("")
    $('#cells').html("")
    level = 0
    dim_x = dim_y = DIM_FIRST
    t1 = 0
    penarty = 0
  )
