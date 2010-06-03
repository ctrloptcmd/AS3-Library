package com.ctrloptcmd.utils {

		/**
	 	*		XTrace.as
	 	*
	 	*		@langversion	: ActionScript 3.0
	 	*		@playerversion	: Flash 9.0
	 	*
		*		@author			: Martin Jacobsen
		* 		@url			: http://ctrloptcmd.com/
		*		@since			: 24-03-2009
		*		@description 	: Simple logging utility for outputting traces to Firebug
		* 						or any other console. Uses the regular trace() function when
		* 						in the Flash IDE, and sends traces to the console when deployed.
		* 						set XTrace.ENABLED to false in your Document Class to disable tracing.
		* 						
		*	      
		*/
	
	import flash.system.Capabilities;
	import flash.external.ExternalInterface;
	
	public class XTrace {

		public static var ENABLED 		: Boolean = true;
		public static var DELIMITER		: String = "\n\t";
		private static var HAS_WARNED 	: Boolean = false;

		public function XTrace(){	/*...*/	  }	

		public static function log(...args) : void 
		{
			var logEntry : String = (args.length > 1) ? args.join(DELIMITER) : args[0];
				XTrace.sendToConsole("console.log" , logEntry);
				logEntry = null;
		}

		public static function info(...args) : void 
		{
			var infoEntry : String= (args.length > 1) ? args.join(DELIMITER) : args[0];
				XTrace.sendToConsole("console.info" , infoEntry);
				infoEntry = null;
		}

		public static function warn(...args) : void 
		{
			var warnEntry : String = (args.length > 1) ? args.join(DELIMITER) : args[0];
				XTrace.sendToConsole("console.warn" , warnEntry);
				warnEntry = null;
		}

		public static function error(...args) : void 
		{
			var errorEntry : String = (args.length > 1) ? args.join(DELIMITER) : args[0];
				XTrace.sendToConsole("console.error" , errorEntry);
				errorEntry = null;
		}
		
		public static function sendToConsole(logLevel : String , str : * = "") : void 
		{
			if(ENABLED){
				switch (Capabilities.playerType) {
	            case "PlugIn":
	            case "ActiveX":
		            try {
						ExternalInterface.call(logLevel, str);
					} catch (e:Error) {
						trace("XTrace had a glitch: ", e.message)
					}
	            break;
					default :
						trace(str);
					break;
	        	}
			} else {
				if(!HAS_WARNED)
					trace("XTrace is disabled. Set XTrace.ENABLED to true to receive log messages.")
					HAS_WARNED = true;
			} 
		}
	}
}