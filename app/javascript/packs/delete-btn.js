$(document).ready(
    $('.delete-action').on('click', ({
        target
    }) => {
        $(target).parents('.comment-wrapper')[0].remove()
    })
);