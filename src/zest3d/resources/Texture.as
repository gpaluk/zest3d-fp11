package zest3d.resources 
{
	import flash.utils.ByteArray;
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
			var texture:TextureBase;
			var format:TextureFormat;
			
			switch( reader.type.value )
			{
				case 0:
				case 1:
						format = TextureFormat.DXT1;
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
			
			// TODO hack because it's not flipping to cube texture
			switch( ATFTextureType.TYPE_CUBE )
			{
				case ATFTextureType.TYPE_2D:
						texture = new Texture2D( format, reader.width, reader.height, reader.numTextures );
					break;
				case ATFTextureType.TYPE_CUBE:
						texture = new TextureCube( format, reader.width, reader.numTextures );
					break;
				default :
						throw new Error( "Invalid ATF type " + reader.type );
			}
			texture.data = reader.data;
			return texture as TextureBase;
		}
	}

}