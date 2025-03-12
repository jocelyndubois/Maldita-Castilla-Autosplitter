state("maldita_castilla_arcade_cabinet")
{
    int  map       : 0x92358, 0x0;
    int  lives     : 0x4EBC, 0x0;
    bool canMove   : 0x304B84, 0x8, 0xB4;
    bool menuOpen  : 0x304B8C, 0x0, 0xE8, 0xC, 0xC0;
    bool startGame : 0x305F1C, 0x20, 0x18, 0x24;
}

startup
{
    settings.Add("map-6", true, "Stage 1-1");
    settings.Add("map-7", true, "Stage 1-2");
    settings.Add("map-8", true, "Stage 1-3 (headless)");
    settings.Add("map-9", true, "Stage 1-4");
    settings.Add("map-10", true, "Stage 1-5 (Zarrampla)");
    settings.Add("map-12", true, "Stage 2-1 (autoscroll)");
    settings.Add("map-13", true, "Stage 2-2");
    settings.Add("map-14", true, "Stage 2-3 (windmill)");
    settings.Add("map-15", true, "Stage 2-4 (Nuberu)");
    settings.Add("map-17", true, "Stage Bonus 1");
    settings.Add("map-19", true, "Stage 3-1");
    settings.Add("map-20", true, "Stage 3-2");
    settings.Add("map-21", true, "Stage 3-3 (Manticore)");
    settings.Add("map-22", true, "Stage 3-4");
    settings.Add("map-23", true, "Stage 3-5");
    settings.Add("map-24", true, "Stage 3-6 (Crazy Quixote)");
    settings.Add("map-26", true, "Stage 4-1");
    settings.Add("map-27", true, "Stage 4-2");
    settings.Add("map-28", true, "Stage 4-3 (Tarasca)");
    settings.Add("map-29", true, "Stage 4-4");
    settings.Add("map-30", true, "Stage 4-5");
    settings.Add("map-31", true, "Stage 4-6 (Bu)");
    settings.Add("map-32", true, "Stage 4-7 (Ancient Souls)");
    settings.Add("map-34", true, "Stage Bonus 2");
    settings.Add("map-36", true, "Stage 5-1");
    settings.Add("map-37", true, "Stage 5-2");
    settings.Add("map-38", true, "Stage 5-3");
    settings.Add("map-39", true, "Stage 5-4");
    settings.Add("map-40", true, "Stage 5-5");
    settings.Add("map-41", true, "Stage 5-6");
    settings.Add("map-42", true, "Stage 5-7(Mendoza)");
    settings.Add("map-44", true, "Stage 5-8");
    settings.Add("map-45", true, "Stage 5-9");
}

start
{
    return !old.startGame && current.startGame && current.map == 3;
}

split
{
    if (old.lives != current.lives || current.menuOpen)
    {
        return false;
    }

    if (old.canMove && !current.canMove)
    {
        var key = "map-" + current.map;
        return settings.ContainsKey(key) && settings[key];
    }

    if (old.map < current.map)
    {
        var key = "map-" + old.map;
        return settings.ContainsKey(key) && settings[key]
            || current.map == 46; // End split
    }
}

reset
{
    return old.map > 1 && current.map == 1;
}
