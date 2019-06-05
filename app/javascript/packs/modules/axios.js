import axios from 'axios';

function prepareAxios() {
    return axios.create({
        headers: {
            'X-Requested-With': 'XMLHttpRequest',
            'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
        }
    });
}

export default prepareAxios;
