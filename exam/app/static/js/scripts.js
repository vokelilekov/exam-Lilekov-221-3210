"use strict"

function fillModal(event) {
    let deleteUrl = event.relatedTarget.dataset.deleteUrl;
    let modalForm = event.target.querySelector("form");
    modalForm.action = deleteUrl;
}

function bookName(event) {
    let bookName = event.relatedTarget.dataset.bookName;
    document.getElementById("book-name").textContent = bookName;
}

window.onload = function () {
    let deleteModal = document.getElementById("delete-modal");
    
    var easyMDE = new EasyMDE({
        element: document.getElementById('description'),
    });
   
    var easyMDE = new EasyMDE({
        element: document.getElementById('text'),
    });
    deleteModal.addEventListener("show.bs.modal", fillModal);
    deleteModal.addEventListener("show.bs.modal", bookName);



};

