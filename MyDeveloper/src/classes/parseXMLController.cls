public class parseXMLController {
	
	public String textToParse{get;set;}
	public String parsedText{get;set;}
	
	public PageReference parse(){
		
		DOM.Document doc = new DOM.Document();
		try{
			doc.load(textToParse);
			DOM.Xmlnode root = doc.getRootElement();
			parsedText = walkThrough(root);
			
		}catch(System.XMLException e){
			Apexpages.addMessage(new Apexpages.Message(Apexpages.Severity.ERROR, e.getMessage()));
		}
		
		return null;
		
	}
	
	private String walkThrough(DOM.XMLNode node){
		
		String result = '\n';
		
		if(node.getNodeType() == DOM.Xmlnodetype.COMMENT){
			return 'Comment(' + node.getText() + ')';
		}
		
		if(node.getNodeType() == DOM.Xmlnodetype.TEXT){
			return 'Text(' + node.getText() + ')';
		}
		
		if(node.getNodeType() == DOM.Xmlnodetype.ELEMENT){
			result += 'Element: ' + node.getName();
			if(node.getText().trim() != ''){
				result += ', text=' + node.getText().trim();
			} 
			if(node.getAttributeCount() > 0){
				for(Integer i=0; i< node.getAttributeCount(); i++){
					result += ', attribute #' + i + ':' + node.getAttributeKeyAt(i) + '=' +
							  node.getAttributeValue(node.getAttributeKeyAt(i), node.getAttributeKeyNsAt(i));
				}
			}
			
			for(DOM.Xmlnode child : node.getChildElements()){
				result += walkThrough(child);
			}
			
			return result;
		}
		
		return '';
		
	}

}