using Godot;
using System;

public partial class options_menu : Control
{
	private CheckButton toggleFullScreen;
	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		toggleFullScreen = GetNode<CheckButton>("MarginContainer/VBoxContainer/TabContainer/Graphics/GraphicsOptions/FullScreen/toggleFullScreen");
		toggleFullScreen.ButtonPressed = globals.isFullScreen;
	}
	
	private void _on_back_pressed()
	{
		GetTree().ChangeSceneToFile("res://Scenes/UI/Menu/Main/menu.tscn");
	}

	private void _on_toggle_full_screen_pressed()
	{
		if (toggleFullScreen.ButtonPressed)
		{
			globals.isFullScreen = true;
			GetTree().Root.GetWindow().Mode = Window.ModeEnum.Fullscreen;
		}
		else
		{
			globals.isFullScreen = false;
			GetTree().Root.GetWindow().Mode = Window.ModeEnum.Windowed;
		}
	}
}






