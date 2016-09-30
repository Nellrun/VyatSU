jQuery(function($){
        $(document).pngFix(); 


 
	$(".registr").click(									
function(){$(".reg_01").slideToggle('slideDown');});
$(".clos").click(									
function(){	$(".reg_01").slideToggle('slideDown');});

$("#into_site").click(									
function(){$(".reg_01").slideToggle('slideDown');});
 

//$("#r_zag_corn").corner( "br top").corner("notch bl 20px");
//$("#r_zag_corn").corner("15px");

});

jQuery(document).ready(function(){

/* функция кроссбраузерного определения отступа от верха документа к текущей позиции скроллера прокрутки */
function getScrollTop() {
           var scrOfY = 0;
           if( typeof( window.pageYOffset ) == "number" ) {
                   //Netscape compliant
                   scrOfY = window.pageYOffset;
           } else if( document.body
           && ( document.body.scrollLeft
           || document.body.scrollTop ) ) {
                   //DOM compliant
                   scrOfY = document.body.scrollTop;
           } else if( document.documentElement
           && ( document.documentElement.scrollLeft
            || document.documentElement.scrollTop ) ) {
                   //IE6 Strict
                   scrOfY = document.documentElement.scrollTop;
           }
           return scrOfY;
}

jQuery(window).scroll(function() {
	fixPaneRefresh();
});

function fixPaneRefresh(){
		var top  = getScrollTop();
        if (top < 260){ jQuery("#fixedBox").css("margin-top",0-top+"px");
		}else {
			$("#fixedBox").css("margin-top","-260px");
		}

		if (top < 540){
			$("#tr").html($("#fixedBox1").css("display"));
				$("#fixedBox1").fadeOut('show');
		}else {
			$("#fixedBox1").css("top","7px");
			$("#fixedBox1").fadeIn('show');
		}
}

});