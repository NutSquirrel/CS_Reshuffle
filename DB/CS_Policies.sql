-- written by GAIA using Notepad++
CREATE TABLE IF NOT EXISTS Sapiens_DBUpdates (Name TEXT PRIMARY KEY, Value INTEGER DEFAULT 0);
INSERT OR IGNORE INTO Sapiens_DBUpdates (Name) VALUES ('CSPolicies');
--======================================================================================================================
-- CITY-STATE POLICIES
--======================================================================================================================
INSERT OR IGNORE INTO Policies
		(Type,								Description)
SELECT	'POLICY_GAIA_CS_'||SUBSTR(Type,11),	'TXT_KEY_CITYSTATE_'||SUBSTR(Type,11)
FROM MinorCivilizations WHERE Type IN (
-- Cultured (8)
	'MINOR_CIV_BOGOTA',
	'MINOR_CIV_CARAL',
	'MINOR_CIV_GREAT_ZIMBAWE',
	'MINOR_CIV_KIEV',
	'MINOR_CIV_KYZYL',
	'MINOR_CIV_SIOUX',
	'MINOR_CIV_PRAGUE',
	'MINOR_CIV_YEREVAN',
-- Maritime (9)
	'MINOR_CIV_BYBLOS',
	'MINOR_CIV_CAPE_TOWN',
	'MINOR_CIV_MANILA',
	'MINOR_CIV_MOMBASA',
	'MINOR_CIV_PANAMA_CITY',
	'MINOR_CIV_RAGUSA',
	'MINOR_CIV_REYKJAVIK',
	'MINOR_CIV_SEYCHELLES',
	'MINOR_CIV_WELLINGTON',
-- Mercantile (9)
	'MINOR_CIV_ADEN',
	'MINOR_CIV_COLOMBO',
	'MINOR_CIV_GARAMANTES',
	'MINOR_CIV_HAVANA',
	'MINOR_CIV_HONG_KONG',
	'MINOR_CIV_MALACCA',
	'MINOR_CIV_TYRE',
	'MINOR_CIV_VILNIUS',
	'MINOR_CIV_ZANZIBAR',
-- Militaristic (8)
	'MINOR_CIV_ALMATY',
	'MINOR_CIV_BELGRADE',
	'MINOR_CIV_DAKAR',
	'MINOR_CIV_KABUL',
	'MINOR_CIV_MAPUCHE',
	'MINOR_CIV_SIDON',
	'MINOR_CIV_SOFIA',
	'MINOR_CIV_VALLETTA',
-- Religious (7)
	'MINOR_CIV_GENEVA',
	'MINOR_CIV_IFE',
	'MINOR_CIV_KATHMANDU',
	'MINOR_CIV_LA_VENTA',
	'MINOR_CIV_LHASA',
	'MINOR_CIV_NAN_MADOL',
	'MINOR_CIV_TIWANAKU'
);
--------------------------------------------------------------------------
-- LINK POLICES
--------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS _MinorCivilization_AllyBonuses (
	MinorCivType		TEXT NOT NULL PRIMARY KEY REFERENCES MinorCivilizations(Type),
	AllyBonusPolicy		TEXT DEFAULT NULL REFERENCES Policies(Type),
	AllyBonusHelp		TEXT DEFAULT NULL,
	CSWonderHelp		TEXT DEFAULT NULL
);
INSERT OR REPLACE INTO _MinorCivilization_AllyBonuses
		(MinorCivType,	AllyBonusPolicy)
SELECT	Type,			'POLICY_GAIA_CS_' || SUBSTR(Type, 11)
FROM MinorCivilizations WHERE Type IN (
-- Cultured (8)
	'MINOR_CIV_BOGOTA',
	'MINOR_CIV_CARAL',
	'MINOR_CIV_GREAT_ZIMBAWE',
	'MINOR_CIV_KIEV',
	'MINOR_CIV_KYZYL',
	'MINOR_CIV_SIOUX',
	'MINOR_CIV_PRAGUE',
	'MINOR_CIV_YEREVAN',
-- Maritime (9)
	'MINOR_CIV_BYBLOS',
	'MINOR_CIV_CAPE_TOWN',
	'MINOR_CIV_MANILA',
	'MINOR_CIV_MOMBASA',
	'MINOR_CIV_PANAMA_CITY',
	'MINOR_CIV_RAGUSA',
	'MINOR_CIV_REYKJAVIK',
	'MINOR_CIV_SEYCHELLES',
	'MINOR_CIV_WELLINGTON',
-- Mercantile (9)
	'MINOR_CIV_ADEN',
	'MINOR_CIV_COLOMBO',
	'MINOR_CIV_GARAMANTES',
	'MINOR_CIV_HAVANA',
	'MINOR_CIV_HONG_KONG',
	'MINOR_CIV_MALACCA',
	'MINOR_CIV_TYRE',
	'MINOR_CIV_VILNIUS',
	'MINOR_CIV_ZANZIBAR',
-- Militaristic (8)
	'MINOR_CIV_ALMATY',
	'MINOR_CIV_BELGRADE',
	'MINOR_CIV_DAKAR',
	'MINOR_CIV_KABUL',
	'MINOR_CIV_MAPUCHE',
	'MINOR_CIV_SIDON',
	'MINOR_CIV_SOFIA',
	'MINOR_CIV_VALLETTA',
-- Religious (7)
	'MINOR_CIV_GENEVA',
	'MINOR_CIV_IFE',
	'MINOR_CIV_KATHMANDU',
	'MINOR_CIV_LA_VENTA',
	'MINOR_CIV_LHASA',
	'MINOR_CIV_NAN_MADOL',
	'MINOR_CIV_TIWANAKU'
);	
--======================================================================================================================
UPDATE Sapiens_DBUpdates SET Value = 1 WHERE Name = 'CSPolicies';
