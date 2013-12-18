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
package zest3d.shaders.states 
{
	import io.plugin.core.interfaces.IDisposable;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class OffsetState implements IDisposable 
	{
		
		public var fillEnabled: Boolean;
		public var lineEnabled: Boolean;
		public var pointEnabled: Boolean;
		
		public var scale: Number;
		public var bias: Number;
		
		public function OffsetState() 
		{
			fillEnabled = false;
			lineEnabled = false;
			pointEnabled = false;
			scale = 0;
			bias = 0;
		}
		
		public function dispose(): void
		{
			
		}
		
	}

}