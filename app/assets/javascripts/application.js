// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks

//= require svg-pan-zoom

// common配下のjs(CoffeeScript)を全て（再帰で）application.jsに取り込む。
// ※javascript直下や commonディレクトリ以外のjs(CoffeeScript)は取り込まれないので、
//   config/initializers/assets.rbに記載しておかないと、プリコンパイルの対象(?)にならず使えない。
//= require_tree ./common
// ※ここを ./なしで記述するとページ読み込み時に「require_tree argument must be a relative path」というエラーが発生する
