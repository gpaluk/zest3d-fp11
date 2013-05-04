package zest3d.renderers.interfaces 
{
	import zest3d.renderers.Renderer;
	import zest3d.resources.Texture2D;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public interface IRenderTarget 
	{
		function enable( renderer: Renderer ): void;
		function disable( renderer: Renderer ): void;
		function readColor( i: int, renderer: Renderer, texture: Texture2D ): void;
	}
	
}