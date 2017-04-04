var practiceName = "";   
var practiceChairEmail = "";
  
  WebService.GetPracticeNameByDocumentId(contactmodal_documentId,function success(data) {
      practiceName = data;
    },
  function error(err) {
    console.log("Stack Trace: " + err.get_stackTrace() + "/r/n" +
          "Error: " + err.get_message() + "/r/n" +
          "Status Code: " + err.get_statusCode());
    }); 

WebService.GetChairPersons(contactmodal_documentId, serviceSuccess, serviceFailed);

$('#contactsModal').on('shown.bs.modal', function () {    
    $("#contactDiv input,textarea").val("");  
    if(practiceChairEmail !== "")
         $('#practice-chairs').selectpicker('val', practiceChairEmail); 
});

function serviceSuccess(results)
{
   if(results)
   {         
      var options = $("#practice-chairs");
      
      if(options == undefined)
        return;

      options.find('option')
      .remove()
        .end()
        .append('<option value="">Select Practice Chair</option>')
        .val('');
           
      $.each(results, function () {
      options.append($("<option />").val(this.Email).text(this.FullName));
    });
      
       if(results.length == 1){
         $('div.chairs').eq(0).hide();
         options.val(results[0].Email);
       }                
       else{                 
         $('div.chairs').eq(0).show();
       }

       options.selectpicker('refresh');     
   }
}
function serviceFailed(error){
     console.log("Stack Trace: " + error.get_stackTrace() + "/r/n" +
          "Error: " + error.get_message() + "/r/n" +
          "Status Code: " + error.get_statusCode());
}
  
$('#send').click(function()
{  
  var isValid = true;
  practiceChairEmail = "";
  var $chair = $("#contactsModal #practice-chairs");
  var $name = $("#contactsModal #name");  
  var $email = $("#contactsModal #email");
  var $title = $("#contactsModal #title");
  var $phone = $("#contactsModal #phone");
  var $message = $("#contactsModal #message");

  $("#contactDiv p.error").remove();

  if($chair.val() == ""){
    $chair.after("<p class='error text-danger'>Please select a practice chair.</p>");
    isValid = false;
  }
  if($name.val() == ""){
    $name.after("<p class='error text-danger'>Please enter your name.</p>");
    isValid = false;
  }
  if($email.val() == ""){   
    $email.after("<p class='error text-danger'>Please enter your email address.</p>");
    isValid = false;
  }  
  else
  {
    if(isEmail($email.val()) == false){
    $email.after("<p class='error text-danger'>Please enter a valid email address.</p>");
    isValid = false;  
    }
  }
  if($message.val() == ""){
    $message.after("<p class='error text-danger'>Please enter your message.</p>");
    isValid = false;
  }

  if(isValid)
  {
    WebService.SendContactForm($chair.val(), $email.val(), $name.val(), $title.val(), $phone.val(), $message.val(), practiceName, sendSuccess, sendError);
    $('#contactsModal').modal('hide');
  }
  
});
  
function isEmail(email)
{      
  var emailReg = /^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$/;
  return emailReg.test(email); 
}

function sendSuccess(s){
  //send google analytics tracking
  ga('send', 'event', 'Form Submission', 'Inquiry', 'Contact Form');
}

function sendError(error){
     console.log("Stack Trace: " + error.get_stackTrace() + "/r/n" +
          "Error: " + error.get_message() + "/r/n" +
          "Status Code: " + error.get_statusCode());
}

function SendEmailToPracticeChair(email){
  practiceChairEmail = email;
  $('#contactsModal').modal('show');
}

