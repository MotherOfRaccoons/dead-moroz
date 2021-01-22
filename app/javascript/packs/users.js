$(function(){
  $('#review-modal').on('shown.bs.modal', function() {
    $(this).find('#review-body').focus();
  }).on('hidden.bs.modal', function() {
    $(this).find('#review-body').val('');
  });

  $('#assessment-modal').on('shown.bs.modal', function() {
    $(this).find('#assessment-comment').focus();
  }).on('hidden.bs.modal', function() {
    $(this).find('#assessment-comment').val('');

    $('#stars li.star').each(function(i) {
      $(this).removeClass('selected');
    });

  });

  // Stars
  $('#stars li').on('mouseover', function() {
    let onStar = parseInt($(this).data('value'), 10);
    $(this).parent().children('li.star').each(function (i){
      if (i < onStar) {
        $(this).addClass('hover');
      } else {
        $(this).removeClass('hover');
      }
    });
  }).on('mouseout', function(){
    $('li.star').each(function(){
      $(this).removeClass('hover');
    });
  });

  $('#stars li').on('click', function(){
    let onStar = parseInt($(this).data('value'), 10);
    $(this).data('test', 69)

    $('li.star').each(function(i) {
      $(this).removeClass('selected');
      if (i < onStar) {
        $(this).addClass('selected');
      }
    });
  
    let ratingValue = parseInt($('#stars li.selected').last().data('value'), 10);
    $('#rating').val(ratingValue)
  });

  $('#translate').click(function() {
    $(this).addClass('d-none')
    $('#translation-spinner').removeClass('d-none')
  })

});
