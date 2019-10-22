import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

/**
 * ʹ�ó�������������Ȩ����
 * 1.ɾ��Java,js,CSS�����е�ע��
 * 2.д��Ŀ���ļ���
 *
 * @author lichuang
 * @build 2019-3-26
 */
public class GenerateHDSoftCopyrightFile {

	public static void main(String[] args) {
    	/*
    	 * ʹ��˵����
    	 * 1.�����Դ�뿽����һ��Ŀ¼��
    	 * 2.�޸�codeFilePathΪԴ��·��λ��
    	 * 3.�ڸ�Ŀ¼�»�����out.txt�ļ���ֱ�ӿ���out.txt�ļ���word�м���
    	 */
    	String codeFilePath="D:\\dev\\rcu\\GRCOfficeV8\\GRCOffice-v8\\src\\product\\src\\main\\webapp\\resources\\oa\\emtest"; 	
    	String outFilePath=codeFilePath+"\\out.txt";
    	String charset =  "UTF-8";
    	try {
			outFile = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(outFilePath),charset));
			File file = new File(codeFilePath);
	    	clearCommentAndCombineToFile(file,charset);
	    	outFile.flush();             
	    	outFile.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
        // ɾ��ĳ�������ļ���ע��
    }
	
	
	
    private static int count = 0;

    private static BufferedWriter outFile = null;
    public static void clearCommentAndCombineToFile(File file, String charset) {

    	 try {
             // �ݹ鴦���ļ���
             if (!file.exists()) {
                 return;
             }

             if (file.isDirectory()) {
                 File[] files = file.listFiles();
                 for (File f : files) {
                		 clearCommentAndCombineToFile(f, "UTF-8"); // �ݹ���� 
                 }
                 return;
             } else if (!file.getName().toLowerCase().endsWith(".java") && !file.getName().toLowerCase().endsWith(".js") && !file.getName().toLowerCase().endsWith(".css")) {
                 // ��java�ļ�ֱ�ӷ���
                 return;
             }
             System.out.println("-----��ʼ�����ļ���" + file.getAbsolutePath());

             // ���ݶ�Ӧ�ı����ʽ��ȡ
             BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), charset));
             StringBuffer content = new StringBuffer();
             String tmp = null;
             while ((tmp = reader.readLine()) != null) {
                 content.append(tmp);
                 content.append("\n");
             }
             String target = content.toString();
             // String s =
             // target.replaceAll("\\/\\/[^\\n]*|\\/\\*([^\\*^\\/]*|[\\*^\\/*]*|[^\\**\\/]*)*\\*\\/",
             // ""); //��������ժ�����ϣ���һ������޷����㣨/* ...**/���������޸�
             String s = target.replaceAll("\\/\\/[^\\n]*|\\/\\*([^\\*^\\/]*|[\\*^\\/*]*|[^\\**\\/]*)*\\*+\\/", "");
             // System.out.println(s);
             // ʹ�ö�Ӧ�ı����ʽ���
             BufferedWriter out = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), charset));
             out.write(s);
             out.flush();             
             out.close();
             outFile.write(s.replaceAll("(?m)^\\s*$(\\n|\\r\\n)", ""));
             count++;
             System.out.println("-----�ļ��������---" + count);
         } catch (Exception e) {
             e.printStackTrace();
         }
    }

    

}