using Newtonsoft.Json;

namespace LogicGame;

public class Tile : JsonSerializable
{
  [JsonProperty] public int tileId;
  [JsonProperty] public int layer;

  public Tile(int tileId = default, int layer = default)
  {
    this.tileId = tileId;
    this.layer = layer;
  }

  public Tile() { }

  public override bool Equals(object obj)
  {
    if (obj == null || GetType() != obj.GetType())
      return false;

    Tile other = obj as Tile;

    return (tileId == other.tileId) && (layer == other.layer);
  }

  public override int GetHashCode()
    => System.HashCode.Combine(tileId, layer);

}
