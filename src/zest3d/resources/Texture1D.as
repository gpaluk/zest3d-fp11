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
package zest3d.resources 
{
	import flash.utils.ByteArray;
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferUsageType;
	import zest3d.resources.enum.TextureFormat;
	import zest3d.resources.enum.TextureType;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Texture1D extends Texture implements IDisposable 
	{
		
		public function Texture1D( format: TextureFormat, dimension0: int, numLevels: int, usage: BufferUsageType = null ) 
		{
			usage ||= BufferUsageType.TEXTURE;
			super( format, TextureType.TEXTURE_1D, usage, numLevels );
		}
		
		override public function dispose():void 
		{
			Renderer.unbindAllTexture1D( this );
			super.dispose();
		}
		
		/*
		[Inline]
		public final function get length(): int
		{
			return getDimension( 0, 0 );
		}
		
		public function generateMipmaps(): void
		{
			
		}
		
		public function hasMipmaps(): Boolean
		{
			
		}
		
		public function getDataLevel( level: int ): ByteArray
		{
			
		}
		
		// TODO load data from file
		//public function load()
		
		protected function computeNextLevelBytes(): void
		{
			
		}
		
		protected function generateNextMipmap( length: int, texels: ByteArray, lengthNext: int, texelsNext: ByteArray, rgba: Array ): void
		{
			
		}
		
		*/
		
	}

}