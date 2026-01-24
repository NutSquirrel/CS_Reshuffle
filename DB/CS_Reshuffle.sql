-- written by GAIA using Notepad++
CREATE TABLE IF NOT EXISTS Sapiens_DBUpdates (Name TEXT PRIMARY KEY, Value INTEGER DEFAULT 0);
INSERT OR IGNORE INTO Sapiens_DBUpdates (Name) VALUES ('CS_Reschuffle');
--======================================================================================================================
-- CITY-STATE REDUX
--======================================================================================================================
--DELETED CITY-STATES--
DELETE FROM MinorCivilizations WHERE Type IN (
-- Cultured
	'MINOR_CIV_BRATISLAVA',
	'MINOR_CIV_FLORENCE',
	'MINOR_CIV_BUCHAREST',
	'MINOR_CIV_BRUSSELS',
	'MINOR_CIV_MONACO',
	'MINOR_CIV_KUALA_LUMPUR',
	'MINOR_CIV_MILAN',
	'MINOR_CIV_BUENOS_AIRES',
	--'MINOR_CIV_KABUL', --> Militaristic
-- Maritime
	'MINOR_CIV_RIGA',
	--'MINOR_CIV_RAGUSA', --> Mercantile
	'MINOR_CIV_SYDNEY',
	'MINOR_CIV_QUEBEC_CITY',
	'MINOR_CIV_ORMUS',
	'MINOR_CIV_VANCOUVER',
	'MINOR_CIV_MOGADISHU',
	'MINOR_CIV_UR',
-- Mercantile
	'MINOR_CIV_GENOA',
	--'MINOR_CIV_SINGAPORE', --> Maritime
	'MINOR_CIV_ANTWERP',
	--'MINOR_CIV_CAHOKIA', --> Cultured
	'MINOR_CIV_ANTANANARIVO',
	'MINOR_CIV_ZURICH',
	'MINOR_CIV_MELBOURNE',
-- Militaristic
	'MINOR_CIV_BUDAPEST',
	'MINOR_CIV_HANOI',
-- Religious
	'MINOR_CIV_JERUSALEM',
	'MINOR_CIV_VATICAN_CITY',
	'MINOR_CIV_WITTENBERG'
);
DELETE FROM MinorCivilization_CityNames WHERE MinorCivType IN (
-- Cultured
	'MINOR_CIV_BRATISLAVA',
	'MINOR_CIV_FLORENCE',
	'MINOR_CIV_BUCHAREST',
	'MINOR_CIV_BRUSSELS',
	'MINOR_CIV_MONACO',
	'MINOR_CIV_KUALA_LUMPUR',
	'MINOR_CIV_MILAN',
	'MINOR_CIV_BUENOS_AIRES',
	--'MINOR_CIV_KABUL', --> Militaristic
-- Maritime
	'MINOR_CIV_RIGA',
	--'MINOR_CIV_RAGUSA', --> Mercantile
	'MINOR_CIV_SYDNEY',
	'MINOR_CIV_QUEBEC_CITY',
	'MINOR_CIV_ORMUS',
	'MINOR_CIV_VANCOUVER',
	'MINOR_CIV_MOGADISHU',
	'MINOR_CIV_UR',
-- Mercantile
	'MINOR_CIV_GENOA',
	--'MINOR_CIV_SINGAPORE', --> Maritime
	'MINOR_CIV_ANTWERP',
	--'MINOR_CIV_CAHOKIA', --> Cultured
	'MINOR_CIV_ANTANANARIVO',
	'MINOR_CIV_ZURICH',
	'MINOR_CIV_MELBOURNE',
-- Militaristic
	'MINOR_CIV_BUDAPEST',
	'MINOR_CIV_HANOI',
-- Religious
	'MINOR_CIV_JERUSALEM',
	'MINOR_CIV_VATICAN_CITY',
	'MINOR_CIV_WITTENBERG'
);
DELETE FROM MinorCivilization_Flavors WHERE MinorCivType IN (
-- Cultured
	'MINOR_CIV_BRATISLAVA',
	'MINOR_CIV_FLORENCE',
	'MINOR_CIV_BUCHAREST',
	'MINOR_CIV_BRUSSELS',
	'MINOR_CIV_MONACO',
	'MINOR_CIV_KUALA_LUMPUR',
	'MINOR_CIV_MILAN',
	'MINOR_CIV_BUENOS_AIRES',
	'MINOR_CIV_KABUL', --> Militaristic
-- Maritime
	'MINOR_CIV_RIGA',
	'MINOR_CIV_RAGUSA', --> Mercantile
	'MINOR_CIV_SYDNEY',
	'MINOR_CIV_QUEBEC_CITY',
	'MINOR_CIV_ORMUS',
	'MINOR_CIV_VANCOUVER',
	'MINOR_CIV_MOGADISHU',
	'MINOR_CIV_UR',
-- Mercantile
	'MINOR_CIV_GENOA',
	'MINOR_CIV_SINGAPORE', --> Maritime
	'MINOR_CIV_ANTWERP',
	'MINOR_CIV_CAHOKIA', --> Cultured
	'MINOR_CIV_ANTANANARIVO',
	'MINOR_CIV_ZURICH',
	'MINOR_CIV_MELBOURNE',
-- Militaristic
	'MINOR_CIV_BUDAPEST',
	'MINOR_CIV_HANOI',
-- Religious
	'MINOR_CIV_JERUSALEM',
	'MINOR_CIV_VATICAN_CITY',
	'MINOR_CIV_WITTENBERG'
);

CREATE TABLE CSIDRemapper ( id INTEGER PRIMARY KEY AUTOINCREMENT, Type TEXT );
INSERT INTO CSIDRemapper (Type) SELECT Type FROM MinorCivilizations ORDER BY ID;
UPDATE MinorCivilizations SET ID = ( SELECT CSIDRemapper.id FROM CSIDRemapper WHERE MinorCivilizations.Type = CSIDRemapper.Type);
DROP TABLE CSIDRemapper;

UPDATE sqlite_sequence
SET seq = (SELECT COUNT(ID) FROM MinorCivilizations)
WHERE name = 'MinorCivilizations';

--=======================================================================================================================
-- CITY-STATE TYPE UPDATES
--=======================================================================================================================
--------------------------------------------------------------------------
-- KABUL CULTURED -> MILITARISTIC
--------------------------------------------------------------------------
UPDATE MinorCivilizations SET MinorCivTrait = 'MINOR_TRAIT_MILITARISTIC'	WHERE Type = 'MINOR_CIV_KABUL';
UPDATE MinorCivilizations SET MinorCivTrait = 'MINOR_TRAIT_MERCANTILE'		WHERE Type = 'MINOR_CIV_RAGUSA';
UPDATE MinorCivilizations SET MinorCivTrait = 'MINOR_TRAIT_MARITIME'		WHERE Type = 'MINOR_CIV_SINGAPORE';
UPDATE MinorCivilizations SET MinorCivTrait = 'MINOR_TRAIT_CULTURED'		WHERE Type = 'MINOR_CIV_CAHOKIA';

--Flavors
INSERT INTO MinorCivilization_Flavors
	(MinorCivType,			FlavorType,					Flavor) VALUES
-- Cultured
	('MINOR_CIV_CAHOKIA',	'FLAVOR_CULTURE',           10),
-- Maritime
	('MINOR_CIV_SINGAPORE',	'FLAVOR_GROWTH',            8),
	('MINOR_CIV_SINGAPORE',	'FLAVOR_NAVAL',             8),
-- Mercantile
	('MINOR_CIV_RAGUSA',	'FLAVOR_GOLD',              10),
-- Militaristic
	('MINOR_CIV_KABUL',		'FLAVOR_CITY_DEFENSE',		7),
	('MINOR_CIV_KABUL',		'FLAVOR_DEFENSE',			7),
	('MINOR_CIV_KABUL',		'FLAVOR_MILITARY_TRAINING',	7),
	('MINOR_CIV_KABUL',		'FLAVOR_OFFENSE',			7);

--Colors
UPDATE MinorCivilizations SET DefaultPlayerColor = 'PLAYERCOLOR_MINOR_BUDAPEST'		WHERE Type = 'MINOR_CIV_KABUL';
UPDATE MinorCivilizations SET DefaultPlayerColor = 'PLAYERCOLOR_MINOR_SINGAPORE'	WHERE Type = 'MINOR_CIV_RAGUSA';
UPDATE MinorCivilizations SET DefaultPlayerColor = 'PLAYERCOLOR_MINOR_RAGUSA'		WHERE Type = 'MINOR_CIV_SINGAPORE';
UPDATE MinorCivilizations SET DefaultPlayerColor = 'PLAYERCOLOR_MINOR_BRATISLAVA'	WHERE Type = 'MINOR_CIV_CAHOKIA';

--Sounds
UPDATE Audio_2DSounds SET SoundID = 'SND_MINOR_BUDAPEST'					WHERE ScriptID = 'AS2D_MINOR_CIV_KABUL';
UPDATE Audio_2DSounds SET SoundID = 'SND_MINOR_SINGAPORE'					WHERE ScriptID = 'AS2D_MINOR_CIV_RAGUSA';
UPDATE Audio_2DSounds SET SoundID = 'SND_MINOR_RAGUSA'						WHERE ScriptID = 'AS2D_MINOR_CIV_SINGAPORE';
UPDATE Audio_2DSounds SET SoundID = 'SND_MINOR_BRATISLAVA'					WHERE ScriptID = 'AS2D_MINOR_CIV_CAHOKIA';

--=======================================================================================================================
-- NEW CITY-STATES
--=======================================================================================================================
INSERT OR IGNORE INTO MinorCivilizations
	(Type,                      Description,						Civilopedia,							ShortDescription,					Adjective,								ArtDefineTag,                  DefaultPlayerColor,					ArtStyleType,				ArtStyleSuffix,  ArtStylePrefix,     MinorCivTrait) VALUES
-- Cultured
	('MINOR_CIV_CARAL',			'TXT_KEY_CITYSTATE_CARAL',         'TXT_KEY_CIV5_GAIA_CARAL_TEXT',			'TXT_KEY_CITYSTATE_CARAL',			'TXT_KEY_CITYSTATE_CARAL_ADJ',			'ART_DEF_CIVILIZATION_MINOR',  'PLAYERCOLOR_MINOR_FLORENCE',		'ARTSTYLE_SOUTH_AMERICA',	'_AMER',         'AMERICAN',         'MINOR_TRAIT_CULTURED'),
	('MINOR_CIV_GREAT_ZIMBAWE',	'TXT_KEY_CITYSTATE_GREAT_ZIMBAWE', 'TXT_KEY_CIV5_GAIA_GREAT_ZIMBAWE_TEXT',	'TXT_KEY_CITYSTATE_GREAT_ZIMBAWE',	'TXT_KEY_CITYSTATE_GREAT_ZIMBAWE_ADJ',	'ART_DEF_CIVILIZATION_MINOR',  'PLAYERCOLOR_MINOR_BUCHAREST',		'ARTSTYLE_AFRICA',			'_AFRI',         'AFRICAN',          'MINOR_TRAIT_CULTURED'),
-- Maritime
	('MINOR_CIV_HAVANA',		'TXT_KEY_CITYSTATE_HAVANA',			'TXT_KEY_CIV5_GAIA_HAVANA_TEXT',		'TXT_KEY_CITYSTATE_HAVANA',			'TXT_KEY_CITYSTATE_HAVANA_ADJ',			'ART_DEF_CIVILIZATION_MINOR',  'PLAYERCOLOR_MINOR_RIGA',			'ARTSTYLE_EUROPEAN',		'_EURO',         'EUROPEAN',         'MINOR_TRAIT_MARITIME'),
	('MINOR_CIV_SEYCHELLES',	'TXT_KEY_CITYSTATE_SEYCHELLES',		'TXT_KEY_CIV5_GAIA_SEYCHELLES_TEXT',	'TXT_KEY_CITYSTATE_SEYCHELLES',		'TXT_KEY_CITYSTATE_SEYCHELLES_ADJ',		'ART_DEF_CIVILIZATION_MINOR',  'PLAYERCOLOR_MINOR_SYDNEY',			'ARTSTYLE_AFRICA',			'_AFRI',         'AFRICAN',          'MINOR_TRAIT_MARITIME'),
-- Mercantile
	('MINOR_CIV_ADEN',			'TXT_KEY_CITYSTATE_ADEN',			'TXT_KEY_CIV5_GAIA_ADEN_TEXT',			'TXT_KEY_CITYSTATE_ADEN',			'TXT_KEY_CITYSTATE_ADEN_ADJ',			'ART_DEF_CIVILIZATION_MINOR',  'PLAYERCOLOR_MINOR_GENOA',			'ARTSTYLE_MIDDLE_EAST',		'_MIDEAST',      'MIDDLE_EASTERN',   'MINOR_TRAIT_MERCANTILE'),
-- Militaristic
	('MINOR_CIV_MAPUCHE',		'TXT_KEY_CITYSTATE_MAPUCHE',		'TXT_KEY_CIV5_GAIA_MAPUCHE_TEXT',		'TXT_KEY_CITYSTATE_MAPUCHE',		'TXT_KEY_CITYSTATE_MAPUCHE_ADJ',		'ART_DEF_CIVILIZATION_MINOR',  'PLAYERCOLOR_MINOR_HANOI',			'ARTSTYLE_SOUTH_AMERICA',	'_AMER',         'AMERICAN',         'MINOR_TRAIT_MILITARISTIC'),
-- Religious
	('MINOR_CIV_NAN_MADOL',		'TXT_KEY_CITYSTATE_NAN_MADOL',		'TXT_KEY_CIV5_GAIA_NAN_MADOL_TEXT',		'TXT_KEY_CITYSTATE_NAN_MADOL',		'TXT_KEY_CITYSTATE_NAN_MADOL_ADJ',		'ART_DEF_CIVILIZATION_MINOR',  'PLAYERCOLOR_MINOR_JERUSALEM',		'ARTSTYLE_ASIAN',			'_ASIA',         'ASIAN',            'MINOR_TRAIT_RELIGIOUS'),
	('MINOR_CIV_TIWANAKU',		'TXT_KEY_CITYSTATE_TIWANAKU',		'TXT_KEY_CIV5_GAIA_TIWANAKU_TEXT',		'TXT_KEY_CITYSTATE_TIWANAKU',		'TXT_KEY_CITYSTATE_TIWANAKU_ADJ',		'ART_DEF_CIVILIZATION_MINOR',  'PLAYERCOLOR_MINOR_VATICAN_CITY',	'ARTSTYLE_SOUTH_AMERICA',	'_AMER',         'AMERICAN',         'MINOR_TRAIT_RELIGIOUS');

--------------------------------------------------------------------------
-- AUDIO
--------------------------------------------------------------------------

INSERT OR IGNORE INTO Audio_2DSounds 
	(ScriptID,							SoundID,						DontTriggerDuplicates,	TaperSoundtrackVolume,	MinVolume,	MaxVolume,	SoundType) VALUES
-- Cultured
	('AS2D_MINOR_CIV_CARAL',			'SND_MINOR_CIV_FLORENCE',		1,	0.0,	50,	50,	'GAME_MUSIC_STINGS'),
	('AS2D_MINOR_CIV_GREAT_ZIMBAWE',	'SND_MINOR_CIV_BUCHAREST',		1,	0.0,	50,	50,	'GAME_MUSIC_STINGS'),
-- Maritime	
	('AS2D_MINOR_CIV_HAVANA',			'SND_MINOR_CIV_RIGA',			1,	0.0,	50,	50,	'GAME_MUSIC_STINGS'),
	('AS2D_MINOR_CIV_SEYCHELLES',		'SND_MINOR_CIV_SYDNEY',			1,	0.0,	50,	50,	'GAME_MUSIC_STINGS'),
-- Mercantile	
	('AS2D_MINOR_CIV_ADEN',				'SND_MINOR_CIV_GENOA',			1,	0.0,	50,	50,	'GAME_MUSIC_STINGS'),
-- Militaristic	
	('AS2D_MINOR_CIV_MAPUCHE',			'SND_MINOR_CIV_HANOI',			1,	0.0,	50,	50,	'GAME_MUSIC_STINGS'),
-- Religious
	('AS2D_MINOR_CIV_NAN_MADOL',		'SND_MINOR_CIV_JERUSALEM',		1,	0.0,	50,	50,	'GAME_MUSIC_STINGS'),
	('AS2D_MINOR_CIV_TIWANAKU',			'SND_MINOR_CIV_VATICAN_CITY',	1,	0.0,	50,	50,	'GAME_MUSIC_STINGS');

--------------------------------------------------------------------------
-- CITY NAMES
--------------------------------------------------------------------------
DELETE FROM MinorCivilization_CityNames WHERE MinorCivType IN (
	'MINOR_CIV_CARAL',
	'MINOR_CIV_GREAT_ZIMBAWE',
	'MINOR_CIV_HAVANA',
	'MINOR_CIV_SEYCHELLES',
	'MINOR_CIV_ADEN',
	'MINOR_CIV_MAPUCHE',
	'MINOR_CIV_NAN_MADOL',
	'MINOR_CIV_TIWANAKU'
);
INSERT INTO MinorCivilization_CityNames
	(MinorCivType,              CityName) VALUES
-- Cultured
	('MINOR_CIV_CARAL',         'TXT_KEY_CITYSTATE_CARAL'),
	('MINOR_CIV_GREAT_ZIMBAWE', 'TXT_KEY_CITYSTATE_GREAT_ZIMBAWE'),
-- Maritime
	('MINOR_CIV_HAVANA',		'TXT_KEY_CITYSTATE_HAVANA'),
	('MINOR_CIV_SEYCHELLES',    'TXT_KEY_CITYSTATE_SEYCHELLES'),
-- Mercantile
	('MINOR_CIV_ADEN',          'TXT_KEY_CITYSTATE_ADEN'),
-- Militaristic
	('MINOR_CIV_MAPUCHE',       'TXT_KEY_CITYSTATE_MAPUCHE'),
-- Religious
	('MINOR_CIV_NAN_MADOL',     'TXT_KEY_CITYSTATE_NAN_MADOL'),
	('MINOR_CIV_TIWANAKU',		'TXT_KEY_CITYSTATE_TIWANAKU');

--------------------------------------------------------------------------
-- FLAVORS
--------------------------------------------------------------------------
DELETE FROM MinorCivilization_Flavors WHERE MinorCivType IN (
	'MINOR_CIV_CARAL',
	'MINOR_CIV_GREAT_ZIMBAWE',
	'MINOR_CIV_HAVANA',
	'MINOR_CIV_SEYCHELLES',
	'MINOR_CIV_ADEN',
	'MINOR_CIV_MAPUCHE',
	'MINOR_CIV_NAN_MADOL',
	'MINOR_CIV_TIWANAKU'
);
INSERT INTO MinorCivilization_Flavors
	(MinorCivType,				FlavorType,					Flavor) VALUES
-- Cultured
	('MINOR_CIV_CARAL',			'FLAVOR_CULTURE',           10),
	('MINOR_CIV_GREAT_ZIMBAWE',	'FLAVOR_CULTURE',			10),
-- Maritime
	('MINOR_CIV_HAVANA',		'FLAVOR_GROWTH',			8),
	('MINOR_CIV_HAVANA',		'FLAVOR_NAVAL',				8),
	('MINOR_CIV_SEYCHELLES',	'FLAVOR_GROWTH',            8),
	('MINOR_CIV_SEYCHELLES',	'FLAVOR_NAVAL',             8),
-- Mercantile
	('MINOR_CIV_ADEN',          'FLAVOR_GOLD',              10),
-- Militaristic
	('MINOR_CIV_MAPUCHE',       'FLAVOR_CITY_DEFENSE',      7),
	('MINOR_CIV_MAPUCHE',       'FLAVOR_DEFENSE',           7),
	('MINOR_CIV_MAPUCHE',       'FLAVOR_MILITARY_TRAINING',	7),
	('MINOR_CIV_MAPUCHE',       'FLAVOR_OFFENSE',           7),
-- Religious
	('MINOR_CIV_NAN_MADOL',     'FLAVOR_RELIGION',          10),
	('MINOR_CIV_TIWANAKU',      'FLAVOR_RELIGION',          10);

--======================================================================================================================
-- CITY-STATE POLICIES
--======================================================================================================================
INSERT OR IGNORE INTO Policies
		(Type,								Description)
SELECT	'POLICY_GAIA_CS_'||SUBSTR(Type,11),	'TXT_KEY_CITYSTATE_'||SUBSTR(Type,11)
FROM MinorCivilizations;

CREATE TABLE IF NOT EXISTS _MinorCivilization_AllyBonuses (
	MinorCivType		TEXT NOT NULL PRIMARY KEY REFERENCES MinorCivilizations(Type),
	AllyBonusPolicy		TEXT DEFAULT NULL REFERENCES Policies(Type),
	AllyBonusHelp		TEXT DEFAULT NULL, CSWonderHelp TEXT DEFAULT NULL
);
INSERT OR IGNORE INTO _MinorCivilization_AllyBonuses
		(MinorCivType,	AllyBonusPolicy)
SELECT	Type,			'POLICY_GAIA_CS_' || SUBSTR(Type, 11)
FROM MinorCivilizations;

--=======================================================================================================================
UPDATE Sapiens_DBUpdates SET Value = 1 WHERE Name = 'CS_Reschuffle';
