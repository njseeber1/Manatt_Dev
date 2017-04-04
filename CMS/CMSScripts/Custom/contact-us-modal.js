
var practiceChairEmail = "";

$('#contactsModal').on('shown.bs.modal', function () {
    $("#contactDiv input,textarea").val("");
    if (practiceChairEmail !== "")
        $('#contactemail').val(practiceChairEmail);
});

$('#send').click(function () {
    var isValid = true;
    practiceChairEmail = "";
    var $contactemail = $('#contactemail');
    var $name = $("#contactsModal #name");
    var $email = $("#contactsModal #email");
    var $title = $("#contactsModal #title");
    var $phone = $("#contactsModal #phone");
    var $message = $("#contactsModal #message");

    $("#contactDiv p.error").remove();

    if ($name.val() == "") {
        $name.after("<p class='error text-danger'>Please enter your name.</p>");
        isValid = false;
    }
    if ($email.val() == "") {
        $email.after("<p class='error text-danger'>Please enter your email address.</p>");
        isValid = false;
    }
    else {
        if (isEmail($email.val()) == false) {
            $email.after("<p class='error text-danger'>Please enter a valid email address.</p>");
            isValid = false;
        }
    }
    if ($message.val() == "") {
        $message.after("<p class='error text-danger'>Please enter your message.</p>");
        isValid = false;
    }

    if (isValid) {
        WebService.SendContactForm($contactemail.val(), $email.val(), $name.val(), $title.val(), $phone.val(), $message.val(), "", sendSuccess, sendError);
        $('#contactsModal').modal('hide');
    }

});

function isEmail(email) {
    var emailReg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
    return emailReg.test(email);
}

function sendSuccess(s) {
    //send google analytics tracking
    ga('send', 'event', 'Form Submission', 'Inquiry', 'Contact Form');
}

function sendError(error) {
    console.log("Stack Trace: " + error.get_stackTrace() + "/r/n" +
         "Error: " + error.get_message() + "/r/n" +
         "Status Code: " + error.get_statusCode());
}

function SendEmailToPracticeChair(email) {
    practiceChairEmail = email;
    $('#contactsModal').modal('show');
}

