package zest3d.resources 
{
	//import br.com.stimuli.loading.BulkProgressEvent;
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import io.plugin.core.interfaces.IDisposable;
	import io.plugin.core.system.Assert;
	import io.plugin.math.base.BitHacks;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferUsageType;
	import zest3d.resources.enum.TextureFormat;
	import zest3d.resources.enum.TextureType;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public class Texture2D extends Texture implements IDisposable 
	{
		
		public function Texture2D( format: TextureFormat, dimension0: int, dimension1: int, numLevels: int, usage: BufferUsageType = null ) 
		{
			usage ||= BufferUsageType.TEXTURE;
			super( format, TextureType.TEXTURE_2D, usage, numLevels );
			
			Assert.isTrue( dimension0 > 0, "Dimension0 must be positive." );
			Assert.isTrue( dimension1 > 0, "Dimension1 must be positive." );
			
			_dimension[ 0 ][ 0 ] = dimension0;
			_dimension[ 1 ][ 0 ] = dimension1;
			
			var logDim0: uint = BitHacks.logOfPowerTwoUint( uint( dimension0 ) );
			var logDim1: uint = BitHacks.logOfPowerTwoUint( uint( dimension1 ) );
			
			var maxLevels: int = int( ( logDim0 > - logDim1 ? logDim0 + 1 : logDim1 + 1 ) );
			
			if ( numLevels == 0)
			{
				_numLevels = maxLevels;
			}
			else if ( numLevels <= maxLevels )
			{
				_numLevels = numLevels;
			}
			else
			{
				throw new Error( "Invalid number of levels." );
			}
			
			//computeNumLevelBytes();
			_data = new ByteArray();
			_data.endian = Endian.LITTLE_ENDIAN;
			_data.length = _numTotalBytes;
		}
		
		
		override public function dispose():void 
		{
			Renderer.unbindAllTexture2D( this );
			super.dispose();
		}
		
		[Inline]
		public final function get width(): int
		{
			return getDimension( 0, 0 );
		}
		
		[Inline]
		public final function get height(): int
		{
			return getDimension( 1, 0 );
		}
		
		public function generateMipmaps(): void
		{
			throw new Error( "generateMipmaps not yet implemented" );
		}
		
		public function get hasMipmaps(): Boolean
		{
			return false; //TODO implement mipmap checks
		}
		/*
		public function getDataAt( level: int ): ByteArray
		{
			
		}
		
		protected function computeNumLevelBytes(): void
		{
			trace( "computeNumLevelBytes not yet implemented!" );
		}
		
		
		override protected function onTextureLoadComplete(e:BulkProgressEvent):void 
		{
			super.onTextureLoadComplete(e);
			Renderer.updateAllTexture2D( this, 0 ); //TODO this is currently hardcoded until we load via mipmaps levels
		}
		*/
	}

}