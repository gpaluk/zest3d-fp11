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
package zest3d.renderers.interfaces 
{
	import zest3d.renderers.Renderer;
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public interface IVertexFormat 
	{
		function enable( renderer: Renderer ): void;
		function disable( renderer: Renderer ): void;
	}

}