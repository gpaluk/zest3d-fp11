package zest3d.primitives 
{
	import zest3d.datatypes.Transform;
	import zest3d.resources.enum.AttributeType;
	import zest3d.resources.enum.AttributeUsageType;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.TriMesh;
	import zest3d.shaders.VisualEffectInstance;
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class TorusPrimitive extends Primitive
	{
		
		public function TorusPrimitive( effect:VisualEffectInstance, hasTexCoords:Boolean = true, hasNormals: Boolean = true, circleSamples:int = 32, radialSamples:int = 16, outerRadius:Number = 1, innerRadius:Number = 0.5, bothSides:Boolean = false, isStatic:Boolean = true, inside:Boolean = false, transform:Transform = null ) 
		{
			effectInstance = effect;
			this.bothSides = bothSides;
			var vFormat:VertexFormat = this.generateVertexFormat( hasTexCoords, hasNormals );
			var primitive:TriMesh = new StandardMesh( vFormat, isStatic, inside, transform ).torus( circleSamples, radialSamples, outerRadius, innerRadius );
			super( vFormat, primitive.vertexBuffer, primitive.indexBuffer );
		}
	}
}