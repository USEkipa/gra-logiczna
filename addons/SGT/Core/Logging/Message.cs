using System;

namespace SGT;

[Serializable]
public class Message
{
  public enum Severity { INFO, PASSED, FAILED, TIMEOUT }
  public enum SuiteType { STAY, START_SUITE, END_SUITE }
  public enum SuiteKind { INFO, METHOD, CLASS, NAMESPACE, ALL }

  public Severity severity;
  public SuiteType suiteType;
  public SuiteKind suiteKind;
  public string text;
  public long timeTook;
  public string details;

  private Message() { }

  public Message(
    Severity severity,
    SuiteType suiteType,
    SuiteKind suiteKind,
    string text,
    long timeTook = -1,
    string details = "")
  {
    this.severity = severity;
    this.suiteType = suiteType;
    this.suiteKind = suiteKind;
    this.text = text;
    this.timeTook = timeTook;
    this.details = details;
  }

  public string GetDetails(bool addStartNewLine = false)
  {
    string output = "";
    if (string.IsNullOrEmpty(details))
      return output;
    if (addStartNewLine)
      output += '\n';

    string[] splitDetails = details.Split('\n', '\r', StringSplitOptions.RemoveEmptyEntries);
    foreach (var detail in splitDetails)
    {
      output += $"{detail}\n";
    }

    if (output.Length > 0)
      output = output[..^1];

    return output;
  }

  public string GetInfo() => text;
  public string GetTimeTook() => timeTook > -1 ? $"<{timeTook} ms>" : "";
}