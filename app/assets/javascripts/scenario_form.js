$(function () {
    $(document).on('turbolinks:load', function() {

        if ($(".scenario").length) {

            scenario.init()

        }

    });
})

var scenario =  {}

scenario.init = function () {
    this.bind()
    this.fadeIn()
    this[this.action]()
}

scenario.bind = function () {
    this.action = $(".scenario_content_form__submit").first().attr("id")
    this.scenario = $(".scenario").first()
    this.nextProgress = $(".progress li.active").last().next()
}

scenario.fadeIn = function () {
    this.scenario.removeClass("anim__in")
}

scenario.fadeOut = function () {
    this.scenario.addClass("anim__out")
    this.nextProgress.addClass("active")
}

scenario.post = function (url, data) {
    return $.post(url, data, function (e) {
        console.log('ok', e)
    })
    .fail(function (e) {
        debugger
        console.log('fail', e)
        Materialize.toast("Something wrong happen, are you sure all field are set ?", 4000, 'rounded')
    })
    .always(function (e) {
        console.log('finish', e)
    });
}

scenario.redirect = function (url, delay) {
    delay == undefined ? delay = 500 : delay

    this.fadeOut()

    setTimeout(function () {
        window.location.href = url
    }, delay)
}

scenario.getData = function (key, required, checkbox) {
    checkbox === undefined ? checkbox = false : checkbox
    var value
    $("body").find("[name='" + key + "']").each(function() {
        if (checkbox) {
            if ($(this).attr("type") != "hidden") {
                $(this).prop('checked') ? value = 1 : value = 0
            }
        } else {
            value = $(this).val()
        }
    });

    return value
}

scenario.newWorld = function () {
    var self = this
    $("body").on("click", "#newWorld", function (e) {
        e.preventDefault()

        var name = self.getData("world[name]", true)
        var narrator_name = self.getData("narrator_name", true)
        var public = self.getData("world[public]", true, true)

        if (name.length != 0 && public.length != 0 && narrator_name.length != 0) {

            var DATA = {world: {
                name: name,
                narrator_name: narrator_name,
                public: public
            }}

            var URL = "/world"

            self.post(URL, DATA)
                // .done(function (e) {
                //     console.log('done', e)

                //     var url = '/world/' + e.world.id + '/chapter/new'

                //     self.redirect(url)
                // })

        } else {
            Materialize.toast("Please complete all fields", 4000, 'rounded')
        }

    })
}

scenario.newChapter = function () {

    var self = this

    $("body").on("click", "#newChapter", function (e) {
        e.preventDefault()

        var title = self.getData("chapter[title]", true)
        var description = self.getData("chapter[description]", true)
        var world_id = self.getData("chapter[world_id]", true)
        if (title.length != 0 && description.length != 0) {

            var DATA = {
                chapter: {
                    world_id: world_id,
                    title: title,
                    description: description
                }
            }

            var URL = "/world/" + world_id + "/chapter/"

            self.post(URL, DATA)

                // .done(function (e) {
                //     console.log(e)
                //     debugger
                //     var url = '/world/' + world_id + '/chapter/' + e.chapter_id + '/event/new'
                //     self.redirect(url)
                // })
        } else {
            Materialize.toast("Please complete all fields", 4000, 'rounded')
        }
    })

}

scenario.newEvent = function () {

    var self = this

    $("body").on("click", "#newEvent", function (e) {
        e.preventDefault()

        var title = self.getData("event[title]", true)
        var description = self.getData("event[description]", true)

        var world_id = self.getData("event[world_id]")
        var chapter_id = self.getData("event[chapter_id]")

        if (title.length != 0 && description.length != 0) {

            var DATA = {
                event: {
                    world_id: world_id,
                    chapter_id: chapter_id,
                    title: title,
                    description: description
                }
            }

            var URL = "/world/" + world_id + "/chapter/" + chapter_id + "/event/"

            self.post(URL, DATA)
        } else {
            Materialize.toast("Please complete all fields", 4000, 'rounded')
        }
    })

}

scenario.newReward = function () {

    var self = this

    $("body").on("click", "#newReward", function (e) {
        e.preventDefault()

        var name = self.getData("stuff[name]", true)
        var bonus_attack = self.getData("stuff[bonus_attack]", true)
        var bonus_armor = self.getData("stuff[bonus_armor]", true)
        var bonus_life = self.getData("stuff[bonus_life]", true)
        var quantity = self.getData("quantity", true)

        var world_id = self.getData("stuff[world_id]")
        var chapter_id = self.getData("stuff[chapter_id]")
        var event_id = self.getData("stuff[event_id]")

        if (name.length != 0 && bonus_attack.length != 0 &&
            bonus_armor.length != 0 && bonus_life.length != 0 && quantity.length != 0) {
            var DATA = {
                stuff: {
                    name: name,
                    bonus_attack: bonus_attack,
                    bonus_armor: bonus_armor,
                    bonus_life: bonus_life,
                    world_id: world_id
                },
                quantity: quantity
            }

            var URL = "/world/" + world_id + "/chapter/" + chapter_id + "/event/" + event_id + "/reward"

            self.post(URL, DATA)
                // .done(function (e) {

                //     var url = '/world/' + world_id + '/character_type/new'

                //     self.redirect(url)
                // })
        } else {
            Materialize.toast("Please complete all fields", 4000, 'rounded')
        }
    })

}

scenario.newCharacter = function () {

    var self = this

    $("body").on("click", "#newCharacter", function (e) {
        e.preventDefault()

        var name = self.getData("character_type[name]", true)
        var attack_min = self.getData("character_type[attack_min]", true)
        var attack_max = self.getData("character_type[attack_max]", true)
        var armor = self.getData("character_type[armor]", true)
        var life = self.getData("character_type[life]", true)

        var world_id = self.getData("world_id")

        if (name.length != 0 && attack_min.length != 0 &&
            attack_max.length != 0 && armor.length != 0 && life.length != 0) {

            var DATA = {
                character_type: {
                    name: name,
                    attack_min: attack_min,
                    attack_max: attack_max,
                    armor: armor,
                    life: life
                }
            }

            var URL = "/world/" + world_id + "/character_type/"

            self.post(URL, DATA)
                // .done(function (e) {

                //     var url = '/world/' + world_id + '/monster/new'

                //     self.redirect(url)
                // })
        } else {
            Materialize.toast("Please complete all fields", 4000, 'rounded')
        }
    })

}

scenario.newMonster = function () {

    var self = this

    $("body").on("click", "#newMonster", function (e) {
        e.preventDefault()

        var name = self.getData("monster[name]", true)
        var attack_min = self.getData("monster[attack_min]", true)
        var attack_max = self.getData("monster[attack_max]", true)
        var armor = self.getData("monster[armor]", true)
        var life = self.getData("monster[life]", true)

        var world_id = self.getData("world_id")

        if (name.length != 0 && attack_min.length != 0 &&
            attack_max.length != 0 && armor.length != 0 && life.length != 0) {

            var DATA = {
                monster: {
                    name: name,
                    attack_min: attack_min,
                    attack_max: attack_max,
                    armor: armor,
                    life: life
                }
            }

            var URL = "/world/" + world_id + "/monster/"

            self.post(URL, DATA)
                // .done(function (e) {

                //     var url = '/world/' + world_id + '/monster/new'

                //     $(".scenario_content").html("<h2>Your scenario has been created</h2>")

                //     setTimeout(function () {
                //         self.redirect("/")
                //     }, 2000)
                // })
        } else {
            Materialize.toast("Please complete all fields", 4000, 'rounded')
        }
    })

}