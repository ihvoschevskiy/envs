const https = require('https')

const fetchBranches = () => {
  return new Promise((response, reject) => {
    const path = 'https://api.github.com/repos/ihvoschevskiy/envs/branches'
    const options = { headers: { 'User-Agent': 'envs' } }
    https.get(path, options, res => {
      const data = []
      res
        .on('data', chunk => {
          data.push(chunk)
        })
        .on('end', () => {
          const result = JSON.parse(Buffer.concat(data).toString())
          if (!result.length) reject({ err: 'error', message: 'data not found' })
          const branches = result
            .map(itm => itm.name)
            .filter(branch => /^(?!(HEAD|master|dev|testing))(.+)/.test(branch))

          response(branches)
        })
        .on('error', err => {
          reject(err)
        })
    })
  })
}

module.exports = { fetchBranches }
