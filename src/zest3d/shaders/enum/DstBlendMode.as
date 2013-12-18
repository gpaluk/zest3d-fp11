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
	public class DstBlendMode 
	{
		
		public static const ZERO: DstBlendMode = new DstBlendMode( "zero", 0 );
		public static const ONE: DstBlendMode = new DstBlendMode( "one", 1 );
		public static const SRC_COLOR: DstBlendMode = new DstBlendMode( "srcColor", 2 );
		public static const ONE_MINUS_SRC_COLOR: DstBlendMode = new DstBlendMode( "oneMinusSrcColor", 3 );
		public static const SRC_ALPHA: DstBlendMode = new DstBlendMode( "srcAlpha", 4 );
		public static const ONE_MINUS_SRC_ALPHA: DstBlendMode = new DstBlendMode( "oneMinusSrcAlpha", 5 );
		public static const DST_ALPHA: DstBlendMode = new DstBlendMode( "dstAlpha", 6 );
		public static const ONE_MINUS_DST_ALPHA: DstBlendMode = new DstBlendMode( "oneMinusDstAlpha", 7 );
		public static const CONSTANT_COLOR: DstBlendMode = new DstBlendMode( "constantColor", 8 );
		public static const ONE_MINUS_CONSTANT_COLOR: DstBlendMode = new DstBlendMode( "oneMinusConstantColor", 9 );
		public static const CONSTANT_ALPHA: DstBlendMode = new DstBlendMode( "constantAlpha", 10 );
		public static const ONE_MINUS_CONSTANT_ALPHA: DstBlendMode = new DstBlendMode( "oneMinusConstantAlpha", 11 );
		
		public static const QUANTITY: int = 12;
		
		protected var _type: String;
		protected var _index: int;
		public function DstBlendMode( type: String, index: int ) 
		{
			_type = type;
			_index = index;
		}
		
		public static function toVector(): Vector.<DstBlendMode>
		{
			return Vector.<DstBlendMode>
			([
				ZERO,
				ONE,
				SRC_COLOR,
				ONE_MINUS_SRC_COLOR,
				SRC_ALPHA,
				ONE_MINUS_SRC_ALPHA,
				DST_ALPHA,
				ONE_MINUS_DST_ALPHA,
				CONSTANT_COLOR,
				ONE_MINUS_CONSTANT_COLOR,
				CONSTANT_ALPHA,
				ONE_MINUS_CONSTANT_ALPHA
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