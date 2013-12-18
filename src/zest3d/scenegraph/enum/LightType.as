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
package zest3d.scenegraph.enum 
{
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class LightType 
	{
		
		public static const AMBIENT: LightType = new LightType( "ambient", 0 );
		public static const DIRECTIONAL: LightType = new LightType( "directional", 1 );
		public static const POINT: LightType = new LightType( "point", 2 );
		public static const SPOT: LightType = new LightType( "spot", 3 );
		
		public static const QUANITY: int = 4;
		
		protected var _type: String;
		protected var _index: int;
		public function LightType( type: String, index: int ) 
		{
			_type = type;
			_index = index;
		}
		
		public static function toVector(): Vector.<LightType>
		{
			return Vector.<LightType>
			([
				AMBIENT,
				DIRECTIONAL,
				POINT,
				SPOT
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
		
		public function toString(): String
		{
			return "[object LightType] (type: " + type + ", index: " + index + ")";
		}
		
	}

}