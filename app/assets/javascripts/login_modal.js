// The traditional "on document ready" won't work with turbolinks
$(document).on('turbolinks:load', function() {
  var formModal = $('.cd-user-modal'),
      formLogin = formModal.find('#cd-login'),
      formSignup = formModal.find('#cd-signup'),
      formForgotPassword = formModal.find('#cd-reset-password'),
      formModalTab = $('.cd-switcher'),
      tabLogin = formModalTab.children('li').eq(0).children('a'),
      tabSignup = formModalTab.children('li').eq(1).children('a'),
      forgotPasswordLink = formLogin.find('.cd-form-bottom-message a'),
      backToLoginLink = formForgotPassword.find('.cd-form-bottom-message a'),
      mainNav = $('.main-nav');

  //open modal
  mainNav.on('click', function(event){
    $(event.target).is(mainNav) && mainNav.children('ul').toggleClass('is-visible');
  });
  $("#restaurants-page").on('click',"a[data-target='#login-modal']",login_selected);

  //open sign-up form
  mainNav.on('click', '.cd-signup', signup_selected);
  //open login-form form
  mainNav.on('click', '.cd-signin', login_selected);

  //close modal
  formModal.on('click', function(event){
    if( $(event.target).is(formModal) || $(event.target).is('.cd-close-form') ) {
      formModal.removeClass('is-visible');
    }   
  });
  //close modal when clicking the esc keyboard button
  $(document).keyup(function(event){
    if(event.which=='27'){
      formModal.removeClass('is-visible');
    }
  });

  //switch from a tab to another
  formModalTab.on('click', function(event) {
    event.preventDefault();
    ( $(event.target).is( tabLogin ) ) ? login_selected() : signup_selected();
  });

  //show forgot-password form 
  forgotPasswordLink.on('click', function(event){
    event.preventDefault();
    forgot_password_selected();
  });

  //back to login from the forgot-password form
  backToLoginLink.on('click', function(event){
    event.preventDefault();
    login_selected();
  });

  function login_selected(){
    mainNav.children('ul').removeClass('is-visible');
    formModal.addClass('is-visible');
    formLogin.addClass('is-selected');
    formSignup.removeClass('is-selected');
    formForgotPassword.removeClass('is-selected');
    tabLogin.addClass('selected');
    tabSignup.removeClass('selected');
  }

  function signup_selected(){
    mainNav.children('ul').removeClass('is-visible');
    formModal.addClass('is-visible');
    formLogin.removeClass('is-selected');
    formSignup.addClass('is-selected');
    formForgotPassword.removeClass('is-selected');
    tabLogin.removeClass('selected');
    tabSignup.addClass('selected');
  }

  function forgot_password_selected(){
    formLogin.removeClass('is-selected');
    formSignup.removeClass('is-selected');
    formForgotPassword.addClass('is-selected');
  }

  //IE9 placeholder fallback
  //credits http://www.hagenburger.net/BLOG/HTML5-Input-Placeholder-Fix-With-jQuery.html
  if(!Modernizr.input.placeholder){
    $('[placeholder]').focus(function() {
      var input = $(this);
      if (input.val() == input.attr('placeholder')) {
        input.val('');
      }
    }).blur(function() {
      var input = $(this);
      if (input.val() == '' || input.val() == input.attr('placeholder')) {
        input.val(input.attr('placeholder'));
      }
    }).blur();
  $('[placeholder]').parents('form').submit(function() {
      $(this).find('[placeholder]').each(function() {
        var input = $(this);
        if (input.val() == input.attr('placeholder')) {
          input.val('');
        }
      })
    });
  }

  $("#new_user_login").bind("ajax:error", function(event, data, status, xhr) {
    errors_p = $("p.sign-in-error")
    errors_p.text(data.responseText)
    errors_p.show()
  });

  $("#new_user").bind("ajax:error", function(event, data, status, xhr) {
    errors = data.responseJSON['errors'];
    errors_p = $("p.sign-up-error")
    for (var field in errors) {
      field_errors = errors[field]
      for (var error_n in field_errors) {
        errors_p.append("<p>" + capitalizeFirstLetter(field) + " " + field_errors[error_n] + ".</ṕ>")
      }
    }
    errors_p.show()
  });

  $("#new_user").bind("ajax:success", function(event, data, status, xhr) {
    window.location = data['location'];
  });

  $("#new_user, #new_user_login").bind("submit", function() {
    $("p.sign-up-error").text("");
    $("p.sign-in-error").text("");
  });

  $("#forgot-password-form").bind("ajax:error, ajax:success", function(event, data, status, xhr) {
    $("p.instructions-sent").text(data['result']);
  });

  function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
  }
});
