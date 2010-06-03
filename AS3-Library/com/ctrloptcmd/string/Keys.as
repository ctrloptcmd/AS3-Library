package com.ctrloptcmd.string {

			/**
		 	*		Keys.as
		 	*
		 	*		@langversion: ActionScript 3.0
		 	*		@playerversion: Flash 9.0
		 	*
			*		@author: Martin Jacobsen
			*		@site : http://ctrloptcmd.com
			*		@since: 27-05-2009
			*		@description : 
			*		Fixing shit that's broken.
			*		Use constants as Keys.A, Keys.B, Keys.C
			*		Get keyCodes from string: Keys.getKeyCodes("WTF");
			*		And, of course; Use Keys.KONAMI to listen for the konami code.
			*		
			*		Todo: Support for enter / return.
			*	
			*		@copyright : 
			*		No restrictions. Leave my name and link and do what thou wilt shall be the whole of the law.
			*		
			*/
				
	public class Keys {

		public static const A : uint = 65;
		public static const B : uint = 66;
		public static const C : uint = 67;
		public static const D : uint = 68;
		public static const E : uint = 69;
		public static const F : uint = 70;
		public static const G : uint = 71;
		public static const H : uint = 72;
		public static const I : uint = 73;
		public static const J : uint = 74;
		public static const K : uint = 75;
		public static const L : uint = 76;
		public static const M : uint = 77;
		public static const N : uint = 78;
		public static const O : uint = 79;
		public static const P : uint = 80;
		public static const Q : uint = 81;
		public static const R : uint = 82;
		public static const S : uint = 83;
		public static const T : uint = 84;
		public static const U : uint = 85;
		public static const V : uint = 86;
		public static const W : uint = 87;
		public static const X : uint = 88;
		public static const Y : uint = 89;
		public static const Z : uint = 90;
	
		public static const ZERO 	: uint = 48;
		public static const ONE 	: uint = 49;
		public static const TWO 	: uint = 50;			 
		public static const THREE 	: uint = 51;
		public static const FOUR 	: uint = 52;
		public static const FIVE 	: uint = 53;
		public static const SIX 	: uint = 54;
		public static const SEVEN 	: uint = 55;
		public static const EIGHT 	: uint = 56;
		public static const NINE 	: uint = 57;
		
		public static const LEFT 	: uint = 37; 
		public static const UP 		: uint = 38;
		public static const RIGHT 	: uint = 39;
		public static const DOWN 	: uint = 40;

		public static const SPACE : uint = 32; 

	/*		Language specific special chars go here. 
			Good form: Comment the char for each one you add. 
	*/
		public static const AE : uint = 222;		/* Norwegian Æ */
		public static const OE : uint = 186;		/* Norwegian Ø */
		public static const AA : uint = 219;		/* Norwegian Å */
		
	/*		EOF Special chars	*/
	

		
		
		
		private static const CODE : Array = [A,B,C,D,E,F,G,H,I,J,K,L,M,N,O,P,Q,R,S,T,U,V,W,X,Y,Z,AE,OE,AA,
														ZERO,ONE,TWO,THREE,FOUR,FIVE,SIX,SEVEN,EIGHT,NINE,SPACE];
		private static const CHAR : Array = "abcdefghijklmnopqrstuvwxyzæøå0123456789 ".split("");


	/*		Hey! Who doesn't need this all the time? 	*/
		public static const KONAMI : Array = [	UP, UP, DOWN, DOWN, LEFT, RIGHT, LEFT, RIGHT, B, A ];

		
		
		public function Keys () {		/*...*/		}
				
				
				
		public static function getKeyCodes( str : String ) : Array {
			
			var chars : Array = str.toLowerCase().split("");
			var codes : Array = [];			
				for (var i:int = 0; i < chars.length; i++) {
					var curChar : String = chars[i];
					for (var j : int = 0; j < CHAR.length; j++) {
						if(curChar == CHAR[j]){
							codes.push(CODE[j]);
						} 
					} 
				}
			return codes;
		}
		
						
		}

}
