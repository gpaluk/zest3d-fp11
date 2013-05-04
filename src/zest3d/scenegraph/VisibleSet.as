/**
 * Plugin.IO - http://www.plugin.io
 * Copyright (c) 2011-2012
 *
 * Geometric Tools, LLC
 * Copyright (c) 1998-2012
 * 
 * Distributed under the Boost Software License, Version 1.0.
 * http://www.boost.org/LICENSE_1_0.txt
 */
package zest3d.scenegraph 
{
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.core.system.Assert;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class VisibleSet implements IDisposable
	{
		
		private var _numVisible: int;
		private var _visible: Vector.<Spatial>;
		
		public function VisibleSet() 
		{
			_visible = new Vector.<Spatial>();
			_numVisible = 0;
		}
		
		public function dispose(): void
		{
			for each( var d:IDisposable in _visible )
			{
				d.dispose();
			}
			_visible = null;
		}
		
		
		[Inline]
		public final function get numVisible(): int
		{
			return _numVisible;
		}
		
		[Inline]
		public final function getAllVisible(): Vector.<Spatial>
		{
			return _visible;
		}
		
		[Inline]
		public final function getVisibleAt( index: int ): Spatial
		{
			Assert.isTrue( 0 <= index && index < _numVisible, "Invalid index to GetVisible." );
			return _visible[ index ];
		}
		
		public function insert( visible: Spatial ): void
		{
			_visible.push( visible )
			++_numVisible;
		}
		
		[inline]
		public final function clear(): void
		{
			/*
			for each( var d:IDisposable in _visible )
			{
				d.dispose();
			}
			*/
			_visible.length = 0;
			_numVisible = 0;
		}
		
	}

}