$('#sendSharePageEmail').click(function()
{  
  
  var isValid = true;
  var $senderName = $("#senderName");
  var $recipientName = $("#recipientName");  
  var $senderEmail = $("#senderEmail");
  var $recipientEmail = $("#recipientEmail");

  $("#shareDiv p.error").remove();

  if($senderName.val() == ""){
    $senderName.after("<p class='error text-danger'>Please enter your name.</p>");
    isValid = false;
  }
  if($recipientName.val() == ""){
    $recipientName.after("<p class='error text-danger'>Please enter the recipient's name.</p>");
    isValid = false;
  }
  if($senderEmail.val() == ""){   
    $senderEmail.after("<p class='error text-danger'>Please enter your email address.</p>");
    isValid = false;
  }  
  else
  {
    if(isEmail($senderEmail.val()) == false){
    $senderEmail.after("<p class='error text-danger'>Please enter a valid email address.</p>");
    isValid = false;  
    }
  }
  if($recipientEmail.val() == ""){   
    $recipientEmail.after("<p class='error text-danger'>Please enter the recipient's email address.</p>");
    isValid = false;
  }  
  else
  {
    if(isEmail($recipientEmail.val()) == false){
    $recipientEmail.after("<p class='error text-danger'>Please enter a valid email address.</p>");
    isValid = false;  
    }
  }  

  if(isValid)
  {	
    WebService.SendShareThisPageEmail($senderName.val(), $recipientName.val(), $senderEmail.val(), $recipientEmail.val(), window.location.href , sendSuccess, sendError);
    $('#sharePageModal').modal('hide');
  }  
});
  
function isEmail(email)
{      
  var emailReg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  return emailReg.test(email); 
}


function sendSuccess(s) {
    //send google analytics tracking
    ga('send', 'event', 'Form Submission', 'Share Page', 'Share Form');
}

function sendError(error) {
    console.log("Stack Trace: " + error.get_stackTrace() + "/r/n" +
         "Error: " + error.get_message() + "/r/n" +
         "Status Code: " + error.get_statusCode());
}

function OpenShareThisPageModal(){
  $("#shareDiv p.error").remove();
  $("#senderName").val("");
  $("#recipientName").val("");
  $("#senderEmail").val("");
  $("#recipientEmail").val("");
  $('#sharePageModal').modal('show');
}