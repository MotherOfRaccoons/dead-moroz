$(function(){
  $('#review-modal').on('shown.bs.modal', function() {
    $(this).find('#review-body').focus();
  });

  $('#review-modal').on('hidden.bs.modal', function() {
    $(this).find('#review-body').val('');
  });

  $('#assessment-modal').on('shown.bs.modal', function() {
    $(this).find('#assessment-comment').focus();
  });

  $('#assessment-modal').on('hidden.bs.modal', function() {
    $(this).find('#assessment-comment').val('');

    $('#form-rating li.star').each(function(i) {
      $(this).removeClass('selected');
    });
  });

  // Stars
  $('#form-rating li').on('mouseover', function() {
    let onStar = parseInt($(this).data('value'), 10);
    $(this).parent().children('li.star').each(function (i){
      if (i < onStar) {
        $(this).addClass('hover');
      } else {
        $(this).removeClass('hover');
      }
    });
  });

  $('#form-rating li').on('mouseout', function(){
    $('#form-rating li.star').each(function(){
      $(this).removeClass('hover');
    });
  });

  $('#form-rating li').on('click', function(){
    let onStar = parseInt($(this).data('value'), 10);
    $('#form-rating li.star').each(function(i) {
      $(this).removeClass('selected');
      if (i < onStar) {
        $(this).addClass('selected');
      }
    });
  
    let ratingValue = parseInt($('#form-rating li.selected').last().data('value'), 10);
    $('#rating').val(ratingValue);
  });

  $('#translate').click(function() {
    $(this).addClass('d-none');
    $('#translation-spinner').removeClass('d-none');
  });
});
