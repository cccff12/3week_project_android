import android.app.Service;
import android.content.Intent;
import android.os.IBinder;

/// 안드로이드 스튜디오에서 <service android:name=".SttService" /> 이걸
// 추가했으니 여기서 보내야 거기서 받을 수 있음
public class SttService extends Service {
   
    @Override
    public IBinder onBind(Intent intent) {
        return null;
    }
}