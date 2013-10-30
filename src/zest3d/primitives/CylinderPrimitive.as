package zest3d.primitives 
{
	import zest3d.datatypes.Transform;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.TriMesh;
	import zest3d.shaders.VisualEffectInstance;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class CylinderPrimitive extends Primitive 
	{
		
		public function CylinderPrimitive( effect:VisualEffectInstance, hasTexCoords:Boolean = true, hasNormals: Boolean = true, axisSamples:int = 4, radialSamples:int = 16,  radius:Number = 1, height:Number = 2, open:Boolean = false, bothSides:Boolean = false, isStatic:Boolean = true, inside:Boolean = false, transform:Transform = null ) 
		{
			this.effect = effect;
			this.bothSides = bothSides;
			
			var vFormat:VertexFormat = this.generateVertexFormat( hasTexCoords, hasNormals );
			var primitive:TriMesh = new StandardMesh( vFormat, isStatic, inside, transform ).cylinder( axisSamples, radialSamples, radius, height, open );
			
			super( vFormat, primitive.vertexBuffer, primitive.indexBuffer );
		}
		
	}

}