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
	public class CompareMode 
	{
		
		public static const NEVER: CompareMode = new CompareMode( "never", 0 );
		public static const LESS: CompareMode = new CompareMode( "less", 1 );
		public static const EQUAL: CompareMode = new CompareMode( "equal", 2 );
		public static const LEQUAL: CompareMode = new CompareMode( "lequal", 3 );
		public static const GREATER: CompareMode = new CompareMode( "greater", 4 );
		public static const NOTEQUAL: CompareMode = new CompareMode( "notequal", 5 );
		public static const GEQUAL: CompareMode = new CompareMode( "gequal", 6 );
		public static const ALWAYS: CompareMode = new CompareMode( "always", 7 );
		
		public static const QUANTITY: int = 8;
		
		public static function toVector(): Vector.<CompareMode>
		{
			return Vector.<CompareMode>
			([
				NEVER,
				LESS,
				EQUAL,
				LEQUAL,
				GREATER,
				NOTEQUAL,
				GEQUAL,
				ALWAYS
			]);
		}
		
		protected var _type: String;
		protected var _index: int;
		public function CompareMode( type: String, index: int ) 
		{
			_type = type;
			_index = index;
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