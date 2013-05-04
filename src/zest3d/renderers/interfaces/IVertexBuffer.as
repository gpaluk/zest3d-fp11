package zest3d.renderers.interfaces 
{
	import flash.utils.ByteArray;
	import zest3d.renderers.Renderer;
	import zest3d.resources.enum.BufferLockingType;
	import zest3d.resources.VertexBuffer;
	
	/**
	 * ...
	 * @author Gary Paluk
	 */
	public interface IVertexBuffer 
	{
		function enable( renderer: Renderer, vertexSize: uint, streamIndex: uint, offset: uint ): void;
		function disable( renderer: Renderer, streamIndex: uint ): void;
		function lock( mode: BufferLockingType ): void;
		function unlock(): void;
	}
	
}