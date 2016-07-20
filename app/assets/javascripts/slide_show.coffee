# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on 'ready page:load', ->
  # public直下のファイルを指定するときには / で始める
  files = [
    '/img1.jpg',
    '/img2.jpg',
    '/img3.jpg',
    '/img4.jpg'
  ]
  
  # サムネイル表示
  playTimer = 0
  currentNum = 0
  nowPlaying = false
  for i in [0..files.length-1]
    img = $('<img>').attr('src', files[i]).addClass('thumbnail')
    $('#thumbnails').append(img)

  # 大きなイメージ表示
  $('#main').append($('<img>').attr('src', files[0]))
  $('.thumbnail:first').addClass('current')

  # サムネイルclickイベントハンドラ
  $('.thumbnail').click(->
    $('#main img').attr('src', $(this).attr('src'))
    currentNum = $(this).index()   # thumbnailクラス要素の何番目か(0-)
    $(this).addClass('current').siblings().removeClass('current')  # siblings()兄弟要素
  )

  # 前へ・次へ ボタン
  $('#prev').click(->
    currentNum--
    if currentNum < 0
      currentNum = files.length - 1
    $('#main img').attr('src', files[currentNum])
    $('.thumbnail').removeClass('current') # 全てのthumbnailからcurrentを削除
    $('.thumbnail').eq(currentNum).addClass('current')
  )

  $('#next').click(->
    currentNum++
    if files.length <= currentNum
      currentNum = 0
    $('#main img').attr('src', files[currentNum])
    $('.thumbnail').removeClass('current') # 全てのthumbnailからcurrentを削除
    $('.thumbnail').eq(currentNum).addClass('current')
  )

  # 自動再生・停止
  autoPlay = ->
    $('#next').click()
    # 1行で書く書き方
    # playTimer = setTimeout (-> autoPlay()), 1000
    # 複数行なら
    playTimer = setTimeout ->
      autoPlay()
    , 1000

  $('#play').click ->
    return if nowPlaying
    nowPlaying = true
    autoPlay()

  $('#stop').click ->
    clearTimeout(playTimer)
    nowPlaying = false


