package zest3d.effects 
{
	import zest3d.resources.Texture2D;
	import zest3d.shaderfloats.matrix.PVWMatrixConstant;
	import zest3d.shaders.enum.SamplerCoordinateType;
	import zest3d.shaders.enum.SamplerFilterType;
	import zest3d.shaders.enum.SamplerType;
	import zest3d.shaders.enum.VariableSemanticType;
	import zest3d.shaders.enum.VariableType;
	import zest3d.shaders.PixelShader;
	import zest3d.shaders.states.AlphaState;
	import zest3d.shaders.states.CullState;
	import zest3d.shaders.states.DepthState;
	import zest3d.shaders.states.OffsetState;
	import zest3d.shaders.states.StencilState;
	import zest3d.shaders.states.WireState;
	import zest3d.shaders.VertexShader;
	import zest3d.shaders.VisualEffect;
	import zest3d.shaders.VisualEffectInstance;
	import zest3d.shaders.VisualPass;
	import zest3d.shaders.VisualTechnique;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Texture2DEffect extends VisualEffectInstance 
	{
		
		public static const msAGALVRegisters: Array = [ 0, 1 ];
		public static const msAllPTextureUnits: Array = [ 1 ];
		
		public static const msPTextureUnits: Array =
		[
			null,
			msAllPTextureUnits,
			null,
			null,
			null
		];
		
		public static const msVRegisters: Array =
		[
			null,
			msAGALVRegisters,
			null,
			null,
			null
		];
		
		public static const msVPrograms: Array =
		[
			"",
			// AGAL_1_0
			"m44 op, va0, vc0 \n" +
			"mov v0, va1",
			// AGAL_2_0
			"",
			"",
			""
		];
		
		
		// TODO rebuild to accept changes to sampler (this is just an example)
		
		public static const msPPrograms: Array =
		[
			"",
			// AGAL_1_0
			"mov ft0, v0 \n" +
			"tex ft1, ft0, fs1 <2d,clamp,linear,miplinear,dxt1> \n" +
			"mov oc, ft1",
			// AGAL_2_0
			"",
			"",
			""
		];
		
		private var _visualEffect:VisualEffect;
		
		public function Texture2DEffect( texture:Texture2D, filter:SamplerFilterType = null,
										  coord0: SamplerCoordinateType = null, coord1: SamplerCoordinateType = null ) 
		{
			filter ||= SamplerFilterType.LINEAR;
			coord0 ||= SamplerCoordinateType.CLAMP_EDGE;
			coord1 ||= SamplerCoordinateType.CLAMP_EDGE;
			
			var vShader: VertexShader = new VertexShader( "Zest3D.MaterialTexture", 2, 1, 1, 0, false );
			vShader.setInput( 0, "modelPosition", VariableType.FLOAT3, VariableSemanticType.POSITION );
			vShader.setInput( 1, "modelTCoord", VariableType.FLOAT2, VariableSemanticType.TEXCOORD0 );
			vShader.setOutput( 0, "clipPosition", VariableType.FLOAT4, VariableSemanticType.POSITION );
			vShader.setConstant( 0, "PVWMatrix", 4 );
			vShader.setBaseRegisters( msVRegisters );
			vShader.setPrograms( msVPrograms );
			
			var pShader: PixelShader = new PixelShader( "Zest3D.MaterialTexture", 1, 1, 0, 1, false );
			pShader.setInput( 0, "vertexTCoord", VariableType.FLOAT2, VariableSemanticType.TEXCOORD0 );
			pShader.setOutput( 0, "pixelColor", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
			pShader.setSampler( 0, "BaseSampler", SamplerType.TYPE_2D );
			pShader.setFilter( 0, filter );
			pShader.setCoordinate( 0, 0, coord0 );
			pShader.setCoordinate( 0, 1, coord1 );
			pShader.setTextureUnits( msPTextureUnits );
			pShader.setPrograms( msPPrograms );
			
			var pass: VisualPass = new VisualPass();
			pass.vertexShader = vShader;
			pass.pixelShader = pShader;
			pass.alphaState = new AlphaState();
			pass.cullState = new CullState();
			pass.depthState = new DepthState();
			pass.offsetState = new OffsetState();
			pass.stencilState = new StencilState();
			pass.wireState = new WireState();
			
			var technique: VisualTechnique = new VisualTechnique();
			technique.insertPass( pass );
			
			_visualEffect = new VisualEffect();
			_visualEffect.insertTechnique( technique );
			
			super( _visualEffect, 0 );
			
			setVertexConstantByHandle( 0, 0, new PVWMatrixConstant() );
			setPixelTextureByHandle( 0, 0, texture );
			
			var filter: SamplerFilterType = visualEffect.getPixelShader( 0, 0 ).getFilter( 0 );
			
			if ( filter != SamplerFilterType.NEAREST &&
				 filter != SamplerFilterType.LINEAR &&
				 !texture.hasMipmaps )
			{
				texture.generateMipmaps();
			}
		}
		
		public function get visualEffect():VisualEffect 
		{
			return _visualEffect;
		}
	}

}