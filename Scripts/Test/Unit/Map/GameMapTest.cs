namespace UnitTests;
using SGT;
using Godot;
using LogicGame;

public class GameMapTest : SimpleTestClass
{
  const string SAVE_FOLDER_PATH = "TestFolder";
  const string TEST_FILE_PATH = SAVE_FOLDER_PATH + "/testFile.json";

  [SimpleBeforeAll]
  public void BeforeAll()
  {
    DirAccess.MakeDirAbsolute(SAVE_FOLDER_PATH);
  }

  [SimpleAfterEach]
  public void AfterEach()
  {
    DirAccess.RemoveAbsolute(TEST_FILE_PATH);
  }

  [SimpleAfterAll]
  public void AfterAll()
  {
    DirAccess.RemoveAbsolute(SAVE_FOLDER_PATH);
  }

  [SimpleTestMethod]
  public void Serialization_shouldCreateValidObject_whenSerialized()
  {
    // Given
    GameMap gameMap = new(new Vector2I(1, 1));

    // When
    string jsonString = gameMap.ToJsonString();
    GameMap gameMapFromJson = new GameMap().FromJsonString<GameMap>(jsonString);

    // Then
    Assertions.AssertEqual(gameMap.ToJsonString(), gameMapFromJson.ToJsonString());
  }


  [SimpleTestMethod]
  public void saveAndLoad_shouldSaveAndLoadMap_whenCalled()
  {
    // Given
    GameMap gameMap = new(new Vector2I(1, 1));
    gameMap.SetTile(new Vector2I(0, 0), new());

    // When
    gameMap.SaveMap(TEST_FILE_PATH);
    GameMap loadedMap = GameMap.LoadMap(TEST_FILE_PATH);

    // Then
    Assertions.AssertEqual(gameMap.ToJsonString(), loadedMap.ToJsonString());
  }
}