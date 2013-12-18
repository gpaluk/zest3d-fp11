/**
 * Plugin.IO - http://www.plugin.io
 * Copyright (c) 2013
 *
 * Geometric Tools, LLC
 * Copyright (c) 1998-2012
 * 
 * Distributed under the Boost Software License, Version 1.0.
 * http://www.boost.org/LICENSE_1_0.txt
 */
package zest3d.scenegraph 
{
	import flash.utils.getQualifiedClassName;
	import io.plugin.core.errors.AbstractClassError;
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.AVector;
	import io.plugin.math.base.MathHelper;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.AttributeUsageType;
	import zest3d.resources.IndexBuffer;
	import zest3d.resources.VertexBuffer;
	import zest3d.resources.VertexBufferAccessor;
	import zest3d.resources.VertexFormat;
	import zest3d.scenegraph.enum.PrimitiveType;
	import zest3d.scenegraph.enum.UpdateType;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Triangles extends Visual implements IDisposable 
	{
		
		protected var _vba: VertexBufferAccessor;
		
		public function Triangles( type: PrimitiveType, vFormat: VertexFormat, vBuffer:VertexBuffer, iBuffer:IndexBuffer = null ) 
		{
			super( type, vFormat, vBuffer, iBuffer );
			if ( getQualifiedClassName( this ) == "zest3d.scenegraph::Triangles" )
			{
				throw new AbstractClassError();
			}
			
			_vba = new VertexBufferAccessor( _vFormat, _vBuffer );
		}
		
		override public function dispose():void 
		{
			//TODO Triangles::dispose()
			super.dispose();
		}
		
		// virtual
		public function get numTriangles(): int
		{
			throw new Error( "Method is virtual" );
		}
		
		public function getTriangleAt( index: int, data: Array ): Boolean
		{
			throw new Error( "virtual method must be overridden." );
		}
		
		
		public function getModelTriangleAt( index: int, modelTriangle: Array ): Boolean
		{
			var tri: Array = [];
			
			if ( getTriangleAt( index, tri ) )
			{
				modelTriangle[ 0 ] = _vba.getPositionAt( tri[ 0 ] );
				modelTriangle[ 1 ] = _vba.getPositionAt( tri[ 1 ] );
				modelTriangle[ 2 ] = _vba.getPositionAt( tri[ 2 ] );
				return true;
			}
			return false;
		}
		
		public function getWorldTriangleAt( index: int, worldTriangle: Array ): Boolean
		{
			var modelTriangle: Array = [];
			if ( getModelTriangleAt( index, modelTriangle ) )
			{
				//TODO model point to TEMP
				worldTriangle[ 0 ] = worldTransform.multiplyAPoint( APoint.fromTuple( modelTriangle[ 0 ] )).toTuple();
				worldTriangle[ 1 ] = worldTransform.multiplyAPoint( APoint.fromTuple( modelTriangle[ 1 ] )).toTuple();
				worldTriangle[ 2 ] = worldTransform.multiplyAPoint( APoint.fromTuple( modelTriangle[ 2 ] )).toTuple();
				
				return true;
			}
			return false;
		}
		
		[Inline]
		public final function get numVertices(): int
		{
			return _vBuffer.numElements;
		}
		
		public function getPositionAt( index: int ): Array
		{
			var i: int = _vFormat.getIndex( AttributeUsageType.POSITION );
			if ( i >= 0 )
			{
				var positions: uint = _vFormat.getOffset( i );
				var stride: int = _vFormat.stride;
				
				_vBuffer.data.position = (positions + index * stride);
				return [ _vBuffer.data.readFloat(),
						 _vBuffer.data.readFloat(),
						 _vBuffer.data.readFloat() ];
			}
			throw new Error( "Get position failed." );
		}
		
		//virtual
		override public function updateModelSpace(type:UpdateType):void 
		{
			updateModelBound();
			if ( type == UpdateType.MODEL_BOUND_ONLY )
			{
				return;
			}
			
			if ( _vba.hasNormal() )
			{
				updateModelNormals( _vba );
			}
			
			if ( type == UpdateType.NORMALS )
			{
				if ( _vba.hasTangent() || _vba.hasBinormal() )
				{
					if ( type == UpdateType.USE_GEOMETRY )
					{
						updateModelTangentsUseGeometry( _vba );
					}
					else
					{
						updateModelTangentsUseTCoords( _vba );
					}
				}
			}
			
			Renderer.updateAllVertexBuffer( _vBuffer );
		}
		
		
		private function updateModelNormals( vba: VertexBufferAccessor ): void
		{
			var numVertices: int = vba.numVertices;
			var i: int;
			
			for ( i = 0; i < numVertices; ++i )
			{
				vba.setNormalAt( i, [ 0, 0, 0 ] );
			}
			
			var numTriangles: int = this.numTriangles;
			for ( i = 0; i < numTriangles; ++i )
			{
				var triangle: Array = [];
				if ( !getTriangleAt( i, triangle ) )
				{
					continue;
				}
				
				var posArr0: Array = vba.getPositionAt( triangle[ 0 ] );
				var posArr1: Array = vba.getPositionAt( triangle[ 1 ] );
				var posArr2: Array = vba.getPositionAt( triangle[ 2 ] );
				
				var pos0: APoint = new APoint( posArr0[ 0 ], posArr0[ 1 ], posArr0[ 2 ] );
				var pos1: APoint = new APoint( posArr1[ 0 ], posArr1[ 1 ], posArr1[ 2 ] );
				var pos2: APoint = new APoint( posArr2[ 0 ], posArr2[ 1 ], posArr2[ 2 ] );
				
				var triEdge1: AVector = pos1.subtract( pos0 );
				var triEdge2: AVector = pos2.subtract( pos0 );
				var triNormal: AVector = triEdge1.crossProduct( triEdge2 );
				
				var normal0: Array = vba.getNormalAt( triangle[ 0 ] );
				var normal1: Array = vba.getNormalAt( triangle[ 1 ] );
				var normal2: Array = vba.getNormalAt( triangle[ 2 ] );
				
				// TODO minimize object cration POOL
				var n0: AVector = new AVector( normal0[ 0 ], normal0[ 1 ], normal0[ 2 ] );
				var n1: AVector = new AVector( normal1[ 0 ], normal1[ 1 ], normal1[ 2 ] );
				var n2: AVector = new AVector( normal2[ 0 ], normal2[ 1 ], normal2[ 2 ] );
				
				var out0: AVector = n0.add( triNormal );
				var out1: AVector = n1.add( triNormal );
				var out2: AVector = n2.add( triNormal );
				
				vba.setNormalAt( triangle[ 0 ], [ out0.x, out0.y, out0.z ] );
				vba.setNormalAt( triangle[ 1 ], [ out1.x, out1.y, out1.z ] );
				vba.setNormalAt( triangle[ 2 ], [ out2.x, out2.y, out2.z ] );
				
			}
			
			for ( i = 0; i < numVertices; ++i )
			{
				var normal: Array = vba.getNormalAt( i );
				
				var out: AVector = new AVector( normal[0], normal[1], normal[2] );
				out.normalize();
				
				vba.setNormalAt( i, [ out.x, out.y, out.z ] );
			}
			
		}
		
		
		private function updateModelTangentsUseGeometry( vba: VertexBufferAccessor ): void
		{
			throw new Error( "Method not implemented Triangles::updateModelTangentsUseGeometry" );
		}
		
		
		private function updateModelTangentsUseTCoords( vba: VertexBufferAccessor ): void
		{
			throw new Error( "Method not implemented Triangles::updateModelTangentsUseTCoords" );
		}
		
		
		private static function computeTangent( position0: APoint, tCoord0: Array,
												position1: APoint, tCoord1: Array,
												position2: APoint, tCoord2: Array ): AVector
		{
			
			var diffP1P0: AVector = position1.subtract( position0 );
			var diffP2P0: AVector = position2.subtract( position0 );
			
			if ( Math.abs( diffP1P0.length ) < MathHelper.ZERO_TOLLERANCE
			  || Math.abs( diffP2P0.length ) < MathHelper.ZERO_TOLLERANCE )
			{
				return AVector.ZERO;
			}
			
			var diffU1U0: Number = tCoord1[ 0 ] - tCoord0[ 0 ];
			var diffV1V0: Number = tCoord1[ 1 ] - tCoord0[ 1 ];
			
			if ( Math.abs( diffV1V0 ) < MathHelper.ZERO_TOLLERANCE )
			{
				if ( Math.abs( diffU1U0 ) < MathHelper.ZERO_TOLLERANCE )
				{
					return AVector.ZERO;
				}
				return diffP1P0.divide( diffU1U0 );
			}
			
			
			var diffU2U0: Number = tCoord2[ 0 ] - tCoord0[ 0 ];
			var diffV2V0: Number = tCoord2[ 1 ] - tCoord0[ 1 ];
			var det: Number = diffV1V0 * diffU2U0 - diffV2V0 * diffU1U0;
			
			if ( Math.abs( det ) < MathHelper.ZERO_TOLLERANCE )
			{
				return AVector.ZERO;
			}
			
			return diffP2P0.scale( diffV1V0 ).subtract( diffP1P0.scale( diffV2V0 ) ).divide( det );
		}
		
		
	}

}