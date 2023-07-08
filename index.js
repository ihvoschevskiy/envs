#!/usr/bin/env node

const { join } = require('path')
const { promisify } = require('util')
const { enterProjectPrompt, confirmBranchPrompt } = require('./modules/prompt')
const { fetchBranches } = require('./modules/fetch')

async function initCli() {
  const exec = promisify(require('child_process').exec)

  const branches = await fetchBranches()
  const branch = await confirmBranchPrompt(branches)
  const project = await enterProjectPrompt()

  await exec(`sh ${join(__dirname, 'scripts/create_environment.sh')} ${branch} ${project}`)
}

initCli()
