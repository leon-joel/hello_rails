# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

# http://dotinstall.com/lessons/tablesort_jquery

$(document).on 'ready page:load', ->
  # ソート用比較関数
  compare = (a, b, type, col) ->
    _a = $(a).find('td').eq(col).text()
    _b = $(b).find('td').eq(col).text()

    if type == "string"
      if _a < _b
        return -1
      else if _b < _a
        return 1
      else
        return 0
    else
      _a *= 1    # *1 で文字列を数値に変換している
      _b *= 1
      return _a - _b

  # 並べ替え順を設定
  sortOrder = 1  # 1:昇順  -1:降順


  # ヘッダーをクリック
  $('.dothesort').click ->
    type = $(this).data('type')  # string, integer
    col = $(this).index()        # 0, 1, ...

    # 行全体を取得 ※変数の前の$はjQueryのオブジェクトであることを示す ※スクリプト上の意味は特にない
    $rows = $('tbody>tr')  # tr要素の配列

    # 行を点数で並べ替え ※JSのsort関数を使用
    $rows.sort (a, b) ->
      compare(a, b, type, col) * sortOrder         # 降順の場合は結果を反転

    # tbodyを並べ替えされた行全体で入れ替え
    $('tbody').empty().append($rows)

    # 昇順・降順を示すマークを表示
    arrow = if sortOrder == 1 then "▲" else "▼"   # 3項演算子はCoffeeScriptに存在しない
    $('.dothesort > span').text("")
    $(this).find('span').text(arrow)

    # 並べ替え順を反転
    sortOrder *= -1

