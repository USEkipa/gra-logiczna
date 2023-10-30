using System;

namespace LogicGame;

public partial class WrongValueException : Exception
{
  public WrongValueException(string message)
       : base(message)
  {
  }
}
