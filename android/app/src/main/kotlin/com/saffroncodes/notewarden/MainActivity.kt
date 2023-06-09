package com.saffroncodes.notewarden

import android.content.Intent
import android.net.Uri
import android.os.Bundle
import android.os.Parcelable
import android.provider.MediaStore
import android.util.Log
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugins.GeneratedPluginRegistrant

class MainActivity: FlutterActivity() {
    private val CHANNEL:String = "com.notewarden/share"
    private var sharedImagePath:String? = null


    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val action:String? = intent.action
        val type:String? = intent.type


        if(Intent.ACTION_SEND == action && type != null){
            if(type.startsWith("image/")){
                Log.i("IMAGE_PATH","Handling Image")
                handleSharedImage(intent)
            }
        }
    }



    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        GeneratedPluginRegistrant.registerWith(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "handleImage") {
                result.success(sharedImagePath)
                sharedImagePath = null
            }
        }

    }

    private fun handleSharedImage(intent: Intent) {
        /*
        val selectedImageUri: Uri? = intent.getParcelableExtra(Intent.EXTRA_STREAM)
        val imagePath: String? = selectedImageUri?.let { getImagePathFromUri(it) }

        if (imagePath != null) {
            sharedImagePath = imagePath
        }
         */
        val selectedImageUri = intent.getParcelableExtra<Parcelable>(Intent.EXTRA_STREAM) as? Uri
        val selectedImagePath = selectedImageUri?.let { uri ->
            val filePathColumn = arrayOf(MediaStore.Images.Media.DATA)
            val cursor = contentResolver.query(uri, filePathColumn, null, null, null)
            cursor?.use {
                it.moveToFirst()
                val columnIndex = it.getColumnIndexOrThrow(MediaStore.Images.Media.DATA)
                it.getString(columnIndex)
            }
        }
        /*
        selectedImagePath?.let {
            Log.i("WARDEN", it)
            sharedImagePath = it
        }
         */
        sharedImagePath = selectedImagePath

    }

}

