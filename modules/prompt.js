const { prompt } = require('enquirer')

async function enterProjectPrompt() {
  try {
    const response = await prompt({
      type: 'input',
      name: 'project',
      message: 'Введите название проекта',
    })

    const project = response.project.trim()
    if (!project.length) return await enterProjectPrompt()

    return project
  } catch (err) {
    process.exit()
  }
}

async function confirmBranchPrompt(branches) {
  try {
    const response = await prompt({
      type: 'select',
      name: 'branch',
      message: 'Выберите окружение',
      choices: branches,
    })

    return response.branch
  } catch (err) {
    process.exit()
  }
}

module.exports = {
  enterProjectPrompt,
  confirmBranchPrompt,
}
