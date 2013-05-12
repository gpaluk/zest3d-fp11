/**
 * Plugin.IO - http://www.plugin.io
 * Copyright (c) 2011-2012
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
	public class TextureFormat 
	{
		
		//public static const NONE: TextureFormat = new TextureFormat( "none", 0 );
		//public static const R5G6B5: TextureFormat = new TextureFormat( "R5G6B5", 1 );
		//public static const A1R5G5B5: TextureFormat = new TextureFormat( "A1R5G5B5", 2 );
		//public static const A4R4G4B4: TextureFormat = new TextureFormat( "A4R4G4B4", 3 );
		
		//public static const A8: TextureFormat = new TextureFormat( "A8", 4 );
		//public static const L8: TextureFormat = new TextureFormat( "L8", 5 );
		//public static const A8L8: TextureFormat = new TextureFormat( "A8L8", 6 );
		//public static const R8G8B8: TextureFormat = new TextureFormat( "R8G8B8", 7 );
		//public static const A8R8G8B8: TextureFormat = new TextureFormat( "A8R8G8B8", 8 );
		//public static const A8B8G8R8: TextureFormat = new TextureFormat( "A8B8G8R8", 9 );
		
		//public static const L16: TextureFormat = new TextureFormat( "L16", 10 );
		//public static const G16R16: TextureFormat = new TextureFormat( "G16R16", 11 );
		//public static const A16B16G16R16: TextureFormat = new TextureFormat( "A16B16G16R16", 12 );
		
		//public static const R16F: TextureFormat = new TextureFormat( "R16F", 13 );
		//public static const G16R16F: TextureFormat = new TextureFormat( "G16R16F", 14 );
		//public static const A16B16G16R16F: TextureFormat = new TextureFormat( "A16B16G16R16F", 15 );
		
		//public static const R32F: TextureFormat = new TextureFormat( "R32F", 16 );
		//public static const G32R32F: TextureFormat = new TextureFormat( "G32R32F", 17 );
		//public static const A32B32G32R32F: TextureFormat = new TextureFormat( "A32B32G32R32F", 18 );
		
		public static const DXT1: TextureFormat = new TextureFormat( "DXT1", 19 );
		//public static const DXT3: TextureFormat = new TextureFormat( "DXT3", 20 );
		public static const DXT5: TextureFormat = new TextureFormat( "DXT5", 21 );
		
		//public static const D24S8: TextureFormat = new TextureFormat( "D24S8", 22 );
		
		
		// flash
		public static const BGRA: TextureFormat = new TextureFormat( "BGRA", 23 );
		public static const BITMAP: TextureFormat = new TextureFormat( "Bitmap", 24 );
		
		// extra
		// public static const
		
		
		//public static const QUANTITY: int = 3;
		
		
		protected var _type: String;
		protected var _index: int;
		public function TextureFormat( type: String, index: int ) 
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