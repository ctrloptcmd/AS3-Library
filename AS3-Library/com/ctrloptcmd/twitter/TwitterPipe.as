package com.ctrloptcmd.twitter {	
	
		/**
	 	*		TwitterPipe.as
	 	*
	 	*		@langversion: ActionScript 3.0
	 	*		@playerversion: Flash 10.0
	 	*
		*		@author: Martin Jacobsen
		*		@since: 22-03-2009
		*	
		*		@description : Cleaned up version of the previous "TweetPipeLoad" 
		*		class which was written by a younger, more foolish and not quite as 
		*		pretty version of myself. I'm not saying this class is by any means
		*		a stroke of genius, but by jove it certainly is an improvement on
		*		the dreadful mess of the old one.
		*	
		*		This new and improved version has far less unused "mass imports", less 
		*		incomprehensible variables and actually uses E4X for what it's worth 
		*		rather than clumsily climbing through XMLNode hierarchies AS2 style.
		*	
		*		Also; This class utilizes the URLValidator class for parsing through
		*		tweets for URLs rather than relying on string-parsing mumbo jumbo and
		*		misunderstood implementation of black magic regular expressions to try 
		*		and figure out whether there are any URLs present. Just trust me on this; 
		*		It's better. 
		*	
		*		Note that this version returns a Vector with objects rather than just strings.
		*		I found that returning objects and accessing the different versions of the
		*		string representations seemed somehow easier to use. It also makes it easy to 
		*		later expand upon with a "Tweet" class if that should prove interesting at 
		*		any time.
		*	
		*		The class uses Vectors because it seems to be all the rage these
		*		days among the optimization literati. If you don't like Flash Player
		*		10, feel free to swap them for Arrays, as I don't think there's anything
		*		else in here that necessitates FP10.
		*	
		*/
	
	
		import flash.net.URLLoader;
		import flash.net.URLRequest;
		import flash.net.URLVariables;

		import flash.events.Event;
		import flash.events.EventDispatcher;
		import flash.events.IOErrorEvent;import com.ctrloptcmd.utils.XTrace;
		
		
		import com.ctrloptcmd.string.URLValidator;

	public class TwitterPipe extends EventDispatcher {

			private var request 			: URLRequest;
			private var variables		: URLVariables;
			private var loader 			: URLLoader;

			private var txml 				: XML;
			private var urlvalidator	: URLValidator;

			private var ignoreReplies 	: Boolean;
			private var userID 			: String;

			public var tweets				: Vector.<Object>;
			
			public static const FAILWHALE : String = "failwhale"; 
			public static const FREEBIRD : String = "freebird"; 
			

		public function TwitterPipe (_userID : String, _ignoreReplies : Boolean = true) {
		   	
				ignoreReplies	= _ignoreReplies;
				userID 			= _userID;

				variables 			= new URLVariables();
				variables._render = "rss";
				variables.twitter = userID;

				request = new URLRequest("http://pipes.yahooapis.com/pipes/pipe.run?_id=4b85031723ba7785e277add01b0169c5&_render=rss&twitter="+userID);
				request.data = variables;
								
				loader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, onLoadComplete);
				loader.addEventListener(IOErrorEvent.IO_ERROR, onLoadIOError);
				loader.load(request);
			
		}
			
			
		private function onLoadComplete(e:Event) : void {
			if (loader.data) {
				tweets = new Vector.<Object>();
				urlvalidator = new URLValidator();
				txml = new XML(loader.data);
					for each (var xTweet:XML in txml..item..description.text()) {
						var sTweet : String = xTweet.toString();
						/*trace("From the pipe: " + sTweet)*/
						var tweet : Object = {};
							tweet.raw = sTweet;
							tweet.chopped = sTweet.substr(sTweet.indexOf(":") + 2);
							tweet.linked = urlvalidator.tag(sTweet);
							tweet.choppedAndLinked = urlvalidator.tag(sTweet.substr(sTweet.indexOf(":") + 2));
							
							if(sTweet.indexOf("@") > -1)
								tweet.friendly = true;
							else
								tweet.friendly = false;
							
							if(!ignoreReplies)
								tweets.push(tweet);
							else if (ignoreReplies && !tweet.friendly)
								tweets.push(tweet);
				}
					this.dispatchEvent(new Event(FREEBIRD));
			}
		}	

		public function getTweets(): Vector.<Object> {
			return tweets;
		}

		private function onLoadIOError(ioe : IOErrorEvent) : void {
					this.dispatchEvent(new Event(FAILWHALE));
					XTrace.log("From: TwitterPipe => onLoadIOError", ioe.type);
		}


		}

}