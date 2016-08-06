# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# HTML5 ガイドブック ～p.40  2.3 Canvas


$(document).on 'ready page:load', ->
  draw_sample()
  draw_sample_color()
  draw_sample_rect()
  draw_sample_text()
  draw_sample_text_align()

draw_sample = ->
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

draw_sample_color = ->
  canvas = $('#sample_color')  # -> jQueryオブジェクトを返す https://api.jquery.com/id-selector/
  ctx = canvas.get(0).getContext('2d')

  # 赤色の円
  ctx.beginPath()
  ctx.arc(150, 45, 35, 0, Math.PI * 2, false)
  ctx.fillStyle = 'rgba(192, 80, 77, 0.7)'     # 半透明の赤
  ctx.fill()
  ctx.strokeStyle = 'rgba(192, 80, 77, 1）'    # 赤
  ctx.stroke()

  # 緑色の円
  ctx.beginPath()
  ctx.arc(125, 95, 35, 0, Math.PI * 2, false)
  ctx.fillStyle = 'rgba(155, 187, 89, 0.7)'   # 半透明
  ctx.fill()
  ctx.strokeStyle = 'rgba(155, 187, 89, 1）'  #
  ctx.stroke()

  # 紫色の円
  ctx.beginPath()
  ctx.arc(175, 95, 35, 0, Math.PI * 2, false)
  ctx.fillStyle = 'rgba(128, 100, 162, 0.7)'   # 半透明
  ctx.fill()
  ctx.strokeStyle = 'rgba(128, 100, 162, 1）'  #
  ctx.stroke()


draw_sample_rect = ->
  canvas = $('#sample_rect')  # -> jQueryオブジェクトを返す https://api.jquery.com/id-selector/
  ctx = canvas.get(0).getContext('2d')

  # 全体を緑で塗りつぶす
  ctx.fillStyle = "#005500"
  ctx.fillRect(0, 0, 300, 150)

  # 赤の矩形
  ctx.strokeStyle = "#ff6666"
  ctx.strokeRect(30, 30, 240, 90)

  # 小さい矩形でくりぬく
  ctx.clearRect(50, 50, 200, 50)

draw_sample_text = ->
  canvas = $('#sample_text')  # -> jQueryオブジェクトを返す https://api.jquery.com/id-selector/
  ctx = canvas.get(0).getContext('2d')

  # テキストの定義
  text = "Canvasでテキストの描画"
  # フォントを設定
  ctx.font = "24px 'Arial'"

  # 輪郭を描画
  ctx.strokeStyle = "blue"
  ctx.strokeText(text, 10, 40)

  # 塗りつぶしで描画
  ctx.fillStyle = "red"
  ctx.fillText(text, 10, 85)

  # 幅を固定して描画
  ctx.fillStyle = "green"
  ctx.fillText(text, 10, 130, 130)

draw_sample_text_align = ->
  canvas = $('#sample_text_align').get(0)   # get(0)でjQueryオブジェクトからcanvasオブジェクトを取り出し

  # 幅と高さ
  w = parseInt(canvas.width)
  h = parseInt(canvas.height)

  ctx = canvas.getContext('2d')   # 2Dコンテキストを取得

  # テキストの定義
  text = "Canvasでテキストの描画∫"
  # フォントを設定
  ctx.font = "24px 'Arial'"

  ctx.textAlign = "center"

  # 垂直方向に【正しく】centerに配置するため、テキストのベースライン（配置の基準となるライン）を設定する ※ブラウザによって実装が多少異なるので要確認
#  ctx.textBaseline = "top"   #
#  ctx.textBaseline = "hanging"   #
  ctx.textBaseline = "middle"  # テキストのおおむね中心 ※ブラウザによっても少し異なる
#  ctx.textBaseline = "alphabetic"   #
#  ctx.textBaseline = "ideographic"   #
#  ctx.textBaseline = "bottom"   #

  ctx.fillStyle = "green"
  ctx.fillText(text, w/2, h/2)






