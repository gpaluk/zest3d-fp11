/**
 * Plugin.IO - http://www.plugin.io
 * Copyright (c) 2013
 *
 * Geometric Tools, LLC
 * Copyright (c) 1998-2012
 * 
 * Distributed under the Boost Software License, Version 1.0.
 * http://www.boost.org/LICENSE_1_0.txt
 */
package zest3d.shaders.enum 
{
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class OperationType 
	{
		
		public static const KEEP: OperationType = new OperationType( "keep", 0 );
		public static const ZERO: OperationType = new OperationType( "zero", 1 );
		public static const REPLACE: OperationType = new OperationType( "replace", 2 );
		public static const INCREMENT: OperationType = new OperationType( "increment", 3 );
		public static const DECREMENT: OperationType = new OperationType( "decrement", 4 );
		public static const INVERT: OperationType = new OperationType( "invert", 5 );
		
		public static const QUANTITY: int = 6;
		
		protected var _type: String;
		protected var _index: int;
		
		public function OperationType( type: String, index: int ) 
		{
			_type = type;
			_index = index;
		}
		
		public static function toVector(): Vector.<OperationType>
		{
			return Vector.<OperationType>
			([
				KEEP,
				ZERO,
				REPLACE,
				INCREMENT,
				DECREMENT,
				INVERT
			]);
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function get index():int 
		{
			return _index;
		}
		
	}

}