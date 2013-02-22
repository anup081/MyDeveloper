public class PdfGenerator {

List<Account> accs;

public PdfGenerator(){

    accs = [select id, Name, AnnualRevenue, Phone, Industry, Ownership from Account];

}

public List<Account> getAccs(){
    return accs;

}

}