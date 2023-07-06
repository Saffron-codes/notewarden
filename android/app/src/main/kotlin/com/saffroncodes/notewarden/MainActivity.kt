package com.saffroncodes.notewarden

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL:String = "com.notewarden"
    private val inviteFriendsTxt = "Organize and save your notes on the go with Note Warden \n Install the app now \n https://github.com/saffron-codes/note_warden"



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

    }



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if(call.method == "getApiLevel"){
                val apiLevel = android.os.Build.VERSION.SDK_INT
                result.success(apiLevel)
            }
            else if(call.method == "openPDF") {
                //val filePath = call.argument<String>("filePath")
                // openPDF(filePath)
                result.success(null)
            }
            else if(call.method == "inviteFriends") {
                shareText(context)
            }
            else {
                result.notImplemented()
            }
        }

    }

    private fun openFile(filePath: String?) {
        val fileUri = Uri.parse(filePath)
        val intent = Intent(Intent.ACTION_VIEW)
        intent.setDataAndType(fileUri, "application/pdf")
        intent.addFlags(Intent.FLAG_GRANT_READ_URI_PERMISSION)
        startActivity(intent)
    }

    private fun shareText(context: Context) {
        val shareIntent = Intent(Intent.ACTION_SEND)
        shareIntent.type = "text/plain"
        shareIntent.putExtra(Intent.EXTRA_TEXT, inviteFriendsTxt)
        context.startActivity(Intent.createChooser(shareIntent, "Share via"))
    }
}

