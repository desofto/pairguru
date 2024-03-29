const APIQL = {
  on_error: null,
  endpoint: '',

  hash: function(s) {
    let hash = 0, i, chr
    if(s.length === 0) return hash
    for(i = 0; i < s.length; i++) {
      chr   = s.charCodeAt(i)
      hash  = ((hash << 5) - hash) + chr
      hash |= 0
    }
    return hash
  },

  post: function(endpoint, data) {
    return new Promise(function(resolve, reject) {
      let http = new XMLHttpRequest()
      http.open("POST", endpoint, true)
      http.setRequestHeader("X-CSRF-Token", document.querySelector('meta[name="csrf-token"]').getAttribute("content"))
      http.setRequestHeader("Content-Type", "application/json;charset=UTF-8")
      http.onload = function() {
        resolve({
          status: http.status,
          body: JSON.parse(http.responseText)
        })
      }
      http.send(JSON.stringify(data))
    })
  },

  call: function(schema, params, form) {
    if(!params) params = {}
    if(!form) form = null

    return new Promise(function(resolve, reject) {
      if(params instanceof FormData) {
        form = params
        params = {}
      }

      if(form) {
        Object.keys(params).forEach(function(key) {
          form.append(key, params[key])
        })
      }

      if(form) {
        form.append('apiql', APIQL.hash(schema))
      } else {
        params.apiql = APIQL.hash(schema)
      }

      APIQL.post(APIQL.endpoint, form || params)
      .then(function(response) {
        resolve(response.body)
      })
      .catch(function(response) {
        if(response.status == 401 && APIQL.on_error) {
          APIQL.on_error(response)
          return
        }

        if(response.status < 400) return

        if(form) {
          form.append('apiql_request', schema)
        } else {
          params.apiql_request = schema
        }

        APIQL.post(APIQL.endpoint, form || params)
        .then(function(response) {
          resolve(response.body)
        })
        // .catch(function(response) {
          // if(APIQL.on_error) {
            // APIQL.on_error(response)
          // } else {
            // alert(response.body)
          // }
        // })
      })
    })
  }
}

function apiql(schema, params, form) {
  if(!params) params = {}
  if(!form) form = null
  return APIQL.call(schema, params, form)
}
