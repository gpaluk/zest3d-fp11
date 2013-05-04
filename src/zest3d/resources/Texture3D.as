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
	public class Texture3D extends Texture implements IDisposable 
	{
		
		public function Texture3D( format: TextureFormat, dim0: int, dim1: int, dim2: int, numLevels: int, usage: BufferUsageType = null ) 
		{
			usage ||= BufferUsageType.TEXTURE;
			super( format, TextureType.TEXTURE_3D, usage, numLevels );
		}
		
		override public function dispose():void 
		{
			Renderer.unbindAllTexture3D( this );
			super.dispose();
		}
	}

}