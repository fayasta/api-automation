function fn() {
  var env = karate.env; // get system property 'karate.env'
  karate.log('karate.env system property was:', env);
  if (!env) {
    env = 'dev';
  }

  var config = {
    base_url: 'https://api-ci.careviso.com/',
    repeat_number : parseInt(karate.properties['karate.repeat_number']) || 1
  }

  if (env == 'dev') {
    config.token = ''
    config.clinicId = 'CY10000'
    config.insuranceId = 'qm7wys0ag'
    config.caseId = '4qn7arfa6'
    config.labId = 'ATL1001'
    config.caseAttachment = 'bk04lv7q4'
  } else if (env == 'qa') {
    config.base_url = "https://api-qa-ci.careviso.com/"
    config.clinicId = 'qa_value'
    config.insuranceId = 'qa_value'
    config.caseId = 'qa_value'
    config.labId = 'qa_value'
    config.caseAttachment = 'qa_value'
  }
  karate.log('karate property system property was:', karate.properties);

  karate.configure('headers',{Authorization: 'Bearer '+ config.token})

  return config;
}