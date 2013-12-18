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
package zest3d.resources.enum 
{
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class AttributeUsageType 
	{
		
		public static const NONE: AttributeUsageType = new AttributeUsageType( "none", 0 );
		public static const POSITION: AttributeUsageType = new AttributeUsageType( "position", 1 );
		public static const NORMAL: AttributeUsageType = new AttributeUsageType( "normal", 2 );
		public static const TANGENT: AttributeUsageType = new AttributeUsageType( "tangent", 3 );
		public static const BINORMAL: AttributeUsageType = new AttributeUsageType( "binormal", 4 );
		public static const TEXCOORD: AttributeUsageType = new AttributeUsageType( "texCoord", 5 );
		public static const COLOR: AttributeUsageType = new AttributeUsageType( "color", 6 );
		public static const BLENDINDICES: AttributeUsageType = new AttributeUsageType( "blendIndices", 7 );
		public static const BLENDWEIGHT: AttributeUsageType = new AttributeUsageType( "blendWeight", 8 );
		public static const FOGCOORD: AttributeUsageType = new AttributeUsageType( "fogCoord", 9 );
		public static const PSIZE: AttributeUsageType = new AttributeUsageType( "pSize", 10 );
		
		public static const QUANTITY: int = 11;
		
		protected var _type: String;
		protected var _index: int;
		public function AttributeUsageType( type: String, index: int ) 
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
		
		public static function toVector(): Vector.<AttributeUsageType>
		{
			return Vector.<AttributeUsageType>
			([
				NONE,
				POSITION,
				NORMAL,
				TANGENT,
				BINORMAL,
				TEXCOORD,
				COLOR,
				BLENDINDICES,
				BLENDWEIGHT,
				FOGCOORD,
				PSIZE
			]);
		}
		
		public function toString(): String
		{
			return "[object AttributeUsageType] (type: " + type + ")";
		}
	}

}