// RegMod.cpp : Defines the entry point for the application.
//
#include <windows.h>
#include <stdio.h>

class CRegUtils
{
	static HKEY openRegKeyPath( LPCTSTR szKey, char *strAttr, DWORD *pdwType, DWORD openMode = KEY_READ | KEY_WRITE )
	{
		// split key into type, base, path & attr
		char szBase[1024], szSubKey[ 1024 ], szType[ 1024 ];

		if( sscanf( szKey, "%[^:]: %[^\\]\\%[^\0]", szType, szBase, szSubKey ) != 3 )
			return 0;

		char *szAttr = strrchr( szSubKey, '\\' );
		*(szAttr++) = 0;

		if( strAttr )
			strcpy( strAttr, szAttr );

		// Determine which registry section we want to use & the type of the key
		HKEY hkBase = lookupBase( szBase );
		if( pdwType )
			*pdwType = lookupType( szType );

		// Open the registry key
		HKEY key = 0;
		
		DWORD dwErrorCode = ::RegOpenKeyEx( hkBase, szSubKey, 0, openMode, &key );
		if( dwErrorCode != ERROR_SUCCESS )
			return 0;

		return key;
	}

public:

	static LPCTSTR lookupBaseString( HKEY key )
	{
		if( key == HKEY_CLASSES_ROOT ) return "HKEY_CLASSES_ROOT";
		if( key == HKEY_CURRENT_USER ) return "HKEY_CURRENT_USER";
		if( key == HKEY_LOCAL_MACHINE ) return "HKEY_LOCAL_MACHINE";
		if( key == HKEY_USERS ) return "HKEY_USERS";
		if( key == HKEY_PERFORMANCE_DATA ) return "HKEY_PERFORMANCE_DATA";
		if( key == HKEY_PERFORMANCE_TEXT ) return "HKEY_PERFORMANCE_TEXT";
		if( key == HKEY_PERFORMANCE_NLSTEXT ) return "HKEY_PERFORMANCE_NLSTEXT";
		if( key == HKEY_CLASSES_ROOT ) return "HKEY_CLASSES_ROOT";
		if( key == HKEY_CURRENT_CONFIG ) return "HKEY_CURRENT_CONFIG";
		if( key == HKEY_DYN_DATA ) return "HKEY_DYN_DATA";
		return NULL;
	}

	static HKEY lookupBase( LPCTSTR szKey )
	{
		if( ! strcmp( szKey, "HKEY_CLASSES_ROOT" ) ) return HKEY_CLASSES_ROOT;
		if( ! strcmp( szKey, "HKEY_CURRENT_USER" ) ) return HKEY_CURRENT_USER;
		if( ! strcmp( szKey, "HKEY_LOCAL_MACHINE" ) ) return HKEY_LOCAL_MACHINE;
		if( ! strcmp( szKey, "HKEY_USERS" ) ) return HKEY_USERS;

		if( ! strcmp( szKey, "HKEY_PERFORMANCE_DATA" ) ) return HKEY_PERFORMANCE_DATA;
		if( ! strcmp( szKey, "HKEY_PERFORMANCE_TEXT" ) ) return HKEY_PERFORMANCE_TEXT;
		if( ! strcmp( szKey, "HKEY_PERFORMANCE_NLSTEXT" ) ) return HKEY_PERFORMANCE_NLSTEXT;

		if( ! strcmp( szKey, "HKEY_CURRENT_CONFIG" ) ) return HKEY_CURRENT_CONFIG;
		if( ! strcmp( szKey, "HKEY_DYN_DATA" ) ) return HKEY_DYN_DATA;
		return 0;
	}

	static DWORD lookupType( LPCTSTR szType )
	{
		if( ! strcmp( szType, "DWORD" ) ) return REG_DWORD;
		if( ! strcmp( szType, "SZ" ) ) return REG_SZ;
		return 0;
	}

	static LPCTSTR lookupTypeString( DWORD dwType )
	{
		if( dwType == REG_DWORD ) return "DWORD";
		if( dwType == REG_SZ ) return "SZ";
		return NULL;
	}

	static BOOL checkKey( LPCTSTR szKey )
	{
		HKEY key = openRegKeyPath( szKey, NULL, NULL, KEY_READ | KEY_WRITE );

		if( key == 0 )
			return FALSE;

		::RegCloseKey( key );
		return TRUE;
	}

	static BOOL deleteKey( LPCTSTR szKey )
	{
		char strAttr[ 1024 ];
		HKEY key = openRegKeyPath( szKey, strAttr, NULL, KEY_READ | KEY_WRITE );

		if( key == 0 )
			return FALSE;

		DWORD dwErrorCode = ::RegDeleteValue( key, strAttr );
		::RegCloseKey( key );
		return dwErrorCode == ERROR_SUCCESS;
	}

	static BOOL getKey( LPCTSTR szKey, char *strValue, DWORD *pdwOrigType = NULL )
	{
		strValue[0] = 0;
		char strAttr[ 1024 ];

		HKEY key = openRegKeyPath( szKey, strAttr, NULL, KEY_READ );

		if( key == 0 )
			return FALSE;

		// Read current value from attribute
		BYTE data[ 1024 ];
		DWORD dwType = 0, dwDataSize = sizeof( data );

		if( ::RegQueryValueEx( key, strAttr, NULL, &dwType, (LPBYTE)&data, &dwDataSize ) != ERROR_SUCCESS )
		{
			::RegCloseKey( key );
			return FALSE;
		}

		if( pdwOrigType )
			*pdwOrigType = dwType;
			
		switch( dwType )
		{
			case REG_DWORD: 
					sprintf( strValue, "%li", *((DWORD *)data) );
					break;

			case REG_SZ: 
					strncpy( strValue, (const char *)data, dwDataSize );
					strValue[ dwDataSize ] = 0;
					break;
		}

		::RegCloseKey( key );
		return TRUE;
	}

	static BOOL setKey( LPCTSTR szKey, LPCTSTR szValue )
	{
		char strAttr[ 1024 ];
		DWORD dwType = 0;
		HKEY key = openRegKeyPath( szKey, strAttr, &dwType, KEY_READ | KEY_WRITE );

		if( key == 0 )
			return FALSE;

		// Read current value from attribute
		BYTE data[ 1024 ];
		DWORD dwSize = sizeof( data );
		
		switch( dwType )
		{
			case REG_DWORD: 
					*((DWORD *)data) = atol( szValue ); 
					dwSize = sizeof( DWORD ); 
					break;

			case REG_SZ: 
					strcpy( (char *)data, szValue ); 
					dwSize = (DWORD)strlen( szValue ); 
					break;
		}

		BOOL bOk = ::RegSetValueEx( key, strAttr, 0, dwType, data, dwSize ) == ERROR_SUCCESS;

		::RegCloseKey( key );
		return bOk;
	}
};

class CRegMod : public CRegUtils
{
//	char m_strErrors[ 1024 ];
public:

	CRegMod()
	{
//		m_strErrors[0] = 0;
	}

	BOOL installKey( LPCTSTR szKey, LPCTSTR szValue, LPCTSTR szBackupKey )
	{
		DWORD dwOrigType;
		char strOriginal[ 1024 ];

		BOOL bExists = getKey( szKey, strOriginal, &dwOrigType );

		if( ! strcmp( szValue, strOriginal ) )
			return TRUE;

		if( ! setKey( szBackupKey, bExists ? strOriginal : "9999" ) )
		{}
//			sprintf( m_strErrors + strlen( m_strErrors ), "Failed to save backup key: %s\n", szBackupKey );
		
		BOOL bOk = setKey( szKey, szValue );
		//if( ! bOk )
//			sprintf( m_strErrors + strlen( m_strErrors ), "Failed to save key: %s\n", szKey );
		return bOk;
	}

	BOOL restoreKey( LPCTSTR szBackupKey, LPCTSTR szKey )
	{
		char strValue[ 1024 ];
		if( ! getKey( szBackupKey, strValue, NULL ) )
		{
			//sprintf( m_strErrors + strlen( m_strErrors ), "Key doesn't exist: %s\n", szBackupKey );
			return FALSE;
		}

		if( ! strcmp( strValue, "9999" ) )
			deleteKey( szKey );
		else
			setKey( szKey, strValue ); 

		deleteKey( szBackupKey );
		return TRUE;
	}

	BOOL check()
	{
		BOOL bOk = checkKey( "DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPerServer" ) &&
					checkKey( "DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPer1_0Server" );
		return bOk;
	}

	void install()
	{
		installKey( "DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPerServer", "36",
			"DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPerServer__Backup" );

		installKey( "DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPer1_0Server", "8",
			"DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPer1_0Server__Backup" );
	}

	BOOL uninstall()
	{
		BOOL bOk = restoreKey( "DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPerServer__Backup",
			"DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPerServer" );

		bOk = restoreKey( "DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPer1_0Server__Backup",
			"DWORD: HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPer1_0Server" );

		return bOk;
	}
};

void install()
{
	CRegMod regMod;

LPCTSTR szIntro = 
"This application implements a workaround to a known Internet Explorer bug that affects Weathernews’ Beacon software.\n\
The workaround increases the number of concurrent connections that can be opened and maintained by IE.\n\
\n\
The workaround is implemented by changing the Windows registry keys:\n\
\n\
HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPerServer\n\
HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPer1_0Server\n\
\n\
You can restore your original IE settings at any time by going to the Weathernews patch page (the one where you originally downloaded this workaround application) and downloading a ‘restore’ application.\n\
\n\
If you have any questions, please contact stevea@wni.com.\n\
\n\
Press OK to Continue or Cancel to Exit.";

LPCTSTR szOK = 
"Your settings have been updated to implement the workaround.\n\
Please close all Internet Explorer windows and restart IE for the changes to take effect.";

LPCTSTR szNoKey = 
"It appears that there was an access problem trying to update your system.\n\
\n\
Please contact stevea@wni.com for further assistance";

LPCTSTR szCaption = "Beacon RegMod Install";

	if( ::MessageBox( 0, szIntro, szCaption, MB_OKCANCEL  | MB_ICONINFORMATION ) == IDCANCEL )
		return;

	if( ! regMod.check() )
	{
		::MessageBox( 0, szNoKey, szCaption, MB_OK | MB_ICONERROR );
		return;
	}

	regMod.install();

	::MessageBox( 0, szOK, szCaption, MB_OK | MB_ICONINFORMATION );
}

void uninstall()
{
	CRegMod regMod;

LPCTSTR szIntro = 
"This application removes a workaround to a known Internet Explorer bug that affects Weathernews’ Beacon software.\n\
The workaround increases the number of concurrent connections that can be opened and maintained by IE. \n\
\n\
The workaround is implemented by changing the Windows registry keys:\n\
\n\
HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPerServer\n\
HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPer1_0Server\n\
\n\
This application restores the registry keys to their original settings (before having applied the workaround).\n\
\n\
If you have any questions, please contact stevea@wni.com.";

LPCTSTR szOK = 
"Your settings have been updated to remove the workaround\n\
Please close all Internet Explorer windows and restart IE for the changes to take effect.";

LPCTSTR szNoKey = 
"It appears that there was an access problem trying to update your system.\n\
\n\
Please contact stevea@wni.com for further assistance";

LPCTSTR szCaption = "Beacon RegMod Uninstall";

//	LPCTSTR szIntro = "This will restore the following registry keys to their original values\nIf you have any questions, please contact stevea@wni.com\nPress OK to Continue or Cancel to Exit";
//	LPCTSTR szOK = "Thank you. Your settings have been successfully restored to their original values.";
//	LPCTSTR szNoKey = "It appears that the registry key:\n HKEY_CURRENT_USER\\Software\\Microsoft\\Windows\\CurrentVersion\\Internet Settings\\MaxConnectionsPerServer\n cannot be accessed.\nCheck that you have to correct permissions to access this key.";
//	LPCTSTR szCaption = "Beacon RegMod Uninstall";

	if( ::MessageBox( 0, szIntro, szCaption, MB_OKCANCEL | MB_ICONINFORMATION ) == IDCANCEL )
		return;

	if( ! regMod.check() )
	{
		::MessageBox( 0, szNoKey, szCaption, MB_OK | MB_ICONERROR );
		return;
	}

	regMod.uninstall();

	::MessageBox( 0, szOK, szCaption, MB_OK | MB_ICONINFORMATION );
}

int __stdcall WinMain( HINSTANCE hInstance, HINSTANCE hPrevInstance, LPSTR lpCmdLine, int nCmdShow )
{
	install();
	//uninstall();
}
