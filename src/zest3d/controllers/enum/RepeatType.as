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
package zest3d.controllers.enum 
{
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class RepeatType 
	{
		
		public static const CLAMP: RepeatType = new RepeatType( "clamp" );
		public static const WRAP: RepeatType = new RepeatType( "wrap" );
		public static const CYCLE: RepeatType = new RepeatType( "cycle" );
		
		protected var _type: String;
		
		public function RepeatType( type: String )
		{
			_type = type;
		}
		
		public function get type():String 
		{
			return _type;
		}
		
	}

}