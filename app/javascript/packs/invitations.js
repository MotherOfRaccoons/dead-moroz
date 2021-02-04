$(function(){
  $('#invitation-modal').on('shown.bs.modal', function() {
    $(this).find('#invitation_email').focus();
  });

  $('#invitation-modal').on('hidden.bs.modal', function() {
    $(this).find('#invitation_email').val('');
  });

  $('.btn-copy').click(function() {
    copyToClipboard($(this).attr('target'));
  })

  $('.btn-copy').popover({ placement: 'top', trigger: 'focus', delay: { 'hide': 1000 } })
});

function copyToClipboard(element) {
    let temp = $("<input>");
    $("body").append(temp);
    temp.val($(element).text()).select();
    document.execCommand("copy");
    temp.remove();
}
