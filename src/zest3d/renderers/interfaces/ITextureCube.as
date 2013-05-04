package zest3d.renderers.interfaces 
{
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferLockingType;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public interface ITextureCube 
	{
		function enable( renderer: Renderer, textureUnit: int ): void;
		function disable( renderer: Renderer, textureUnit: int ): void;
		function lock( face: int, level: int, mode: BufferLockingType ): void;
		function unlock( face: int, level: int ): void;
	}
	
}