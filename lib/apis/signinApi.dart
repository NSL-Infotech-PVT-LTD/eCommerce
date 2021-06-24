import 'dart:convert';

import 'package:funfy/utils/urls.dart';
import 'package:http/http.dart' as http;

Future signinUser({String? email, String? password, String? devicetype}) async {
  String _token =
      "eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjA5Zjg5ZTVjM2E2MzMyNjgwODFkZTk2NzgxNzQ1MThlNWY0YzU0Y2FhOTQ1YmM5MzI1NWM0YWQ0NjQ5MGJiMjkyYjYyNmMyYmJlYjJlNGMxIn0.eyJhdWQiOiIxIiwianRpIjoiMDlmODllNWMzYTYzMzI2ODA4MWRlOTY3ODE3NDUxOGU1ZjRjNTRjYWE5NDViYzkzMjU1YzRhZDQ2NDkwYmIyOTJiNjI2YzJiYmViMmU0YzEiLCJpYXQiOjE2MjQ1MjY0NDQsIm5iZiI6MTYyNDUyNjQ0NCwiZXhwIjoxNjU2MDYyNDQ0LCJzdWIiOiIxIiwic2NvcGVzIjpbXX0.u9B_xBDDYnakpG216XO4gj00JwD5tniwykBceknEywAT7vuwMnrCFJCY1pt0B4OILDeJxo2g888UTEZcbUQOaFkNrqgTvXbBuanknVerdhl4F5iFQI6rjqgPhkqNMiy-zWcKaEP5EFy29JMVrTkH5kkrlRKiB0H156IV9lj_Uctk6MAe1_dLctlcIOgt1NupOXwKwOXmhg7Rgg8Ur_hLE6nfyJzSjXJK2bdLR60tabr0V_q1neW8PV26Q2wGaowmiLV5OtslnwOFElKYyYAigIIzeAH3DwY7aHc2pb-Aq0nEZte4xiTpNnLkogtCdtiBsZsfmlmG1H_plUukwnB1pNXx74qU_8tYKZpYPtMi_6pCo2amcUdgWLZ7_t7Io8mnuNWjPemrOiUNIAoa9dJ6mwSlWB96H6B259DRyxMxDW53qgOqbDsEuundQxDmBEMqVIFuJlL6stoL6qmKHdmZAeiJ6p1qpKt-BL_Xdz00fM8siR0QQEw6dyBdR6RLNudH9B5RjY7ENACpvrLlaWzLFmad3R1i-0Ti_qg7ndnF3YokMMOcny54rvwNoQLAS6HHZ3qRXiE73yOzU8scF-4nF4O4zYEklmj1W_CWIw9usSafomiuGQ0QiDvdWuEJJKogppHl1e-_x9E8hAXWX8KD8DI_0ju2iIRtrlTMDZYfxto";
  var body = {
    "email": email,
    "password": password,
    "device_type": devicetype,
    "device_token": _token
  };
  var res = await http.post(Uri.parse(Urls.siginUrl), body: body);

  var response = json.decode(res.body);

  if (response["status"] == true && response["code"] == 200) {
    return response;
  }

  return false;
}
