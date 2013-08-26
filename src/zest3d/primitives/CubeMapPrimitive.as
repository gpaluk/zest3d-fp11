package zest3d.primitives 
{
	import flash.utils.ByteArray;
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.math.algebra.APoint;
	import zest3d.effects.local.SkyBoxEffect;
	import zest3d.effects.local.Texture2DEffect;
	import zest3d.resources.enum.AttributeType;
	import zest3d.resources.enum.AttributeUsageType;
	import zest3d.resources.enum.BufferUsageType;
	import zest3d.resources.enum.TextureFormat;
	import zest3d.resources.IndexBuffer;
	import zest3d.resources.Texture2D;
	import zest3d.resources.VertexBuffer;
	import zest3d.resources.VertexBufferAccessor;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.Node;
	import zest3d.scenegraph.TriMesh;
	import zest3d.shaders.enum.SamplerCoordinateType;
	import zest3d.shaders.enum.SamplerFilterType;
	import zest3d.shaders.VisualEffectInstance;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class CubeMapPrimitive extends Node implements IDisposable 
	{
		
		public function CubeMapPrimitive( face0: Texture2D, face1: Texture2D, face2: Texture2D, face3: Texture2D, face4: Texture2D, face5: Texture2D )
		{
			super();
			
			var iBuffer: IndexBuffer = new IndexBuffer( 6, 2, BufferUsageType.STATIC );
			iBuffer.setIndexAt( 0, 0 );
			iBuffer.setIndexAt( 1, 1 );
			iBuffer.setIndexAt( 2, 3 );
			iBuffer.setIndexAt( 3, 0 );
			iBuffer.setIndexAt( 4, 3 );
			iBuffer.setIndexAt( 5, 2 );
			
			var vFormat: VertexFormat = VertexFormat.create( 2, AttributeUsageType.POSITION, AttributeType.FLOAT3, 0,
																AttributeUsageType.TEXCOORD, AttributeType.FLOAT2, 0 );
			
			var vStride: int = vFormat.stride;
			var vba: VertexBufferAccessor;
			var wall: TriMesh;
			
			var vBuffer: VertexBuffer = new VertexBuffer( 4, vStride );
			
			vba = new VertexBufferAccessor( vFormat, vBuffer );
			
			var face0TextureEffect: VisualEffectInstance = SkyBoxEffect.createUniqueInstance( face0 );
			var face1TextureEffect: VisualEffectInstance = SkyBoxEffect.createUniqueInstance( face1 );
			var face2TextureEffect: VisualEffectInstance = SkyBoxEffect.createUniqueInstance( face2 );
			var face3TextureEffect: VisualEffectInstance = SkyBoxEffect.createUniqueInstance( face3 );
			var face4TextureEffect: VisualEffectInstance = SkyBoxEffect.createUniqueInstance( face4 );
			var face5TextureEffect: VisualEffectInstance = SkyBoxEffect.createUniqueInstance( face5 );
			
			// +x wall
			vba.setPositionAt( 0, [ +1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 1, [ +1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 2, [ +1.005, +1.005, -1.005 ] );
			vba.setPositionAt( 3, [ +1.005, +1.005, +1.005 ] );
			
			vba.setTCoordAt( 0, 0, [ 0, 0 ] );
			vba.setTCoordAt( 0, 1, [ 1, 0 ] );
			vba.setTCoordAt( 0, 2, [ 0, 1 ] );
			vba.setTCoordAt( 0, 3, [ 1, 1 ] );
			
			wall = new TriMesh( vFormat, vBuffer, iBuffer );
			wall.effectInstance = face0TextureEffect;
			addChild( wall );
			
			// -x wall
			vBuffer = new VertexBuffer( 4, vStride, BufferUsageType.STATIC );
			vba.applyToData( vFormat, vBuffer );
			vba.setPositionAt( 0, [ -1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 1, [ -1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 2, [ -1.005, +1.005, +1.005 ] );
			vba.setPositionAt( 3, [ -1.005, +1.005, -1.005 ] );
			
			vba.setTCoordAt( 0, 0, [ 0, 0 ] );
			vba.setTCoordAt( 0, 1, [ 1, 0 ] );
			vba.setTCoordAt( 0, 2, [ 0, 1 ] );
			vba.setTCoordAt( 0, 3, [ 1, 1 ] );
			
			wall = new TriMesh( vFormat, vBuffer, iBuffer );
			wall.effectInstance = face1TextureEffect;
			addChild( wall );
			
			// +y
			vBuffer = new VertexBuffer( 4, vStride );
			vba.applyToData( vFormat, vBuffer );
			vba.setPositionAt( 0, [ +1.005, +1.005, +1.005 ] );
			vba.setPositionAt( 1, [ -1.005, +1.005, +1.005 ] );
			vba.setPositionAt( 2, [ +1.005, +1.005, -1.005 ] );
			vba.setPositionAt( 3, [ -1.005, +1.005, -1.005 ] );
			
			vba.setTCoordAt( 0, 0, [ 0, 0 ] );
			vba.setTCoordAt( 0, 1, [ 1, 0 ] );
			vba.setTCoordAt( 0, 2, [ 0, 1 ] );
			vba.setTCoordAt( 0, 3, [ 1, 1 ] );
			
			wall = new TriMesh( vFormat, vBuffer, iBuffer );
			wall.effectInstance = face2TextureEffect;
			addChild( wall );
			
			// -y
			vBuffer = new VertexBuffer( 4, vStride );
			vba.applyToData( vFormat, vBuffer );
			vba.setPositionAt( 0, [ +1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 1, [ -1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 2, [ +1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 3, [ -1.005, -1.005, +1.005 ] );
			
			vba.setTCoordAt( 0, 0, [ 0, 0 ] );
			vba.setTCoordAt( 0, 1, [ 1, 0 ] );
			vba.setTCoordAt( 0, 2, [ 0, 1 ] );
			vba.setTCoordAt( 0, 3, [ 1, 1 ] );
			
			wall = new TriMesh( vFormat, vBuffer, iBuffer );
			wall.effectInstance = face3TextureEffect;
			addChild( wall );
			
			// +z
			vBuffer = new VertexBuffer( 4, vStride );
			vba.applyToData( vFormat, vBuffer );
			vba.setPositionAt( 0, [ +1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 1, [ -1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 2, [ +1.005, +1.005, +1.005 ] );
			vba.setPositionAt( 3, [ -1.005, +1.005, +1.005 ] );
			
			vba.setTCoordAt( 0, 0, [ 0, 0 ] );
			vba.setTCoordAt( 0, 1, [ 1, 0 ] );
			vba.setTCoordAt( 0, 2, [ 0, 1 ] );
			vba.setTCoordAt( 0, 3, [ 1, 1 ] );
			
			wall = new TriMesh( vFormat, vBuffer, iBuffer );
			wall.effectInstance = face4TextureEffect;
			addChild( wall );
			
			// -z
			vBuffer = new VertexBuffer( 4, vStride );
			vba.applyToData( vFormat, vBuffer );
			vba.setPositionAt( 0, [ -1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 1, [ +1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 2, [ -1.005, +1.005, -1.005 ] );
			vba.setPositionAt( 3, [ +1.005, +1.005, -1.005 ] );
			
			vba.setTCoordAt( 0, 0, [ 0, 0 ] );
			vba.setTCoordAt( 0, 1, [ 1, 0 ] );
			vba.setTCoordAt( 0, 2, [ 0, 1 ] );
			vba.setTCoordAt( 0, 3, [ 1, 1 ] );
			
			wall = new TriMesh( vFormat, vBuffer, iBuffer );
			wall.effectInstance = face5TextureEffect;
			addChild( wall );
			
			localTransform.scale = new APoint( 50, 50, 50 );
		}
	}

}