function requestAjax(options) {
  const method = options.method || "GET";
  let ajaxData = options.data;
  let contentType;
  let processData;

  // GET, DELETE는 query string으로 (processData: true)
  if (method === "GET" || method === "DELETE") {
    ajaxData = options.data;
    contentType = undefined;
    processData = true;
  } 
  // 
  // POST, PUT, PATCH는 JSON body로 (processData: false)
  else {
    if (options.contentType === false) {
      // 파일 업로드 등
      contentType = false;
      processData = false;
      ajaxData = options.data;
    } else {
      contentType = "application/json";
      processData = false;
      ajaxData = options.data ? JSON.stringify(options.data) : null;
    }
  }

  // options에서 명시적으로 지정한 경우 우선 적용
  if (options.contentType !== undefined) {
    contentType = options.contentType;
  }
  if (options.processData !== undefined) {
    processData = options.processData;
  }

  $.ajax({
    url: options.url,
    type: method,
    contentType: contentType,
    processData: processData,
    data: ajaxData,
    success: function (response) {
      if (options.success) {
        options.success(response);
      }
    },
    error: function (xhr) {
      if (options.error) {
        options.error(xhr);
      } else {
        alert("요청 중 오류가 발생했습니다.");
      }
    }
  });
}