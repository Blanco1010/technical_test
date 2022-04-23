import 'package:google_maps_flutter/google_maps_flutter.dart';

class Environment {
  static const String token =
      "Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOnsidXNlcl9pZCI6IjI5Nzk4NGIzLTQ1NDMtNDhmMC1hMTkxLTdlN2UwMWVjMWRjOCIsInVzZXJfdHlwZSI6IkFETUlOIiwicHVzaGVyX2NoYW5uZWwiOiJBRE1JTl8yOTc5ODRiMy00NTQzLTQ4ZjAtYTE5MS03ZTdlMDFlYzFkYzgifSwiaWF0IjoxNjQ0ODU5MjE3LCJleHAiOjE2NTQwNTk1OTl9.3ximsrIe4RlcXBDrVpoj7XlvhIJsLVpXEPXA42x6YeI";

  static const String url = "us-central1-adomi-dev.cloudfunctions.net";

  static const String cityId = "c1e4bcc9-eb84-4653-872c-e38f8de4bf79";

  static const LatLng pos = LatLng(4.545367057195659, -76.09435558319092);

  static const bool coverageRadio = true;
}
