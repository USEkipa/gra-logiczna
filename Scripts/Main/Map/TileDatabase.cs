using Godot;

namespace LogicGame;

public class TileDatabase : InMemoryDatabase<Tile>
{
  public enum TileType { TEMP_TILE_NAME }

  public TileDatabase()
  {
    AddTile(TileType.TEMP_TILE_NAME, Colors.SkyBlue);
  }

  private void AddTile(TileType tileType, Color color)
    => AddEntry(tileType, new((int)tileType, color));

}