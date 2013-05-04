package zest3d.renderers.interfaces 
{
	import zest3d.renderers.Renderer;
	import zest3d.shaders.PixelShader;
	import zest3d.shaders.ShaderParameters;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public interface IPixelShader 
	{
		function enable( renderer: Renderer, pShader:PixelShader, parameters: ShaderParameters ): void;
		function disable( renderer: Renderer, pShader: PixelShader, parameters: ShaderParameters ): void;
	}
	
}