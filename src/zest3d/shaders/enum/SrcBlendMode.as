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
	public class SrcBlendMode 
	{
		
		public static const ZERO: SrcBlendMode = new SrcBlendMode( "zero", 0 );
		public static const ONE: SrcBlendMode = new SrcBlendMode( "one", 1 );
		public static const DST_COLOR: SrcBlendMode = new SrcBlendMode( "dstColor", 2 );
		public static const ONE_MINUS_DST_COLOR: SrcBlendMode = new SrcBlendMode( "oneMinusDstColor", 3 );
		public static const SRC_ALPHA: SrcBlendMode = new SrcBlendMode( "srcAlpha", 4 );
		public static const ONE_MINUS_SRC_ALPHA: SrcBlendMode = new SrcBlendMode( "oneMinusSrcAlpha", 5 );
		public static const DST_ALPHA: SrcBlendMode = new SrcBlendMode( "dstAlpha", 6 );
		public static const ONE_MINUS_DST_ALPHA: SrcBlendMode = new SrcBlendMode( "oneMinusDstAlpha", 7 );
		public static const SRC_ALPHA_SATURATE: SrcBlendMode = new SrcBlendMode( "srcAlphaSaturate", 8 );
		public static const CONSTANT_COLOR: SrcBlendMode = new SrcBlendMode( "constantColor", 9 );
		public static const ONE_MINUS_CONSTANT_COLOR: SrcBlendMode = new SrcBlendMode( "oneMinusConstantColor", 10 );
		//public static const CONSTANT_ALPHA: SrcBlendMode = new SrcBlendMode( "constantAlpha", 11 );
		//public static const ONE_MINUS_CONSTANT_ALPHA: SrcBlendMode = new SrcBlendMode( "oneMinusConstantAlpha", 12 );
		
		public static const QUANTITY: int = 11;
		
		
		public static function toVector():Vector.<SrcBlendMode>
		{
			return Vector.<SrcBlendMode>
			([
				ZERO,
				ONE,
				DST_COLOR,
				ONE_MINUS_DST_COLOR,
				SRC_ALPHA,
				ONE_MINUS_SRC_ALPHA,
				DST_ALPHA,
				ONE_MINUS_DST_ALPHA,
				SRC_ALPHA_SATURATE,
				CONSTANT_COLOR,
				ONE_MINUS_CONSTANT_COLOR/*,
				CONSTANT_ALPHA,
				ONE_MINUS_CONSTANT_ALPHA*/
			]);
		}
		
		protected var _type: String;
		protected var _index: int;
		public function SrcBlendMode( type: String, index: int ) 
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