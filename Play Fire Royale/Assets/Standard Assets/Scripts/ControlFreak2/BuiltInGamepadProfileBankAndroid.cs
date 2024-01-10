// DecompilerFi decompiler from Assembly-CSharp-firstpass.dll class: ControlFreak2.BuiltInGamepadProfileBankAndroid
// SourcesPostProcessor 
namespace ControlFreak2
{
	public class BuiltInGamepadProfileBankAndroid : BuiltInGamepadProfileBank
	{
		public BuiltInGamepadProfileBankAndroid()
		{
			genericProfile = new GamepadProfile.GenericProfile(GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(4,  true, 5, vertPositiveUp: false), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(2), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Key(11), GamepadProfile.KeySource.Key(10), GamepadProfile.KeySource.Key(4), GamepadProfile.KeySource.Key(5), GamepadProfile.KeySource.KeyAndPlusAxis(6, 6), GamepadProfile.KeySource.KeyAndPlusAxis(7, 7), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9));
			profiles = new GamepadProfile[6]
			{
				new GamepadProfile("8Bitdo FC30 PRO", "8Bitdo", GamepadProfile.ProfileMode.Normal, null, null, GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(4,  true, 5, vertPositiveUp: false), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(2), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Key(11), GamepadProfile.KeySource.Key(10), GamepadProfile.KeySource.Key(4), GamepadProfile.KeySource.Key(5), GamepadProfile.KeySource.Key(6), GamepadProfile.KeySource.Key(7), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9)),
				new GamepadProfile("MOGA", "Broadcom Bluetooth HID", GamepadProfile.ProfileMode.Normal, null, null, GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(4,  true, 5, vertPositiveUp: false), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(2), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Empty(), GamepadProfile.KeySource.Key(10), GamepadProfile.KeySource.Key(4), GamepadProfile.KeySource.Key(5), GamepadProfile.KeySource.Empty(), GamepadProfile.KeySource.Empty(), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9)),
				new GamepadProfile("XBOX 360", "Microsoft X-Box 360 pad", GamepadProfile.ProfileMode.Normal, null, null, GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(4,  true, 5, vertPositiveUp: false), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(2), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Empty(), GamepadProfile.KeySource.Key(10), GamepadProfile.KeySource.Key(4), GamepadProfile.KeySource.Key(5), GamepadProfile.KeySource.PlusAxis(6), GamepadProfile.KeySource.PlusAxis(7), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9)),
				new GamepadProfile("XBOX 360", "(X-Box)|(Xbox)", GamepadProfile.ProfileMode.Regex, null, null, GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(4,  true, 5, vertPositiveUp: false), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(2), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Empty(), GamepadProfile.KeySource.Key(10), GamepadProfile.KeySource.Key(4), GamepadProfile.KeySource.Key(5), GamepadProfile.KeySource.PlusAxis(6), GamepadProfile.KeySource.PlusAxis(7), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9)),
				new GamepadProfile("DualShock3", "Sony PLAYSTATION(R)3 Controller", GamepadProfile.ProfileMode.Normal, null, null, GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(2,  true, 3, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(4,  true, 5, vertPositiveUp: false), GamepadProfile.KeySource.Key(0), GamepadProfile.KeySource.Key(1), GamepadProfile.KeySource.Key(2), GamepadProfile.KeySource.Key(3), GamepadProfile.KeySource.Key(11), GamepadProfile.KeySource.Key(10), GamepadProfile.KeySource.Key(4), GamepadProfile.KeySource.Key(5), GamepadProfile.KeySource.PlusAxis(6), GamepadProfile.KeySource.PlusAxis(7), GamepadProfile.KeySource.Key(8), GamepadProfile.KeySource.Key(9)),
				new GamepadProfile("PSX", "Twin USB Joystick", GamepadProfile.ProfileMode.Normal, null, null, GamepadProfile.JoystickSource.Axes(0,  true, 1, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(3,  true, 2, vertPositiveUp: false), GamepadProfile.JoystickSource.Axes(4,  true, 5, vertPositiveUp: false), GamepadProfile.KeySource.Key(17), GamepadProfile.KeySource.Key(16), GamepadProfile.KeySource.Key(18), GamepadProfile.KeySource.Key(15), GamepadProfile.KeySource.Key(-1), GamepadProfile.KeySource.Key(-1), GamepadProfile.KeySource.Key(-1), GamepadProfile.KeySource.Key(-1), GamepadProfile.KeySource.Key(19), GamepadProfile.KeySource.Key(-1), GamepadProfile.KeySource.Key(-1), GamepadProfile.KeySource.Key(-1))
			};
		}
	}
}