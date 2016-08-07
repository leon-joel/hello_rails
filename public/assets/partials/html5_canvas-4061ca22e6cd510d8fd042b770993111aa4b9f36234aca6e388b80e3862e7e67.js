(function() {
  var draw_graph, draw_sample, draw_sample_color, draw_sample_rect, draw_sample_text, draw_sample_text_align;

  draw_sample = function() {
    var canvas, ctx;
    canvas = $('#sample');
    ctx = canvas.get(0).getContext('2d');
    ctx.beginPath();
    ctx.moveTo(150, 20);
    ctx.lineTo(250, 130);
    ctx.lineTo(50, 130);
    ctx.closePath();
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(150, 75, 60, 0, Math.PI * 2, false);
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(70, 70, 60, 10 * Math.PI / 180, 80 * Math.PI / 180, true);
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(75, 75, 60, 10 * Math.PI / 180, 80 * Math.PI / 180, false);
    return ctx.stroke();
  };

  draw_sample_color = function() {
    var canvas, ctx;
    canvas = $('#sample_color');
    ctx = canvas.get(0).getContext('2d');
    ctx.beginPath();
    ctx.arc(150, 45, 35, 0, Math.PI * 2, false);
    ctx.fillStyle = 'rgba(192, 80, 77, 0.7)';
    ctx.fill();
    ctx.strokeStyle = 'rgba(192, 80, 77, 1）';
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(125, 95, 35, 0, Math.PI * 2, false);
    ctx.fillStyle = 'rgba(155, 187, 89, 0.7)';
    ctx.fill();
    ctx.strokeStyle = 'rgba(155, 187, 89, 1）';
    ctx.stroke();
    ctx.beginPath();
    ctx.arc(175, 95, 35, 0, Math.PI * 2, false);
    ctx.fillStyle = 'rgba(128, 100, 162, 0.7)';
    ctx.fill();
    ctx.strokeStyle = 'rgba(128, 100, 162, 1）';
    return ctx.stroke();
  };

  draw_sample_rect = function() {
    var canvas, ctx;
    canvas = $('#sample_rect');
    ctx = canvas.get(0).getContext('2d');
    ctx.fillStyle = "#005500";
    ctx.fillRect(0, 0, 300, 150);
    ctx.strokeStyle = "#ff6666";
    ctx.strokeRect(30, 30, 240, 90);
    return ctx.clearRect(50, 50, 200, 50);
  };

  draw_sample_text = function() {
    var canvas, ctx, text;
    canvas = $('#sample_text');
    ctx = canvas.get(0).getContext('2d');
    text = "Canvasでテキストの描画";
    ctx.font = "24px 'Arial'";
    ctx.strokeStyle = "blue";
    ctx.strokeText(text, 10, 40);
    ctx.fillStyle = "red";
    ctx.fillText(text, 10, 85);
    ctx.fillStyle = "green";
    return ctx.fillText(text, 10, 130, 130);
  };

  draw_sample_text_align = function() {
    var canvas, ctx, h, text, w;
    canvas = $('#sample_text_align').get(0);
    w = parseInt(canvas.width);
    h = parseInt(canvas.height);
    ctx = canvas.getContext('2d');
    text = "Canvasでテキストの描画∫";
    ctx.font = "24px 'Arial'";
    ctx.textAlign = "center";
    ctx.textBaseline = "middle";
    ctx.fillStyle = "green";
    return ctx.fillText(text, w / 2, h / 2);
  };

  draw_graph = function() {
    var bar_h, bar_max_h, bar_w, baseX, baseY, canvas, ctx, gh, gw, head, head_cells, i, idx, interval, j, len, len1, max, results, start_x, th_cell, tw, v, value_cell, value_cells, values, x, years;
    canvas = $('#sample_graph').get(0);
    ctx = canvas.getContext('2d');
    head_cells = $('table#tbl>thead>tr>th');
    years = [];
    for (idx = i = 0, len = head_cells.length; i < len; idx = ++i) {
      th_cell = head_cells[idx];
      if (1 <= idx) {
        years.push(th_cell.innerHTML);
      }
    }
    value_cells = $('table#tbl>tbody>tr>td');
    max = 0;
    values = (function() {
      var j, len1, results;
      results = [];
      for (j = 0, len1 = value_cells.length; j < len1; j++) {
        value_cell = value_cells[j];
        v = value_cell.innerHTML;
        v = parseInt(v.replace(/[^\d]/g, ""));
        if (max < v) {
          max = v;
        }
        results.push(v);
      }
      return results;
    })();
    baseX = parseInt(canvas.width * 0.1);
    baseY = parseInt(canvas.height * 0.8);
    gw = parseInt(canvas.width * 0.8);
    gh = parseInt(canvas.height * 0.7);
    ctx.fillStyle = "#eeeeee";
    ctx.fillRect(baseX, baseY - gh, gw, gh);
    ctx.beginPath();
    ctx.moveTo(baseX, baseY - gh);
    ctx.lineTo(baseX, baseY);
    ctx.lineTo(baseX + gw, baseY);
    ctx.strokeStyle = "#666666";
    ctx.stroke();
    ctx.font = "12px 'MS ゴシック'";
    interval = gw / years.length;
    bar_w = interval * 0.7;
    start_x = interval / 2;
    bar_max_h = gh * 0.9;
    results = [];
    for (idx = j = 0, len1 = years.length; j < len1; idx = ++j) {
      head = years[idx];
      v = values[idx];
      bar_h = bar_max_h * (v / max);
      x = baseX + start_x + (interval * idx);
      ctx.fillStyle = "green";
      ctx.fillRect(x - bar_w / 2, baseY - bar_h, bar_w, bar_h);
      if (!ctx.fillText) {
        continue;
      }
      tw = interval * 0.9;
      ctx.textAlign = "center";
      ctx.textBaseline = "top";
      ctx.fillStyle = "black";
      ctx.fillText(head, x, baseY + 3, tw);
      ctx.textBaseline = "ideographic";
      ctx.fillStyle = "black";
      results.push(ctx.fillText(v, x, baseY - bar_h - 3, tw));
    }
    return results;
  };

  draw_sample();

  draw_sample_color();

  draw_sample_rect();

  draw_sample_text();

  draw_sample_text_align();

  draw_graph();

}).call(this);
