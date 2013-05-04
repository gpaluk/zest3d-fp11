package zest3d.effects.local 
{
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.shaderfloats.matrix.PVWMatrixConstant;
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
	public class VertexColor4Effect extends VisualEffect implements IDisposable 
	{
		
		public static const msAGALVRegisters: Array = [ 0, 1 ];
		
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
			"m44 op, va0, vc0\n" +
			"mov v0, vc4",
			// AGAL_2_0
			"",
			"",
			""
		];
		
		public static const msPPrograms: Array =
		[
			"",
			// AGAL_1_0
			"mov oc, v0",
			// AGAL_2_0
			"",
			"",
			""
		];
		
		public function VertexColor4Effect() 
		{
			var vShader: VertexShader = new VertexShader( "Zest3D.VertexColor4", 2, 2, 1, 0, false );
			vShader.setInput( 0, "modelPosition", VariableType.FLOAT3, VariableSemanticType.POSITION );
			vShader.setInput( 1, "modelColor", VariableType.FLOAT3, VariableSemanticType.COLOR0 );
			vShader.setOutput( 0, "clipPosition", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
			vShader.setConstant( 0, "PVWMatrix", 4 );
			vShader.setBaseRegisters( msVRegisters );
			vShader.setPrograms( msVPrograms );
			
			var pShader: PixelShader = new PixelShader( "Zest3D.VertexColor4", 1, 1, 0, 0, false );
			pShader.setInput( 0, "vertexColor", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
			pShader.setOutput( 0, "pixelColor", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
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
		
		public function createInstance(): VisualEffectInstance
		{
			var instance: VisualEffectInstance = new VisualEffectInstance( this, 0 );
			instance.setVertexConstantByHandle( 0, 0, new PVWMatrixConstant() );
			return instance;
		}
		
		public static function creatUniqueInstance(): VisualEffectInstance
		{
			var effect: VertexColor4Effect = new VertexColor4Effect();
			return effect.createInstance();
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
	}

}