package zest3d.geometry 
{
	import flash.utils.ByteArray;
	import io.plugin.math.algebra.APoint;
	import zest3d.effects.ReflectionEffect;
	import zest3d.effects.SkyboxEffect;
	import zest3d.effects.Texture2DEffect;
	import zest3d.resources.enum.AttributeType;
	import zest3d.resources.enum.AttributeUsageType;
	import zest3d.resources.enum.BufferUsageType;
	import zest3d.resources.IndexBuffer;
	import zest3d.resources.Texture2D;
	import zest3d.resources.TextureCube;
	import zest3d.resources.VertexBuffer;
	import zest3d.resources.VertexBufferAccessor;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.Camera;
	import zest3d.scenegraph.TriMesh;
	import zest3d.shaders.enum.CompareMode;
	import zest3d.shaders.states.CullState;
	import zest3d.shaders.states.DepthState;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class SkyboxGeometry extends TriMesh 
	{
		
		private var _camera:Camera;
		
		public function SkyboxGeometry( texture:Texture2D, camera:Camera ) 
		{
			
			_camera = camera;
			var iBuffer:IndexBuffer = new IndexBuffer( 36, 2 );
			
			iBuffer.data.writeShort( 0 );
			iBuffer.data.writeShort( 1 );
			iBuffer.data.writeShort( 3 );
			iBuffer.data.writeShort( 0 );
			iBuffer.data.writeShort( 3 );
			iBuffer.data.writeShort( 2 );
			
			iBuffer.data.writeShort( 4 );
			iBuffer.data.writeShort( 5 );
			iBuffer.data.writeShort( 7 );
			iBuffer.data.writeShort( 4 );
			iBuffer.data.writeShort( 7 );
			iBuffer.data.writeShort( 6 );
			
			iBuffer.data.writeShort( 8 );
			iBuffer.data.writeShort( 9 );
			iBuffer.data.writeShort( 11 );
			iBuffer.data.writeShort( 8 );
			iBuffer.data.writeShort( 11 );
			iBuffer.data.writeShort( 10 );
			
			iBuffer.data.writeShort( 12 );
			iBuffer.data.writeShort( 13 );
			iBuffer.data.writeShort( 15 );
			iBuffer.data.writeShort( 12 );
			iBuffer.data.writeShort( 15 );
			iBuffer.data.writeShort( 14 );
			
			iBuffer.data.writeShort( 16 );
			iBuffer.data.writeShort( 17 );
			iBuffer.data.writeShort( 19 );
			iBuffer.data.writeShort( 16 );
			iBuffer.data.writeShort( 19 );
			iBuffer.data.writeShort( 18 );
			
			iBuffer.data.writeShort( 20 );
			iBuffer.data.writeShort( 21 );
			iBuffer.data.writeShort( 23 );
			iBuffer.data.writeShort( 20 );
			iBuffer.data.writeShort( 23 );
			iBuffer.data.writeShort( 22 );
			
			var vFormat:VertexFormat = VertexFormat.create( 2, AttributeUsageType.POSITION, AttributeType.FLOAT3, 0,
															   AttributeUsageType.TEXCOORD, AttributeType.FLOAT2, 0 );
			
			var vBuffer:VertexBuffer = new VertexBuffer( 24, 20 );
			
			var vba: VertexBufferAccessor = new VertexBufferAccessor( vFormat, vBuffer );
			
			
			/*
			vba.setPositionAt( 0, [ -1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 1, [ -1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 2, [ -1.005, +1.005, +1.005 ] );
			vba.setPositionAt( 3, [ -1.005, +1.005, -1.005 ] );
			
			vba.setTCoordAt( 0, 0, [ 0, 0 ] );
			vba.setTCoordAt( 0, 1, [ 1, 0 ] );
			vba.setTCoordAt( 0, 2, [ 0, 1 ] );
			vba.setTCoordAt( 0, 3, [ 1, 1 ] );
			
			
			
			
			vba.setPositionAt( 4, [ +1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 5, [ +1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 6, [ +1.005, +1.005, -1.005 ] );
			vba.setPositionAt( 7, [ +1.005, +1.005, +1.005 ] );
			
			vba.setTCoordAt( 0, 4, [ 0, 0 ] );
			vba.setTCoordAt( 0, 5, [ 1, 0 ] );
			vba.setTCoordAt( 0, 6, [ 0, 1 ] );
			vba.setTCoordAt( 0, 7, [ 1, 1 ] );
			
			
			
			
			vba.setPositionAt( 8, [ +1.005, +1.005, +1.005 ] );
			vba.setPositionAt( 9, [ -1.005, +1.005, +1.005 ] );
			vba.setPositionAt( 10, [ +1.005, +1.005, -1.005 ] );
			vba.setPositionAt( 11, [ -1.005, +1.005, -1.005 ] );
			
			vba.setTCoordAt( 0, 8, [ 0, 0 ] );
			vba.setTCoordAt( 0, 9, [ 1, 0 ] );
			vba.setTCoordAt( 0, 10, [ 0, 1 ] );
			vba.setTCoordAt( 0, 11, [ 1, 1 ] );
			
			
			
			vba.setPositionAt( 12, [ +1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 13, [ -1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 14, [ +1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 15, [ -1.005, -1.005, +1.005 ] );
			
			vba.setTCoordAt( 0, 12, [ 0, 0 ] );
			vba.setTCoordAt( 0, 13, [ 1, 0 ] );
			vba.setTCoordAt( 0, 14, [ 0, 1 ] );
			vba.setTCoordAt( 0, 15, [ 1, 1 ] );
			
			
			
			vba.setPositionAt( 16, [ +1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 17, [ -1.005, -1.005, +1.005 ] );
			vba.setPositionAt( 18, [ +1.005, +1.005, +1.005 ] );
			vba.setPositionAt( 19, [ -1.005, +1.005, +1.005 ] );
			
			vba.setTCoordAt( 0, 16, [ 0, 0 ] );
			vba.setTCoordAt( 0, 17, [ 1, 0 ] );
			vba.setTCoordAt( 0, 18, [ 0, 1 ] );
			vba.setTCoordAt( 0, 19, [ 1, 1 ] );
			
			
			
			
			vba.setPositionAt( 20, [ -1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 21, [ +1.005, -1.005, -1.005 ] );
			vba.setPositionAt( 22, [ -1.005, +1.005, -1.005 ] );
			vba.setPositionAt( 23, [ +1.005, +1.005, -1.005 ] );
			
			vba.setTCoordAt( 0, 20, [ 0, 0 ] );
			vba.setTCoordAt( 0, 21, [ 1, 0 ] );
			vba.setTCoordAt( 0, 22, [ 0, 1 ] );
			vba.setTCoordAt( 0, 23, [ 1, 1 ] );
			
			*/
			
			
			
			
			//+x
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 1 );
			
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 1 );
			
			
			//-x
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 1 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 1 );
			
			//+y
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 1 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 1 );
			
			//-y
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 1 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 1 );
			
			//+z
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 1 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 1 );
			
			// -z
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 0 );
			
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 0 );
			vBuffer.data.writeFloat( 1 );
			
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( +1.005 );
			vBuffer.data.writeFloat( -1.005 );
			vBuffer.data.writeFloat( 1 );
			vBuffer.data.writeFloat( 1 );
			
			this.effect = new SkyboxEffect( texture );
			var cullState:CullState = effect.getPass(0).cullState;
			cullState.enabled = false;
			
			var depthState:DepthState = effect.getPass(0).depthState;
			//depthState.enabled = false;
			//depthState.writable = false;
			depthState.compare = CompareMode.LEQUAL;
			
			super( vFormat, vBuffer, iBuffer );
			
			localTransform.scale = new APoint( 300, 300, 300 );
		}
		/*
		override public function update(applicationTime:Number = -1.79e+308, initiator:Boolean = true):void 
		{
			super.update(applicationTime, initiator);
			this.localTransform.translate = new APoint( _camera.position.x, _camera.position.y, _camera.position.z );
			
		}*/
	}
}