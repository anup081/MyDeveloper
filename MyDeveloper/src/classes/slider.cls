public class slider {
 
    Account d;        
 
    public slider(ApexPages.StandardController controller){        
        d = (Account)controller.getRecord();             
    }        
 
    public void save(){        
        update d;        
    }
}