$(document).ready(function () {
    //handleResponse(true, "");
  
    //$('#messageinfo').text("");
    // $('#messageinfo').hide();
    $("#fade").click(function () {
        $('#fade').hide();
    });

});
function show_birthdate_date_block() {
    var maxYear = new Date().getFullYear();
    var minYear = maxYear - 100;
    $('body').on('focus', ".loginradius-raas-birthdate", function () {
        $('.loginradius-raas-birthdate').datepicker({
            dateFormat: 'mm-dd-yy',
            maxDate:  new Date(),
            minDate: "-100y",
            changeMonth: true,
            changeYear: true,
            yearRange: (minYear + ":" + maxYear)
        });
    });
}

function ShowformbyId(currentform) {
    $('.lr-traditional-frame').removeClass('lr-form-active');

    $("#"+currentform).addClass('lr-form-active');
}
function redirect(token, name) {
    var token_name = name ? name : 'mtoken';
    $('#fade').show();
    var form = document.createElement('form');
    form.action = LocalDomain;
    form.method = 'POST';

    var hiddenToken = document.createElement('input');
    hiddenToken.type = 'hidden';
    hiddenToken.value = token;
    hiddenToken.name = token_name;
    form.appendChild(hiddenToken);

    document.body.appendChild(form);
    form.submit();
}
function linking(){
    $(".lr-linked-data, .lr-unlinked-data").html('');
    $(".lr-linked").each(function() {
        $(".lr-linked-data").append($(this).html());
    });
    $(".lr-unlinked").each(function() {
        $(".lr-unlinked-data").append($(this).html());
    });
    var linked_val  =  $('.lr-linked-data').html();
    var unlinked_val  =  $('.lr-unlinked-data').html();
    if(linked_val != ''){

        $(".lr-linked-data").prepend('Connected Account<br>');
    }
    if(unlinked_val != ''){
        $(".lr-unlinked-data").prepend('Choose Social Account to connect<br>');
    }
    $('#interfacecontainerdiv').hide();
}
function handleResponse(isSuccess, message, show) {
    if (show) {

    }
    else {
        $('#fade').show();
    }
    if (message != null && message != "") {
        $('#messageinfo').text(message);
        $(".messagediv").show();
        $('#messageinfo').show();
        if (isSuccess) {
            $('form').each(function () {
                this.reset();
            });
        }
    } else {
        $(".messagediv").hide();
        $('#messageinfo').hide();
        $('#messageinfo').text("");
    }
}
LoginRadiusRaaS.$hooks.setProcessHook(function () {
    //  console.log("start process", '');
    $('#fade').show();
}, function () {
    // console.log("end process", '');

    $('#fade').hide();
    
});
LoginRadiusRaaS.$hooks.socialLogin.onFormRender = function () {
    ShowformbyId('lr-social-register');
    //$(".lr-login-buttons-frame").closest("div.lr-heading").hide();
    $(".lr-login-buttons-frame").hide();
};
//initialize registration form
function initializeRaasForms(raasoption) {
    LoginRadiusRaaS.init(raasoption, 'registration', function (response) {
        handleResponse(true, "An email has been sent to " + $("#loginradius-raas-registration-emailid").val() + ".Please verify your email address.");
        //handleResponse(true, "");
        //redirect(response.access_token);
    }, function (response) {
        if (response[0].description != null) {
            handleResponse(false, response[0].description);
        }
    }, "registeration-container");

    //initialize Login form
    LoginRadiusRaaS.init(raasoption, 'login', function (response) {
        //$("#fade").show();
        // $('#loginradius-fade').hide();
        handleResponse(true, "");
        // $("#fade").show();
        redirect(response.access_token);
    }, function (response) {
        if (response[0].description != null) {

            handleResponse(false, response[0].description);
            $('#fade').hide();
        }
    }, "login-container");

    //initialize forgot password form
    LoginRadiusRaaS.init(raasoption, 'forgotpassword', function (response) {
        handleResponse(true, "An email has been sent to " + $("#loginradius-raas-forgotpassword-emailid").val() + " with reset Password link.");
    }, function (response) {
        if (response[0].description != null) {
            handleResponse(false, response[0].description);
        }
    }, "forgotpassword-container");

    //initialize social Login form
    LoginRadiusRaaS.init(raasoption, 'sociallogin', function (response) {
        if (response.isPosted) {
            handleResponse(true, "An email has been sent to " + $("#loginradius-raas-social-registration-emailid").val() + ".Please verify your email address.");
            ShowformbyId("lr-sign-in");
        } else {
            handleResponse(true, "", true);
            redirect(response);
        }
    }, function (response) {
        if (response[0].description != null) {
            handleResponse(false, response[0].description);
        }
    }, "social-registration-container");

    //initialize reset password form and handel email verifaction 
    var vtype = $SL.util.getQueryParameterByName("vtype");
    if (vtype != null && vtype != "") {
        LoginRadiusRaaS.init(raasoption, 'resetpassword', function (response) {
            handleResponse(true, "Password reset successfully");
            ShowformbyId("lr-sign-in");
        }, function (response) {
            handleResponse(false, response[0].description);
            $('#fade').hide();
        }, "resetpassword-container");

        if (vtype == "reset") {
            LoginRadiusRaaS.init(raasoption, 'emailverification', function (response) {
                handleResponse(true, "");
                ShowformbyId("lr-reset-pw");
            }, function (response) {
                // on failure this function will call â€˜errorsâ€™ is an array of error with message.
                handleResponse(false, response[0].description);
                $('#fade').hide();
            });
        } else {
            LoginRadiusRaaS.init(raasoption, 'emailverification', function (response) {
                //On Success this callback will call
                handleResponse(true, "Your email has been verified successfully");
                ShowformbyId("lr-sign-in");
            }, function (response) {
                // on failure this function will call â€˜errorsâ€™ is an array of error with message.
                handleResponse(false, response[0].description);
                $('#fade').hide();
            });
        }
    }

}

function login_radius_log_out() {
    handleResponse(true, "");
   
     var array = {};
        array['value'] = 'logout';
        
        get_form_for_hidden_value(array);
}
function unLinkAccount(name,id) {
    handleResponse(true, "");
    if (confirm('Are you sure you want to unlink!')) {
        $('#fade').show();
        var array = {};
        array['value'] = 'accountUnLink';
        array['provider'] = name;
        array['providerId'] = id;
        get_form_for_hidden_value(array);
    }
    else {
        $('#fade').hide();
    }
}
function get_form_for_hidden_value(array){
    var form = document.createElement('form');
    var key;
    form.action = LocalDomain;
    form.method = 'POST';
    for (key in array) {
        var hiddenToken = document.createElement('input');
        hiddenToken.type = 'hidden';
        hiddenToken.value = array[key];
        hiddenToken.name = key;
        form.appendChild(hiddenToken);
    }
    document.body.appendChild(form);
    form.submit();
}
function linking(){
    $(".lr-linked-data, .lr-unlinked-data").html('');
    $(".lr-linked").each(function() {
        $(".lr-linked-data").append($(this).html());
    });
    $(".lr-unlinked").each(function() {
        $(".lr-unlinked-data").append($(this).html());
    });
    var linked_val  =  $('.lr-linked-data').html();
    var unlinked_val  =  $('.lr-unlinked-data').html();
    if(linked_val != ''){

        $(".lr-linked-data").prepend('<div class="lr-heading">Linked Accounts</div>');
    }
    if(unlinked_val != ''){
        $(".lr-unlinked-data").prepend('<div class="lr-heading lr-heading-small">Choose a social account to link</div>');
    }
    $('#interfacecontainerdiv').hide();
}
//if possible, use a much better toggle
$(document).ready(function() {
    $('.lr-link').click(function(){
        var dataForm = $(this).attr("data-form");

        $('.lr-traditional-frame').removeClass('lr-form-active');

        $("#"+dataForm).addClass('lr-form-active');
    });

    // this makes the first element with that class visible.. if you don't want this.. add that class manually
    $('.lr-traditional-frame:eq(0)').addClass('lr-form-active');
});

//tabs
$(document).ready(function() {
    $('.lr-menu-buttons .lr-buttons').click(function(){
        var dataTab = $(this).attr("data-tab");

        $('.lr-menu-buttons .lr-buttons').removeClass('lr-tab-active');
        $('.lr-profile-frame .lr-frame').removeClass('lr-tab-active');

        $(this).addClass('lr-tab-active');
        $("#"+dataTab).addClass('lr-tab-active');
    });

    // this makes the first element with that class visible.. if you don't want this.. add that class manually
    $('.lr-menu-buttons .lr-buttons:eq(0)').addClass('lr-tab-active');
    $('.lr-profile-frame .lr-frame:eq(0)').addClass('lr-tab-active');
});

// Show Password

$(document).ready(function() {
    $('.lr-show-pw').click(function(){
        var dataTab = $('.lr-tab-active').attr("data-tab");
        var placeholder ='';
        var showPass = function() {
            $('.'+dataTab).find('input:password').each(function() {
              
                $("<input type='text' class='showPass' />").attr({ name: this.name, value: this.value }).insertBefore(this);
            }).remove();
        };
        var hidePass = function() {
            $('.'+dataTab).find('input.showPass').each(function() {
                
                $("<input type='Password' />").attr({ name: this.name, value: this.value }).insertBefore(this);
            }).remove();
        };

        if ($('.'+dataTab+' input:password').is(':visible')) {
            showPass();
            $('.lr-show-pw').addClass('lr-toggle');
         //   $('.'+dataTab+' input:text').focus();
        } else {
            hidePass();
            $('.lr-show-pw').removeClass('lr-toggle');
          //  $('.'+dataTab+' input:password').focus();
        }
    });
});