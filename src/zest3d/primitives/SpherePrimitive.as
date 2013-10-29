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
	public class SpherePrimitive extends Primitive 
	{
		
		public function SpherePrimitive( effect:VisualEffectInstance, hasTexCoords:Boolean = true, hasNormals: Boolean = true, zSamples:int = 16, radialSamples:int = 16, radius:Number = 1, bothSides:Boolean = false, isStatic:Boolean = true, inside:Boolean = false, transform:Transform = null ) 
		{
			this.effect = effect;
			this.bothSides = bothSides;
			
			var vFormat:VertexFormat = this.generateVertexFormat( hasTexCoords, hasNormals );
			var primitive:TriMesh = new StandardMesh( vFormat, isStatic, inside, transform ).sphere( zSamples, radialSamples, radius );
			
			super( vFormat, primitive.vertexBuffer, primitive.indexBuffer );
		}
		
	}

}