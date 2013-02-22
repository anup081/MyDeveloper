global class MortgageCalculator implements Process.Plugin
{
    global Process.PluginResult invoke(Process.PluginRequest request)
    {
        Double amount = (Double)request.inputParameters.get('Amount');
        Double term = (Double)request.inputParameters.get('Term');
        // Magic here
        Double cMonthlyPayment;
        cMonthlyPayment=2750;
        Map<String, Object> result = new Map<String, Object>();
        result.put('MonthlyPayment', cMonthlyPayment);
        return new Process.PluginResult(result);
    }
    global Process.PluginDescribeResult describe()
    {
        Process.PluginDescribeResult result = new Process.PluginDescribeResult();
        result.description='This plug-in generates a monthly payment quote given the term and amount.';
        result.tag='Mortgage Quote';
        result.inputParameters = new List<Process.PluginDescribeResult.InputParameter> {
            new Process.PluginDescribeResult.InputParameter('Amount',
                Process.PluginDescribeResult.ParameterType.DOUBLE, true),
            new Process.PluginDescribeResult.InputParameter('Term',
                Process.PluginDescribeResult.ParameterType.DOUBLE, true)
        };
        result.outputParameters = new List<Process.PluginDescribeResult.OutputParameter> {
            new Process.PluginDescribeResult.OutputParameter('MonthlyPayment',
                Process.PluginDescribeResult.ParameterType.DOUBLE)
        };
        return result;
    }
    
    
    public static testmethod void testAll() 
    {
        MortgageCalculator plugin = new MortgageCalculator();
        Map<String,Object> inputParams = new Map<String,Object>();
        Double amount = 100000;
        Double term = 25;
        inputParams.put('Amount', amount);
        inputParams.put('Term', term);
        Process.PluginRequest request = new Process.PluginRequest(inputParams);
        Process.PluginResult aresult = Plugin.invoke(request);
        Double monthlyAmount = (Double) aresult.outputParameters.get('MonthlyPayment');
        System.assertEquals(monthlyAmount,2750);
        Process.PluginDescribeResult describe = plugin.describe();
        System.assertEquals(describe.InputParameters.size(), 2);
        System.assertEquals(describe.InputParameters[0].name, 'Amount');
        System.assertEquals(describe.InputParameters[1].name, 'Term');
        System.assertEquals(describe.OutputParameters.size(), 1);
        System.assertEquals(describe.OutputParameters[0].name, 'MonthlyPayment');
    }
}