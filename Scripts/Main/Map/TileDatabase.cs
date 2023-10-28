using Godot;

namespace LogicGame;

public class TileDatabase : InMemoryDatabase<Tile>
{
  public enum Layer { BACKGROUND, FOREGROUND }
  public enum TileType { STONE, STONE_GROUND, WATER }

  public TileDatabase()
  {
    AddTile(TileType.STONE, Layer.BACKGROUND);
    AddTile(TileType.WATER, Layer.BACKGROUND);
    AddTile(TileType.STONE_GROUND, Layer.FOREGROUND);
  }

  private void AddTile(TileType tileType, Layer layer)
    => AddEntry(tileType, new((int)tileType, (int)layer));

}