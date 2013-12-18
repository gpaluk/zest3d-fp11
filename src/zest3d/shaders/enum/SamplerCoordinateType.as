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
	public class SamplerCoordinateType 
	{
		
		public static const NONE: SamplerCoordinateType = new SamplerCoordinateType( "none", 0 );
		public static const CLAMP: SamplerCoordinateType = new SamplerCoordinateType( "clamp", 1 );
		public static const REPEAT: SamplerCoordinateType = new SamplerCoordinateType( "repeat", 2 );
		public static const MIRRORED_REPEAT: SamplerCoordinateType = new SamplerCoordinateType( "mirroredRepeat", 3 );
		public static const CLAMP_BORDER: SamplerCoordinateType = new SamplerCoordinateType( "clampBorder", 4 );
		public static const CLAMP_EDGE: SamplerCoordinateType = new SamplerCoordinateType( "clampEdge", 5 );
		
		public static const QUANTITY: int = 6;
		
		protected var _type: String;
		protected var _index: int;
		public function SamplerCoordinateType( type: String, index: int ) 
		{
			_type = type;
			_index = index;
		}
		
		public static function toVector(): Vector.<SamplerCoordinateType>
		{
			return Vector.<SamplerCoordinateType>
			([
				NONE,
				CLAMP,
				REPEAT,
				MIRRORED_REPEAT,
				CLAMP_BORDER,
				CLAMP_EDGE
			]);
		}
		
	}

}