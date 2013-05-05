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
	import flash.display3D.Context3D;
	import flash.display3D.Context3DTextureFormat;
	import flash.display3D.textures.CubeTexture;
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.renderers.agal.AGALRenderer;
	import zest3d.renderers.interfaces.ITextureCube;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferLockingType;
	import zest3d.resources.enum.TextureFormat;
	import zest3d.resources.TextureCube;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class AGALTextureCube implements ITextureCube, IDisposable 
	{
		
		private var _renderer: AGALRenderer;
		private var _texture: TextureCube;
		private var _textureFormat: TextureFormat;
		private var _context: Context3D;
		
		private var _gpuTexture: CubeTexture;
		
		public function AGALTextureCube( renderer: Renderer, texture: TextureCube ) 
		{
			_renderer = renderer as AGALRenderer;
			_context = _renderer.data.context;
			
			_texture = texture;
			_textureFormat = texture.format;
			
			_gpuTexture = _context.createCubeTexture( _texture.width, Context3DTextureFormat.COMPRESSED, false, 0 );
			if ( _texture.isCompressed )
			{
				_gpuTexture.uploadCompressedTextureFromByteArray( _texture.data, 0 );
			}
			else
			{
				//_gpuTexture.uploadFromByteArray( _texture.data, 0, _texture.numLevels );
			}
		}
		
		public function dispose(): void
		{
			_gpuTexture.dispose();
		}
		
		public function enable( renderer: Renderer, textureUnit: int ): void
		{
			_context.setTextureAt( textureUnit, _gpuTexture );
		}
		
		public function disable( renderer: Renderer, textureUnit: int ): void
		{
			_context.setTextureAt( textureUnit, null );
		}
		
		public function lock( face: int, level: int, mode: BufferLockingType ): void
		{
		}
		
		public function unlock( face: int, level: int ): void
		{
		}
		
	}

}