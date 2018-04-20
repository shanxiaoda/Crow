package game.base
{
	public interface IGameInit {
		function initDialog():void;
		function initSession():void;
		function initAction():void;
		function initCommand():void;
		function initDoublePanel():void;
		function initScence():void;
		function initGameLoader():void;
	}
}