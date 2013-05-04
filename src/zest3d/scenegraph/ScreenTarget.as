package zest3d.scenegraph 
{
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.AVector;
	import zest3d.resources.enum.AttributeType;
	import zest3d.resources.enum.AttributeUsageType;
	import zest3d.resources.IndexBuffer;
	import zest3d.resources.VertexBuffer;
	import zest3d.resources.VertexBufferAccessor;
	import zest3d.resources.VertexFormat;
	import zest3d.shaders.enum.VertexShaderProfileType;
	import zest3d.shaders.VertexShader;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class ScreenTarget implements IDisposable 
	{
		
		public function ScreenTarget() 
		{
			
		}
		
		public function dispose(): void
		{
			
		}
		
		public static function createCamera(): Camera
		{
			var camera: Camera = new Camera( false );
			camera.setFrustum( [ 0, 1, 0, 1, 0, 1 ] );
			camera.setFrame( APoint.ORIGIN, AVector.UNIT_Z, AVector.UNIT_Y, AVector.UNIT_X );
			return camera;
		}
		
		public static function createRectangle( vFormat: VertexFormat, rtWidth: int, rtHeight: int, xMin: Number, xMax: Number, yMin: Number, yMax: Number, zValue: Number ): TriMesh
		{
			if ( validFormat( vFormat ) && validSizes( rtWidth, rtHeight ) )
			{
				var tc0: Array = [];
				var tc1: Array = [];
				var tc2: Array = [];
				var tc3: Array = [];
				
				if ( VertexShader.profile == VertexShaderProfileType.NONE )
				{
					// TODO do nothing, yeh, wasteful, but I'll come back to this as a switch case etc
					// and fix it up to show that we can support moultiple profile types here
				}
				else
				{
					//TODO check that we have the correct method here
					var dx: Number = 0.5 * (xMax - xMin) / (rtWidth - 1);
					var dy: Number = 0.5 * (yMax - yMin) / (rtHeight - 1);
					xMin -= dx;
					xMax -= dx;
					yMin += dy;
					yMax += dy;
					
					tc0 = [ 0, 1 ];
					tc1 = [ 1, 0 ];
					tc2 = [ 1, 0 ];
					tc3 = [ 0, 0 ];
				}
				
				var vStride: int = vFormat.stride;
				var vBuffer: VertexBuffer = new VertexBuffer( 4, vStride );
				var vba: VertexBufferAccessor = new VertexBufferAccessor( vFormat, vBuffer );
				
				vba.setPositionAt( 0, [ xMin, yMin, zValue ] );
				vba.setPositionAt( 1, [ xMax, yMin, zValue ] );
				vba.setPositionAt( 2, [ xMax, yMax, zValue ] );
				vba.setPositionAt( 3, [ xMin, yMax, zValue ] );
				
				vba.setTCoordAt( 0, 0, tc0 );
				vba.setTCoordAt( 0, 1, tc1 );
				vba.setTCoordAt( 0, 2, tc2 );
				vba.setTCoordAt( 0, 3, tc3 );
				
				var iBuffer: IndexBuffer = new IndexBuffer( 6, 4 );
				iBuffer.setIndexAt( 0, 0 );
				iBuffer.setIndexAt( 0, 1 );
				iBuffer.setIndexAt( 0, 2 );
				iBuffer.setIndexAt( 0, 0 );
				iBuffer.setIndexAt( 0, 2 );
				iBuffer.setIndexAt( 0, 3 );
				
				return new TriMesh( vFormat, vBuffer, iBuffer );
			}
			
			throw new Error( "ScreenTarget::createReactangle() must get a valid format and size." );
		}
		
		public static function createPositions( rtWidth: int, rtHeight: int, xMin: Number, xMax: Number, yMin: Number, yMax: Number, zValue: Number, positions: Array ): Boolean
		{
			if ( validSizes( rtWidth, rtHeight  ) )
			{
				// TODO check that we have the correct implementation here
				if ( VertexShader.profile == VertexShaderProfileType.NONE )
				{
					// again, just showing
				}
				else
				{
					var dx: Number = 0.5 * (xMax - xMin) / (rtWidth - 1);
					var dy: Number = 0.5 * (yMax - yMin) / (rtHeight - 1);
					xMin -= dx;
					xMax -= dx;
					yMin += dy;
					yMax += dy;
				}
				
				positions[ 0 ] = [ xMin, yMin, zValue ];
				positions[ 1 ] = [ xMax, yMin, zValue ];
				positions[ 2 ] = [ xMax, yMax, zValue ];
				positions[ 3 ] = [ xMin, yMax, zValue ];
				
				return true;
			}
			return false;
		}
		
		public static function createTCoords( tCoords: Array ): void
		{
			//TODO again, just showing, see other comment in this class. (check implementation too)
			if ( VertexShader.profile == VertexShaderProfileType.NONE )
			{
				
			}
			else
			{
				tCoords[ 0 ] = [ 0, 1 ];
				tCoords[ 1 ] = [ 1, 1 ];
				tCoords[ 2 ] = [ 1, 0 ];
				tCoords[ 3 ] = [ 0, 0 ];
			}
		}
		
		private static function validSizes( rtWidth: int, rtHeight: int ): Boolean
		{
			if ( rtWidth > 0 && rtHeight > 0 )
			{
				return true;
			}
			throw new Error( "Invalid dimensions." );
		}
		
		private static function validFormat( vFormat: VertexFormat ): Boolean
		{
			var index: int = vFormat.getIndex( AttributeUsageType.POSITION, 0 );
			if ( index < 0 )
			{
				throw new Error( "Format must have positions." );
			}
			
			if ( vFormat.getAttributeType( index ) != AttributeType.FLOAT3 )
			{
				throw new Error( "Positions must be 3-tuples." );
			}
			
			index = vFormat.getIndex( AttributeUsageType.TEXCOORD, 0 );
			if ( index < 0 )
			{
				throw new Error( "Format must have texture coordinates in unit 0." );
			}
			
			if ( vFormat.getAttributeType( index ) != AttributeType.FLOAT2 )
			{
				throw new Error( "Texture coordinates in unit 0 must be 2-tuples." );
			}
			
			return true;
		}
	}

}