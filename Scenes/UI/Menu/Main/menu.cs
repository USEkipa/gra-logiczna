using Godot;
using System;

public partial class menu : Control
{
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		if (globals.isFullScreen)
			GetTree().Root.GetWindow().Mode = Window.ModeEnum.Fullscreen;
	}
	
	private void _on_quit_pressed()
	{
		GetTree().Quit();
	}
	
	private void _on_options_pressed()
	{
		GetTree().ChangeSceneToFile("res://Scenes/UI/Menu/Options/options_menu.tscn");
	}
}
