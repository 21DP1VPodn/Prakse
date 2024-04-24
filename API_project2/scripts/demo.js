const invokeAl = getAlMethod("OnInvoke");

function AL(name)
{
    return 'Hello ' + name + '!'; 
}

function initialize()
{
    let root = document.getElementById('controlAddIn');
    let button = document.createElement('button');
    button.innerText = 'Invoke AL';
    root.appendChild(button);
    button.addEventListener('click', click);
}

async function click()
{ 
    const invokeAl = getAlMethod("OnInvoke");
    let result = await invokeAl('Vlad');
    alert(result);
}

function OnInvokeResult(result)
{
    alert('AL invokes OnInvokeResult: ' + result);
}