function getAlMethod (name)
{
    return function(...args) {

        let result;
        window["OnInvokeResult"] = function(Alresult)
        {
            result = Alresult;
        }

        return new Promise(function(resolve){
            Microsoft.Dynamics.NAV.InvokeExtensibilityMethod(name, args, false, () => {
                delete window.OnInvokeResult;
                resolve(result)
            });
        })
    }
}