package flatbuffertesting;

import java.util.concurrent.TimeUnit;
 
import org.jeromq.ZMQ;
import org.jeromq.ZMQ.Context;
import org.jeromq.ZMQ.Socket;
 
//https://github.com/miniway/jeromq/tree/master/src/test/java/guide
public class Sub { // Used to be Wuserver
    static final int NUM_MSG = 1000000;
    static final String TOPIC = "topic1";
    public static void main(String[] args) throws Exception {
        long bTime = System.currentTimeMillis();
 
        // Prepare our context and subscriber
        Context context = ZMQ.context(1);
        Socket subscriber = context.socket(ZMQ.SUB);
 
        subscriber.connect("tcp://127.0.0.1:5563");
        subscriber.setRcvHWM(1000000);
        subscriber.subscribe(TOPIC.getBytes());
        System.out.println("subscribed to  "+TOPIC);
        int c = 0;
        while (true) {
            String msg = subscriber.recvStr();
            if(msg.startsWith("message")){
                c++;
                System.out.println(c + msg);
                // logBenchMark();
                if (c >= NUM_MSG) {
                    break;
                }
            }
        }
        long secs = TimeUnit.MILLISECONDS.toSeconds(System.currentTimeMillis()- bTime);
        System.out.println("Wuserver done at " + c + " in " + secs + " seconds");
        //showCounterMap.run();
        subscriber.close();
        Thread.sleep(1000);
        context.term();
        System.exit(1);
    }
}