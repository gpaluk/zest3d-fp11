package zest3d.resources 
{
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferUsageType;
	import zest3d.resources.enum.TextureFormat;
	import zest3d.resources.enum.TextureType;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class TextureCube extends Texture implements IDisposable 
	{
		
		public function TextureCube( format: TextureFormat, dimension: int, numLevels: int, usage: BufferUsageType = null ) 
		{
			usage ||= BufferUsageType.TEXTURE;
			super( format, TextureType.TEXTURE_CUBE, usage, numLevels );
		}
		
		override public function dispose():void 
		{
			Renderer.unbindAllTextureCube( this );
			super.dispose();
		}
		
	}

}