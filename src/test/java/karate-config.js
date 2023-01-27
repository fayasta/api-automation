function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  var config = {
    base_url: 'https://api-ci.careviso.com/'
  }

  if (env == 'dev') {
    config.token = ''
    config.clinicId = 'CY10000'
    config.insuranceId = 'qm7wys0ag'
    config.caseId = '4qn7arfa6'
    config.labId = 'ATL1001'
    config.caseAttachment = 'bk04lv7q4'
  } else if (env == 'qa') {
    config.token = 'xxxxxxx'
    config.clinicId = 'xxxxxxx'
  }

  karate.configure('headers',{Authorization: 'Bearer '+ config.token})

  return config;
}