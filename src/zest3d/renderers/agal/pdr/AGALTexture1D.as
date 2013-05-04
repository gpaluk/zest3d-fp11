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
package zest3d.renderers.agal.pdr 
{
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.renderers.interfaces.ITexture1D;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferLockingType;
	import zest3d.resources.Texture1D;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class AGALTexture1D implements ITexture1D, IDisposable 
	{
		
		public function AGALTexture1D( renderer: Renderer, texture: Texture1D ) 
		{
			
		}
		
		public function dispose(): void
		{
			
		}
		
		public function enable( renderer: Renderer, textureUnit: int ): void
		{
			trace( "* enabling texture 1d." );
		}
		
		public function disable( renderer: Renderer, textureUnit: int ): void
		{
			trace( "* disabling texture 1d." );
		}
		
		public function lock( level: int, mode: BufferLockingType ): void
		{
			trace( "* locking texture 1d." );
		}
		
		public function unlock( level: int ): void
		{
			trace( "* unlocking texture 1d." );
		}
		
	}

}