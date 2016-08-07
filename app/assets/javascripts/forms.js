$(document).ready(function(){
  $("div#otherField").hide();

  $(document).on('change', 'select#organization_org_type', function(e) {
    if($(this).val() == 'Other'){
      $("div#otherField").css('display','block');
    }else{
      $("div#otherField").css('display','none');
      console.log(this.options[e.target.selectedIndex].text);
    };
    (function($){
	function floatLabel(inputType){
		$(inputType).each(function(){
			var $this = $(this);
			// on focus add cladd active to label
			$this.focus(function(){
				$this.next().addClass("active");
			});
			//on blur check field and remove class if needed
			$this.blur(function(){
				if($this.val() === '' || $this.val() === 'blank'){
					$this.next().removeClass();
				}
			});
		});
	}
	// just add a class of "floatLabel to the input field!"
	floatLabel(".floatLabel");
})(jQuery);
  });
});
