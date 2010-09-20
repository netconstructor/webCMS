/*
Copyright (c) 2003-2010, CKSource - Frederico Knabben. All rights reserved.
For licensing, see LICENSE.html or http://ckeditor.com/license
*/

CKEDITOR.editorConfig = function( config )
{
  config.PreserveSessionOnFileBrowser = true;
  // Define changes to default configuration here. For example:
  config.language = 'en';
  config.uiColor = '#CCCCCC';

  //config.ContextMenu = ['Generic','Anchor','Flash','Select','Textarea','Checkbox','Radio','TextField','HiddenField','ImageButton','Button','BulletedList','NumberedList','Table','Form'] ; 
  
	config.filebrowserImageWindowHeight = '600, scrollbars=yes';
  
  //config.resize_enabled = false;
  //config.resize_maxHeight = 2000;
  //config.resize_maxWidth = 750;
  
  //config.startupFocus = true;
  
  // works only with en, ru, uk languages
	//	var dialogName = config.data.name;
	//	var dialogDefinition = config.data.definition;
	//config.extraPlugins = "attachment";
  config.resize_enabled = false;
	config.toolbarCanCollapse = false;
  config.toolbar = 'Easy';
  config.toolbar_Easy =
    [
        ['PasteFromWord','Maximize', 'Undo','Redo', 'Format'],
        ['Bold','Italic','Underline','Strike','-','Subscript','Superscript', 'TextColor'],
        ['NumberedList','BulletedList','-','Outdent','Indent'],
        ['JustifyLeft','JustifyCenter','JustifyRight','JustifyBlock'],
        ['Link','Unlink'],
				['Table','HorizontalRule','SpecialChar'],
				['Image']
    ];
};