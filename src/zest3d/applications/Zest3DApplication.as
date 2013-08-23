package zest3d.applications 
{
	import flash.utils.getTimer;
	import io.plugin.core.graphics.Color;
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.math.algebra.APoint;
	import io.plugin.math.algebra.AVector;
	import zest3d.scenegraph.Culler;
	import zest3d.scenegraph.Node;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Zest3DApplication extends AGALApplication implements IDisposable 
	{
		
		private var _scene: Node;
		protected var _culler: Culler;
		
		public function Zest3DApplication( ) 
		{
			super( new Color( 0.3, 0.6, 0.9, 1 ) );
		}
		
		override public function onInitialize(): Boolean 
		{
			if ( !super.onInitialize() )
			{
				return false;
			}
			
			_camera.setFrustumFOV( 60, aspectRatio, 0.01, 1000 );
			var camPosition: APoint = new APoint( 0, 0, -5 );
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
		
		protected function update( appTime: Number ): void
		{
			// hook
		}
		
		protected function draw( appTime: Number ): void
		{
			if ( _renderer.preDraw() )
			{
				_renderer.clearBuffers();
				_renderer.drawVisibleSet( _culler.visibleSet );
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
		
		
	}

}