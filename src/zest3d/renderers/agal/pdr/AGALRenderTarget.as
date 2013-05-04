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
	import zest3d.renderers.interfaces.IRenderTarget;
	import zest3d.renderers.Renderer;
	import zest3d.resources.RenderTarget;
	import zest3d.resources.Texture2D;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class AGALRenderTarget implements IRenderTarget, IDisposable 
	{
		
		public function AGALRenderTarget( renderer: Renderer, renderTarget: RenderTarget ) 
		{
			
		}
		
		public function dispose(): void
		{
			
		}
		
		public function enable( renderer: Renderer ): void
		{
			trace( "* enabling render target." );
		}
		
		public function disable( renderer: Renderer ): void
		{
			trace( "* disabling render target." );
		}
		
		public function readColor( i: int, renderer: Renderer, texture: Texture2D ): void
		{
		}
		
	}

}