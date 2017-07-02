// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require jquery3
//= require jquery_ujs
//= require semantic-ui
//= require turbolinks
//= require jquery.infinitescroll
//= require_tree .

$(document).ready(function() {
  $("#submit").click(function() {
    var searchQuery = $("#search").val();
    console.log(window.location.host);
    window.location.href = "/?q=" + searchQuery;
  });
  $('#search').keypress(function() {
    if (event.keyCode === 13) {
      var searchQuery = $('#search').val();
      window.location.href = "/?q=" + searchQuery;
    };
  });
  $("#home").click(function() {
    document.location.href = "/";
  });
});
