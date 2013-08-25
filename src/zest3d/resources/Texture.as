package zest3d.resources 
{
	import flash.utils.ByteArray;
	import flash.utils.Endian;
	import plugin.image.atf.ATFReader;
	import plugin.image.atf.enum.ATFTextureType;
	import zest3d.resources.enum.TextureFormat;
	
	/**
	 * ...
	 * @author Gary Paluk - http://www.plugin.io
	 */
	public class Texture 
	{
		
		public static function fromByteArray( data:ByteArray ):TextureBase
		{
			var reader:ATFReader = new ATFReader( data );
			var format:TextureFormat;
			var texture:TextureBase;
			
			switch( reader.format )
			{
				case 0:
						format = TextureFormat.RGB888;
						break;
				case 1:
						format = TextureFormat.RGBA8888;
					break;
				case 2:
				case 3:
						format = TextureFormat.DXT1;
					break;
				case 4:
				case 5:
						format = TextureFormat.DXT5;
						break;
				default:
					throw new Error( "Invalid ATF format " + format );
			}
			
			switch( reader.cubemap )
			{
				case 0x0:
						texture = new Texture2D( format, reader.width, reader.height, reader.count );
					break;
				case 0x1:
						texture = new TextureCube( format, reader.width, reader.count );
					break;
				default :
						throw new Error( "Invalid ATF type " + reader.cubemap );
			}
			texture.data = reader.data;
			return texture as TextureBase;
		}
	}

}