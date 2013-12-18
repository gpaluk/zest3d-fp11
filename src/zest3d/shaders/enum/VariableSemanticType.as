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
	public class VariableSemanticType 
	{
		
		public static const NONE: VariableSemanticType = new VariableSemanticType( "none", 0 );
		public static const POSITION: VariableSemanticType = new VariableSemanticType( "position", 1 );
		public static const BLENDWEIGHT: VariableSemanticType = new VariableSemanticType( "blendWeight", 2 );
		public static const NORMAL: VariableSemanticType = new VariableSemanticType( "normal", 3 );
		public static const COLOR0: VariableSemanticType = new VariableSemanticType( "color0", 4 );
		public static const COLOR1: VariableSemanticType = new VariableSemanticType( "color1", 5 );
		public static const FOGCOORD: VariableSemanticType = new VariableSemanticType( "fogCoord", 6 );
		public static const PSIZE: VariableSemanticType = new VariableSemanticType( "pSize", 7 );
		public static const BLENDINDICES: VariableSemanticType = new VariableSemanticType( "blendIndices", 8 );
		public static const TEXCOORD0: VariableSemanticType = new VariableSemanticType( "texCoord0", 9 );
		public static const TEXCOORD1: VariableSemanticType = new VariableSemanticType( "texCoord1", 10 );
		public static const TEXCOORD2: VariableSemanticType = new VariableSemanticType( "texCoord2", 11 );
		public static const TEXCOORD3: VariableSemanticType = new VariableSemanticType( "texCoord3", 12 );
		public static const TEXCOORD4: VariableSemanticType = new VariableSemanticType( "texCoord4", 13 );
		public static const TEXCOORD5: VariableSemanticType = new VariableSemanticType( "texCoord5", 14 );
		public static const TEXCOORD6: VariableSemanticType = new VariableSemanticType( "texCoord6", 15 );
		public static const TEXCOORD7: VariableSemanticType = new VariableSemanticType( "texCoord7", 16 );
		public static const FOG: VariableSemanticType = new VariableSemanticType( "fog", 17 );
		public static const TANGENT: VariableSemanticType = new VariableSemanticType( "tangent", 18 );
		public static const BINORMAL: VariableSemanticType = new VariableSemanticType( "binormal", 19 );
		public static const COLOR2: VariableSemanticType = new VariableSemanticType( "color2", 20 );
		public static const COLOR3: VariableSemanticType = new VariableSemanticType( "color3", 21 );
		public static const DEPTH0: VariableSemanticType = new VariableSemanticType( "depth0", 22 );
		
		protected var _type: String;
		protected var _index: int;
		public function VariableSemanticType( type: String, index: int ) 
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
		
	}

}