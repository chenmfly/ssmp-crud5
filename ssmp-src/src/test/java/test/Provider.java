package test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class Provider {
    public static void main(String[] args) throws Exception {
        ClassPathXmlApplicationContext context = new ClassPathXmlApplicationContext(new String[] {"META-INF/spring/orders-provider.xml"});
        context.start();
        System.out.println("服务已启动-->");
        System.in.read();
    }
}
