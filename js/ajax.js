// will only run once the page Document Object Model (DOM) is ready for JavaScript code to execute.
$(document).ready(function () {







});





// will run once the entire page (images or iframes), not just the DOM, is ready.
$(window).on("load", function () {
    $('form').submit(function (event) {
        event.preventDefault();
        var formData = $('form').serialize();
        ajaxPOST(formData);
    });
});



//function ajaxGET(url, callback) {
//    var f = callback || function (data) {};
//    $.ajax({
//        type: 'GET',
//        url: url,
//        //        data: "format=json",
//        //        cache: false,
//        //        dataType: "jsonp",
//        //        timeout: 5000,
//        success: f(data),
//        error: function () {
//
//        }
//    });
//}


var $error_codes = [01, 803, 804, 805, 851, 853];
var $info_codes = [802, 852];
var $warning_codes = [806];


function ajaxPOST(postData) {
    console.log("CLIK");
    $.ajax({
        type: 'POST',
        url: '/server.php',
        data: postData,
        beforeSend: function (request) {
            request.setRequestHeader("Content-Type", 'application/x-www-form-urlencoded');
        },
        success: function (message) {
            
            console.log(message);
            var response = JSON.parse(message);
          
            var code = response.code;
                
            if(code == 800 || code == 850){
                $("#response").html(msg_success(response.msg));
            }
            else if ($.inArray(code, $error_codes) !== -1){
                $("#response").html(msg_error(response.msg));
            }
            else if ($.inArray(code, $warning_codes) !== -1){
                $("#response").html(msg_warning(response.msg));
            }
            else if ($.inArray(code, $info_codes) !== -1){
                $("#response").html(msg_info(response.msg));
            }
            

        },
        error: function (xhr, status, error) {
            if (xhr.responseText !== '') {
                $("#response").html(xhr.responseText);
            }
        }
    });
}


function msg_error(message){
    return $("<p>", {class: "msg_error", text: "<b>Error: </b>" + message.toLowerCase()});
}

function msg_success(message){
    return $("<p>", {class: "msg_success", text: message});
}

function msg_warning(message){
    return $("<p>", {class: "msg_warning", text: message});
}

function msg_info(message){
    return $("<p>", {class: "msg_info", text: message});
}
