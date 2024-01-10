// DecompilerFi decompiler from Assembly-CSharp-firstpass.dll class: ControlFreak2.BuiltInGamepadProfileBankOSX
// SourcesPostProcessor 
namespace ControlFreak2
{
	public class BuiltInGamepadProfileBankOSX : BuiltInGamepadProfileBank
	{
		public BuiltInGamepadProfileBankOSX()
		{
			profiles = new GamepadProfile[4]
			{
				new GamepadProfile("MOGA", "Unknown Moga 2 HID", GamepadProfile.ProfileMode.Normal, null, null, GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(4,  true, 5, vertPositiveUp: false), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(2), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Key(6), GamepadProfile.KeySource.Key(7), GamepadProfile.KeySource.Key(4), GamepadProfile.KeySource.Key(5), GamepadProfile.KeySource.PlusAxis(6), GamepadProfile.KeySource.PlusAxis(7), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9)),
				new GamepadProfile("MOGA", "Moga", GamepadProfile.ProfileMode.Regex, null, null, GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(4,  true, 5, vertPositiveUp: false), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(2), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Key(6), GamepadProfile.KeySource.Key(7), GamepadProfile.KeySource.Key(4), GamepadProfile.KeySource.Key(5), GamepadProfile.KeySource.PlusAxis(6), GamepadProfile.KeySource.PlusAxis(7), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9)),
				new GamepadProfile("DualShock 3", "Sony PLAYSTATION(R)3 Controller", GamepadProfile.ProfileMode.Normal, null, null, GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Dpad(4, 5, 6, 7), GamepadProfile.KeySource.Key(14), GamepadProfile.KeySource.Key(13), GamepadProfile.KeySource.Key(12), GamepadProfile.KeySource.Key(15), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Key(10), GamepadProfile.KeySource.Key(11), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(2)),
				new GamepadProfile("PSX", "Twin USB Joystick", GamepadProfile.ProfileMode.Regex, null, null, GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(1,  true, 0, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(8,  true, 9, vertPositiveUp: false), GamepadProfile.KeySource.Key(2), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9), GamepadProfile.KeySource.Key(6), GamepadProfile.KeySource.Key(7), GamepadProfile.KeySource.Key(4), GamepadProfile.KeySource.Key(5), GamepadProfile.KeySource.Key(10), GamepadProfile.KeySource.Key(11))
			};
		}
	}
}
