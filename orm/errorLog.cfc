component extends="mura.bean.beanORM" table="errorlog" entityname="errorLog" {
	property name="logID" fieldtype="id";
	property name="userID" ormtype="varchar" length="255" default="";
	property name="source" ormtype="varchar" length="255" default="";
	property name="errorData" ormtype="longtext" html="true";
	property name="systemData" ormtype="longtext" html="true";
	property name="dateAdded" ormtype="timestamp";
}
