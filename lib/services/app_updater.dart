import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:note_warden/models/github_response.dart';
import 'package:note_warden/view/widgets/bottom_sheets/app_release_info_sheet.dart';
import 'package:url_launcher/url_launcher.dart';

class AppUpdater {
  final http.Client client;
  final String curVersion;
  String md = "", version = "";

  AppUpdater(this.client, this.curVersion);

  void check(String repo, bool isReceivingBeta, BuildContext context) async {
    if (isReceivingBeta) {
      final response = await client
          .get(Uri.parse("https://api.github.com/repos/$repo/releases"));
      // print(response.body);
      final releasesData = json.decode(response.body) as List<dynamic>;
      final releases = releasesData
          .map((release) => GithubResponse.fromJson(release))
          .toList();

      GithubResponse? r;
      try {
        r = releases.where((item) => item.prerelease).reduce(
            (currentMax, item) =>
                currentMax.timeStamp() > item.timeStamp() ? currentMax : item);
      } catch (e) {
        updateStableVersion(repo);
      }

      var v = r!.tagName.split("v").last;

      md = r.body ?? "";
      if (v.isEmpty) {
        throw Exception("Weird version : ${r.tagName}");
      } else {
        version = v;
      }
    } else {
      // No prelease found so update to stable release
      updateStableVersion(repo);
    }

    if (compareVersion(version, curVersion)) {
      showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          showDragHandle: true,
          builder: (context) => AppReleaseInfoSheet(
              version, md, () => downloadAPK(repo, version)));
    }
  }

  double toDouble(List<String> list) {
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

  bool compareVersion(String newVersion, String currentVersion) {
    List<String> newVersionList = newVersion.split(".");
    List<String> currentVersionList = currentVersion.split(".");

    double newVersionValue = toDouble(newVersionList);
    double currentVersionValue = toDouble(currentVersionList);

    return newVersionValue > currentVersionValue;
  }

  void downloadAPK(String repo, String version) async {
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

  void updateStableVersion(String repo) async {
    final response = await client.get(
        Uri.parse("https://raw.githubusercontent.com/$repo/master/stable.md"));
    final res = response.body;
    md = res;
    version = res.substring(res.indexOf("# ") + 1, res.indexOf("\n"));
  }
}
