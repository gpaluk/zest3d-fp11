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
	import zest3d.shaders.enum.CompareMode;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class DepthState implements IDisposable 
	{
		
		public var enabled: Boolean;
		public var writable: Boolean;
		public var compare: CompareMode;
		
		public function DepthState() 
		{
			enabled = true;
			writable = true;
			compare = CompareMode.LEQUAL;
		}
		
		public function dispose(): void
		{
			compare = null;
		}
		
	}

}