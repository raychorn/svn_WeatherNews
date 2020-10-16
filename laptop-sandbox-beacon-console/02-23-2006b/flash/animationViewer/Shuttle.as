import mx.utils.Delegate;

class Shuttle
extends MovieClip
{

	private var mcPrevious:MovieClip;
	private var mcPlay:MovieClip;
	private var mcStop:MovieClip;
	private var mcPause:MovieClip;
	private var mcNext:MovieClip;
	private var mcHandle:MovieClip;
	private var mcSpeed:MovieClip;
	private var _listener;
	private var _previous;
	private var _play;
	private var _stop;
	private var _pause;
	private var _next;
	private var _speed;
	private var _speedValue;
	
	function Shuttle()
	{
		initialize();
	}
	/*
		mcPrevious.onRollOver = over;
		mcPrevious.onRollOut = out;
		mcPrevious.onPress = down;
		mcPrevious.onRelease = out;
	*/
	private function initialize( Void ):Void
	{
		initButton( mcPrevious, previous );
		initButton( mcPlay, play );
		initButton( mcStop, stop );
		initButton( mcPause, pause );
		initButton( mcNext, next );
		
		mcSpeed.x = mcSpeed._x; mcSpeed.y = mcSpeed._y;
		mcSpeed.onRelease = Delegate.create( this, speed );
		
		if ( _listener == '' ) _listener = _parent;
		else
		{
			var hops, max;
			hops = _listener.split( '.' );
			max = hops.length - 1;
			_listener = _parent
			for ( var i = 0; i < max; i++ )
			{
				_listener = _listener[ hops[ i ] ]
			}
			_listener = _listener[ hops.pop() ];
		}
	}
	
	private function initButton( target, func ):Void
	{
		target.onRelease = Delegate.create( this, func );
		target.onRollOver = over;
		target.onRollOut = out;
		target.onPress = down;
	}
	
	private function over( Void ):Void
	{
		this[ 'mcFace' ]._x = -1;
		this[ 'mcFace' ]._y = -1;
	}
	
	private function out( Void ):Void
	{
		this[ 'mcFace' ]._x = 0;
		this[ 'mcFace' ]._y = 0;
	}
	
	private function down( Void ):Void
	{
		this[ 'mcFace' ]._x = 1;
		this[ 'mcFace' ]._y = 1;
	}
	
	private function previous( Void ):Void
	{
		_listener[ _previous ]();
		out.apply( mcPrevious );
	}
	
	private function play( Void ):Void
	{
		_listener[ _play ]();
		out.apply( mcPlay );
	}
	
	private function stop( Void ):Void
	{
		_listener[ _stop ]();
		out.apply( mcStop );
	}
	
	private function pause( Void ):Void
	{
		_listener[ _pause ]();
		out.apply( mcPause );
	}
	
	private function next( Void ):Void
	{
		_listener[ _next ]();
		out.apply( mcNext );
	}
	
	private function speed( Void ):Void
	{
		if ( _speedValue > 1 && mcHandle._x > _xmouse )
		{
			_speedValue--;
			mcHandle._x -= 10;
		}
		else if ( _speedValue < 6  && mcHandle._x < _xmouse )
		{
			_speedValue++;
			mcHandle._x += 10;
		}
		_listener[ _speed ]( _speedValue );
	}
		
}

