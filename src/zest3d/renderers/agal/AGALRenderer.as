/**
 * Plugin.IO - http://www.plugin.io
 * Copyright (c) 2011-2012
 *
 * Geometric Tools, LLC
 * Copyright (c) 1998-2012
 * 
 * Distributed under the Boost Software License, Version 1.0.
 * http://www.boost.org/LICENSE_1_0.txt
 */
package zest3d.renderers.agal 
{
	import flash.display3D.Context3DBlendFactor;
	import flash.display3D.Context3DCompareMode;
	import flash.display3D.Context3DTriangleFace;
	import flash.display3D.Context3DVertexBufferFormat;
	import flash.display3D.Program3D;
	import flash.geom.Rectangle;
	import flash.utils.ByteArray;
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.effects.global.GlobalEffect;
	import zest3d.renderers.agal.pdr.AGALIndexBuffer;
	import zest3d.renderers.agal.pdr.AGALPixelShader;
	import zest3d.renderers.agal.pdr.AGALRenderTarget;
	import zest3d.renderers.agal.pdr.AGALTexture2D;
	import zest3d.renderers.agal.pdr.AGALTexture3D;
	import zest3d.renderers.agal.pdr.AGALTextureCube;
	import zest3d.renderers.agal.pdr.AGALVertexBuffer;
	import zest3d.renderers.agal.pdr.AGALVertexFormat;
	import zest3d.renderers.agal.pdr.AGALVertexShader;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.TextureFormat;
	import zest3d.resources.IndexBuffer;
	import zest3d.resources.VertexBuffer;
	import zest3d.scenegraph.enum.PrimitiveType;
	import zest3d.scenegraph.TriMesh;
	import zest3d.scenegraph.Visual;
	import zest3d.shaders.enum.SrcBlendMode;
	import zest3d.shaders.states.CullState;
	import zest3d.shaders.states.DepthState;
	import zest3d.shaders.states.OffsetState;
	import zest3d.shaders.states.StencilState;
	import zest3d.shaders.states.WireState;
	
	import zest3d.shaders.states.AlphaState;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class AGALRenderer extends Renderer implements IDisposable 
	{
		
		public function AGALRenderer( input: AGALRendererInput, width: int, height: int, colorFormat: TextureFormat, depthStencilFormat: TextureFormat, numMultiSamples: int ) 
		{
			
			super( GlobalEffect, AGALIndexBuffer, AGALPixelShader, AGALRenderTarget,
				/*AGALTexture1D,*/ AGALTexture2D, AGALTexture3D, AGALTextureCube,
				AGALVertexBuffer, AGALVertexFormat, AGALVertexShader );
			
			_initialize( width, height, colorFormat, depthStencilFormat, numMultiSamples );
			
			_data = new AGALRendererData( input, width, height, colorFormat, depthStencilFormat, numMultiSamples );
			
			data.currentRS.initialize( _defaultAlphaState, _defaultCullState, _defaultDepthState,
									   _defaultOffsetState, _defaultStencilState, _defaultWireState );
			
			// Configure the back buffer
			data.context.configureBackBuffer( width, height, numMultiSamples, true );
		}
		
		override public function dispose():void 
		{
			data.dispose();
			_data = null;
			terminate();
		}
		
		// helper method
		public function get data(): AGALRendererData
		{
			return _data as AGALRendererData;
		}
		
		override public function set alphaState( alphaState:AlphaState):void 
		{
			if ( !_overrideAlphaState )
			{
				_alphaState = alphaState;
			}
			else
			{
				_alphaState = _overrideAlphaState;
			}
			
			if ( _alphaState.blendEnabled )
			{
				
				
				if ( !data.currentRS._alphaBlendEnabled )
				{
					data.currentRS._alphaBlendEnabled = true;
					// glEnable(GL_BLEND);
				}
				
				var srcBlend: String = AGALMapping.alphaSrcBlend[ _alphaState.srcBlend.index ];
				var dstBlend: String = AGALMapping.alphaDstBlend[ _alphaState.dstBlend.index ];
				
				if ( srcBlend != data.currentRS._alphaSrcBlend
				  || dstBlend != data.currentRS._alphaDstBlend )
				{
					data.currentRS._alphaSrcBlend = srcBlend;
					data.currentRS._alphaDstBlend = dstBlend;
					
					// glBlendFunc(srcBlend, dstBlend);
					
				}
				data.context.setBlendFactors( srcBlend, dstBlend );
				
				
				if ( _alphaState.constantColor != data.currentRS._blendColor )
				{
					data.currentRS._blendColor = _alphaState.constantColor;
					
					// glBlendColor(
					// 		mData->mCurrentRS.mBlendColor[0],
					// 		mData->mCurrentRS.mBlendColor[1],
					// 		mData->mCurrentRS.mBlendColor[1],
					// 		mData->mCurrentRS.mBlendColor[3] );
					/*
					data.context.setColorMask( data.currentRS._blendColor[ 0 ],
											   data.currentRS._blendColor[ 1 ],
											   data.currentRS._blendColor[ 2 ],
											   data.currentRS._blendColor[ 3 ] );*/
				}
				
			}
			else
			{
				if ( data.currentRS._alphaBlendEnabled )
				{
					data.currentRS._alphaBlendEnabled = false;
					
					// glDisable(GL_BLEND);
					data.context.setBlendFactors( Context3DBlendFactor.ONE, Context3DBlendFactor.ZERO );
				}
			}
			
			/*
			if ( _alphaState.compareEnabled )
			{
				
				
				if ( !data.currentRS._alphaCompareEnabled )
				{
					data.currentRS._alphaCompareEnabled = true;
					//  glEnable(GL_ALPHA_TEST);
				}
				
				var compare: String = AGALMapping.alphaCompare[ _alphaState.compare.index ];
				var reference: Number = _alphaState.reference;
				//data.context.setDepthTest( true, AGALMapping.alphaCompare[ alphaState.compare.index ] );
				if ( compare != data.currentRS._compareFunction
				  || reference != data.currentRS._alphaReference )
				{
					data.currentRS._compareFunction = compare;
					data.currentRS._alphaReference = reference;
					
					// glAlphaFunc(compare, reference);
					data.context.setDepthTest( true, AGALMapping.alphaCompare[ alphaState.compare.index ] );
					data.context.setStencilReferenceValue( reference );
				}
				
			}
			else
			{
				if ( data.currentRS._alphaCompareEnabled )
				{
					data.currentRS._alphaCompareEnabled = false;
					
					// glDisable(GL_ALPHA_TEST);
					data.context.setDepthTest( false, Context3DCompareMode.NEVER );
				}
				
			}
			*/
		}
		
		override public function set cullState( cullState:CullState ):void 
		{
			if ( !_overrideCullState )
			{
				_cullState = cullState;
			}
			else
			{
				_cullState = _overrideCullState;
			}
			
			if ( _cullState.enabled )
			{
				if ( !data.currentRS._cullEnabled )
				{
					data.currentRS._cullEnabled = true;
					// glEnable(GL_CULL_FACE);
					// glFrontFace(GL_CCW);
					//data.context.setCulling(Context3DTriangleFace.FRONT);
				}
				
				var order: Boolean = _cullState.ccwOrder;
				if ( _reverseCullOrder )
				{
					order = !order;
				}
				
				if ( order != data.currentRS._ccwOrder )
				{
					data.currentRS._ccwOrder = order;
					if ( data.currentRS._ccwOrder )
					{
						// glCullFace(GL_BACK);
						data.context.setCulling(Context3DTriangleFace.BACK);
					}
					else
					{
						// glCullFace(GL_FRONT);
						data.context.setCulling(Context3DTriangleFace.FRONT);
					}
				}
			}
			else
			{
				if ( data.currentRS._cullEnabled )
				{
					data.currentRS._cullEnabled = false;
					
					// glDisable(GL_CULL_FACE);
					data.context.setCulling(Context3DTriangleFace.NONE);
				}
			}
		}
		
		override public function set depthState( depthState:DepthState):void 
		{
			
			if ( !_overrideDepthState )
			{
				_depthState = depthState;
			}
			else
			{
				_depthState = _overrideDepthState;
			}
			
			if ( _depthState.enabled )
			{
				var depthRequiresUpdate:Boolean = false;
				var compare: String = AGALMapping.depthCompare[ _depthState.compare.index ];
				
				if ( !data.currentRS._depthEnabled || compare != data.currentRS._depthCompareFunction )
				{
					depthRequiresUpdate = true;
					data.currentRS._depthEnabled = true;
					data.currentRS._depthCompareFunction = compare;
					
					// glEnable( GL_DEPTH_TEST )
				}
				if ( depthRequiresUpdate )
				{
					data.context.setDepthTest( depthState.writable, compare );
				}
				/*
				var compare: String = AGALMapping.depthCompare[ _depthState.compare.index ];
				if ( compare != data.currentRS._depthCompareFunction )
				{
					data.currentRS._depthCompareFunction = compare;
					// glDepthFunc(compare);
					
				}*/
			}
			else
			{
				if ( data.currentRS._depthEnabled )
				{
					data.currentRS._depthEnabled = false;
					//  glDisable(GL_DEPTH_TEST);
					data.context.setDepthTest( false, Context3DCompareMode.LESS );
				}
			}
			
			
		}
		
		override public function set offsetState(offsetState:OffsetState):void 
		{
			/*
			if ( !_overrideOffsetState )
			{
				_offsetState = offsetState;
			}
			else
			{
				_offsetState = _overrideOffsetState;
			}
			
			if ( _offsetState.fillEnabled )
			{
				if ( !data.currentRS._fillEnabled )
				{
					data.currentRS._fillEnabled = true;
					//  glEnable(GL_POLYGON_OFFSET_FILL);
				}
			}
			else
			{
				if ( data.currentRS._fillEnabled )
				{
					data.currentRS._fillEnabled = false;
					// glDisable(GL_POLYGON_OFFSET_FILL);
				}
			}
			
			if ( _offsetState.lineEnabled )
			{
				if ( !data.currentRS._lineEnabled )
				{
					data.currentRS._lineEnabled = true;
					// glEnable(GL_POLYGON_OFFSET_LINE);
				}
			}
			else
			{
				if ( data.currentRS._lineEnabled )
				{
					data.currentRS._lineEnabled = false;
					// glDisable(GL_POLYGON_OFFSET_LINE);
				}
			}
			
			if ( _offsetState.pointEnabled )
			{
				if ( !data.currentRS._pointEnabled )
				{
					data.currentRS._pointEnabled = true;
					// glEnable(GL_POLYGON_OFFSET_POINT);
				}
			}
			else
			{
				if ( data.currentRS._pointEnabled )
				{
					data.currentRS._pointEnabled = false;
					// glDisable(GL_POLYGON_OFFSET_POINT);
				}
			}
			
			if ( _offsetState.scale != data.currentRS._offsetScale
			  || _offsetState.bias != data.currentRS._offsetBias )
			{
				data.currentRS._offsetScale = _offsetState.scale;
				data.currentRS._offsetBias = _offsetState.bias;
				// glPolygonOffset(mOffsetState->Scale, mOffsetState->Bias);
			}*/
		}
		
		override public function set stencilState(stencilState:StencilState):void 
		{
			if ( !_overrideStencilState )
			{
				_stencilState = stencilState;
			}
			else
			{
				_stencilState = _overrideStencilState;
			}
			
			if ( _stencilState.enabled )
			{
				if ( !data.currentRS._stencilEnabled )
				{
					data.currentRS._stencilEnabled = true;
					//glEnable(GL_STENCIL_TEST);
				}
				
				var compare: String = AGALMapping.stencilCompare[ _stencilState.compare.index ];
				if ( compare != data.currentRS._stencilCompareFunction
					|| _stencilState.reference != data.currentRS._stencilReference
					|| _stencilState.mask != data.currentRS._stencilMask )
				{
					data.currentRS._stencilCompareFunction = compare;
					data.currentRS._stencilReference = _stencilState.reference;
					data.currentRS._stencilMask = _stencilState.mask;
					
					// glStencilFunc(compare, mStencilState->Reference,  mStencilState->Mask);
					data.context.setStencilReferenceValue( _stencilState.reference, _stencilState.mask, 0/*, _stencilState.writeMask*/ );
				}
				
				if ( _stencilState.writeMask != data.currentRS._stencilWriteMask )
				{
					data.currentRS._stencilWriteMask = _stencilState.writeMask;
					
					// glStencilMask(mStencilState->WriteMask);
					data.context.setStencilReferenceValue( _stencilState.reference, _stencilState.mask, 0/*, _stencilState.writeMask*/ );
				}
			}
		}
		
		override public function set wireState(wireState:WireState):void 
		{
		}
		
		override public function setViewport(x:int, y:int, width:int, height:int):void 
		{
		}
		
		override public function getViewport():Array 
		{
			// TODO encapsulate a viewport rectangle
			return [0, 0, _width, _height];
		}
		
		override public function setDepthRange(zMin:Number, zMax:Number):void 
		{
			//data.context.
			//data.context.setStencilReferenceValue( 0, zMin, zMax );
		}
		
		override public function getDepthRange():Array 
		{
			//TODO calculate this
			//data.context.setStencilReferenceValue( 0, 0, 255 );
			return [ 0, 1 ];
		}
		
		override public function resize(width:int, height:int):void 
		{
			_width = width;
			_height = height;
			
			// glGetIntegerv(GL_VIEWPORT, param);
			// glViewport(param[0], param[1], width, height);
			
		}
		
		override public function clearColorBuffer(x:int = 0, y:int = 0, width:int = -1, height:int = -1):void 
		{
			if ( width > 0 || height > 0 )
			{
				throw new Error( "Scissoring does not affect AGAL clear operations." );
			}
			data.context.clear( _clearColor.r, _clearColor.g, _clearColor.b, _clearColor.a );
		}
		
		override public function clearDepthBuffer(x:int = 0, y:int = 0, width:int = -1, height:int = -1):void 
		{
			if ( width > 0 || height > 0 )
			{
				throw new Error( "Scissoring does not affect AGAL clear operations." );
			}
			//data.context.clear( null, null, null, null, _clearDepth, null, null );
		}
		
		override public function clearStencilBuffer(x:int = 0, y:int = 0, width:int = -1, height:int = -1):void 
		{
			if ( width > 0 || height > 0 )
			{
				throw new Error( "Scissoring does not affect AGAL clear operations." );
			}
			//data.context.clear( null, null, null, null, null, null, _clearStencil );
		}
		
		override public function clearBuffers(x:int = 0, y:int = 0, width:int = -1, height:int = -1):void 
		{
			if ( width > 0 || height > 0 )
			{
				throw new Error( "Scissoring does not affect AGAL clear operations." );
			}
			// TODO investigate the use of mask
			data.context.clear( _clearColor.r, _clearColor.g, _clearColor.b, _clearColor.a, _clearDepth, _clearStencil );
		}
		
		override public function setColorMask(allowRed:Boolean, allowGreen:Boolean, allowBlue:Boolean, allowAlpha: Boolean ):void 
		{
			_allowRed = allowRed;
			_allowGreen = allowGreen;
			_allowBlue = allowBlue;
			_allowAlpha = allowAlpha;
			
			data.context.setColorMask( _allowRed, _allowGreen, _allowBlue, _allowAlpha );
		}
		
		override public function preDraw():Boolean 
		{
			data.context.clear();
			return true;
		}
		
		override public function postDraw():void 
		{
			data.context.present();
		}
		
		override protected function drawPrimitive(visual:Visual):void 
		{
			var type: PrimitiveType = visual.primitiveType;
			var vBuffer: VertexBuffer = visual.vertexBuffer;
			var iBuffer:IndexBuffer = visual.indexBuffer;
			
			if ( type == PrimitiveType.TRIMESH ||
				 type == PrimitiveType.TRISTRIP ||
				 type == PrimitiveType.TRIFAN )
			{
				var numVertices: int = vBuffer.numElements;
				var numIndices: int = iBuffer.numElements;
				
				//TODO set ibuffer offsets etc in DRAW :D
				var indexType: String;
				if ( numVertices > 0 && numIndices > 0 )
				{
					if ( iBuffer.elementSize == 2 )
					{
						/*
						var program: Program3D = data.context.createProgram();
						program.upload( AGALVertexShader.program, AGALPixelShader.program );
						data.context.setProgram( program );
						*/
						
						var agalIBuffer: AGALIndexBuffer = getResourceIndexBuffer( iBuffer ) as AGALIndexBuffer;
						data.context.drawTriangles( agalIBuffer.indexBuffer3D ); // TODO the offset an count
					}
					else
					{
						throw new Error( "Only element sizes of 2 bytes are supported. AGALRenderer::drawPrimitive()" );
					}
					
				}
			}
			else
			{
				throw new Error( "Currently supports meshes only." );
			}
			
		}
		
	}

}