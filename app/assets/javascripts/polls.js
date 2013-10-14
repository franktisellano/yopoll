$(document).ready(function() {

  $(document).on('click', '.activate', function() {
    var pollId = $(this).parents('.poll_active_status').attr('data-poll-id');
    var $parent = $(this).parents('.poll_active_status');

    $.ajax({
      type: 'PUT',
      url: '/polls/' + pollId,
      data: { active: true }
    }).done(function () {
      var $activateLink = $('<a/>', {
        'href': '#',
        'class': 'activate',
        'html': 'Activate'
      });

      $('.active')
        .removeClass('active')
        .addClass('inactive')
        .html($activateLink);

      $parent
        .toggleClass('active')
        .toggleClass('inactive')
        .html('Active');
    });

    return false;
  });
  
});
