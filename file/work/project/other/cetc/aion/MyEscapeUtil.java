package com.hd.rcugrc.product.oa.common.util;


public class MyEscapeUtil{

	//编码
	public static String escape(String psText){
		int i; 
		char j; 
		StringBuffer tmp = new StringBuffer(); 
		tmp.ensureCapacity(psText.length()*6); 
		
		for (i = 0; i < psText.length(); i++ ){ 
			j = psText.charAt(i); 

			if (Character.isDigit(j) || Character.isLowerCase(j) || Character.isUpperCase(j)){ 
	           tmp.append(j); 
			}else{
				if (j < 256){ 
					tmp.append( "%" );
					
					if (j < 16){
						tmp.append( "0" );
					}
					tmp.append( Integer.toString(j,16) ); 
				}else{ 
					tmp.append( "%u" );
					tmp.append( Integer.toString(j,16) ); 
				}
			}
		}
		
	    return tmp.toString();
	}

	//解码
	public static String unescape (String psText) {
		StringBuffer tmp = new StringBuffer(); 
		tmp.ensureCapacity(psText.length());
		int iLastPos = 0;
		int iPos = 0; 
		char ch; 

		while (iLastPos < psText.length()){ 
			iPos = psText.indexOf("%",iLastPos); 
			
			if (iPos == iLastPos){ 
				if (psText.charAt(iPos + 1) == 'u'){ 
					ch = (char)Integer.parseInt(psText.substring(iPos + 2,iPos + 6),16); 
	                tmp.append(ch); 
	                iLastPos = iPos + 6;  
				}else{ 
	                ch = (char)Integer.parseInt(psText.substring(iPos + 1,iPos + 3),16); 
	                tmp.append(ch);
	                iLastPos = iPos + 3; 
				}
			}else{ 
				if (iPos == -1){
					tmp.append(psText.substring(iLastPos));
					iLastPos = psText.length(); 
				}else{     
					tmp.append(psText.substring(iLastPos,iPos)); 
					iLastPos = iPos;
				} 
			}
		} 
		
		return tmp.toString();
	} 
}
