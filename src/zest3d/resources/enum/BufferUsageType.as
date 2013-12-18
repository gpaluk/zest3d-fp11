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
	public class BufferUsageType 
	{
		
		public static const STATIC: BufferUsageType = new BufferUsageType( "static" );
		public static const DYNAMIC: BufferUsageType = new BufferUsageType( "dynamic" );
		public static const RENDERTARGET: BufferUsageType = new BufferUsageType( "rendertarget" );
		public static const DEPTHSTENCIL: BufferUsageType = new BufferUsageType( "depthstencil" );
		public static const TEXTURE: BufferUsageType = new BufferUsageType( "texture" );
		
		public static const QUANTITY: int = 5;
		
		
		protected var _type: String;
		public function BufferUsageType( type: String ) 
		{
			_type = type;
		}
		
		public static function toVector(): Vector.<BufferUsageType>
		{
			return Vector.<BufferUsageType>
			([
				STATIC,
				DYNAMIC,
				RENDERTARGET,
				DEPTHSTENCIL,
				TEXTURE
			]);
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public function toString(): String
		{
			return "[object BufferUsageType] (type: " + type + ")";
		}
	}

}