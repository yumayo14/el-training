import axios from 'axios';

const instance = axios.create({
    headers: {
        'X-Requested-With': 'XMLHttpRequest',
        'X-CSRF-TOKEN' : document.querySelector('meta[name="csrf-token"]').getAttribute('content')
    }
});

export default instance;
