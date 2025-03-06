state("maldita_castilla_arcade_cabinet")
{
    int map :  "maldita_castilla_arcade_cabinet.exe", 0x00092358, 0x0;
    int lives :  "maldita_castilla_arcade_cabinet.exe", 0x00004EBC, 0x0;
    int canMove :  "maldita_castilla_arcade_cabinet.exe", 0x00304B84, 0x8, 0xB4;
    int menuOpen :  "maldita_castilla_arcade_cabinet.exe", 0x00304B8C, 0x110, 0xC, 0xB4;
    int startGame :  "maldita_castilla_arcade_cabinet.exe", 0x00305F1C, 0x20, 0x18, 0x24;
}

startup
{
    settings.Add("stage_1-1", true, "Stage 1-1");
    settings.Add("stage_1-2", true, "Stage 1-2");
    settings.Add("stage_1-3", true, "Stage 1-3 (headless)");
    settings.Add("stage_1-4", true, "Stage 1-4");
    settings.Add("stage_1-5", true, "Stage 1-5 (Zarrampla)");
    settings.Add("stage_2-1", true, "Stage 2-1 (autoscroll)");
    settings.Add("stage_2-2", true, "Stage 2-2");
    settings.Add("stage_2-3", true, "Stage 2-3 (windmill)");
    settings.Add("stage_2-4", true, "Stage 2-4 (Nuberu)");
    settings.Add("stage_Bonus-1", true, "Stage Bonus 1");
    settings.Add("stage_3-1", true, "Stage 3-1");
    settings.Add("stage_3-2", true, "Stage 3-2");
    settings.Add("stage_3-3", true, "Stage 3-3 (Manticore)");
    settings.Add("stage_3-4", true, "Stage 3-4");
    settings.Add("stage_3-5", true, "Stage 3-5");
    settings.Add("stage_3-6", true, "Stage 3-6 (Crazy Quixote)");
    settings.Add("stage_4-1", true, "Stage 4-1");
    settings.Add("stage_4-2", true, "Stage 4-2");
    settings.Add("stage_4-3", true, "Stage 4-3 (Tarasca)");
    settings.Add("stage_4-4", true, "Stage 4-4");
    settings.Add("stage_4-5", true, "Stage 4-5");
    settings.Add("stage_4-6", true, "Stage 4-6 (Bu)");
    settings.Add("stage_4-7", true, "Stage 4-7 (Ancient Souls)");
    settings.Add("stage_Bonus-2", true, "Stage Bonus 2");
    settings.Add("stage_5-1", true, "Stage 5-1");
    settings.Add("stage_5-2", true, "Stage 5-2");
    settings.Add("stage_5-3", true, "Stage 5-3");
    settings.Add("stage_5-4", true, "Stage 5-4");
    settings.Add("stage_5-5", true, "Stage 5-5");
    settings.Add("stage_5-6", true, "Stage 5-6");
    settings.Add("stage_5-7", true, "Stage 5-7(Mendoza)");
    settings.Add("stage_5-8", true, "Stage 5-8");
    settings.Add("stage_5-9", true, "Stage 5-9");

    vars.stagesId = new Dictionary<int, string>
	{
        {6, "stage_1-1"},
        {7, "stage_1-2"},
        {8, "stage_1-3"},
        {9, "stage_1-4"},
        {10, "stage_1-5"},
        {12, "stage_2-1"},
        {13, "stage_2-2"},
        {14, "stage_2-3"},
        {15, "stage_2-4"},
        {17, "stage_Bonus-1"},
        {19, "stage_3-1"},
        {20, "stage_3-2"},
        {21, "stage_3-3"},
        {22, "stage_3-4"},
        {23, "stage_3-5"},
        {24, "stage_3-6"},
        {26, "stage_4-1"},
        {27, "stage_4-2"},
        {28, "stage_4-3"},
        {29, "stage_4-4"},
        {30, "stage_4-5"},
        {31, "stage_4-6"},
        {32, "stage_4-7"},
        {34, "stage_Bonus-2"},
        {36, "stage_5-1"},
        {37, "stage_5-2"},
        {38, "stage_5-3"},
        {39, "stage_5-4"},
        {40, "stage_5-5"},
        {41, "stage_5-6"},
        {42, "stage_5-7"},
        {44, "stage_5-8"},
        {45, "stage_5-9"}
	};
}

start
{
    return current.map == 3 && old.startGame == 0 && current.startGame == 1;
}

reset
{
    return old.map > 1 && current.map == 1;
}

split
{
    if (current.map == 67)
    {
        return false;
    } 

    bool enabledMap = false;
    if (current.map == 46)
    {
        // This is the end split, it's not listed as it's mandatory to end the run.
        enabledMap = true;
    }
    else if (vars.stagesId.ContainsKey(old.map))
    {
        string stageToSplitId = vars.stagesId[old.map];
        enabledMap = settings[stageToSplitId];
    }

    if (old.map == 31)
    {
        // Specific case, we never lose the controle of the character after Bu fight, so we split when the map updates.
        return enabledMap && current.lives == old.lives && current.map > old.map && current.menuOpen == 0;
    }
    else
    {
        return enabledMap && current.lives == old.lives && current.canMove == 0 && old.canMove == 1 && current.menuOpen == 0;
    }
}

update
{}
