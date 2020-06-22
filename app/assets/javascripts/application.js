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
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery_ujs

document.addEventListener('turbolinks:load', function(){
  const open = document.getElementById("menu-link")
  const close = document.getElementById("close-menu")
  const menu = document.getElementById("menu")
  if(open && close && menu){
    open.addEventListener("click", function(){
      menu.classList.add("open")
      close.classList.add("open")
    })
    close.addEventListener("click", function(){
      menu.classList.remove("open")
      close.classList.remove("open")
    })
  }
  $(function () {
    function buildHTML(image) {
      var html =
        `
        <div class="prev-content">
          <img src="${image}" class="prev-image">
        </div>
        `
      return html;
    }

    $('#notice-close').on('click', function(){
      $('.notice').fadeOut()
      return false
    })

    $('#alert-close').on('click', function(){
      $('.alert').fadeOut()
      return false
    })

    $('.alert').hide().fadeIn("slow")

    $(document).on('change', '.hidden-file', function () {
      var file = this.files[0];
      var reader = new FileReader();
      reader.readAsDataURL(file);
      reader.onload = function () {
        var image = this.result;
        if ($('.prev-content').length == 0) {
          var html = buildHTML(image)
          $('.prev-contents').prepend(html);
          $('.default-icon').hide();
        } else {
          $('.prev-content .prev-image').attr({ src: image });
        }
      }
    });
  });
})
