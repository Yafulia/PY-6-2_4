------------------------------------------------------------------------
-- ADD FEATURES
--
-- @program		A350
-- @version		1.32
-- @module		ELCODATA
--
-- List of features added:
--	- Propose to Validation			(EDD LOAD)
--	- Validate						(EDD LOAD)
--	- Downgrade EDD LOAD			(EDD LOAD)
--	- Downgrade EDD LOAD Validated	(EDD LOAD)
--	- Link FIN CI P/CD				(EDD LOAD)
--	- Unlink FIN CI P/CD			(EDD LOAD)
--	- Copy from another EDD LOAD	(EDD LOAD)
--	- Create EDD Uninstall			(EDD Uninstall)
--	- Edit Operation Table
------------------------------------------------------------------------

------------------------------------------------------------------------
-- Add new feature "Propose to Validation"
------------------------------------------------------------------------
IF (NOT EXISTS(	SELECT * FROM T_FEATURE
					WHERE label = 'Propose to Validation')
) BEGIN
	INSERT INTO T_FEATURE (label, description, idr_feature_group, linked_url, display_context, icon, where_clause)
		VALUES ('Propose to Validation',
				'Propose to Validation',
				'5',
				'/BUSINESS_OBJECTS/DS/EDD/Update/EDD_Update_Status_Process.php?id_ds=#id_ds#&update_type=upgrade',
				';DS/CONSULT;',
				'puce_orange.gif',
				'SELECT id_ds FROM R_FIN_DS WHERE id_ds=#id_ds# AND ds_type=''4'' AND FINDS_EDD_Type = ''LOAD'' AND EDD_Load_State = ''In elaboration''')
END

------------------------------------------------------------------------
-- Add new feature "Validate"
------------------------------------------------------------------------
IF (NOT EXISTS(	SELECT * FROM T_FEATURE
					WHERE label = 'Validate')
) BEGIN
	INSERT INTO T_FEATURE (label, description, idr_feature_group, linked_url, display_context, icon, where_clause)
		VALUES ('Validate',
				'Validate',
				'5',
				'/BUSINESS_OBJECTS/DS/EDD/Update/EDD_Update_Status_Process.php?id_ds=#id_ds#&update_type=upgrade',
				';DS/CONSULT;',
				'puce_orange.gif',
				'SELECT id_ds FROM R_FIN_DS WHERE id_ds=#id_ds# AND ds_type=''4'' AND FINDS_EDD_Type = ''LOAD'' AND EDD_Load_State = ''Proposed to Validation''')
END

------------------------------------------------------------------------
-- Add new feature "Downgrade EDD LOAD"
------------------------------------------------------------------------
IF (NOT EXISTS(	SELECT * FROM T_FEATURE
					WHERE label = 'Downgrade EDD LOAD')
) BEGIN
	INSERT INTO T_FEATURE (label, description, idr_feature_group, linked_url, display_context, icon, where_clause)
		VALUES ('Downgrade EDD LOAD',
				'Downgrade EDD LOAD',
				'5',
				'/BUSINESS_OBJECTS/DS/EDD/Update/EDD_Update_Status_Process.php?id_ds=#id_ds#&update_type=downgrade',
				';DS/CONSULT;',
				'puce_orange.gif',
				'SELECT id_ds FROM R_FIN_DS WHERE id_ds=#id_ds# AND ds_type=''4'' AND FINDS_EDD_Type = ''LOAD'' AND EDD_Load_State = ''Proposed to Validation''')
END

------------------------------------------------------------------------
-- Add new feature "Downgrade EDD LOAD Validated"
------------------------------------------------------------------------
IF (NOT EXISTS(	SELECT * FROM T_FEATURE
					WHERE label = 'Downgrade EDD LOAD Validated')
) BEGIN
	INSERT INTO T_FEATURE (label, description, idr_feature_group, linked_url, display_context, icon, where_clause)
		VALUES ('Downgrade EDD LOAD Validated',
				'Downgrade EDD LOAD Validated',
				'5',
				'/BUSINESS_OBJECTS/DS/EDD/Update/EDD_Update_Status_Process.php?id_ds=#id_ds#&update_type=downgrade',
				';DS/CONSULT;',
				'puce_orange.gif',
				'SELECT id_ds FROM R_FIN_DS WHERE id_ds=#id_ds# AND ds_type=''4'' AND FINDS_EDD_Type = ''LOAD'' AND EDD_Load_State = ''Validated''')
END

------------------------------------------------------------------------
-- Add new feature "Link FIN CI P/CD"
------------------------------------------------------------------------
IF (NOT EXISTS(	SELECT * FROM T_FEATURE
					WHERE label = 'Link FIN CI P/CD')
) BEGIN
	INSERT INTO T_FEATURE (label, description, idr_feature_group, linked_url, display_context, icon, where_clause)
		VALUES ('Link FIN CI P/CD',
				'Link FIN CI P/CD',
				'5',
				'/BUSINESS_OBJECTS/CI/Link/CI_LinkFin_Form.php?id_fin=#id_fin#',
				';CI/CONSULT;',
				'puce_orange.gif',
				'SELECT * FROM R_FIN_CI WHERE FINCategory = ''LOAD GROUP'' AND id_fin NOT IN (SELECT id_fin_link FROM R_FIN_LINK) AND id_fin=#id_fin#')
END

------------------------------------------------------------------------
-- Add new feature "Unlink FIN CI P/CD"
------------------------------------------------------------------------
IF (NOT EXISTS(	SELECT * FROM T_FEATURE
					WHERE label = 'Unlink FIN CI P/CD')
) BEGIN
	INSERT INTO T_FEATURE (label, description, idr_feature_group, linked_url, display_context, icon, where_clause)
		VALUES ('Unlink FIN CI P/CD',
				'Unlink FIN CI P/CD',
				'5',
				'/BUSINESS_OBJECTS/CI/Link/CI_LinkFin_Process.php?id_fin=#id_fin#&type=unlink',
				';CI/CONSULT;',
				'puce_orange.gif',
				'SELECT * FROM R_FIN_CI WHERE FINCategory = ''LOAD GROUP'' AND id_fin IN (SELECT id_fin_link FROM R_FIN_LINK) AND id_fin=#id_fin#')
END

------------------------------------------------------------------------
-- Add new feature "Copy from another EDD LOAD"
------------------------------------------------------------------------
IF (NOT EXISTS(	SELECT * FROM T_FEATURE
					WHERE label = 'Copy from another EDD LOAD'))
BEGIN
	INSERT INTO T_FEATURE (label, description, idr_feature_group, linked_url, display_context, icon, where_clause)
		VALUES ('Copy from another EDD LOAD',
				'Copy from another EDD LOAD',
				'5',
				'/BUSINESS_OBJECTS/DS/EDD/Duplicate/TRUTH_TABLE/EDD_TruthTable_Duplicate_Form.php?id_ds=#id_ds#',
				';DS/CONSULT;',
				'puce_orange.gif',
				'SELECT id_ds FROM R_FIN_DS WHERE id_ds = #id_ds# AND FINDS_EDD_Type = ''LOAD'' AND ds_type = ''4'' AND EDD_Load_State IN (''In elaboration'',''Proposed to Validation'')')
END

------------------------------------------------------------------------
-- Ajout Feature "Create EDD Uninstall" --> ElcodataSD-Uninstall_Functions-005
------------------------------------------------------------------------
if not exists (SELECT * FROM T_FEATURE WHERE label = 'Create EDD Uninstall')
Begin
INSERT INTO T_feature (label,
			description,
			display_order,
			linked_url,
			DSType,
			display_context,
			is_PopUp,
			popup_description,
			popup_name,
			is_displayed_separated,
			icon,
			where_clause,
			idr_feature_group)
	SELECT 'Create EDD Uninstall',
			'Create EDD Uninstall',
			'20',
			'BUSINESS_OBJECTS/DS/EDD/creation/EDD_Creation_Form.php?edd_type=uninstall',
			null,
			';HOME;CI/CONSULT;;DS/CONSULT;',
			null,
			null,
			null,
			null,
			'puce_orange.gif',
			null,
			id_feature_group from t_feature_group where label='CONFIGURATION MANAGEMENT'
End

------------------------------------------------------------------------
-- Ajout Feature "Edit Operation Table"
------------------------------------------------------------------------
if not exists (SELECT * FROM T_FEATURE WHERE label = 'Edit Operation Table')
Begin
INSERT INTO T_feature (label,
			description,
			display_order,
			linked_url,
			DSType,
			display_context,
			is_PopUp,
			popup_description,
			popup_name,
			is_displayed_separated,
			icon,
			where_clause,
			idr_feature_group)
	SELECT 'Edit Operation Table',
			'Edit Operation Table',
			'30',
			'BUSINESS_OBJECTS/CI/OPERATION_TABLE/edit/OPERATION_TABLE_update_Form.php?id_fin=#id_fin#',
			null,
			';CI/CONSULT;',
			null,
			null,
			null,
			null,
			'puce_orange.gif',
			'SELECT id_fin FROM R_FIN_CI WHERE id_fin=#id_fin# AND FinCategory=''LOAD GROUP''',
			id_feature_group from t_feature_group where label='MANAGEMENT'
End


/***********************************/
-- Ajout Feature "Smart Edit"

if not exists (SELECT * FROM T_FEATURE WHERE label = 'Smart Edit')
Begin
INSERT INTO T_feature (label,
			description,
			display_order,
			linked_url,
			DSType,
			display_context,
			is_PopUp,
			popup_description,
			popup_name,
			is_displayed_separated,
			icon,
			where_clause,
			idr_feature_group)
	SELECT 'Smart Edit',
			'Smart Edit',
			'30',
			'BUSINESS_OBJECTS/CI/OPERATION_TABLE/edit/SMART_EDIT_search_form.php?id_fin=#id_fin#',
			null,
			';CI/CONSULT;',
			null,
			null,
			null,
			null,
			'puce_orange.gif',
			'SELECT id_fin FROM R_FIN_CI WHERE id_fin=#id_fin# AND FinCategory=''LOAD GROUP''',
			id_feature_group from t_feature_group where label='MANAGEMENT'

End





