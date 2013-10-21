package zest3d.applications 
{
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.utils.getTimer;
	import io.plugin.core.graphics.Color;
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.AVector;
	import zest3d.geometry.SkyboxGeometry;
	import zest3d.scenegraph.Culler;
	import zest3d.scenegraph.Node;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Zest3DApplication extends AGALApplication implements IDisposable 
	{
		
		private var _scene: Node;
		private var _skybox:SkyboxGeometry;
		
		protected var _culler: Culler;
		
		public function Zest3DApplication( ) 
		{
			super( new Color( 0.3, 0.6, 0.9, 1 ) );
			stage.scaleMode = StageScaleMode.NO_SCALE;
			stage.align = StageAlign.TOP_LEFT;
		}
		
		override public function onInitialize(): Boolean 
		{
			if ( !super.onInitialize() )
			{
				return false;
			}
			
			_camera.setFrustumFOV( 60, aspectRatio, 0.01, 1000 );
			var camPosition: APoint = new APoint( 0, 0, 5 );
			var camDVector: AVector = AVector.UNIT_Z;
			var camUVector: AVector = AVector.UNIT_Y_NEGATIVE;
			var camRVector: AVector = camDVector.crossProduct( camUVector );
			
			_camera.setFrame( camPosition, camDVector, camUVector, camRVector );
			
			_scene = new Node();
			
			_culler = new Culler( _camera );
			_culler.computeVisibleSet( _scene );
			
			initializeCameraMotion( 0.1, 0.01 );
			initializeObjectMotion( _scene );
			
			initialize();
			return true;
		}
		
		override public function onIdle():void 
		{
			measureTime();
			
			var appTime: Number = getTimer();
			update( appTime );
			
			if ( moveCamera() || moveObject() )
			{
				_scene.update( appTime );
				_culler.computeVisibleSet( _scene );
			}
			
			draw( appTime );
			updateFrameCount();
		}
		
		private var _numVisibleObjects:int = 0;
		public function get numVisibleObjects():int
		{
			return _numVisibleObjects;
		}
		
		protected function update( appTime: Number ): void
		{
			// hook
		}
		
		protected function draw( appTime: Number ): void
		{
			if ( _renderer.preDraw() )
			{
				_renderer.clearBuffers();
				if( _skybox )
				{
					_renderer.drawVisual( _skybox );
				}
				_renderer.drawVisibleSet( _culler.visibleSet );
				
				_numVisibleObjects = _culler.visibleSet.numVisible;
				_renderer.postDraw();
			}
		}
		
		public function initialize(): void
		{
			// hook
		}
		
		override public function dispose(): void 
		{
			super.dispose();
		}
		
		public function get scene():Node 
		{
			return _scene;
		}
		
		public function get skybox():SkyboxGeometry
		{
			return _skybox;
		}
		
		public function set skybox( skybox:SkyboxGeometry ):void
		{
			_skybox = skybox;
			if ( _skybox )
			{
				_skybox.scaleUniform = 400;
				_skybox.camera = _renderer.camera;
				_skybox.update();
			}
		}	
	}
}