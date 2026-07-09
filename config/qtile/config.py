import os
from collections.abc import Callable

import libqtile.resources
from libqtile import bar, layout, qtile, widget
from libqtile.config import Click, Drag, Group, Key, Match, Output, Screen
from libqtile.lazy import lazy
from libqtile.utils import guess_terminal

#to set our current wallpaper, we need Path()
from pathlib import Path

mod = "mod4"
terminal = guess_terminal()
browser = "zen"
files = 'nautilus'
launcher = "rofi -show drun"

keys = [
    Key([mod], "h", lazy.layout.left(), desc="Move focus to left"),
    Key([mod], "l", lazy.layout.right(), desc="Move focus to right"),
    Key([mod], "j", lazy.layout.down(), desc="Move focus down"),
    Key([mod], "k", lazy.layout.up(), desc="Move focus up"),
    Key([mod], "space", lazy.layout.next(), desc="Move window focus to other window"),
    Key([mod, "shift"], "h", lazy.layout.shuffle_left(), desc="Move window to the left"),
    Key([mod, "shift"], "l", lazy.layout.shuffle_right(), desc="Move window to the right"),
    Key([mod, "shift"], "j", lazy.layout.shuffle_down(), desc="Move window down"),
    Key([mod, "shift"], "k", lazy.layout.shuffle_up(), desc="Move window up"),
    Key([mod, "control"], "h", lazy.layout.grow_left(), desc="Grow window to the left"),
    Key([mod, "control"], "l", lazy.layout.grow_right(), desc="Grow window to the right"),
    Key([mod, "control"], "j", lazy.layout.grow_down(), desc="Grow window down"),
    Key([mod, "control"], "k", lazy.layout.grow_up(), desc="Grow window up"),
    Key([mod], "n", lazy.layout.normalize(), desc="Reset all window sizes"),
    Key(
        [mod],
        "f",
        lazy.window.toggle_fullscreen(),
        desc="Toggle fullscreen on the focused window",
    ),
    Key([mod], "t", lazy.window.toggle_floating(), desc="Toggle floating on the focused window"),
    Key([mod, "shift"], "q", lazy.spawn("emacsclient -c -a'emacs'"), desc="Spawn Qmacs"),
    Key([mod], "b", lazy.spawn(browser), desc="Open browser"),
    Key([mod], "e", lazy.spawn(files), desc="Open file manager"),
    Key([mod], "Return", lazy.spawn(terminal), desc="Launch terminal"),
    Key([mod], "r", lazy.spawncmd(), desc="Spawn a command using a prompt widget"),
    Key(["mod1"], "space", lazy.spawn(launcher)),
    Key([mod], "Tab", lazy.next_layout(), desc="Toggle between layouts"),
    Key([mod], "q", lazy.window.kill(), desc="Kill focused window"),
    Key([mod, "shift"], "r", lazy.reload_config(), desc="Reload the config"),
    Key([mod], "m", lazy.shutdown(), desc="Shutdown Qtile"),
    Key([],"XF86AudioRaiseVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1+ l 1.0")),
    Key([],"XF86AudioLowerVolume", lazy.spawn("wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.1-")),
    Key([],"XF86AudioMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle")),
    Key([],"XF86AudioMicMute", lazy.spawn("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle")),
    
    Key([],"XF86AudioPlay", lazy.spawn("playerctl play-pause")),
    Key([],"XF86AudioStop", lazy.spawn("playerctl stop")),
    Key([],"XF86AudioPrev", lazy.spawn("playerctl previous")),
    Key([],"XF86AudioNext", lazy.spawn("playerctl next")),
    
    Key([],"XF86MonBrightnessUp", lazy.spawn("brightnessctl --class=backlight set +10%")),
    Key([],"XF86MonBrightnessDown", lazy.spawn("brightnessctl --class=backlight set 10%-")),
]

for vt in range(1, 8):
    keys.append(
        Key(
            ["control", "mod1"],
            f"f{vt}",
            lazy.core.change_vt(vt).when(func=lambda: qtile.core.name == "wayland"),
            desc=f"Switch to VT{vt}",
        )
    )

groups = [Group(i) for i in "123456789"]

for i in groups:
    keys.extend(
        [
            # mod + group number = switch to group
            Key(
                [mod],
                i.name,
                lazy.group[i.name].toscreen(),
                desc=f"Switch to group {i.name}",
            ),
            # mod + shift + group number = switch to & move focused window to group
            Key(
                [mod, "mod1"],
                i.name,
                lazy.window.togroup(i.name, switch_group=True),
                desc=f"Switch to & move focused window to group {i.name}",
            ),
            # Or, use below if you prefer not to switch to that group.
            # # mod + shift + group number = move focused window to group
            # Key([mod, "shift"], i.name, lazy.window.togroup(i.name),
            #     desc="move focused window to group {}".format(i.name)),
        ]
    )

layouts = [
    layout.Columns(border_focus_stack=["#d75f5f", "#8f3d3d"], border_width=4),
    layout.Max(),
    # Try more layouts by unleashing below layouts.
    layout.Stack(num_stacks=2),
    # layout.Bsp(),
    layout.Matrix(),
    layout.MonadTall(),
    layout.MonadWide(),
    # layout.RatioTile(),
    layout.Tile(),
    layout.TreeTab(),
    # layout.VerticalTile(),
    layout.Zoomy(),
]

colors = {
    "bg":"#24283b",
    "fg": "#bb9af7",
    "fg1": "#73daca",
    "accent": "#7aa2f7",
    "urgent": "#f7768e"
}

widget_defaults = dict(
    font="Iosevka Nerd Font",
    fontsize=18,
    padding=5,
    foreground=colors["fg"],
)
extension_defaults = widget_defaults.copy()

wall_path = Path.home().joinpath("nixos-dots/config/.wallpaper").read_text().strip()

def make_bar():
    return bar.Bar(
            [
                widget.BatteryIcon(padding=2),
                widget.Battery(),

                widget.Spacer(),

                widget.GroupBox(
                    highlight_method="line",
                    active=colors["fg"],
                    inactive=colors["fg1"],
                    highlight_color = [colors["bg"],colors["bg"]],
                    this_current_screen_border = colors["urgent"],
                ),
                widget.Prompt(),
                widget.CurrentLayout(),

                widget.Spacer(),

                widget.StatusNotifier(),
                widget.PulseVolume(
                    emoji = True,
                    emoji_list = ['🔇', '🔈', '🔉', '🔊'],
                ),
                widget.Clock(format="%m.%d.%Y %a %I:%M %p"),
                widget.Backlight(
                    foreground=colors["accent"],
                ),
            ],
            24,
            background=colors["bg"],
    )

screens = [
    Screen(
        bottom=make_bar(),
        background="#000000",
        wallpaper=wall_path,
        wallpaper_mode="fill",
        # You can uncomment this variable if you see that on X11 floating resize/moving is laggy
        # By default we handle these events delayed to already improve performance, however your system might still be struggling
        # This variable is set to None (no cap) by default, but you can set it to 60 to indicate that you limit it to 60 events per second
        # x11_drag_polling_rate = 60,
    ),

    Screen(
        bottom=make_bar(),
        background="#000000",
        wallpaper=wall_path,
        wallpaper_mode="fill",
    ),
]

mouse = [
    Drag([mod], "Button1", lazy.window.set_position_floating(), start=lazy.window.get_position()),
    Drag([mod], "Button3", lazy.window.set_size_floating(), start=lazy.window.get_size()),
    Click([mod], "Button2", lazy.window.bring_to_front()),
]

dgroups_key_binder = None
dgroups_app_rules = []  # type: list
follow_mouse_focus = True
bring_front_click = False
floats_kept_above = True
cursor_warp = False
floating_layout = layout.Floating(
    float_rules=[
        # Run the utility of `xprop` to see the wm class and name of an X client.
        *layout.Floating.default_float_rules,
        Match(wm_class="confirmreset"),  # gitk
        Match(wm_class="makebranch"),  # gitk
        Match(wm_class="maketag"),  # gitk
        Match(wm_class="ssh-askpass"),  # ssh-askpass
        Match(title="branchdialog"),  # gitk
        Match(title="pinentry"),  # GPG key password entry
    ]
)
auto_fullscreen = True
focus_on_window_activation = "smart"
focus_previous_on_window_remove = False
reconfigure_screens = True

# If things like steam games want to auto-minimize themselves when losing
# focus, should we respect this or not?
auto_minimize = True

wl_input_rules = None

wl_xcursor_theme = None
wl_xcursor_size = 24

idle_timers = []  # type: list
idle_inhibitors = []  # type: list

wmname = "LG3D"
