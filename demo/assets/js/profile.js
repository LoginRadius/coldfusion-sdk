var stringVariable = window.location.href;
domainName = stringVariable.substring(0, stringVariable.lastIndexOf('/'));
$(function () {
    handleSetPassword();
    handleChangePassword();
    resetMultifactor();

    createCustomObjects();
    getCustomObjects();
    updateCustomObjects();
    deleteCustomObjects();
});

function handleSetPassword() {
    $('#btn-user-setpassword').on('click', function () {
        $("#user-setpassword-errorMsg").text("");
        $("#user-setpassword-successMsg").text("");
        if ($('#user-setpassword-password').val().trim() == '') {
            $("#user-setpassword-errorMsg").text("The password field is required.");
            return;
        } else if ($('#user-setpassword-password').val().trim().length < '6') {
            $("#user-setpassword-errorMsg").text("The Password field must be at least 6 characters in length.");
            return;
        }
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                uid: localStorage.getItem("LRUserID"),
                newpassword: $("#user-setpassword-password").val(),
                method: "setPassword"
            }),
            success: function (res) {
                $("#lr-loading").hide();
                if (res.status == 'error') {
                    $("#user-setpassword-errorMsg").text(res.message);
                } else if (res.status == 'success') {
                    $("#user-setpassword-password").val("");
                    $("#user-setpassword-successMsg").text(res.message);
                }
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-setpassword-errorMsg").text(xhr.responseText);
            }
        });

    });
}

function handleChangePassword() {
    $('#btn-user-changepassword').on('click', function () {
        $("#user-changepassword-errorMsg").text("");
        $("#user-changepassword-successMsg").text("");
        if ($('#user-changepassword-oldpassword').val().trim() == '' || $('#user-changepassword-newpassword').val().trim() == '') {
            $("#user-changepassword-errorMsg").text("The password field is required.");
            return;
        } else if ($('#user-changepassword-newpassword').val().trim().length < '6') {
            $("#user-changepassword-errorMsg").text("The New Password field must be at least 6 characters in length.");
            return;
        }
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                token: localStorage.getItem("LRTokenKey"),
                oldpassword: $("#user-changepassword-oldpassword").val(),
                newpassword: $("#user-changepassword-newpassword").val(),
                method: "changePassword"
            }),
            success: function (res) {
                $("#lr-loading").hide();
                if (res.status == 'error') {
                    $("#user-changepassword-errorMsg").text(res.message);
                } else if (res.status == 'success') {
                    $("#user-changepassword-oldpassword").val("");
                    $("#user-changepassword-newpassword").val("");
                    $("#user-changepassword-successMsg").text(res.message);
                }
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-changepassword-errorMsg").text(xhr.responseText);
            }
        });
    });
}

function createCustomObjects() {
    $('#btn-user-createcustomobj').on('click', function () {
        $("#user-createcustomobj-successMsg").text("");
        $("#user-createcustomobj-errorMsg").text("");
        var input = $("#user-createcustomobj-data").val();
        if ($('#user-createcustomobj-objectname').val().trim() == '') {
            $("#user-createcustomobj-errorMsg").text("The Object Name field is required.");
            return;
        } else if ($('#user-createcustomobj-data').val().trim() == '') {
            $("#user-createcustomobj-errorMsg").text("The Data field is required.");
            return;
        } else if (!IsJsonString(input)) {
            $("#user-createcustomobj-errorMsg").text("Invalid json in Data field.");
            return;
        }
      
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                uid: localStorage.getItem("LRUserID"),
                objectName: $("#user-createcustomobj-objectname").val(),
                payload: input,
                method: "createCustomObjects"
            }),
            success: function (res) {
                $("#lr-loading").hide();
                if (res.status == 'error') {
                    $("#user-createcustomobj-errorMsg").text(res.message);
                } else if (res.status == 'success') {
                        $("#user-createcustomobj-objectname").val("");              
                        $("#user-createcustomobj-data").val("");
                    $("#user-createcustomobj-successMsg").text(res.message);
                }
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-createcustomobj-errorMsg").text(xhr.responseText);
            }
        });
    });
}

function getCustomObjects() {
    $('#btn-user-getcustomobj').on('click', function () {
        $("#user-getcustomobj-errorMsg").text("");
        $("#user-getcustomobj-successMsg").text("");
        if ($("#user-getcustomobj-objectname").val().trim() == ''){
            $("#user-getcustomobj-errorMsg").text("The Object Name field is required.");
            return;
        }
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                uid: localStorage.getItem("LRUserID"),
                objectName: $("#user-getcustomobj-objectname").val(),
                method: "getCustomObjects"
            }),
            success: function (res) {
                $("#lr-loading").hide();
                $("#user-getcustomobj-errorMsg").text("");
                if (res.status == 'error') {
                    $("#user-getcustomobj-errorMsg").text(res.message);
                    $('#customobj-table').html('');
                } else if (res.status == 'success') {
                    $("#user-getcustomobj-objectname").val("");       
                    
                    $('#customobj-table').html('');
                    $('#customobj-table').append('<tr><th>Object ID</th><th>Custom Object</th></tr>');
                    for (var i = 0; i < res.result.data.length; i++) {
                        var id = res.result.data[i].Id;
                        var custobj = res.result.data[i].CustomObject;
                        $('#customobj-table').append('<tr><td>' + id + '</td><td>' + JSON.stringify(custobj) + '</td></tr>');
                    }
                }
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-getcustomobj-errorMsg").text(xhr.responseText);
            }
        });
    });
}

function updateCustomObjects() {
    $('#btn-user-updatecustomobj').on('click', function () {       
        $("#user-updatecustomobj-errorMsg").text("");
        $("#user-updatecustomobj-successMsg").text("");
        var input = $("#user-updatecustomobj-data").val();
        if ($('#user-updatecustomobj-objectname').val().trim() == '') {
            $("#user-updatecustomobj-errorMsg").text("The Object Name field is required.");
            return;
        } else if ($('#user-updatecustomobj-objectrecordid').val().trim() == '') {
            $("#user-updatecustomobj-errorMsg").text("The Object Record Id field is required.");
            return;
        }else if ($('#user-updatecustomobj-data').val().trim() == '') {
            $("#user-updatecustomobj-errorMsg").text("The Data field is required.");
            return;
        } else if (!IsJsonString(input)) {
            $("#user-updatecustomobj-errorMsg").text("Invalid json in Data field");
            return;
        }
        
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                uid: localStorage.getItem("LRUserID"),
                objectName: $("#user-updatecustomobj-objectname").val(),
                objectRecordId: $("#user-updatecustomobj-objectrecordid").val(),
                payload: input,
                method: "updateCustomObjects"
            }),

            success: function (res) {
                $("#lr-loading").hide();
                if (res.status == 'error') {
                    $("#user-updatecustomobj-errorMsg").text(res.message);
                } else if (res.status == 'success') { 
                    $("#user-updatecustomobj-objectname").val("");
                    $("#user-updatecustomobj-objectrecordid").val("");
                    $("#user-updatecustomobj-data").val("");
                    $("#user-updatecustomobj-successMsg").text(res.message);
                }
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-updatecustomobj-errorMsg").text(xhr.responseText);             
            }
        });
    });
}

function deleteCustomObjects() {
    $('#btn-user-deletecustomobj').on('click', function () {
        $("#user-deletecustomobj-errorMsg").text(""); 
        $("#user-deletecustomobj-successMsg").text(""); 
        if ($('#user-deletecustomobj-objectname').val().trim() == '') {
            $("#user-deletecustomobj-errorMsg").text("The Object Name field is required.");
            return;
        } else if ($('#user-deletecustomobj-objectrecordid').val().trim() == '') {
            $("#user-deletecustomobj-errorMsg").text("The Object Record Id is required.");
            return;
        }
        
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                uid: localStorage.getItem("LRUserID"),
                objectName: $("#user-deletecustomobj-objectname").val(),
                objectRecordId: $("#user-deletecustomobj-objectrecordid").val(),
                method: "deleteCustomObjects"
            }),
            success: function (res) {
                $("#lr-loading").hide();
                if (res.status == 'error') {
                    $("#user-deletecustomobj-errorMsg").text(res.message);
                } else if (res.status == 'success') {
                    $("#user-deletecustomobj-objectname").val("");   
                    $("#user-deletecustomobj-objectrecordid").val("");   
                    $("#user-deletecustomobj-successMsg").text(res.message);
                }
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-deletecustomobj-errorMsg").text(xhr.responseText); 
            }
        });
    });
}

function resetMultifactor() {
    $('#btn-user-mfa-resetgoogle').on('click', function () {
        $("#user-mfa-successMsg").text("");
        $("#user-mfa-errorMsg").text("");
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                uid: localStorage.getItem("LRUserID"),
                method: "resetMultifactor"
            }),
            success: function (res) {
                $("#lr-loading").hide();
                if (res.status == 'error') {
                    $("#user-mfa-errorMsg").text(res.message);
                } else if (res.status == 'success') {
                    $("#user-mfa-successMsg").text(res.message);
                }
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-mfa-errorMsg").text(xhr.responseText);        
            }
        });
    });
}

function IsJsonString(str) {
    try {
        JSON.parse(str);
    } catch (e) {
        return false;
    }
    return true;
}