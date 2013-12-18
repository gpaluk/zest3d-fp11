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
	public class AttributeType 
	{
		
		public static const NONE: AttributeType = new AttributeType( "none", 0 );
		public static const FLOAT1: AttributeType = new AttributeType( "float1", 1 );
		public static const FLOAT2: AttributeType = new AttributeType( "float2", 2 );
		public static const FLOAT3: AttributeType = new AttributeType( "float3", 3 );
		public static const FLOAT4: AttributeType = new AttributeType( "float4", 4 );
		
		public static const QUANTITY: int = 5;
		
		protected var _type: String;
		protected var _index: int;
		
		public function AttributeType( type: String, index: int ) 
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
		
		public static function toVector(): Vector.<AttributeType>
		{
			return Vector.<AttributeType>
			([
				NONE,
				FLOAT1,
				FLOAT2,
				FLOAT3,
				FLOAT4/*,
				HALF1,
				HALF2,
				HALF3,
				HALF4,
				UBYTE4,
				SHORT1,
				SHORT2,
				SHORT4*/
			]);
		}
		
		public function toString(): String
		{
			return "[object AttributeType] (type: " + type + ", index: " + index + ")";
		}
		
	}

}