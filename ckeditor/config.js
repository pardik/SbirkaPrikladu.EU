CKEDITOR.editorConfig = function (config) {    
    // http://docs.cksource.com/ckeditor_api/symbols/CKEDITOR.html - manual nastaveni
    config.language = 'cs';
    config.uiColor = '#eee';
    config.filebrowserImageBrowseUrl = '/ckeditor/photogalleryBrowser.aspx';
    config.filebrowserFlashBrowseUrl = '/ckeditor/photogalleryBrowser.aspx';
    config.filebrowserWindowWidth = 1020;
    config.filebrowserWindowHeight = 680;
    config.baseFloatZIndex = 100000;
    config.enterMode = CKEDITOR.ENTER_BR;
    config.shiftEnterMode = CKEDITOR.ENTER_P;

    
    // Add WIRIS to the plugin list
    config.extraPlugins += (config.extraPlugins.length == 0 ? '' : ',') + 'ckeditor_wiris';

    // Add WIRIS buttons to the "Full toolbar"
    // Optionally, you can remove the following line and follow
    // http://docs.cksource.com/CKEditor_3.x/Developers_Guide/Toolbar    
    config.toolbar_Full.push({ name: 'wiris', items: ['ckeditor_wiris_formulaEditor', 'ckeditor_wiris_CAS'] });    

    config.toolbar_Full =
    [    
    ['Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord'],
    ['Undo', 'Redo', '-', 'Find', 'Replace', '-', 'SelectAll', 'RemoveFormat'],
    ['BidiLtr', 'BidiRtl'],    
    ['Maximize', 'ShowBlocks'], ['ckeditor_wiris_formulaEditor'],
    '/',
    ['Bold', 'Italic', 'Underline', 'Strike', '-', 'Subscript', 'Superscript'],
    ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
    ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'Image', 'Table'],    
    ['Link', 'Unlink']
    ];    
}