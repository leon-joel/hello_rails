(function() {
  var autoPlay, currentNum, files, i, img, j, nowPlaying, playTimer, ref;

  files = ['/img1.jpg', '/img2.jpg', '/img3.jpg', '/img4.jpg'];

  playTimer = 0;

  currentNum = 0;

  nowPlaying = false;

  for (i = j = 0, ref = files.length - 1; 0 <= ref ? j <= ref : j >= ref; i = 0 <= ref ? ++j : --j) {
    img = $('<img>').attr('src', files[i]).addClass('thumbnail');
    $('#thumbnails').append(img);
  }

  $('#main').append($('<img>').attr('src', files[0]));

  $('.thumbnail:first').addClass('current');

  $('.thumbnail').click(function() {
    $('#main img').attr('src', $(this).attr('src'));
    currentNum = $(this).index();
    return $(this).addClass('current').siblings().removeClass('current');
  });

  $('#prev').click(function() {
    currentNum--;
    if (currentNum < 0) {
      currentNum = files.length - 1;
    }
    $('#main img').attr('src', files[currentNum]);
    $('.thumbnail').removeClass('current');
    return $('.thumbnail').eq(currentNum).addClass('current');
  });

  $('#next').click(function() {
    currentNum++;
    if (files.length <= currentNum) {
      currentNum = 0;
    }
    $('#main img').attr('src', files[currentNum]);
    $('.thumbnail').removeClass('current');
    return $('.thumbnail').eq(currentNum).addClass('current');
  });

  autoPlay = function() {
    $('#next').click();
    return playTimer = setTimeout(function() {
      return autoPlay();
    }, 1000);
  };

  $('#play').click(function() {
    if (nowPlaying) {
      return;
    }
    nowPlaying = true;
    return autoPlay();
  });

  $('#stop').click(function() {
    clearTimeout(playTimer);
    return nowPlaying = false;
  });

}).call(this);
