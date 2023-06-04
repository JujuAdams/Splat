if (mouse_check_button(mb_left))
{
    Splat(sprTestA, 0, mouse_x, mouse_y, 1, 1, random(360));
}

if (mouse_check_button(mb_right))
{
    Splat(sprTestB, 0, mouse_x, mouse_y, 1, 1, random(360));
}

if (keyboard_check_pressed(ord("C")))
{
    splatMap.Clear();
}