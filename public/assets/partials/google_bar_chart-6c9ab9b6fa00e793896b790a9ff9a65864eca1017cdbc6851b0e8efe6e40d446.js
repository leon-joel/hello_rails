(function() {
  var drawChart;

  drawChart = function() {
    var barchart, barchart_options, chart, data, options;
    data = new google.visualization.DataTable();
    data.addColumn('string', 'Topping');
    data.addColumn('number', 'Slices');
    data.addRows([['Mushrooms', 3], ['Onions', 1], ['Olives', 1], ['Zucchini', 1], ['Pepperoni', 2]]);
    options = {
      'title': 'How Much Pizza I Ate Last Night',
      'width': 400,
      'height': 300
    };
    chart = new google.visualization.PieChart(document.getElementById('piechart_div'));
    chart.draw(data, options);
    barchart_options = {
      title: 'Barchart: How Much Pizza I Ate Last Night',
      width: 400,
      height: 300,
      legend: 'none'
    };
    barchart = new google.visualization.BarChart(document.getElementById('barchart_div'));
    return barchart.draw(data, barchart_options);
  };

  google.charts.load('current', {
    'packages': ['corechart']
  });

  google.charts.setOnLoadCallback(drawChart);

}).call(this);
