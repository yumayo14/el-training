import axios from 'axios';

/**
 * 各リクエストの際、必要な設定をしたaxiosを返す関数。
 * @param {boolean} withCsrf CSRFトークンを埋め込むかどうか
 * @param {boolean} withCookie withCredentials オプションをtrueにするかどうか
 * @return {axios} CSRFトークンをリクエストヘッダに含めたaxiosを返す
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
