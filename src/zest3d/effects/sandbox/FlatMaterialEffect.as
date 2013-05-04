package zest3d.effects.sandbox
{
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.scenegraph.Material;
	import zest3d.shaderfloats.material.MaterialAmbientConstant;
	import zest3d.shaderfloats.material.MaterialDiffuseConstant;
	import zest3d.shaders.enum.SamplerCoordinateType;
	import zest3d.shaders.enum.SamplerFilterType;
	import zest3d.shaders.enum.VariableSemanticType;
	import zest3d.shaders.enum.VariableType;
	import zest3d.shaders.PixelShader;
	import zest3d.shaders.VertexShader;
	import zest3d.shaders.VisualEffect;
	import zest3d.shaders.VisualEffectInstance;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class FlatMaterialEffect extends VisualEffect implements IDisposable 
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
			"m44 op, va0, vc0",
			// AGAL_2_0
			"",
			"",
			""
		];
		
		public static const msPPrograms: Array =
		[
			"",
			// AGAL_1_0
			"mov oc, fc1",
			// AGAL_2_0
			"",
			"",
			""
		];
		
		public function FlatMaterialEffect( filter: SamplerFilterType = null,
											coord0: SamplerCoordinateType = null,
											coord1: SamplerCoordinateType = null ) 
		{
			filter ||= SamplerFilterType.LINEAR;
			coord0 ||= SamplerCoordinateType.CLAMP_EDGE;
			coord1 ||= SamplerCoordinateType.CLAMP_EDGE;
			
			var vShader: VertexShader = new VertexShader( "Zest3D.FlatMaterial", 1, 1, 1, 0, false );
			vShader.setInput( 0, "modelPosition", VariableType.FLOAT3, VariableSemanticType.POSITION );
			vShader.setOutput( 0, "clipPosition", VariableType.FLOAT4, VariableSemanticType.POSITION );
			vShader.setConstant( 0, "PVWMatrix", 4 );
			vShader.setBaseRegisters( msVRegisters );
			vShader.setPrograms( msVPrograms );
			
			var pShader: PixelShader = new PixelShader( "Zest3D.FlatMaterial", 0, 1, 0, 1, false );
			pShader.setOutput( 0, "pixelColor", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
			pShader.setConstant( 0, "ambientColor", 1 );
			
			pShader.setPrograms( msPPrograms );
		}
		
		public function createInstance( material: Material ): VisualEffectInstance
		{
			var instance: VisualEffectInstance = new VisualEffectInstance( this, 0 );
			instance.setVertexConstantByHandle( 0, 0, MaterialDiffuseConstant( material ) );
			
			return instance;
		}
		
		public static function createUniqueInstance( material: Material ): VisualEffectInstance
		{
			var effect: FlatMaterialEffect = new FlatMaterialEffect();
			
			return effect.createInstance( material );
		}
		
		override public function dispose():void 
		{
			super.dispose();
		}
		
	}

}