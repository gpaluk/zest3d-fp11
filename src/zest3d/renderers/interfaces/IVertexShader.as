package zest3d.renderers.interfaces 
{
	import zest3d.renderers.Renderer;
	import zest3d.shaders.ShaderParameters;
	import zest3d.shaders.VertexShader;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public interface IVertexShader 
	{
		function enable( renderer: Renderer, vShader: VertexShader, parameters: ShaderParameters ): void;
		function disable( renderer: Renderer, vShader: VertexShader, parameters: ShaderParameters ): void;
	}
	
}