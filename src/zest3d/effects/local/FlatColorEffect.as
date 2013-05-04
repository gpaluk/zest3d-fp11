package zest3d.effects.local 
{
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.Material;
	import zest3d.shaderfloats.material.MaterialDiffuseConstant;
	import zest3d.shaderfloats.matrix.PVWMatrixConstant;
	import zest3d.shaderfloats.ShaderFloat;
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
	 * @author Gary Paluk
	 */
	public class FlatColorEffect extends VisualEffect implements IDisposable 
	{
		
		public static const msAGALVRegisters: Array = [ 0, 1 ];
		public static const msAGALPRegisters: Array = [ 0, 1 ];
		
		public static const msVRegisters: Array =
		[
			null,
			msAGALVRegisters,
			null,
			null,
			null
		];
		
		public static const msPRegisters: Array =
		[
			null,
			msAGALPRegisters,
			null,
			null,
			null
		];
		
		public static const msVPrograms: Array =
		[
			"",
			// AGAL_1_0
			"m44 op, va0, vc0 \n",
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
			"mov oc, fc0 \n",
			// AGAL_2_0
			"",
			"",
			""
		];
		
		public function FlatColorEffect( ) 
		{
			
			var vShader: VertexShader = new VertexShader( "Zest3D.MaterialTexture", 1, 1, 1, 0, false );
			vShader.setInput( 0, "modelPosition", VariableType.FLOAT3, VariableSemanticType.POSITION );
			vShader.setOutput( 0, "clipPosition", VariableType.FLOAT4, VariableSemanticType.POSITION );
			vShader.setConstant( 0, "PVWMatrix", 4 );
			vShader.setBaseRegisters( msVRegisters );
			vShader.setPrograms( msVPrograms );
			
			var pShader: PixelShader = new PixelShader( "Zest3D.MaterialTexture", 0, 1, 1, 0, false );
			pShader.setOutput( 0, "pixelColor", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
			pShader.setConstant( 0, "MaterialDiffuse", 1 );
			pShader.setBaseRegisters( msVRegisters );
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
			insertTechnique( technique );
			
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
		public function createInstance( material: Material ): VisualEffectInstance
		{
			var instance: VisualEffectInstance = new VisualEffectInstance( this, 0 );
			instance.setVertexConstantByHandle( 0, 0, new PVWMatrixConstant() );
			instance.setPixelConstantByHandle( 0, 0, new MaterialDiffuseConstant( material ) );
			
			return instance;
		}
		
		public static function createUniqueInstance( material: Material ): VisualEffectInstance
		{
			var effect: FlatColorEffect = new FlatColorEffect();
			
			return effect.createInstance( material );
			
		}
		
	}

}