import axios from 'axios';

/**
 * 各リクエストの際、必要な設定をしたaxiosを返す関数。
 * @return {axios} CSRFトークンをリクエストヘッダに含めたaxiosを返す
 */
function prepareAxios() {
  return axios.create({
    headers: {
      'X-Requested-With': 'XMLHttpRequest',
      'X-CSRF-TOKEN': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
    },
  });
}

export default prepareAxios;
