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
package zest3d.controllers 
{
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class KeyInfo 
	{
		public var ctrlTime: Number = 0;
		public var numTimes: int = 0;
		public var times: Array = [];
		public var lastIndex: int = -1;
		public var normTime: Number = 0;
		public var i0: int = 0;
		public var i1: int = 0;
		
		public function KeyInfo() { };
		
		public function set( ctrlTime: Number, numTimes: int, times: Array, lastIndex: int, normTime: Number, i0: int, i1: int ): void
		{
			this.ctrlTime = ctrlTime;
			this.numTimes = numTimes;
			this.times = times;
			this.lastIndex = lastIndex;
			this.normTime = normTime;
			this.i0 = i0;
			this.i1 = i1;
		}
	}

}