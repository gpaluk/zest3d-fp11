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
	public class PrimitiveType 
	{
		
		public static const NONE: PrimitiveType = new PrimitiveType( "none" );
		public static const POLYPOINT: PrimitiveType = new PrimitiveType( "polypoint" );
		public static const POLYSEGMENTS_DISJOINT: PrimitiveType = new PrimitiveType( "polysegmentsDisjoint" );
		public static const POLYSEGMENTS_CONTIGUOUS: PrimitiveType = new PrimitiveType( "polysegmentsContiguous" );
		public static const TRIANGLES: PrimitiveType = new PrimitiveType( "triangles" ); // abstract
		public static const TRIMESH: PrimitiveType = new PrimitiveType( "trimesh" );
		public static const TRISTRIP: PrimitiveType = new PrimitiveType( "tristrip" );
		public static const TRIFAN: PrimitiveType = new PrimitiveType( "trifan" );
		
		public static const QUANTITY: int = 8;
		
		protected var _type: String;
		
		public function PrimitiveType( type: String ) 
		{
			_type = type;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
		public static function toVector(): Vector.<PrimitiveType>
		{
			return Vector.<PrimitiveType>
			([
				NONE,
				POLYPOINT,
				POLYSEGMENTS_DISJOINT,
				POLYSEGMENTS_CONTIGUOUS,
				TRIANGLES,
				TRIMESH,
				TRISTRIP,
				TRIFAN
			]);
		}
		
		public function toString(): String
		{
			return "[object PrimitiveType] (type: " + type + ")";
		}
		
	}

}