# CoffeeScriptの場合、(JSと違い）呼び出されるメソッドを先に定義しないと正しく動作しない

# Callback that creates and populates a data table,
# instantiates the pie chart, passes in the data and
# draws it.
drawChart = ->
  # Create the data table.
  data = new google.visualization.DataTable()
  data.addColumn('string', 'Topping')
  data.addColumn('number', 'Slices')
  data.addRows([
    ['Mushrooms', 3],
    ['Onions', 1],
    ['Olives', 1],
    ['Zucchini', 1],
    ['Pepperoni', 2]
  ])

  # Set chart options
  options = {'title':'How Much Pizza I Ate Last Night', 'width':400, 'height':300 }

  # Instantiate and draw our chart, passing in some options.
  chart = new google.visualization.PieChart(document.getElementById('piechart_div'))
  chart.draw(data, options)

  # Set Bar chart options
  barchart_options = {
    title:'Barchart: How Much Pizza I Ate Last Night',
    width:400,
    height:300,
    legend: 'none'}
  barchart = new google.visualization.BarChart(document.getElementById('barchart_div'))
  barchart.draw(data, barchart_options)

# Load the Visualization API and the corechart package.
google.charts.load('current', {'packages':['corechart']})
# 複数回load()を呼び出すと下のエラーになる。TurboLinksと一緒に使うのは難しいか？？？
# Error: google.charts.load() cannot be called more than once with version 45 or earlier.
# Google chartを使うページが多数あるのであれば、<head>に仕込んでおいても良いのかもしれないが…

# Set a callback to run when the Google Visualization API is loaded.
google.charts.setOnLoadCallback(drawChart)

