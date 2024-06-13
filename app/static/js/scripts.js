"use strict"

function fillModal(event) {
    let deleteUrl = event.relatedTarget.dataset.deleteUrl;
    let bookTitle = event.relatedTarget.dataset.bookTitle;

    let modalForm = event.target.querySelector("form");
    modalForm.action = deleteUrl;

    let modalTitle = event.target.querySelector("#bookTitle");
    modalTitle.textContent = bookTitle;
}

window.onload = function () {
    let deleteModal = document.getElementById("deleteModal");
    deleteModal.addEventListener("show.bs.modal", fillModal);
}