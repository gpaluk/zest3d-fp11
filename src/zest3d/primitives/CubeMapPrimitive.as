package zest3d.primitives 
{
	import io.plugin.core.interfaces.IDisposable;
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
		
		[Embed(source = "../../../../../Flash Documents/Zest3D Testing/lib/skybox/face0.atf", mimeType = "application/octet-stream")]
		private static const Face0Texture: Class;
		
		[Embed(source = "../../../../../Flash Documents/Zest3D Testing/lib/skybox/face1.atf", mimeType = "application/octet-stream")]
		private static const Face1Texture: Class;
		
		[Embed(source = "../../../../../Flash Documents/Zest3D Testing/lib/skybox/face2.atf", mimeType = "application/octet-stream")]
		private static const Face2Texture: Class;
		
		[Embed(source = "../../../../../Flash Documents/Zest3D Testing/lib/skybox/face3.atf", mimeType = "application/octet-stream")]
		private static const Face3Texture: Class;
		
		[Embed(source = "../../../../../Flash Documents/Zest3D Testing/lib/skybox/face4.atf", mimeType = "application/octet-stream")]
		private static const Face4Texture: Class;
		
		[Embed(source = "../../../../../Flash Documents/Zest3D Testing/lib/skybox/face5.atf", mimeType = "application/octet-stream")]
		private static const Face5Texture: Class;
		
		
		public function CubeMapPrimitive()
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
			
			var face0: Texture2D = new Texture2D( TextureFormat.BGRA, 512, 512, 10, BufferUsageType.TEXTURE );
			face0.data = new Face1Texture();
			var face0TextureEffect: VisualEffectInstance = Texture2DEffect.createUniqueInstance( face0, SamplerFilterType.LINEAR, SamplerCoordinateType.CLAMP, SamplerCoordinateType.CLAMP );
			
			
			var face1: Texture2D = new Texture2D( TextureFormat.BGRA, 512, 512, 10, BufferUsageType.TEXTURE );
			face1.data = new Face0Texture();
			var face1TextureEffect: VisualEffectInstance = Texture2DEffect.createUniqueInstance( face1, SamplerFilterType.LINEAR, SamplerCoordinateType.CLAMP, SamplerCoordinateType.CLAMP );
			
			
			var face2: Texture2D = new Texture2D( TextureFormat.BGRA, 512, 512, 10, BufferUsageType.TEXTURE );
			face2.data = new Face3Texture();
			var face2TextureEffect: VisualEffectInstance = Texture2DEffect.createUniqueInstance( face2, SamplerFilterType.LINEAR, SamplerCoordinateType.CLAMP, SamplerCoordinateType.CLAMP );
			
			
			var face3: Texture2D = new Texture2D( TextureFormat.BGRA, 512, 512, 10, BufferUsageType.TEXTURE );
			face3.data = new Face2Texture();
			var face3TextureEffect: VisualEffectInstance = Texture2DEffect.createUniqueInstance( face3, SamplerFilterType.LINEAR, SamplerCoordinateType.CLAMP, SamplerCoordinateType.CLAMP );
			
			
			var face4: Texture2D = new Texture2D( TextureFormat.BGRA, 512, 512, 10, BufferUsageType.TEXTURE );
			face4.data = new Face4Texture();
			var face4TextureEffect: VisualEffectInstance = Texture2DEffect.createUniqueInstance( face4, SamplerFilterType.LINEAR, SamplerCoordinateType.CLAMP, SamplerCoordinateType.CLAMP );
			
			var face5: Texture2D = new Texture2D( TextureFormat.BGRA, 512, 512, 10, BufferUsageType.TEXTURE );
			face5.data = new Face5Texture();
			var face5TextureEffect: VisualEffectInstance = Texture2DEffect.createUniqueInstance( face5, SamplerFilterType.LINEAR, SamplerCoordinateType.CLAMP, SamplerCoordinateType.CLAMP );
			
			
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
		}
		
	}

}