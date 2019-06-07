import axios from 'axios';

/**
 * 各リクエストの際、必要な設定をしたaxiosを返す関数。
 * @param {object} settingParams withCsrf(CSRFトークンを埋め込むか)とwithCookie（withCredentialsオプションをtrueにするか）というキーで
 *                               boolean型のデータが入っている
 * @return {axios} settingParamsの値に応じて設定されたaxiosを返す
 */
function prepareAxios(withCsrf, withCookie) {
  let headersOption = {};

  if (withCsrf) {
    headersOption = {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    };
  }

  return axios.create({
    headers: headersOption,
    withCredentials: withCookie,
  });
}

export default prepareAxios;
