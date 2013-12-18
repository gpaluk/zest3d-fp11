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
	public class CullingType
	{
		
		public static const DYNAMIC: CullingType = new CullingType( "dynamic" );
		public static const ALWAYS: CullingType = new CullingType( "always" );
		public static const NEVER: CullingType = new CullingType( "never" );
		
		public static const QUANTITY: int = 3;
		
		protected var _type: String;
		public function CullingType( type: String ) 
		{
			_type = type;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public static function toVector(): Vector.<CullingType>
		{
			return Vector.<CullingType>
			([
				DYNAMIC,
				ALWAYS,
				NEVER
			]);
		}
		
		public function toString(): String
		{
			return "[object CullingType] (type: " + type + ")";
		}
		
	}

}