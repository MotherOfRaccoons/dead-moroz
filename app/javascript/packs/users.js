$(function(){
  $('.modal')
    .on('shown.bs.modal', function() {
      $(this).find('#review-body').focus();
    })
    .on('hidden.bs.modal', function() {
      $(this).find('#review-body').val('');
    });
});
