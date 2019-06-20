import axios from 'axios';

/**
 * 各リクエストの際、必要な設定をしたaxiosでリクエストを投げる関数。
 * @param {object} settingParams method string型 (Httpリクエストのタイプ)
 *                               url string型 (リクエストのエンドポイント先)
 *                               requestParams Object() || null (リクエストを投げる際に必要なデータ。データが必要ない場合はnull)
 *                               withCsrf boolean型 (CSRFトークンを埋め込むかどうか)
 *                               withCookie boolean型 （withCredentialsオプションをtrueにするかどうか）
 *
 * @return {axios} s設定されたaxiosの投げたリクエストに対するレスポンスがPromiseオブジェクトとして返ってくる
 */
function requestByConfiguredAxios(settingParams) {
  const axiosConfiguration = {};
  const headersOption = {'X-Requested-With': 'XMLHttpRequest'};

  if (settingParams['withCsrf']) {
    headersOption['X-CSRF-TOKEN'] = document.querySelector('meta[name="csrf-token"]').getAttribute('content');
  }
  axiosConfiguration['method'] = settingParams['method'];
  axiosConfiguration['url'] = settingParams['url'];
  if (settingParams['requestParams'] !== null) {
    axiosConfiguration['params'] = settingParams['requestParams'];
  }
  axiosConfiguration['headers'] = headersOption;
  axiosConfiguration['withCredentials'] = settingParams['withCookie'];

  return axios(axiosConfiguration);
}

export default requestByConfiguredAxios;
