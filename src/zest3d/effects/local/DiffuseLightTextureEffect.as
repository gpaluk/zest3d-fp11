package zest3d.effects.local {
	
	import io.plugin.core.interfaces.IDisposable;
	import zest3d.resources.Texture2D;
	import zest3d.scenegraph.enum.LightType;
	import zest3d.scenegraph.Light;
	import zest3d.shaderfloats.light.*;
	import zest3d.shaderfloats.matrix.PVWMatrixConstant;
	import zest3d.shaderfloats.ShaderFloat;
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
	public class DiffuseLightTextureEffect extends VisualEffect implements IDisposable {

		public function DiffuseLightTextureEffect() {
		}
		
		public function vertexShader(lights:Vector.<Light>):String {
			var shader:String = "";
			shader += "m44 op, va0, vc0 \n";
			shader += "mov v0, va1 \n";
			if(lights.length>0){
				shader += "m33 vt0.xyz, va2.xyz, vc0 \n";
				shader += "mov v1, vt0.xyzx \n";
			}
			return shader;
		}

		public function fragmentShader(lights:Vector.<Light>):String {
			var shader:String = "";
			//Get Diffuse
			shader += "tex ft0, v0, fs1 <rgba,2d,clamp,linear,mipmap>\n";
			
			if(lights.length>0){
				//Get Normal And Normalize It
				shader += "nrm ft1.xyz, v1.xyz \n";
				//Set Lighting To Zero
				shader += "mov ft2.xyz, fc0.xxx \n";
				
				//Add Lights
				for(var i:int=0; i<lights.length; i+=1){
					var light:Light = lights[i];
					
					switch( light.type ){
						case LightType.DIRECTIONAL:
							shader += addDirectionalLight(light);
						break;
						default:
							trace( "Only directional lights are currently supported." );
						break;
					}
				}
				
				//Muliply Diffuse By Light
				shader += "mul ft0.xyz, ft0.xyz, ft2.xyz \n";
			}
			
			//Output
			shader += "mov oc, ft0 \n";
			return shader;
		}
		
		private function addDirectionalLight(light:Light):String {
			var shader:String = "";
			shader += "dp3 ft3.xyz, ft1.xyz, fc1.xyz \n";
			shader += "sat ft3.xyz, ft3.xyz \n";
			shader += "mul ft3.xyz, ft3.xyz, fc2.xyz \n";
			shader += "add ft2.xyz, ft2.xyz, ft3.xyz \n";
			return shader;
		}
		
		private function compile(lights:Vector.<Light>):void{
			var numLights:int = lights.length;
			
			var vShader: VertexShader = new VertexShader( "Zest3D.MaterialTexture", 3, 1, 1, 0, false);
			vShader.setInput( 0, "modelPosition", VariableType.FLOAT3, VariableSemanticType.POSITION );
			vShader.setInput( 1, "modelTCoord", VariableType.FLOAT2, VariableSemanticType.TEXCOORD0 );
			vShader.setInput( 2, "modelNormal", VariableType.FLOAT3, VariableSemanticType.NORMAL);
			vShader.setOutput( 0, "clipPosition", VariableType.FLOAT4, VariableSemanticType.POSITION );
			vShader.setConstant( 0, "PVWMatrix", 4 );
			vShader.setBaseRegisters([null, [0,1], null, null, null]);
			vShader.setPrograms( ["", vertexShader(lights), "", "", ""] );
			
			var pShader: PixelShader = new PixelShader( "Zest3D.MaterialTexture", 1, 1, numLights+1, 1, false);
			pShader.setInput( 0, "vertexTCoord", VariableType.FLOAT2, VariableSemanticType.TEXCOORD0 );
			pShader.setOutput( 0, "pixelColor", VariableType.FLOAT4, VariableSemanticType.COLOR0 );
			pShader.setSampler( 0, "BaseSampler", SamplerType.TYPE_2D );
			pShader.setTextureUnits([null, [1], null, null, null]);
			pShader.setPrograms(["", fragmentShader(lights), "", "", ""]);
			
			if(numLights>0){
				pShader.setConstant(0, "zero", 1);
				var registers:Array = [0];
				for(var i:int=0; i<numLights; i+=1){
					var light:Light = lights[i];
					pShader.setConstant(i+1, "light"+i, 2);
					registers.push(i+1);
				}
				pShader.setBaseRegisters([null, registers, null, null, null]);
			}
			
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

		override public function dispose():void {
			super.dispose();
		}

		public function createInstance( texture: Texture2D, light:Light ):VisualEffectInstance {
			
			var lights:Vector.<Light> = new Vector.<Light>();
			lights.push( light );
			
			compile(lights);
			var instance:VisualEffectInstance = new VisualEffectInstance(this, 0);
			instance.setVertexConstantByHandle( 0, 0, new PVWMatrixConstant());
			instance.setPixelTextureByHandle( 0, 0, texture );
			
			var zeroFloat:ShaderFloat = new ShaderFloat(1);
			//Some Zeros...
			zeroFloat.setRegister( 0, [ 0, 0, 0, 0 ] );
			
			
			instance.setPixelConstantByName(0, "zero", zeroFloat);
			//instance.setPixelConstantByHandle(0, 0, zeroFloat);
			
			var light:Light;
			var i:int;
			var constantOffset: int;
			
			for (i = 0; i < lights.length; i += 1) {
				constantOffset++;
				light = lights[i];
				
				
				var lightFloat:ShaderFloat = new ShaderFloat(2);
				
				lightFloat.setRegister( 0, light.dVector.toTuple() );
				lightFloat.setRegister( 1, light.diffuse.toArray() );
				
				instance.setPixelConstantByName(0, "light"+i, lightFloat);
				
			}
			
			return instance;
		}

		public static function createUniqueInstance( texture: Texture2D, light:Light ):VisualEffectInstance {
			var effect:DiffuseLightTextureEffect = new DiffuseLightTextureEffect();
			
			return effect.createInstance( texture, light );
		}

	}

}