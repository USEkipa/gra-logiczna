using System;
using System.Collections.Generic;
using System.IO;
using Godot;
using Newtonsoft.Json;

namespace LogicGame;

public class GameMap : JsonSerializable
{

  [JsonProperty] public readonly Vector2I mapSize = new();
  [JsonProperty] public readonly Tile[] savedTiles = Array.Empty<Tile>();

  public GameMap() { }

  public GameMap(Vector2I mapSize)
  {
    this.mapSize = mapSize;
    savedTiles = new Tile[mapSize.X * mapSize.Y];
  }

  public void SetTile(Vector2I position, Tile tile)
   => savedTiles[position.X * position.Y] = tile;

  public Tile GetTile(Vector2I position)
    => savedTiles[position.X * position.Y];

  public static GameMap LoadMap(string path)
  {
    if (!Godot.FileAccess.FileExists(path))
      throw new FileNotFoundException("File not found: " + path);

    string fileContent = Godot.FileAccess.GetFileAsString(path);
    return new GameMap().FromJsonString<GameMap>(fileContent);
  }

  public void SaveMap(string path)
  {
    using var file = Godot.FileAccess.Open(path, Godot.FileAccess.ModeFlags.Write);
    file.StoreString(ToJsonString());

    Logger.Log("Saved map to file: " + path);
  }
}
