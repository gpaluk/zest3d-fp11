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
	public class BufferLockingType 
	{
		
		public static const READ_ONLY: BufferLockingType = new BufferLockingType( "readOnly" );
		public static const WRITE_ONLY: BufferLockingType = new BufferLockingType( "writeOnly" );
		public static const READ_WRITE: BufferLockingType = new BufferLockingType( "readWrite" );
		
		public static const QUANTITY: int = 3;
		
		protected var _type: String;
		public function BufferLockingType( type: String ) 
		{
			_type = type;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public static function toVector(): Vector.<BufferLockingType>
		{
			return Vector.<BufferLockingType>
			([
				READ_ONLY,
				WRITE_ONLY,
				READ_WRITE
			]);
		}
		
		public function toString(): String
		{
			return "[object BufferLockingType] (type: " + type + ")";
		}
		
	}

}