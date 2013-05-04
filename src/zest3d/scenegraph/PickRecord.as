package zest3d.scenegraph 
{
	import io.plugin.core.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class PickRecord
	{
		
		public var intersected: Spatial;
		public var t: Number = 0;
		public var triangle: int;
		public var bary: Array = [];
		
		public function PickRecord() 
		{
			
		}
		
	}

}