exports.QUERIES = 
{
    //Boss
    GETBOSS : 'CALL Q_Get_Boss_By_ID(?)',
    INSERTBOSS : 'CALL Q_Insert_Boss(?,?,?)',
    INSERTBOSSGAMEDATA : 'CALL Q_Insert_Game_Boss(?,?,?,?)',

    //Collectibles
    GETCOLLECTIBLE : 'CALL Q_Get_Collectible_By_ID(?)',
    GETARMOR : 'CALL Q_Get_Armor_By_ID(?)',
    INSERTCOLLECTIBLE : 'CALL Q_Insert_Collectible(?,?,?,?,?)',
    INSERTARMOR : 'CALL Q_Insert_Armor(?,?,?,?,?,?)',

    //Games
    GETGAME : 'CALL Q_Get_Game_By_ID(?)',
    INSERTGAME : 'CALL Q_Insert_Game(?,?,?,?,?)',

    //Players
    GETPLAYER : 'CALL Q_Get_Player_By_ID(?)',
    INSERTPLAYER : 'CALL Q_Insert_Player(?,?,?,?)',
    INSERTGAMEPLAYER : 'CALL Q_Insert_Game_Player(?,?)',
    DELETEBADPLAYERREQUEST : 'DELETE FROM player WHERE player_id = ?',

    //Stages
    GETSTAGE : 'CALL Q_Get_Stage_By_ID(?)',
    INSERTSTAGE : 'CALL Q_Insert_Stage(?,?,?)',

    //Weapons
    GETWEAPON : 'CALL Q_Get_Weapon_By_ID(?)',
    INSERTWEAPON : 'CALL Q_Insert_Weapon(?,?,?)',
    INSERTPLAYERWEAPON : 'CALL Q_Insert_Player_Weapon(?,?)',
    DELETEBADPLAYERWEAPONREQUEST : 'DELETE FROM rel_player_weapon WHERE rel_player_weapon_id = ?',
    INSERTDAMAGEVALUES : 'CALL Q_Insert_Boss_Weapon(?,?,?,?,?,?)'
};