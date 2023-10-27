using Godot;
using System;

public partial class options_menu : Control
{
	private CheckButton toggleFullScreen;
	private CheckButton toggleMusic;
	private HSlider volumeSlider;

	public override void _Ready()
	{
		toggleFullScreen = GetNode<CheckButton>("PanelContainer/VBoxContainer/FullScreen/toggleFullScreen");
		toggleMusic = GetNode<CheckButton>("PanelContainer/VBoxContainer/Music/toggleMusic");
		volumeSlider = GetNode<HSlider>("PanelContainer/VBoxContainer/Volume/VolumeControls/VolumeSlider");
		toggleFullScreen.ButtonPressed = globals.isFullScreen;
		toggleMusic.ButtonPressed = globals.isMusic;
		volumeSlider.Value = globals.volume;
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

	private void _on_toggle_music_pressed()
	{
		globals.isMusic = toggleMusic.ButtonPressed;
	}
	
	private void _on_h_slider_value_changed(double value)
	{
		globals.volume = (int)volumeSlider.Value;
	}

	private void _on_volume_up_btn_pressed()
	{
		volumeSlider.Value += 1;
	}

	private void _on_volume_down_btn_pressed()
	{
		volumeSlider.Value -= 1;
	}
}
