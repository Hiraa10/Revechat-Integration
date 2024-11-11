package com.example.flutter_app_one

import android.content.Intent
import com.revesoft.revechatsdk.model.VisitorInfo
import com.revesoft.revechatsdk.service.REVEChatApiService
import com.revesoft.revechatsdk.state.LoginState
import com.revesoft.revechatsdk.ui.activity.ReveChatActivity
import com.revesoft.revechatsdk.utils.ReveChat
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel


class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.app/activity"



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "openActivity") {
                val visitorName = call.argument<String>("visitorName")
                val visitorEmail = call.argument<String>("visitorEmail")
                val visitorNumber = call.argument<String>("visitorNumber")
                if (visitorName != null && visitorEmail != null && visitorNumber != null) {
                    openActivity(visitorName, visitorEmail, visitorNumber)
                    result.success(null)
                } else {
                    result.error("INVALID_ARGUMENTS", "Missing arguments", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onDestroy() {
        super.onDestroy()
        if (!REVEChatApiService.isCallRunning())
            stopService(Intent(this, REVEChatApiService::class.java))
    }

    private fun openActivity(visitorName: String, visitorEmail: String, visitorNumber: String) {
        ReveChat.init("6899443")
        val loginState : LoginState = LoginState.LOGGED_OUT
        val visitorInfo: VisitorInfo = VisitorInfo.Builder()
            .name(visitorName)
            .email(visitorEmail)
            .phoneNumber(visitorNumber)
            .appLoginState(loginState)
            .build()
        ReveChat.setVisitorInfo(visitorInfo)


        startActivity(Intent(this, ReveChatActivity::class.java))
        startService(Intent(this, REVEChatApiService::class.java))
    }
}


