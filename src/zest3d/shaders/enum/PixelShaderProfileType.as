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
	public class PixelShaderProfileType 
	{
		
		public static const NONE: PixelShaderProfileType = new PixelShaderProfileType( "none", 0 );
		public static const AGAL_1_0: PixelShaderProfileType = new PixelShaderProfileType( "agal_1_0", 1 );
		public static const AGAL_2_0: PixelShaderProfileType = new PixelShaderProfileType( "agal_2_0", 2 );
		
		protected var _type: String;
		protected var _index: int;
		public function PixelShaderProfileType( type: String, index: int ) 
		{
			_type = type;
			_index = index;
		}
		
		public static function toVector(): Vector.<PixelShaderProfileType>
		{
			return Vector.<PixelShaderProfileType>
			([
				NONE,
				AGAL_1_0,
				AGAL_2_0
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