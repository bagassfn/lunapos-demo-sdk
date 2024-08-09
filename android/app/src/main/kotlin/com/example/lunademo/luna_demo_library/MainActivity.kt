package com.example.lunademo.luna_demo_library

import android.content.Intent
import com.lunapos.poslite.LunaConstant
import com.lunapos.poslite.LunaMainActivity
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val channel = "example.com/native-code-example"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            if (call.method == "startPos") {
                val firstName = call.argument<String>("firstName")
                val lastName = call.argument<String>("lastName")
                val email = call.argument<String>("email")
                val phone = call.argument<String>("phone")

                startLunaPos(firstName, lastName, email, phone)
                result.success(true)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startLunaPos(firstName: String?, lastName: String?, email: String?, phone: String?) {
        val intent = Intent(applicationContext, LunaMainActivity::class.java)
        intent.apply {
            putExtra(LunaConstant.EXTRA_FIRST_NAME, firstName)
            putExtra(LunaConstant.EXTRA_LAST_NAME, lastName)
            putExtra(LunaConstant.EXTRA_EMAIL, email)

            // Nomor handphone dikirim tanpa awalan "0" (nol)
            putExtra(LunaConstant.EXTRA_PHONE_NUMBER, phone)
        }
        startActivity(intent)
    }
}
