package com.ctrloptcmd.utils{

	public class Calculator  {

	public function Calculator () { /*...*/ }

/* Radians to degrees and vice versa */

	public static function radToDeg( radian : Number ) : Number {
		var degree:Number;
			degree = radian * 180 / Math.PI;
		return degree;
	}
	
	public static function degToRad( degree : Number ) : Number {
		var radian:Number;
			radian = degree * Math.PI / 180;
		return radian;
	}
	
/* Odd or Even number */	
	
	public static function oddEven( num : int ) : String {
		var parity : String;
	    num % 2 ? parity = "odd" : parity = "even";
	    return parity;
	}
	

/* Random Range */

	public static function randomRange(low:Number, high:Number, rounded:Boolean = false) : Number {
		if(rounded)
		return Math.round(Math.random() * (high - low)) + low;
		else
		return Math.random() * (high - low) + low;
	}
	
	
	public static function randomBoolean(chance:Number=0.5):Boolean {
		return (Math.random() < chance);
	}
	
	
	}
	
}