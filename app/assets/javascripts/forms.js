$(document).ready(function(){
  $("div#otherField").hide();

  $(document).on('change', 'select#organization_org_type', function(e) {
    if($(this).val() == 'Other'){
      $("div#otherField").css('display','block');
    }else{
      $("div#otherField").css('display','none');
      console.log(this.options[e.target.selectedIndex].text);
    };
  });


  $(document).on('change', 'select#organization_org_type', function(e) {
    if($(this).val() == 'Shelter'){
      $("div#otherField2").css('display','block');
    }else{
      $("div#otherField2").css('display','none');
      console.log(this.options[e.target.selectedIndex].text);
    };
  });
});
