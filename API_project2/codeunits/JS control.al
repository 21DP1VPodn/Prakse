controladdin Test
{
    Scripts = 'scripts\demo.js',
    'scripts\lib.js';

    StartupScript = 'scripts\startup.js';

    StyleSheets = 'Styles\demo.css';

    RequestedWidth = 800;
    RequestedHeight = 400;

    event OnControlReady();

    event OnInvoke(Context: JsonObject);

    procedure OnInvokeResult(Reslut: JsonObject);
}