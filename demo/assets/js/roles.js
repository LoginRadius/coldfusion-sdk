var stringVariable = window.location.href;
domainName = stringVariable.substring(0, stringVariable.lastIndexOf('/'));
$(function () {
    getAllRoles();
    getUserRoles();
    handleCreateRole();
    handleDeleteRole();
    handleAssignUserRole();  
});

function handleCreateRole() {
    $('#btn-user-createrole').on('click', function () {
        $("#user-createrole-errorMsg").text("");
        $("#user-createrole-successMsg").text("");
        if ($("#user-roles-createrole").val().trim() == '') {
            $("#user-createrole-errorMsg").text("The Role field is required.");
            return;
        }
        var input = $("#user-roles-createrole").val();
        if (!IsJsonString(input)) {
            $("#user-createrole-errorMsg").text("Invalid json in Role field.");
            return;
        }
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                roles: $("#user-roles-createrole").val(),
                method: "handleCreateRole"
            }),
            success: function (res) {
                $("#lr-loading").hide();
                if (res.status == 'error') {
                    $("#user-createrole-errorMsg").text(res.message);
                } else if (res.status == 'success') {
                    $("#user-createrole-successMsg").text(res.message);
                    $("#user-roles-createrole").val('');
                }
                getAllRoles(); // re-render table
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-createrole-errorMsg").text(xhr.responseText);         
            }
        });
    });
}

function handleDeleteRole() {
    $('#btn-user-deleterole').on('click', function () {
        $("#user-deleterole-errorMsg").text("");
        $("#user-deleterole-successMsg").text("");
        if ($("#user-roles-deleterole").val().trim() == '') {
            $("#user-deleterole-errorMsg").text("The Role field is required.");
            return;
        }
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                roles: $("#user-roles-deleterole").val(),
                method: "handleDeleteRole"
            }),
            success: function (res) {
                $("#lr-loading").hide();
                if (res.status == 'error') {
                    $("#user-deleterole-errorMsg").text(res.message);
                } else if (res.status == 'success') {
                    $("#user-deleterole-successMsg").text(res.message);   
                    $("#user-roles-deleterole").val('');
                }
                getAllRoles();
                getUserRoles();
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-deleterole-errorMsg").text(xhr.responseText);
                $("#user-deleterole-successMsg").text("");
            }
        });
    });
}

function handleAssignUserRole() {
    $('#btn-user-assignrole').on('click', function () {
        $("#user-assignrole-errorMsg").text("");
        $("#user-assignrole-successMsg").text("");        
        if ($("#user-roles-assignrole").val().trim() == '') {
            $("#user-assignrole-errorMsg").text("The Role field is required.");
            return;
        }
        var input = $("#user-roles-assignrole").val();
        if (!IsJsonString(input)) {
            $("#user-assignrole-errorMsg").text("Invalid json in Role field.");
            return;
        }
        $("#lr-loading").show();
        $.ajax({
            type: "POST",
            url: domainName + "/ajax_handler/profile.cfc",
            dataType: "json",
            data: $.param({
                uid: localStorage.getItem("LRUserID"),
                roles: $("#user-roles-assignrole").val(),
                method: "handleAssignUserRole"
            }),
            success: function (res) {
                $("#lr-loading").hide();
                if (res.status == 'error') {
                    $("#user-assignrole-errorMsg").text(res.message);
                } else if (res.status == 'success') {
                    $("#user-assignrole-successMsg").text(res.message);
                    $("#user-roles-assignrole").val('');
                }
                getUserRoles();
            },
            error: function (xhr, status, error) {
                $("#lr-loading").hide();
                $("#user-assignrole-errorMsg").text(xhr.responseText);                
            }
        });
    });
}

function getAllRoles() {
    $.ajax({
        type: "POST",
        url: domainName + "/ajax_handler/profile.cfc",
        dataType: "json",
        data: $.param({
            method: "getAllRoles"
        }),
        success: function (res) {
            if (res.status == 'error') {
                console.log("Get All Roles err::", res.message);
            } else if (res.status == 'success') {
                $('#table-allroles').html('');
                $('#table-allroles').append('<tr><th>Role</th></tr>');

                if (res.result.data == null)
                    return;
                for (var i = 0; i < res.result.data.length; i++) {
                    var name = res.result.data[i].Name;
                    $('#table-allroles').append('<tr><td>' + name + '</td></tr>');
                }
            } else if (res.status == 'rolesempty') {
                $('#table-allroles').html('');
            }
        },
        error: function (xhr, status, error) {
            console.log("Get All Roles");
        }
    });
}

function getUserRoles() {
    $.ajax({
        type: "POST",
        url: domainName + "/ajax_handler/profile.cfc",
        data: $.param({
            uid: localStorage.getItem("LRUserID"),
            method: "getUserRoles"
        }),
        dataType: "json",
        success: function (res) {
            if (res.status == 'error') {
                console.log("Get User Roles success::", res.message);
            } else if (res.status == 'success') {
                $('#table-userroles').html('');
                $('#table-userroles').append('<tr><th>Role</th></tr>');

                if (res.data.Roles == null)
                    return;
                for (var i = 0; i < res.data.Roles.length; i++) {
                    var name = res.data.Roles[i];
                    $('#table-userroles').append('<tr><td>' + name + '</td></tr>');
                }
            } else if (res.status == 'userrolesempty') {
                $('#table-userroles').html('');
            }
        },
        error: function (xhr, status, error) {
            console.log("Get User Roles");
        }
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