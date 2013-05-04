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
	import zest3d.renderers.interfaces.ITextureCube;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferLockingType;
	import zest3d.resources.TextureCube;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class AGALTextureCube implements ITextureCube, IDisposable 
	{
		
		public function AGALTextureCube( renderer: Renderer, texture: TextureCube ) 
		{
			
		}
		
		public function dispose(): void
		{
			
		}
		
		public function enable( renderer: Renderer, textureUnit: int ): void
		{
			trace( "* enabling texture cube." );
		}
		
		public function disable( renderer: Renderer, textureUnit: int ): void
		{
			trace( "* disabling texture cube." );
		}
		
		public function lock( face: int, level: int, mode: BufferLockingType ): void
		{
			trace( "* locking texture cube." );
		}
		
		public function unlock( face: int, level: int ): void
		{
			trace( "* unlocking texture cube." );
		}
		
	}

}