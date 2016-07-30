# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# HTML5 ガイドブック ～p.40  2.3 Canvas


$(document).on 'ready page:load', ->
  # canvas の2Dコンテキストを取得
  canvas = $('#sample')  # -> jQueryオブジェクトを返す https://api.jquery.com/id-selector/
  ctx = canvas.get(0).getContext('2d')
  # ↑生のDOM要素を取り出すためにget(0)をかましている
  # http://tnomura9.exblog.jp/12624562/

  # ■moveTo, LineTo, closePath
  ctx.beginPath()    # パスをリセット
  ctx.moveTo(150, 20)
  ctx.lineTo(250, 130)
  ctx.lineTo(50, 130)
  ctx.closePath()    # 開始点に向かってlineToを呼び出したのと同じ

  ctx.stroke()       # パスを描画
  # ctx.fill()       # パスを塗りつぶしで描画

  # ■円弧 arc()

  # 円
  ctx.beginPath()    # パスをリセット ※描画結果は消されない
  ctx.arc(150, 75, 60, 0, Math.PI*2, false)
  ctx.stroke()

  # 円弧
  ctx.beginPath()
  ctx.arc(70, 70, 60, 10 * Math.PI / 180, 80 * Math.PI / 180, true)
  ctx.stroke()

  # 残りの円弧 ※anticlockwiseパラメータだけを変えればOK ※分かりやすいように座標もちょいずらし
  ctx.beginPath()
  ctx.arc(75, 75, 60, 10 * Math.PI / 180, 80 * Math.PI / 180, false)
  ctx.stroke()
