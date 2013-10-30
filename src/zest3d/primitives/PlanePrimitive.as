package zest3d.primitives 
{
	import zest3d.datatypes.Transform;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.TriMesh;
	import zest3d.shaders.states.CullState;
	import zest3d.shaders.VisualEffectInstance;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class PlanePrimitive extends Primitive 
	{
		
		public function PlanePrimitive( effect:VisualEffectInstance, hasTexCoords:Boolean = true, hasNormals: Boolean = true, xSamples:int = 2, ySamples:int = 2, xExtent:Number = 1, yExtent:Number = 1, bothSides:Boolean = false, isStatic:Boolean = true, inside:Boolean = false, transform:Transform = null ) 
		{
			this.effect = effect;
			this.bothSides = bothSides;
			var vFormat:VertexFormat = this.generateVertexFormat( hasTexCoords, hasNormals );
			var primitive:TriMesh = new StandardMesh( vFormat, isStatic, inside, transform ).rectangle( xSamples, ySamples, xExtent, yExtent );
			
			super( vFormat, primitive.vertexBuffer, primitive.indexBuffer );
		}
		
	}
}