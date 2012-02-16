// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
function refreshPage()
{
  location.reload();
}

$(function() {
  $('#search input[name="ip"]').click(function() { $(this).val(""); });

});
