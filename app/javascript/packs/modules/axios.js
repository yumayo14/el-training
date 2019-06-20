import axios from 'axios';

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
