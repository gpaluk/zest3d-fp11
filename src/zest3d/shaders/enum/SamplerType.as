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
	public class SamplerType 
	{
		
		public static const NONE: SamplerType = new SamplerType( "none", 0 );
		//public static const TYPE_1D: SamplerType = new SamplerType( "1d", 1 );
		public static const TYPE_2D: SamplerType = new SamplerType( "2d", 2 );
		public static const TYPE_3D: SamplerType = new SamplerType( "3d", 3 );
		public static const CUBE: SamplerType = new SamplerType( "cube", 4 );
		public static const RECTANGLE: SamplerType = new SamplerType( "rectangle", 5 );
		
		public static const QUANTITY: int = 5;
		
		protected var _type: String;
		protected var _index: int;
		public function SamplerType( type: String, index: int ) 
		{
			_type = type;
			_index = index;
		}
		
		public static function toVector():Vector.<SamplerType>
		{
			return Vector.<SamplerType>
			([
				NONE,
				//TYPE_1D,
				TYPE_2D,
				TYPE_3D,
				CUBE,
				RECTANGLE
			]);
		}
		
		[Inline]
		public final function get type():String 
		{
			return _type;
		}
		
		[Inline]
		public final function get index():int 
		{
			return _index;
		}
		
	}

}