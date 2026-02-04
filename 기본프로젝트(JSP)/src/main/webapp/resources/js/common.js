	/**
     * alert, confirm 공통 함수
     * gfnAlert("메세지") -> alert("메세지")
     * gfnALert("메세지", "") -> confirm("메세지")
     */
    function gfnAlert(msg, options) {
      if (options) {
        return confirm(msg);
      } else {
        alert(msg);
      }
    }

	/**
     * Daum 주소 API (우편번호, 우편번호 찾기(버튼), 주소, 상세주소, 참고항목)
     */
    function daumPostcode(postcode, address, addressDetail, addressExtra) {
      new daum.Postcode({
        oncomplete: function (data) {
          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.

          // 각 주소의 노출 규칙에 따라 주소를 조합한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var addr = ""; // 주소 변수
          var extraAddr = ""; // 참고항목 변수

          //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
          if (data.userSelectedType === "R") {
            // 사용자가 도로명 주소를 선택했을 경우
            addr = data.roadAddress;
          } else {
            // 사용자가 지번 주소를 선택했을 경우(J)
            addr = data.jibunAddress;
          }

          // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
          if (data.userSelectedType === "R") {
            // 법정동명이 있을 경우 추가한다. (법정리는 제외)
            // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
            if (data.bname !== "" && /[동|로|가]$/g.test(data.bname)) {
              extraAddr += data.bname;
            }
            // 건물명이 있고, 공동주택일 경우 추가한다.
            if (data.buildingName !== "" && data.apartment === "Y") {
              extraAddr +=
                extraAddr !== "" ? ", " + data.buildingName : data.buildingName;
            }
            // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
            if (extraAddr !== "") {
              extraAddr = " (" + extraAddr + ")";
            }
            // 조합된 참고항목을 해당 필드에 넣는다.
            document.getElementById(addressExtra).value = extraAddr;
          } else {
            document.getElementById(addressExtra).value = "";
          }

          // 우편번호와 주소 정보를 해당 필드에 넣는다.
          document.getElementById(postcode).value = data.zonecode;
          document.getElementById(address).value = addr;
          // 커서를 상세주소 필드로 이동한다.
          document.getElementById(addressDetail).focus();
        },
      }).open();
    }

	/**
     * ajax 공통 함수
     */
    function ajaxCall(url, type, form, callbackFnc) {
		// form이 문자열이면 jQuery 객체로 변환
		if (typeof form === "string") {
			form = form.indexOf("#") < 0 ? $("#" + form) : $(form);
		}

		let formData;

		// form이 null이거나 undefined일 경우
		if (!form) {
			 formData = {};
		}
		// 일반 객체일 경우 (예: {name: '홍길동', age: 30})
		else if (typeof form === "object" && !form.jquery) {
			formData = new FormData();
			for (let key in form) {
				if (form.hasOwnProperty(key)) {
					formData.append(key, form[key]);
				}
			}
		}
		// jQuery 객체 또는 HTMLFormElement
		else {
			formData = new FormData(form[0]); // jQuery → DOM 요소
		}

    	console.log(formData);

		// FormData 여부 판단
		const isFormData = formData instanceof FormData;
		
		$.ajax({
			url: url,
			type: type,
			data: formData,
			processData: !isFormData ? true : false,
			contentType: !isFormData ? 'application/x-www-form-urlencoded; charset=UTF-8' : false,
			dataType: 'json',
			success: function (res) {
				callbackFnc(res);
			},
			error: function (req, status, err) {
        console.error('AJAX 오류:', req);
        gfnAlert('요청 중 오류 발생: ' + req.status + ' ' + req.statusText);
      }
		});
}
