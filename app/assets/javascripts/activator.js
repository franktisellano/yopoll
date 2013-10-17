$(document).ready(function() {

  $(document).on('click', '.activate', function() {
    var itemId = $(this).parents('.active_status').attr('data-item-id');
    var itemType = $(this).parents('.active_status').attr('data-item-type');
    var $parent = $(this).parents('.active_status');

    console.log('/' + itemType + 's/' + itemId)

    $.ajax({
      type: 'PUT',
      url: '/' + itemType + 's/' + itemId,
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
