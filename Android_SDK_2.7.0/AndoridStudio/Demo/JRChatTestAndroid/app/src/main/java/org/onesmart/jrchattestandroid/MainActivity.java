package org.onesmart.jrchattestandroid;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import com.sobot.chat.SobotApi;
import com.sobot.chat.api.model.Information;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        this.findViewById(R.id.chatId).setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Information info = new Information();
                info.setAppkey("d7ab4728ed784260b5655fce924a75e0");  //分配给App的的密钥

                SobotApi.startSobotChat(MainActivity.this, info);
            }
        });

    }
}
