# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# HTML5 ガイドブック ～p.40  2.3 Canvas

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


draw_graph = ->
  canvas = $('#sample_graph').get(0)   # get(0)でjQueryオブジェクトからcanvasオブジェクトを取り出し
  ctx = canvas.getContext('2d')   # 2Dコンテキストを取得

  # 横軸となる年文字列を取得
  head_cells = $('table#tbl>thead>tr>th')
  years = []

  # 配列内indexと要素(jQueryオブジェクトかな）を取得
  for th_cell, idx in head_cells
    years.push(th_cell.innerHTML) if 1 <= idx

  # 値を取得
  value_cells = $('table#tbl>tbody>tr>td')

  max = 0
  values = for value_cell in value_cells
    v = value_cell.innerHTML
    v = parseInt(v.replace(/[^\d]/g, ""))
    max = v if max < v
    v   # ループ内で最後に評価した値が配列に追加されforの戻り値となる

  # グラフの原点となる座標を計算
  baseX = parseInt(canvas.width * 0.1)
  baseY = parseInt(canvas.height * 0.8)

  # グラフの幅と高さ
  gw = parseInt(canvas.width * 0.8)
  gh = parseInt(canvas.height * 0.7)

  # グラフの背景を描画
  ctx.fillStyle = "#eeeeee"
  ctx.fillRect(baseX, baseY - gh, gw, gh)

  # 軸を描画
  ctx.beginPath()
  ctx.moveTo(baseX, baseY-gh)
  ctx.lineTo(baseX, baseY)    # Y軸
  ctx.lineTo(baseX+gw, baseY)
  ctx.strokeStyle = "#666666"
  ctx.stroke()

  # 文字のフォント
  ctx.font = "12px 'MS ゴシック'"

  # 棒グラフの間隔
  interval = gw / years.length
  # 棒の幅
  bar_w = interval * 0.7
  # 最初の1本の棒のセンター位置X（原点Xからの相対位置）
  start_x = interval / 2
  # 棒の最大高 ※max値の高さ
  bar_max_h = gh * 0.9

  # グラフの描画
  for head, idx in years
    v = values[idx]
    # 棒の高さ
    bar_h = bar_max_h * (v / max)
    # 棒のセンター位置X
    x = baseX + start_x + (interval * idx)
    # 棒の描画
    ctx.fillStyle = "green"
    ctx.fillRect(x - bar_w / 2, baseY - bar_h, bar_w, bar_h)

    # ■テキストの描画
    continue if ! ctx.fillText

    # テキスト幅（許容最大値）
    tw = interval * 0.9   # 棒間隔に対して0.9
    # テキスト描画基準
    ctx.textAlign = "center"

    # X軸ラベル
    ctx.textBaseline = "top"    # テキスト描画基準
    ctx.fillStyle = "black"
    ctx.fillText(head, x, baseY + 3, tw)

    # 値描画
    ctx.textBaseline = "ideographic"
    ctx.fillStyle = "black"
    ctx.fillText(v, x, baseY - bar_h - 3, tw)

draw_sample()
draw_sample_color()
draw_sample_rect()
draw_sample_text()
draw_sample_text_align()
draw_graph()
