package com.ctrloptcmd.string {


			/**
		 	*		Konami.as
		 	*		Up Up Down Down Left Right Left Right B A
		 	*
		 	*		@langversion: ActionScript 3.0
		 	*		@playerversion: Flash 9.0
		 	*
			*		@author: Martin Jacobsen
			*		@since: 27-05-2009
			*		@description : Simple Class to implement a 'cheat code' in your Flash app.
			*		Useful for easter eggs and similar shenaningans.
			*	
			*		Usage should be pretty straightforward. Needs a reference to stage for 
			*		listening purposes. If you don't pass an Array with keyCodes in 
			*		the constructor the Konami Code is used by default (using
			*		the KONAMI Constant of Keys.as).
			*	
			*		To use another default (or indeed to pass an Array from the calling class) 
			*		the easiest way is to use Keys.getKeyCodes("mystring");
			*		
			*		If you don't want to use Keys.as, delete line 41 and use any Array 
			*		of	keyCodes you please as the default.
			*	
			*		@copyright : 
			*		No restrictions. Leave my name and link and do what thou wilt shall 
			*		be the whole of the law
			*	
			*/		
	

		import flash.display.Stage;
		import flash.events.Event;
		import flash.events.KeyboardEvent;
		import flash.events.EventDispatcher;
		import com.ctrloptcmd.string.Keys;


		public class Konami extends EventDispatcher {

			private var sequence	: Array;
			private var count : int;

			public static const CODE_COMPLETE : String = "code_complete"; 

		public function Konami (stage : Stage, _sequence : Array = null){ 

			if(_sequence == null)
				sequence = Keys.KONAMI;
			else
				sequence = _sequence;

		  stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		  count = 0;

		  }

		private function onKeyUp( ke : KeyboardEvent) : void {  
			for (var i:int = 0; i < sequence.length; i++) {
			  if (count == i) {
			    if (ke.keyCode != sequence[i]) {
			      count = 0;
			      return;
			    } else {
			      count++;
			    if (count != sequence.length) {
			      return;
			      }
			    }
			  }
		  	if (count == sequence.length) {
		  		count = 0;
		  		dispatchEvent(new Event(CODE_COMPLETE,true,false));
		  }

		  }

		}
		}

}