public class sortTable {

    public List<String> fields{get; set;}
    public Account acc{get;set;}

    public sortTable(ApexPages.StandardController controller) {
            acc = (Account)controller.getRecord();
            fetchContactFields();
    }
    
    private void fetchContactFields(){
           fields = new List<String>();                
           fields.Add('');
            
    }

}