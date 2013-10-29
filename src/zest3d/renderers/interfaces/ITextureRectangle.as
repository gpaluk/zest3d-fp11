package zest3d.renderers.interfaces 
{
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferLockingType;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public interface ITextureRectangle 
	{
		function enable( renderer: Renderer, textureUnit: int ): void;
		function disable( renderer: Renderer, textureUnit: int ): void;
		function lock( level: int, mode: BufferLockingType ): void;
		function unlock( level: int ): void;
	}
	
}