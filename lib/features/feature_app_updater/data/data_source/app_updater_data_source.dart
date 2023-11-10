import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:note_warden/constants.dart';
import 'package:note_warden/features/feature_app_updater/domain/model/app_update_info.dart';
import 'package:note_warden/features/feature_app_updater/domain/model/github_response.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

abstract class AppUpdaterDataSource {
  Future<AppUpdateInfo> checkForUpdates();
  void downloadAPK();
  bool? isReceivingBeta();
}

class AppUpdaterDataSourceImpl implements AppUpdaterDataSource {
  final http.Client client;
  final PackageInfo packageInfo;
  final SharedPreferences sharedPreferences;
  late Logger logger;
  String md = "", version = "";

  AppUpdaterDataSourceImpl(
      this.client, this.packageInfo, this.sharedPreferences) {
    logger = Logger();
  }

  @override
  Future<AppUpdateInfo> checkForUpdates() async {
    String curVersion = packageInfo.version;
    final isReceivingBeta = sharedPreferences.getBool("beta_updates") ?? false;
    if (isReceivingBeta) {
      logger.i("Checking for Beta Update");
      final response = await client
          .get(Uri.parse("https://api.github.com/repos/$repo/releases"));
      final releasesData = json.decode(response.body) as List<dynamic>;
      final releases = releasesData
          .map((release) => GithubResponse.fromJson(release))
          .toList();

      // checking for preleases

      GithubResponse? r;
      try {
        r = releases.where((item) => item.prerelease).reduce(
            (currentMax, item) =>
                currentMax.timeStamp() > item.timeStamp() ? currentMax : item);
      } catch (e) {
        //updateStableVersion(repo);
      }

      if (r != null) {
        var v = r.tagName.split("v").last;

        md = r.body ?? "";
        if (v.isEmpty) {
          throw Exception("Weird version : ${r.tagName}");
        } else {
          version = v;
        }
      } else {
        // no preleases found so check for latest stable release
        logger.i("no preleases found so check for latest stable release");
        await updateStableVersion(repo);
      }
    } else {
      logger.i("Getting Stable Update");
      // No prelease found so update to stable release
      await updateStableVersion(repo);
    }

    logger.i("$version - $curVersion");

    final isNewVersion = compareVersion(version, curVersion);

    final data = {
      "version": version,
      "md": md,
      "current_version": curVersion,
      "is_new_version": isNewVersion
    };

    return AppUpdateInfo.fromJson(data);

    // if (compareVersion(version, curVersion)) {
    //
    //   // showModalBottomSheet(
    //   //     context: context,
    //   //     isScrollControlled: true,
    //   //     showDragHandle: true,
    //   //     builder: (context) => AppReleaseInfoSheet(
    //   //         version, md, () => downloadAPK(repo, version)));
    // }
  }

  static double toDouble(List<String> list) {
    double result = 0;
    for (int i = 0; i < list.length; i++) {
      switch (i) {
        case 0:
          result += double.parse(list[i]) * 100;
          break;
        case 1:
          result += double.parse(list[i]) * 10;
          break;
        case 2:
          result += double.parse(list[i]);
          break;
        default:
          result += double.tryParse(list[i]) ?? 0.0;
          break;
      }
    }
    return result;
  }

  static bool compareVersion(String newVersion, String currentVersion) {
    List<String> newVersionList = newVersion.split(".");
    List<String> currentVersionList = currentVersion.split(".");

    double newVersionValue = toDouble(newVersionList);
    double currentVersionValue = toDouble(currentVersionList);

    return newVersionValue > currentVersionValue;
  }

  @override
  void downloadAPK() async {
    final res = await client.get(Uri.parse(
        "https://api.github.com/repos/$repo/releases/tags/v$version"));
    final gr = GithubResponse.fromJson(jsonDecode(res.body));
    for (var asset in gr.assets!) {
      if (asset.browserDownloadURL.endsWith("apk")) {
        launchUrl(Uri.parse(asset.browserDownloadURL),
            mode: LaunchMode.externalApplication);
      }
    }
  }

  Future<void> updateStableVersion(String repo) async {
    final response = await client.get(
        Uri.parse("https://raw.githubusercontent.com/$repo/master/stable.md"));
    final res = response.body;
    md = res;
    version = res.substring(res.indexOf("#") + 1, res.indexOf("\n")).trim();
  }

  @override
  bool? isReceivingBeta() {
    return sharedPreferences.getBool("beta_updates");
  }
}
