export function addListeners(){
    addClickListener();
    addFilterListener();
    addSelectButtonListeners();
}

function addClickListener(){
    $('.repo').on('click', function(){
        toggleRepoSelection(this);
    });
}

function addFilterListener(){
    $('input[name="repo-filter"]').on('keyup', function(){
        let searchTerm = $(this).val();
        let repos = $('.repo');

        $.each(repos, function(_index, repo) {
            let $repo = $(repo);
            if($repo.text().match(searchTerm)){
                $repo.show();
            }else{
                $repo.hide();
            }
        });

    });
}

function addSelectButtonListeners(){
    $('#select-all').on("click", selectAll);
    $('#select-none').on("click", selectNone);
}

function selectAll(){
    $.each($('.repo:visible'), function(_index, repo) {
        selectRepo(repo);
    });
}

function selectNone(){
    $.each($('.repo:visible'), function(_index, repo) {
        unselectRepo(repo);
    });
}

function toggleRepoSelection(repo){
    let $repo = $(repo);
    let $checkBox = $repo.find('input[type="checkbox"]');

    $checkBox.prop("checked", !$checkBox.prop("checked"))
    $repo.toggleClass("clicked");
}

function selectRepo(repo){
    let $repo = $(repo);
    let $checkBox = $repo.find('input[type="checkbox"]');

    $checkBox.prop("checked", true);
    $repo.addClass("clicked");
}

function unselectRepo(repo){
    let $repo = $(repo);
    let $checkBox = $repo.find('input[type="checkbox"]');

    $checkBox.prop("checked", false);
    $repo.removeClass("clicked");
}

addSelectButtonListeners();
