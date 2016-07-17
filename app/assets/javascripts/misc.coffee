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
