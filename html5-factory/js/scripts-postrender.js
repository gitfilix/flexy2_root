	function calcHeight(){
				docHGT = $(document).height();
				winHGT = $(window).height();
				diffHGT = $(window).height() - $('.uppercontent').height();

				$('.cnt-wrapper').height(diffHGT)
			//	$('.cnt-wrapper').css('background-color','red');		
				
				
				hgtSIDEBAR = $('#text-20').height();
				hgtCONTENT = $('#text-80').height();
				
				
				// wenn keine sidebar
				if($('aside').length==0){
					
					// scroller auf body einschalten
					$('body').css({
						'overflow-y': 'auto'	
					});
					
					// wenn inhalt des contents wenifer als diff
					if(diffHGT > $('.lowercontent').height()){
						$('.lowercontent').height(diffHGT);	
					}
					// wenn inhalt höher als diff
					else{
						$('.lowercontent').height('auto');	
					}
				}
				// wenn sidebars vorhanden, body scroller wieder entfernen
				else{
					$('body').css({
						'overflow-y': 'hidden'	
					});
				}
				
				
				// nur re-calcen wenn grösser als 800
				if($(window).width()>800){
					// wenn content weniger hoch als diff
					if(docHGT <= winHGT){
						$('aside').height(diffHGT);		
						$('#text-80').height(diffHGT);		
					}
					// wenn content höher ls diff, entweder das eine oder andere dif dem anderen angleichen
					else{
						if($('aside').height()<$('#text-80').height()){
							$('aside').height($('#text-80').height())
						}	
						else{
							$('#text-80').height($('aside').height())	
						}
						$('body').css({
							'overflow-y': 'auto'	
						});
					}
					
				}
				// wenn kleiner als 800
				else{
					//höhen resetten
					$('aside').height('auto')
					$('#text-80').height('auto')
				}
				$('#text-20').css('background-color','#1B1B1B;')	
				$('#text-80').css('background-color','#FAFAFA;')
				
			}
	
	
			$(window).load(function(){
			//$(window).load(function(){
				
					calcHeight();		  
				
				
				//alert('diffHGT');
			});
			
			$(window).resize(function(){
			
					calcHeight();		  
				
			});				