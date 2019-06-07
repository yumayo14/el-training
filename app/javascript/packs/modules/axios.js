import axios from 'axios';

/**
 * 各リクエストの際、必要な設定をしたaxiosを返す関数。
 * @param {object} settingParams withCsrf(CSRFトークンを埋め込むか)とwithCookie（withCredentialsオプションをtrueにするか）というキーで
 *                               boolean型のデータが入っている
 * @return {axios} settingParamsの値に応じて設定されたaxiosを返す
 */
function prepareAxios(settingParams) {
  const axiosConfiguration = {};
  const headersOption = {'X-Requested-With': 'XMLHttpRequest'};

  if (settingParams['withCsrf']) {
    headersOption['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }

  axiosConfiguration['headers'] = headersOption;
  axiosConfiguration['withCredentials'] = settingParams['withCookie'];

  return axios.create(axiosConfiguration);
}

export default prepareAxios;
