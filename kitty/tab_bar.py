from kitty.fast_data_types import Screen
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb

def draw_tab(
    draw_data: DrawData, screen: Screen, tab: TabBarData,
    before: int, max_title_length: int, index: int, is_last: bool,
    extra_data: ExtraData
) -> int:
    # Proper Catppuccin Mocha Blue conversion
    BLUE = as_rgb(0x89b4fa)
    TEXT = as_rgb(0xcdd6f4)
    SUBTEXT = as_rgb(0x6c7086)

    # Force background to match window (no pink)
    screen.cursor.bg = 0

    if tab.is_active:
        # Draw the Blue vertical bar
        screen.cursor.fg = BLUE
        screen.draw("┃ ")
        # Active text
        screen.cursor.fg = TEXT
        screen.cursor.bold = True
    else:
        # Inactive tab (no accent)
        screen.cursor.fg = SUBTEXT
        screen.draw("  ")
        screen.cursor.bold = False

    # Draw title once
    screen.draw(f"{tab.title}")
    screen.draw("  ")

    return screen.cursor.x

