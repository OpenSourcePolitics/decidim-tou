const scrollToTop = () => {
    $("body").animate({
        scrollTop: $("main").offset().top
    }, 200);
};


$(() => {
    const userRegistrationForm = {
        $: $("#register-form"),
        toggleFromSteps: () => {
            $("[form-step]").toggle();
            $("[form-active-step]").toggleClass("step--active");
        },
        errors: {
            display: ($element) => {
                $element.addClass("is-invalid-input");
                $element.parent().addClass("is-invalid-label");
                $element.next("span").addClass("is-visible");
            },
            hide: ($element) => {
                $element.removeClass("is-invalid-input");
                $element.parent().removeClass("is-invalid-label");
                $element.next("span").removeClass("is-visible");
            }
        },
        buttons: {
            $forward: $(".form-step-forward-button"),
            $back: $(".form-step-back-button")
        },
        currentErrors: []
    };

    const formStepsFields = {
        checkMandatoryFields: () => {
            return $.uniqueSort(formStepsFields.filledMandatoryFields().add(
                formStepsFields.password.samePassword()
            ))
        },
        filledMandatoryFields: () => {
            return $mandatoryFormFirstStepFields.map((index, element) => {
                if (formStepsFields.emptyOrFalse(element)) {
                    return element;
                }
                return null
            })
        },
        emptyOrFalse: (element) => {
            if ($(element)[0].type === "checkbox") {
                return $(element)[0].checked === false;
            }
            return $(element).val().length === 0;
        },
        setGroupFieldsVisibility: (value) => {
            if (value === "user") {
                formStepsFields.input.selector.hide();
            } else {
                formStepsFields.input.selector.show();
            }
        },
        $first: $("[form-step='1'] input"),
        $second: $("[form-step='2'] input"),
        password: {
            $: $("#registration_user_password"),
            $confirmation: $("#registration_user_password_confirmation"),
            samePassword: ($selector, $target) => {
                if (formStepsFields.password.$.val() !== formStepsFields.password.$confirmation.val()) {
                    return $target;
                }
                return null;
            }
        },
        $underage: $("#registration_underage_registration"),
        statutoryRepresentativeEmail: {
            $: $("#statutory_representative_email"),
            toggle: () => {
                if (formStepsFields.$underage.is(":checked")) {
                    formStepsFields.statutoryRepresentativeEmail.$.removeClass("hide");
                    return
                }

                formStepsFields.statutoryRepresentativeEmail.$.addClass("hide");
            },
        },
        newsletter: {
            check: (check, $selector, $modal) => {
                $selector.prop("checked", check);
                $modal.data("continue", true);
                $modal.foundation("close");
                userRegistrationForm.$.submit()
            },
            $: $("input[type='checkbox'][name='user[newsletter]']"),
            selector: "input[type='checkbox'][name='user[newsletter]']",
            $modal: $("#sign-up-newsletter-modal"),
        },
        $userGroup: userRegistrationForm.$.find(".user-group-fields"),
        $tosAgreement: $("#registration_user_tos_agreement"),
        input: {
            selector: "input[name='user[sign_up_as]']",
        },
    };

    const $mandatoryFormFirstStepFields = formStepsFields.$first.not("#registration_user_newsletter").not("input[type ='hidden']").add(formStepsFields.$tosAgreement)


    formStepsFields.$underage.on("click", () => {
        formStepsFields.statutoryRepresentativeEmail.toggle()
    });

    userRegistrationForm.buttons.$forward.on("click", (event) => {
        event.preventDefault();

        scrollToTop();

        // validate only input elements from step 1
        formStepsFields.$first.each((index, element) => {
            userRegistrationForm.$.foundation("validateInput", $(element))
        });

        if (!userRegistrationForm.$.find("[data-invalid]:visible").length) {
            userRegistrationForm.toggleFromSteps()
        }
    });

    userRegistrationForm.$.on("submit", (event) => {
        if (!formStepsFields.newsletter.$modal.data("continue")) {
            if (!formStepsFields.newsletter.$.prop("checked")) {
                event.preventDefault();
                formStepsFields.newsletter.$modal.foundation("open")
            }
        }
    });

    formStepsFields.newsletter.$modal.find(".check-newsletter").on("click", (event) => {
        formStepsFields.newsletter.check(
            $(event.target).data("check"),
            formStepsFields.newsletter.$,
            formStepsFields.newsletter.$modal
        )
    });

    userRegistrationForm.buttons.$back.on("click", (event) => {
        event.preventDefault();

        scrollToTop();

        userRegistrationForm.toggleFromSteps()
    })


    formStepsFields.checkMandatoryFields().on("change", (event) => {
        if (formStepsFields.emptyOrFalse($(event.target))) {
            userRegistrationForm.errors.display($(event.target));
        }
        if (formStepsFields.checkMandatoryFields().length === 0) {
            userRegistrationForm.buttons.$forward.attr("disabled", false);
        } else {
            userRegistrationForm.buttons.$forward.attr("disabled", true);
        }
    })

    userRegistrationForm.buttons.$forward.on("click", () => {
        formStepsFields.checkMandatoryFields().each((index, element) => {
            userRegistrationForm.errors.display($(element));
        });

        if (formStepsFields.checkMandatoryFields().length === 0) {
            userRegistrationForm.buttons.$forward.attr("disabled", false);
        } else {
            userRegistrationForm.buttons.$forward.attr("disabled", true);
        }
    });
});
