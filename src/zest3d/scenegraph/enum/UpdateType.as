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
	public class UpdateType 
	{
		
		public static const MODEL_BOUND_ONLY: UpdateType = new UpdateType( "modelBoundOnly", -3 );
		public static const NORMALS: UpdateType = new UpdateType( "normals", -2 );
		public static const USE_GEOMETRY: UpdateType = new UpdateType( "useGeometry", -1 );
		public static const USE_TCOORD_CHANNEL: UpdateType = new UpdateType( "useTCoordChannel", 0 );
		
		public static const QUANTITY: int = 4;
		
		protected var _type: String;
		protected var _index: int;
		
		public function UpdateType( type: String, index: int ) 
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
		
		public static function toVector(): Vector.<UpdateType>
		{
			return Vector.<UpdateType>
			([
				MODEL_BOUND_ONLY,
				NORMALS,
				USE_GEOMETRY,
				USE_TCOORD_CHANNEL
			])
		}
		
		public function toString(): String
		{
			return "[object UpdateType] (type: " + type + ", index: " + index + ")";
		}
		
	}

}