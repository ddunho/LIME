const form = document.querySelector('form.user');

form.addEventListener('submit', function (e) {
    e.preventDefault();

    const data = {
        username: form.username.value,
        email: form.email.value,
        password: form.password.value,
        passwordConfirm: form.passwordConfirm.value,
        phone: form.phone.value,
        address: form.address.value,
        addressDetail: form.addressDetail.value,
        addressExtra: form.addressExtra.value,
        zipcode: form.zipcode.value
    };

    if (data.password !== data.passwordConfirm) {
        alert("비밀번호가 일치하지 않습니다.");
        return;
    }

    fetch('/user/signup', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(data)
    })
    .then(res => {
        if (!res.ok) throw new Error('회원가입 실패');
        return res.text();
    })
    .then(() => {
        alert('회원가입 성공');
        location.href = '/login';
    })
    .catch(err => alert(err.message));
});
