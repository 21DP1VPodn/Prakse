function initialize()
{
    let root = document.getElementById('controlAddIn');
    let button = document.getElementById('button');
    button.innerText = 'Invoke AL';
    root.appendChild(button);
    button.addEventListener("click", click);
}

function click()
{
    Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(
    'OnInvoke', 
    [{name: Vlad}], 
    false, 
    () => alert('This message is from JS, AL is now done'));
}

function OnInvokeResult()
{
    alert('AL invokes OnInvokeResult');
}