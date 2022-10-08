# This script generates a minimal xfwm theme based on user input.

import os

# Some needed constants.
themerc = """title_full_width=false
title_shadow_active=false
title_shadow_inactive=false
active_text_color=%s
inactive_text_color=%s"""

xpm = '''/* XPM */
static char *bottom_right_inactive[] = {
/* columns rows colors chars-per-pixel */
"%d %d 1 1 ",
"@ c %s",
/* pixels */
%s
};'''

files = ['title-1-active.xpm', 'title-1-inactive.xpm', 'title-2-active.xpm',
'title-2-inactive.xpm', 'title-3-active.xpm', 'title-3-inactive.xpm',
'title-4-active.xpm', 'title-4-inactive.xpm', 'title-5-active.xpm',
'title-5-inactive.xpm', 'title-left-active.xpm', 'title-left-inactive.xpm',
'title-right-active.xpm', 'title-right-inactive.xpm', 'right-active.xpm',
'right-inactive.xpm', 'left-active.xpm', 'left-inactive.xpm',
'bottom-active.xpm', 'bottom-inactive.xpm', 'bottom-left-active.xpm',
'bottom-left-inactive.xpm', 'bottom-right-active.xpm',
'bottom-right-inactive.xpm']

# Collect user input
def getInput():
    print("Please enter a name for the theme:")
    while True:
        name = input()
        if name != "": break
        else: print("Invalid input, try again.")

    print("Please enter a pixel width for the theme:")
    while True:
        width = input()
        try:
            width = int(width)
            break
        except:
            print("Invalid input, try again.")

    print("Please enter an active color for the theme in hex (#000000):")
    while True:
        onColor = input()
        if onColor.startswith("#"): break
        else: print("Invalid input, try again.")

    print("Please enter an inactive color for the theme in hex (#FFFFFF):")
    while True:
        offColor = input()
        if offColor.startswith("#"): break
        else: print("Invalid input, try again.")

    return name, width, onColor, offColor

# Generate the themerc file
def genRC(path, onColor, offColor):
    try:
        open(path, "wt").write(themerc % (onColor, offColor))
    except Exception as e:
        print("Error: Failed to create themerc")
        print(e)

# Generate all border images
def genBorders(path, width, onColor, offColor):
    for file in files:
        try:
            color = onColor if file.find("-active") > 0 else offColor
            pixels = ("\"" + "@" * width + "\"\n") * width
            open(path + file, "wt").write(xpm % (width, width, color, pixels))
        except Exception as e:
            print("Error: Failed to write file " + file)
            print(e)

# Main script function
def main():
    name, width, onColor, offColor = getInput()
    path = os.path.abspath(os.getcwd()) + '/' + name + "/xfwm4/"
    print (path)
    try: os.makedirs(path)
    except: print("Theme exists! Overwriting!")
    genRC(path + "themerc", onColor, offColor)
    genBorders(path, width, onColor, offColor)
    print("Done!")

# Runs the script if being run as a standalone application.
if __name__ == "__main__": main()
