package zest3d.effects.global 
{
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.renderers.Renderer;
	import zest3d.scenegraph.VisibleSet;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class GlobalEffect implements IDisposable 
	{
		
		public function GlobalEffect() 
		{
			
		}
		
		public function dispose(): void
		{
			
		}
		
		// virtual
		public function draw( renderer: Renderer, visible: VisibleSet ): void
		{
		}
		
	}

}