document.addEventListener("DOMContentLoaded", () => {
  console.log("DOM content has loaded")
  let url = "http://localhost:3000/boards/index"
  fetch (url)
  .then(resp => resp.json())
  .then(data => data.forEach(board => {
    displayRow(board)}))
})

function displayRow(row){
  const table = document.querySelector("#surfer-table")
  table.innerHTML +=
  `
  <tr>
    <td>${row.name}</td>
    <td>${row.size}</td>
    <td>${row.surfer_id}</td>
  </tr>
  `
}
