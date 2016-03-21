   $(document).ready(function(){
      sendForm();
   });
   function sendForm(){
   $('form.remote-form').submit(function() {
         var $form = $(this),
         url = $form.attr('action'),
         formData = new FormData( $form[0] );
         sendingAJAX(url, formData,function(data, err){
          if (err) 
              return console.log("Ha ocurrido un error al enviar el formulario");
          $('form')[0].reset();
         });
       
       return false; 
   });
  }

  function sendingAJAX(url, formData ,callback){
  $.ajax({
      url: url,
      data: formData,
      processData: false,
      contentType: false,
      type: 'POST',
      success: function(data) {
          callback(data, null);
          headNotice("<p style='font-size:20px; color: #fff; margin-top:20px;'>Formulario enviado correctamente</p>");
      },
      error: function(err) {
          callback(null, err);
            headError("<p style='font-size:20px; color: #fff; margin-top:20px;'>Ha ocurrido un error al enviar el formulario disculpe.</p>");
           }

  });
  }
  function headNotice(text){
  $('.notice_head').html(text);
  $('.notice_head').slideToggle();
    setTimeout(function(){ $('.notice_head').slideToggle(); }, 3000);
  }

  function headError(text){
    $('.errors').html(text);
    $('.errors').slideToggle();
    setTimeout(function(){ $('.errors').slideToggle(); }, 5000);

  }