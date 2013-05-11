package zest3d.resources 
{
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.core.system.Assert;
	import io.plugin.core.system.object.PluginObject;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferUsageType;
	import zest3d.resources.enum.TextureFormat;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class RenderTarget extends PluginObject implements IDisposable 
	{
		
		protected var _numTargets: int;
		protected var _colorTextures: Vector.<Texture2D>;
		protected var _depthStencilTexture: Texture2D;
		protected var _hasMipmaps: Boolean;
		
		public function RenderTarget( numTargets: int, tFormat: TextureFormat, width: int,
				height: int, hasMipmaps: Boolean, hasDepthStencil: Boolean ) 
		{
			_numTargets = numTargets;
			_hasMipmaps = hasMipmaps;
			
			Assert.isTrue( _numTargets > 0 );
			
			_colorTextures = new Vector.<Texture2D>(_numTargets);
			
			var i: int = 0;
			for ( i = 0; i < _numTargets; ++i )
			{
				_colorTextures[i] = new Texture2D( tFormat, width, height,
					(hasMipmaps ? 0 : 1), BufferUsageType.RENDERTARGET );
			}
			
			if ( hasDepthStencil )
			{
				_depthStencilTexture = new Texture2D( TextureFormat.BITMAP, width,
					height, 1, BufferUsageType.DEPTHSTENCIL );
			}
		}
		
		public function dispose(): void
		{
			Renderer.unbindAllRenderTarget( this );
			for each( var texture:Texture3D in _colorTextures )
			{
				texture.dispose();
			}
			_colorTextures = null;
		}
		
		[Inline]
		public final function numTargets(): int
		{
			return _numTargets;
		}
		
		[Inline]
		public final function format(): TextureFormat
		{
			return _colorTextures[ 0 ].format;
		}
		
		[Inline]
		public final function width(): int
		{
			return _colorTextures[0].width;
		}
		
		[Inline]
		public final function height(): int
		{
			return _colorTextures[0].height;
		}
		
		[Inline]
		public final function getColorTextureAt( index: int ): Texture2D
		{
			return _colorTextures[index];
		}
		
		[Inline]
		public final function get depthStencilTextureAt( ): Texture2D
		{
			return _depthStencilTexture;
		}
		
		[Inline]
		public final function hasMipmaps(): Boolean
		{
			return _hasMipmaps;
		}
		
		[Inline]
		public final function hasDepthStencil(): Boolean
		{
			return _depthStencilTexture != null;
		}
		
	}

}