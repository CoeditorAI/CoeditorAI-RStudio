function(response) {
  response |>
    httptest2::gsub_response("https://coeditorai.com/api/v1",
                             replacement = "",
                             fixed       = TRUE) |>
    httptest2::gsub_response('"user_uid":.*?],',
                             '"user_uid": \\["redacted"\\],') |>
    httptest2::gsub_response('"session_uid":.*?],',
                             '"session_uid": \\["redacted"\\],') |>
    httptest2::gsub_response('"hashed_cookie":.*?],',
                             '"hashed_cookie": \\["redacted"\\],') |>
    httptest2::gsub_response('"email":.*?],',
                             '"email": \\["redacted"\\],')
}
