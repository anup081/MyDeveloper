public class MyController {

    public boolean isIPhone {get;set;}
    public boolean isIPad {get;set;}
    
    public MyController() {
         String userAgent = System.currentPageReference().getHeaders().get('User-Agent');
         String device = System.currentPageReference().getParameters().get('device');
         isIPhone = (userAgent.contains('iPhone') || device == 'mobile');
         isIPad = (userAgent.contains('iPad') ||
                  (userAgent.contains('AppleWebKit') && device != 'mobile'));
    }


}