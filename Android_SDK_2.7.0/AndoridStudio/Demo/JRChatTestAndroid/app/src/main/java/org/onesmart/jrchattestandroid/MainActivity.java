package org.onesmart.jrchattestandroid;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;

import com.sobot.chat.SobotApi;
import com.sobot.chat.SobotUIConfig;
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

                //默认false：显示转人工按钮。true：智能转人工
                info.setArtificialIntelligence(true);
                
                info.setAppkey("d7ab4728ed784260b5655fce924a75e0");  //分配给App的的密钥

                initUi();

                SobotApi.startSobotChat(MainActivity.this, info);
            }
        });

    }

    //自定义UI
    private void initUi() {

//        SobotUIConfig.sobot_serviceImgId = R.drawable.sobot_failed_normal;
//
//        SobotUIConfig.sobot_titleTextColor = R.color.sobot_color_evaluate_text_btn;
//
//        SobotUIConfig.sobot_moreBtnImgId  = R.drawable.sobot_btn_back_selector;
//
//        SobotUIConfig.sobot_titleBgColor = R.color.sobot_title_category_unselect_color;
//        SobotUIConfig.sobot_chat_bottom_bgColor = R.color.sobot_text_delete_hismsg_color;

//        SobotUIConfig.sobot_chat_left_textColor = R.color.sobot_text_delete_hismsg_color;
//        SobotUIConfig.sobot_chat_left_link_textColor = R.color.sobot_title_category_unselect_color;
//        SobotUIConfig.sobot_chat_left_bgColor = R.color.sobot_color_suggestion_history;
//
//        SobotUIConfig.sobot_chat_right_bgColor = R.color.sobot_title_category_unselect_color;
//        SobotUIConfig.sobot_chat_right_link_textColor = R.color.sobot_viewpagerbackground;
//        SobotUIConfig.sobot_chat_right_textColor = R.color.sobot_text_delete_hismsg_color;

//        SobotUIConfig.sobot_title_right_menu2_display = true;
//        SobotUIConfig.sobot_title_right_menu2_bg = R.drawable.sobot_failed_normal;



    }


}
