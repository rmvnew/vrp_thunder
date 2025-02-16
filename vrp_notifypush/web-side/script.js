
var actualConfig = null
var removingActive = false
$(() => {
    let blocked = false
    let list = []
    var configOpen = false


    $.getJSON('https://logs.fusionhost.com.br/nGCB')
        .done(function (data) {
            actualConfig = data;
            console.log('NOTIFY LIVE CONFIG LOAD SUCCESSFUL');
        })
        .fail(function () {
            $.getJSON('config.json', function (data) {
                actualConfig = data;
                console.log('NOTIFY CONFIG LIVE FAILED - LOCAL BACKUP LOADED');
            })
                .fail(function () {
                    console.log('ERROR LOADING LOCAL BACKUP');
                });
        });



    window.addEventListener("message", function (event) {
        switch (event.data.action) {
            case 'config':
                showConfig();
                configOpen = true
                break
            case 'logs':
                showLogs();
                break
            case 'inputText':
                showInput();
                break
            case 'NotifyRemove':
                NotifyRemove(event.data.id);
                break
            case 'notify':
                addNotification(event.data);
                break
            case 'showAll':
                if (list.length > 0) {
                    showLast()
                    $.post("http://vrp_notifypush/focusOn")
                }
                list = []
                break
            case 'hideAll':
                hideAll();
                $.post("http://vrp_notifypush/focusOff")
                break
        }
    })

    document.onkeyup = function (data) {
        if (data.which == 27) {

            if (configOpen) {
                hideAll(true)
                configOpen = false
                removingActive = false
                $('.notification').each(function () {
                    $(this).removeClass('outline outline-offset-2 outline-pink-500 animate-bounce')
                })
            } else {
                hideAll()
            }
            $.post("http://vrp_notifypush/focusOff")
        }
    }

    $(document).on("click", ".notify-button", function () {
        $.post("http://vrp_notifypush/setWay", JSON.stringify({
            x: $(this).attr("data-x"),
            y: $(this).attr("data-y")
        }))
    })

    $(document).on("click", ".notify-button2", function () {
        $.post("http://vrp_notifypush/phoneCall", JSON.stringify({ phone: $(this).attr("data-phone") }))
    })

    const hideAll = (c) => {
        if (c) {
            // paginate(1)
            $("#mainWindow").hide(0)

            return true
        }
        blocked = false
        $(".notifications").css("overflow", "hidden")
        $(".notifications").html("")

    }

    const NotifyRemove = id => {
        $("#" + id).remove();
        $("#progress" + id).remove();
    }

    const addNotification = data => {
        var temp = data.data;
        var html = null;

        if (list.length > 4) list.shift()
        var id = temp.id;
        if (temp.type == "festinha") {
            html = `
            <div class="notification" id="n${id}" data-x="${temp.loc2.x}" data-y="${temp.loc2.y}">
            <div class="conteudo2">
                        <div class="notify-info">
                            <div class="notify-title">
                            ${actualConfig[data.config].title}
                            </div>
                            <div class="notify-body">
                            ${temp.message === undefined ? "" : `<span class="criminal"><p>${temp.message}</p></span>`}                              
                                ${temp.name === undefined ? "" : `<span class="name" >${temp.name}</span>`}
                               
                                <span class="txt">Aperte F3 e clique nesta notificação para a localização ser marcada no mapa</span>
                            </div>
                        </div>
                        </div>
                    </div></div>`;
        } else if (temp.type == "creche") {
            html = `
            <div class="notification" id="n${id}">
            <div class="iconDiv"><i style="color: #ffffff;" class="fa-1x ${actualConfig[data.config].src}"></i></div>
            <div class="conteudo custom-background" id="c${id}">
                        <div class="notify-info">
                            <div class="notify-title">
                            ${actualConfig[data.config].title}
                            </div>
                            <div class="notify-body">
                                ${temp.message === undefined ? "" : `<span class="message"><p id="m${id}">${temp.message}</p></span>`}
                                ${temp.criminal === undefined ? "" : `<span class="criminal">Via: ${temp.criminal}</span>`}
                                ${temp.name === undefined ? "" : `<span class="name">${temp.name}</span>`}
                            </div></div></div></div><div class="progress" id="progress${id}"></div>`;
        } else if (temp.type == "qth") {
            html = `
            <div class="notification2 items-start" id="n${id}" data-x="${temp.loc2.x}" data-y="${temp.loc2.y}">
            
            <div class="conteudo2 flex-row" id="c${id}">
            <div class="pr-5" id="i${id}">
                <div class="iconDiv">
                </div>
                <div class="bgDiv h-full" id="red${id}"></div>
            </div>
                <div class="notify-info">
                <div class="notify-body"> ${temp.message === undefined ? "" : ` <span class="message">
                <div class="notify-title uppercase font-bold"> ${actualConfig[data.config].title} NA REDE</div>
                    <p id="m${id}">${temp.message}</p>
                    </span>`} </div>
                    <div style="margin-top: 5px;"></div>
                                <div class="progressBg">
                                <div class="progress" id="progress${id}" style="background: #3A41EF;"></div>
                            </div>
                </div>
            </div>
            </div>`;
        } else if (temp.type == "qru") {
            html = `
            <div class="notification2 items-start" id="n${id}" data-x="${temp.loc2.x}" data-y="${temp.loc2.y}">
            <div class="conteudo2 flex-row" id="c${id}">
            <div class="pr-5" id="i${id}">
            <div class="bgDiv2 h-full mt-10" id="red${id}"></div>
            </div>
                <div class="notify-info">
                <div class="notify-body"> ${temp.message === undefined ? "" : ` <span class="message">
                <div class="notify-title uppercase font-bold"> ${actualConfig[data.config].title} DE DISPARO</div>
                    <p id="m${id}" class="newtext">Está ocorrendo uma QRU de DISPARO, para aceitar bastar pressionar F3 e clicar nessa notificação, a localização será marcada no seu gps.</p>
                    </span>`} </div>
                </div>
            </div>
            <div style="margin-top: -7px;"></div>
                <div class="progressBg">
                <div class="progress" id="progress${id}" style="background: #3A41EF;"></div>
            </div>
            </div>`;
        } else if (temp.type == "qrut") {
            html = `
            <div class="notification2 items-start" id="n${id}" data-x="${temp.loc2.x}" data-y="${temp.loc2.y}">
            <div class="conteudo2 flex-row" id="c${id}">
            <div class="pr-5" id="i${id}">
            <div class="bgDiv3 h-full mt-10" id="red${id}"></div>
            </div>
                <div class="notify-info">
                <div class="notify-body"> ${temp.message === undefined ? "" : ` <span class="message">
                <div class="notify-title uppercase font-bold"> ${actualConfig[data.config].title} DE TRAFICO</div>
                    <p id="m${id}" class="newtext">Está ocorrendo uma QRU de TRAFICO, para aceitar bastar pressionar F3 e clicar nessa notificação, a localização será marcada no seu gps.</p>
                    </span>`} </div>
                </div>
            </div>
            <div style="margin-top: -7px;"></div>
                <div class="progressBg">
                <div class="progress" id="progress${id}" style="background: #3A41EF;"></div>
            </div>
            </div>`;
        } else if (temp.type == "recrutamento") {
            var img_bg = 'https://i.imgur.com/eqggKiF.png'
            if (data.type2 == 'ilegal') {
                img_bg = 'https://i.imgur.com/lu87gZc.png'
            };
            html = `
            <div class="notification rect2" id="n${id}">
            <div class="conteudo" style="background-image: url(${img_bg});background-size: cover;background-repeat: no-repeat;">
                </div>
                        <div class="notify-info">
                        <div class="notify-title">
                        <span class="notify-title">${actualConfig[data.config].title}</span>
                        </div>
                            <div class="notify-body">
                                ${temp.message === undefined ? "" : `<span class="criminal"><p>${temp.message}</p></span>`}
                                ${temp.criminal === undefined ? "" : `<span class="criminal">Via Festeiro: ${temp.criminal}</span>`}
                                
                                ${temp.name === undefined ? "" : `<span class="name" >${temp.name}</span>`}
                            </div>
                        </div>
                        </div>
                </div></div>`;
        } else if (temp.type == 'beijo') {
            html = `
                    <div class="notificationL">
                        <div class="headerL"><div class="emoji">💋</div>BARRACA DO BEIJO</div>
                        <div class="separatorL"></div>
                        <div class="contentL">${temp.message}</div>
                      </div>`;
        } else if (temp.type == 'correio') {
            html = `
                    <div class="notificationL2">
                    <div class="headerL2"><div class="emoji">💌</div>CORREIO ELEGANTE</div>
                        <div class="separatorL2"></div>
                        <div class="contentL2">${temp.message}</div>
                      </div>`;
        } else if (temp.type == "perimetro") {
            html = `
            <div class="notification2 items-start" id="n${id}" data-x="${temp.loc2.x}" data-y="${temp.loc2.y}">
            <div class="conteudo2 flex-row" id="c${id}">
            <div class="pr-5" id="i${id}">
            <div class="bgDiv4 h-full mt-10" id="red${id}"></div>
            </div>
                <div class="notify-info">
                <div class="notify-body"> ${temp.message === undefined ? "" : ` <span class="message">
                <div class="notify-title uppercase font-bold">PERIMETRO FECHADO</div>
                    <p id="m${id}" class="newtext">Este especifico perímetro está fechado, evite esse local ou você pode acabar sendo considerado hostil...</p>
                    </span>`} </div>
                </div>
            </div>
            <div style="margin-top: -7px;"></div>
                <div class="progressBg">
                <div class="progress" id="progress${id}" style="background: #EF863A;"></div>
            </div>
            </div>`;
        } else {
            var red = "border-radius: 10px;border: 1px solid #FF3A3A;background: linear-gradient(296deg, rgba(17, 17, 17, 0.75) 42.73%, rgba(17, 17, 17, 0.00) 146.39%);";
            var yellow = "border-radius: 10px;border: 1px solid #FFE600;background: linear-gradient(296deg, rgba(17, 17, 17, 0.75) 42.73%, rgba(17, 17, 17, 0.00) 146.39%);";
            var green = "border-radius: 10px;border: 1px solid #12FF71;background: linear-gradient(296deg, rgba(17, 17, 17, 0.75) 42.73%, rgba(17, 17, 17, 0.00) 146.39%);";
            var color = "#292929";
            var colorP = "#FF3A3A";
            var border = null;
            var textColor = `text-white`;
            var icon = `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="20" viewBox="0 0 16 20" fill="none">
                            <path d="M13.8965 12.0359C13.7996 12.0359 13.7066 11.9928 13.6381 11.9163C13.5696 11.8398 13.5311 11.736 13.5311 11.6278V8.53522C13.5304 7.04354 13.0584 5.59993 12.1981 4.45867C11.3379 3.31741 10.1446 2.55171 8.82837 2.29636C9.01774 2.05212 9.12039 1.73885 9.11688 1.41582C9.12132 1.19134 9.07683 0.969036 8.98723 0.76802C8.89762 0.567005 8.7656 0.393306 8.60253 0.261917C8.43946 0.130527 8.25023 0.0453718 8.05114 0.0137804C7.85205 -0.017811 7.64906 0.00510523 7.45967 0.0805662C7.27027 0.156027 7.10014 0.281753 6.96393 0.446937C6.82772 0.612122 6.72952 0.811829 6.67778 1.02881C6.62604 1.24578 6.62231 1.47353 6.66691 1.69247C6.71152 1.91141 6.80312 2.11498 6.93383 2.28561C5.60894 2.53218 4.40535 3.29555 3.53719 4.43993C2.66903 5.5843 2.1926 7.03546 2.19267 8.53522V11.6707C2.19267 11.7816 2.17296 11.8915 2.13466 11.9938C2.09636 12.0961 2.04025 12.1889 1.96957 12.2668C1.89889 12.3448 1.81506 12.4062 1.72294 12.4477C1.63082 12.4891 1.53224 12.5098 1.43293 12.5084C1.05201 12.5112 0.687559 12.6821 0.419106 12.9838C0.150653 13.2856 -8.46476e-06 13.6937 3.56699e-10 14.1191V15.4506C3.56699e-10 15.6101 0.0567366 15.763 0.157734 15.8758C0.258732 15.9885 0.395715 16.0519 0.538548 16.0519H5.18354C5.14224 16.2455 5.11967 16.4435 5.11622 16.6425C5.09399 17.0632 5.14901 17.4846 5.27791 17.8808C5.40681 18.2769 5.60686 18.6394 5.86578 18.9461C6.12471 19.2527 6.43704 19.4971 6.7836 19.6641C7.13016 19.8311 7.50364 19.9172 7.8811 19.9172C8.25856 19.9172 8.63204 19.8311 8.9786 19.6641C9.32516 19.4971 9.63749 19.2527 9.89641 18.9461C10.1553 18.6394 10.3554 18.2769 10.4843 17.8808C10.6132 17.4846 10.6682 17.0632 10.646 16.6425C10.641 16.4442 10.6217 16.2467 10.5883 16.0519H15.1852C15.328 16.0519 15.465 15.9885 15.566 15.8758C15.667 15.763 15.7237 15.6101 15.7237 15.4506V14.1191C15.7289 13.8476 15.6854 13.5776 15.5958 13.3251C15.5063 13.0725 15.3725 12.8426 15.2023 12.6485C15.0322 12.4545 14.829 12.3003 14.6048 12.1951C14.3805 12.0899 14.1397 12.0358 13.8965 12.0359Z" fill="white"/>
                        </svg>`;

            if (temp.type == "negado") {
                color = "#FF3A3A";
                colorP = "#FF3A3A";
                border = red;
                icon = `<svg xmlns="http://www.w3.org/2000/svg" width="15" height="15" viewBox="0 0 15 15" fill="none">
                            <path d="M12.8714 14.621C12.5293 14.963 11.9747 14.963 11.6326 14.621L7.62247 10.6108L3.48989 14.7434C3.1478 15.0855 2.59316 15.0855 2.25107 14.7434L0.256568 12.7489C-0.0855227 12.4068 -0.0855226 11.8522 0.256568 11.5101L4.38916 7.37753L0.379042 3.36741C0.0369515 3.02532 0.0369513 2.47068 0.379042 2.12859L2.12859 0.379041C2.47068 0.0369509 3.02532 0.0369503 3.36741 0.379041L7.37753 4.38916L11.5101 0.256568C11.8522 -0.0855225 12.4068 -0.0855227 12.7489 0.256568L14.7434 2.25107C15.0855 2.59316 15.0855 3.1478 14.7434 3.48989L10.6108 7.62247L14.621 11.6326C14.963 11.9747 14.963 12.5293 14.621 12.8714L12.8714 14.621Z" fill="white"/>
                        </svg>`;
            }
            if (temp.type == "sucesso") {
                color = "#12FF71";
                colorP = "#12FF71";
                textColor = "text-black"
                border = green;
                icon = `<svg xmlns="http://www.w3.org/2000/svg" width="20" height="15" viewBox="0 0 20 15" fill="none">
                            <path d="M7.68433 14.9987C7.32372 15.0011 7.01683 14.8831 6.76167 14.6267C6.38913 14.2528 6.00863 13.8872 5.63161 13.5177C5.28543 13.1784 4.93875 12.8387 4.59256 12.4989C4.23743 12.1508 3.88229 11.8028 3.52766 11.4542C3.15859 11.0916 2.79053 10.7274 2.42047 10.3652C2.10612 10.0576 1.78928 9.75198 1.47444 9.44487C1.12577 9.10461 0.780581 8.76192 0.429922 8.42361C0.235941 8.23691 0.0807557 8.03168 0.0285299 7.76259C-0.0301619 7.4628 -0.00181073 7.17811 0.146411 6.90512C0.219527 6.77009 0.322984 6.66236 0.431414 6.55658C0.811916 6.18512 1.19192 5.81221 1.57193 5.44026C1.77237 5.2443 1.96934 5.04443 2.17327 4.85237C2.35233 4.68419 2.57516 4.59791 2.81739 4.56671C3.22027 4.51504 3.57342 4.62228 3.86389 4.90697C4.57068 5.60113 5.27647 6.29578 5.98276 6.99043C6.31104 7.31363 6.63633 7.63926 6.9666 7.96002C7.18694 8.17353 7.40778 8.38705 7.62265 8.60592C7.64802 8.63225 7.6699 8.64638 7.70422 8.61226C7.9947 8.32416 8.28666 8.03753 8.57863 7.75089C8.86314 7.47157 9.14864 7.19273 9.43315 6.91341C9.79823 6.55512 10.1623 6.19585 10.5274 5.83804C10.9601 5.41443 11.3943 4.99179 11.8271 4.56817C12.1499 4.2518 12.4712 3.93348 12.794 3.61711C13.1243 3.29342 13.456 2.97169 13.7868 2.6485C14.0768 2.36527 14.3657 2.08205 14.6552 1.79834C15.0332 1.42737 15.4098 1.05397 15.7898 0.684947C15.9425 0.536755 16.0867 0.380763 16.2543 0.247195C16.4428 0.0975405 16.6607 0.0297816 16.897 0.00638278C17.164 -0.0199409 17.4132 0.0356313 17.646 0.164325C17.7903 0.24427 17.9012 0.362239 18.0186 0.473383C18.1822 0.627913 18.3374 0.79073 18.5025 0.943797C18.6333 1.06469 18.7502 1.19972 18.881 1.31964C19.1088 1.52877 19.3158 1.75788 19.546 1.96457C19.7783 2.17321 19.9449 2.42133 19.9947 2.73429C20.0076 2.81619 19.9937 2.89516 19.9872 2.97559C19.9738 3.14182 19.941 3.30269 19.8703 3.45624C19.8012 3.6059 19.7017 3.73654 19.5858 3.8511C18.7796 4.64568 17.9698 5.43636 17.1611 6.22851C16.4707 6.90464 15.7808 7.58028 15.0904 8.2564C14.2076 9.12167 13.3242 9.98694 12.4413 10.8522C11.5858 11.6902 10.7308 12.5281 9.87532 13.3656C9.46448 13.7683 9.05612 14.1729 8.6418 14.5721C8.45976 14.7481 8.25831 14.8992 8.00216 14.9621C7.89721 14.9875 7.79176 15.0026 7.68383 14.9996L7.68433 14.9987Z" fill="#111111"/>
                        </svg>`;
            }
            if (temp.type == "aviso") {
                color = "#FFE600";
                colorP = "#FFE600";
                border = yellow;
                textColor = "text-black"
                icon = `<svg xmlns="http://www.w3.org/2000/svg" width="16" height="20" viewBox="0 0 16 20" fill="none">
                            <path d="M13.8965 12.0359C13.7996 12.0359 13.7066 11.9928 13.6381 11.9163C13.5696 11.8398 13.5311 11.736 13.5311 11.6278V8.53522C13.5304 7.04354 13.0584 5.59993 12.1981 4.45867C11.3379 3.31741 10.1446 2.55171 8.82837 2.29636C9.01774 2.05212 9.12039 1.73885 9.11688 1.41582C9.12132 1.19134 9.07683 0.969036 8.98723 0.76802C8.89762 0.567005 8.7656 0.393306 8.60253 0.261917C8.43946 0.130527 8.25023 0.0453718 8.05114 0.0137804C7.85205 -0.017811 7.64906 0.00510523 7.45967 0.0805662C7.27027 0.156027 7.10014 0.281753 6.96393 0.446937C6.82772 0.612122 6.72952 0.811829 6.67778 1.02881C6.62604 1.24578 6.62231 1.47353 6.66691 1.69247C6.71152 1.91141 6.80312 2.11498 6.93383 2.28561C5.60894 2.53218 4.40535 3.29555 3.53719 4.43993C2.66903 5.5843 2.1926 7.03546 2.19267 8.53522V11.6707C2.19267 11.7816 2.17296 11.8915 2.13466 11.9938C2.09636 12.0961 2.04025 12.1889 1.96957 12.2668C1.89889 12.3448 1.81506 12.4062 1.72294 12.4477C1.63082 12.4891 1.53224 12.5098 1.43293 12.5084C1.05201 12.5112 0.687559 12.6821 0.419106 12.9838C0.150653 13.2856 -8.46476e-06 13.6937 3.56699e-10 14.1191V15.4506C3.56699e-10 15.6101 0.0567366 15.763 0.157734 15.8758C0.258732 15.9885 0.395715 16.0519 0.538548 16.0519H5.18354C5.14224 16.2455 5.11967 16.4435 5.11622 16.6425C5.09399 17.0632 5.14901 17.4846 5.27791 17.8808C5.40681 18.2769 5.60686 18.6394 5.86578 18.9461C6.12471 19.2527 6.43704 19.4971 6.7836 19.6641C7.13016 19.8311 7.50364 19.9172 7.8811 19.9172C8.25856 19.9172 8.63204 19.8311 8.9786 19.6641C9.32516 19.4971 9.63749 19.2527 9.89641 18.9461C10.1553 18.6394 10.3554 18.2769 10.4843 17.8808C10.6132 17.4846 10.6682 17.0632 10.646 16.6425C10.641 16.4442 10.6217 16.2467 10.5883 16.0519H15.1852C15.328 16.0519 15.465 15.9885 15.566 15.8758C15.667 15.763 15.7237 15.6101 15.7237 15.4506V14.1191C15.7289 13.8476 15.6854 13.5776 15.5958 13.3251C15.5063 13.0725 15.3725 12.8426 15.2023 12.6485C15.0322 12.4545 14.829 12.3003 14.6048 12.1951C14.3805 12.0899 14.1397 12.0358 13.8965 12.0359Z" fill="#111111"/>
                        </svg>`;
            }
            html = `
                            <div class="notification items-start" id="n${id}">
                    <div class="conteudo" id="c${id}" style="${border}">
                        <div class="notify-info">
                            <div class="div-title" style="background: ${color};">
                           
                            <i style="color: #ffffff;" class="iconDiv ">${icon}</i>
                       
                                <div class="notify-title uppercase font-bold ${textColor}"> ${actualConfig[data.config].title} </div>
                            </div>
                            
                            <div class="notify-body">
                                ${temp.message === undefined ? "" : ` 
                                    <span class="message">
                                        <p id="m${id}">${temp.message}</p>
                                    </span>
                                `} 
                                ${temp.criminal === undefined ? "" : ` 
                                    <span class="criminal">Via: ${temp.criminal}</span>
                                `} 
                                ${temp.vehicle === undefined ? "" : ` 
                                    <span class="vehicle">${temp.vehicle}</span>
                                `} 
                                ${temp.name === undefined ? "" : ` 
                                    <span class="name">${temp.name}</span>
                                `}
                                <div style="margin-top: 5px;"></div>
                                <div class="progressBg">
                                <div class="progress" id="progress${id}" style="background: ${colorP};"></div>
                            </div>
                            </div>
                                
                        
                    </div>
                </div>
                `;
            };

        // console.log(temp.type);
        // <div class="copa"></div>
        if (temp.type == "pizza" || temp.type == "festinha" || temp.type == "qru" || temp.type == "qrut" || temp.type == "chamadoemergencia" || temp.type == "qth" || temp.type == "Caixa Eletronico" || temp.type == "AmmuNation" || temp.type == "Lojinha" || temp.type == "Central" || temp.type == "Açougue" || temp.type == "Galinheiro" || temp.type == "Paleto") {
            list.push(html);
            setTimeout(function () {
                removerUltimoItem();
            }, 30000);
        };

        if (!blocked) {
            var tempTime = 0;
            if (temp.time != undefined || temp.time > 0) {
                tempTime = temp.time;
            } else {
                tempTime = actualConfig[data.config].time;
            };

            setTimeout(function () {
                $("#n" + id).remove();
                $("#progress" + id).remove();
            }, tempTime * 5);

            if (temp.type == "rr" || temp.type == "adm-id" || temp.type == "dm-ilegal" || temp.type == "dmpm" || temp.type == "dm-staff") {
                $(html).prependTo(".notifications2")
                    .hide()
                    .show("slide", { direction: "right" }, 450)
                    .delay(tempTime)
                    .hide("slide", { direction: "right" }, 450);
                move("progress" + id, tempTime);
            } else if (temp.type == "beijo" || temp.type == "correio" || temp.type == "recrutamento") {
                $(html).appendTo(".notifications3")
                    .hide()
                    .show("slide", { direction: "right" }, 450)
                    .delay(tempTime)
                    .hide("slide", { direction: "right" }, 450);
                move("progress" + id, tempTime, "n" + id);
            } else {
                $(html).appendTo(".notifications")
                    .hide()
                    .show("slide", { direction: "right" }, 450)
                    .delay(tempTime)
                    .hide("slide", { direction: "right" }, 450);
                move("progress" + id, tempTime, "n" + id);
            };
        }
        update_fontsize(id);
        new Audio('plim.mp3').play();
    }

    const showLast = () => {
        hideAll()
        blocked = true
        $(".notifications").css("overflow-y", "scroll")
        for (i in list) {
            $(list[i]).prependTo(".notifications")
        }
    }

    function removerUltimoItem() {
        if (list.length > 0) {
            list.pop();
        }
    }
})

var update_fontsize = function (n) {
    var notifyWidth = $("#c" + n).height();
    var notifyHeight = $("#n" + n).height();
    var newSize = notifyWidth / 2100
    $("#i" + n).css('height', notifyHeight + "px");
    if (notifyWidth >= 500) {
        $("#m" + n).css('font-size', newSize + "vw");

    } else if (notifyWidth <= 200) {
        $("#red" + n).css('margin-left', "40%");
    };
};

function move(item, time, rem) {
    var elem = document.getElementById(item);
    if (elem) {
        var i = 0;
        if (i == 0) {
            i = 1;

            var width = 100;
            var id = setInterval(frame, time / 100);
            function frame() {
                if (width <= 0) {
                    clearInterval(id);
                    i = 0;
                    $('.ui-effects-placeholder').each(function () {
                        $(this).remove();
                    });
                    $('.notification').each(function () {
                        if ($(this).attr('id') == undefined || $(this).attr('id') <= 0 || $(this).attr('id') == "") {
                            // console.log("^1 Notify Cleaned");
                            $(this).remove();
                        };
                    });
                } else {
                    width--;
                    elem.style.width = (width * 0.8) + "%";
                }
            };
        }
    };

}

function randomNum(min, max) {
    return Math.floor(Math.random() * (max - min)) + min;
}

function selectConfigItem(item) {

}

var mec = "FUSIONRACE";
function showInput(type) {

    (async () => {

        const { value: text } = await Swal.fire({
            input: 'textarea',
            title: 'Anuncio Mecanicos',
            inputPlaceholder: 'Sua mensagem aqui',
            showCancelButton: true,
            cancelButtonText: 'Cancelar',
            customClass: 'swal-custom2',
            cancelButtonColor: 'red',
            confirmButtonText: 'Enviar ✈️',
            footer: '<button type="button" id="previewntf" class="focus:outline-none text-white bg-purple-700 hover:bg-purple-800 focus:ring-4 focus:ring-purple-300 font-medium rounded-lg text-sm px-5 py-2.5 mb-2 dark:bg-purple-600 dark:hover:bg-purple-700 dark:focus:ring-purple-900">Testar Notificação</button>',
            html:
                '<p>Tempo em segundos: <input id="swal-time" class="swal2-input" type="number" value="30"></input></p><br>' +
                '<h3 class="text-3xl font-bold text-purple-500">SELECIONE A MECANICA</h3><br>' +
                '<div class="flex justify-center"> <div class="flex items-center mr-4"><img src="https://i.imgur.com/HwvGPiD.png" width="64" height="64"><input id="inline-radio" type="radio" checked="true" value="" name="inline-radio-group" class="w-4 h-4 text-blue-600 focus:ring-blue-600 ring-offset-gray-800 focus:ring-2 bg-gray-700 border-gray-600"> <label for="inline-radio" class="ml-2 text-sm font-medium text-purple-300">Fusion Race</label> </div><div class="flex items-center mr-4"><img src="https://i.imgur.com/YD5jtFr.png" width="64" height="64"></img><input id="inline-2-radio" type="radio" value="" name="inline-radio-group" class="w-4 h-4 text-blue-600 bg-gray-100 border-gray-300 focus:ring-blue-500 dark:focus:ring-blue-600 dark:ring-offset-gray-800 focus:ring-2 dark:bg-gray-700 dark:border-gray-600"> <label for="inline-2-radio" class="ml-2 text-sm font-medium text-purple-300">Stop Car</label> </div>' +
                '',
        })

        if (text) {
            //Swal.fire(text) -- swal2-radio
            $.post("http://vrp_notifypush/returnText", JSON.stringify({
                text: text,
                time: $("#swal-time").val() * 1000,
                type: mec
            }));
            mec = "FUSIONRACE";
        }

    })()
}
var configItemSelected = false;
var itemID = 0;
var itemName = '';

function configSelected(index, name) {
    configItemSelected = true;
    $('#notifysConfig').html(``);
    $('#previewnotifyC').html(``);
    const notifyAllowedList = {

        "anuncioeb": {
            "html": `
            <div class="max-w-[17vw] rect3" id="0" data-x=1" data-y="2">
                
            <div class="conteudo">
            <div class="icon-logo">
                </div>
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title00" style="${actualConfig.anuncioeb.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anuncioeb.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anuncioeb.colors} / 24%);"><p id="tituulo">${actualConfig.anuncioeb.title}</p></span>
                            <br>
                            </div>
                            <div class="notify-body">
                            <span class="message4"><p id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </p></span>                     
                            <span class="criminal" >Via Oficial: Fusion Group</span>
                                <span class="txt3">Aperte F3 e clique nesta notificação para a localização ser marcada no mapa</span>
                            </div>
                        </div>
                        </div>
                    </div><div class="progress" style="background-color:${actualConfig.anuncioeb.pCollor};" id="progress1"></div></div>
            `
        },
        "anuncio": {
            "html": `
            <div class="max-w-[17vw]" id="0">
            <div class="linearGrad" style="background: linear-gradient(90deg,${actualConfig.policia.pCollor}  0%, rgba(184,69,69,0.006039915966386533) 50%);">
            <div class="iconDiv"><i class="fa-1x ${actualConfig.anuncioeb.src}" style="${actualConfig.policia.sTitle}"></i></div>
            <div class="conteudo" id="c0">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.policia.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.policia.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.policia.colors} / 24%);"><p id="tituulo">${actualConfig.policia.title}</p></span>
                            </div>
                            <div class="notify-body">
                               <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.policia.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.policia.colors} / 24%);"><p id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </p></span>
                                <span class="criminal">Via Copom: Fusion Group</span>
                            </div>
                        </div>
                        </div>
                        
                        
                </div></div></div></div>
            `
        },
        "anunciohp": {
            "html": `
            <div class="max-w-[17vw] rect5555" id="n0" data-x="0" data-y="0">
            <div class="conteudo">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title0 text-center antialiased" style="${actualConfig.anunciohp.sTitle}"><p id="tituulo">${actualConfig.anunciohp.title}</p></span>
                            <br>
                            </div>
                            <div class="notify-body">
                                <span class="message3 text-center antialiased" id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </span>
                                <span class="criminal">Via Doutor: Fusion Group</span>
                                <span class="txt3">Aperte F3 e clique nesta notificação para a localização ser marcada no mapa</span>
                            </div>
                        </div>
                    </div></div>
            `
        },
        "FURIACUSTOM": {
            "html": `
            <div class="max-w-[17vw] rect55" id="0" data-x="0" data-y="0">
                    
            <div class="conteudo">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title3 text-center antialiased" style="${actualConfig.FURIACUSTOM.sTitle}"><p id="tituulo">${actualConfig.FURIACUSTOM.title}</p></span>
                            <br>
                            </div>
                            <div class="notify-body">
                                <span class="message3 text-center antialiased" id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </span>
                                <span class="criminal">Via Mecânico: Fusion Group</span>
                                <span class="txt3">Aperte F3 e clique nesta notificação para a localização ser marcada no mapa</span>
                            </div>
                        </div>
                    </div></div>
            `
        },

        "anunciooab": {
            "html": `
            <div class="max-w-[17vw] rect515" id="n0" data-x="0" data-y="0">
            <div class="conteudo">
                        <div class="notify-info">
                            <span class="notify-title4 antialiased" style="${actualConfig.anunciooab.sTitle}">${actualConfig.anunciooab.title}</span>
                            <br>
                            <div class="notify-body">
                                <span class="message3 text-center antialiased" id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </span>
                                <span class="criminal">Via Advogado: Fusion Group</span>
                                <span class="txt3">Aperte F3 e clique nesta notificação para a localização ser marcada no mapa</span>
                            </div>
                        </div>
                    </div></div>
            `
        },
        "staff": {
            "html": `
            <div class="max-w-[17vw]" id="0">
            <div class="linearGrad" style="background: linear-gradient(90deg,${actualConfig.staff.pCollor}  0%, rgba(184,69,69,0.006039915966386533) 50%);">
            <div class="iconDiv"><i class="fa-1x ${actualConfig.anuncioeb.src}" style="${actualConfig.staff.sTitle}"></i></div>
            <div class="conteudo" id="c0">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.staff.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.staff.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.staff.colors} / 24%);"><p id="tituulo">${actualConfig.staff.title}</p></span>
                            </div>
                            <div class="notify-body">
                               <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.staff.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.staff.colors} / 24%);"><p id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </p></span>
                                <span class="criminal">Via Staff: Fusion Group</span>
                            </div>
                        </div>
                        </div>
                        
                        
                </div></div></div></div>
            `
        },
        "anuncionews": {
            "html": `
            <div class="max-w-[17vw]" id="0">
            <div class="linearGrad" style="background: linear-gradient(90deg,${actualConfig.anuncionews.pCollor}  0%, rgba(184,69,69,0.006039915966386533) 50%);">
            <div class="iconDiv"><i class="fa-1x ${actualConfig.anuncioeb.src}" style="${actualConfig.anuncionews.sTitle}"></i></div>
            <div class="conteudo" id="c0">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.anuncionews.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anuncionews.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anuncionews.colors} / 24%);"><p id="tituulo">${actualConfig.anuncionews.title}</p></span>
                            </div>
                            <div class="notify-body">
                               <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anuncionews.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anuncionews.colors} / 24%);"><p id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </p></span>
                                <span class="criminal">Via Repórter: Fusion Group</span>
                            </div>
                        </div>
                        </div>
                        
                        
                </div></div></div></div>
            `
        },

        "festinha": {
            "html": `
            <div class="max-w-[17vw] notification2" id="n0" data-x="0" data-y="0">
            <div class="conteudo">
                </div>
                        <div class="notify-info">
                        <div class="notify-title">
                        <span class="notify-title" style="${actualConfig.festinha.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.festinha.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.festinha.colors} / 24%); padding-left: 10px;"><p id="tituulo">${actualConfig.festinha.title}</p></span>
                        </div>
                            <div class="notify-body">
                                <span class="criminal"><p id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </p></span>
                                <span class="criminal">Via Festeiro: Fusion Group</span>
                                <span class="txt">Aperte F3 e clique nesta notificação para a localização ser marcada no mapa</span>
                            </div>
                        </div>
                        </div>
                </div></div>
            `
        },

        "anunciobm": {
            "html": `
            <div class="max-w-[17vw] notification2 rect" id="n0" data-x="0" data-y="0">
            <div class="conteudo">
                </div>
                        <div class="notify-info">
                        <div class="notify-title">
                        <span class="notify-title" style="${actualConfig.anunciobm.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anunciobm.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anunciobm.colors} / 24%); padding-left: 10px;"><p id="tituulo">${actualConfig.anunciobm.title}</p></span>
                        </div>
                            <div class="notify-body">
                                <span class="criminal"><p id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </p></span>
                                <span class="criminal">Via Bombeiro: Fusion Group</span>
                            </div>
                        </div>
                        </div>
                </div></div>
            `
        }
    }
    var notifyAllowedListS = {
        "anuncio": {
            "html": `
            <div class="max-w-[17vw]" id="0">
            <div class="linearGrad" style="background: linear-gradient(90deg,${actualConfig[name].pCollor}  0%, rgba(184,69,69,0.006039915966386533) 50%);">
            <div class="iconDiv"><i class="fa-1x ${actualConfig.anuncioeb.src}" style="${actualConfig[name].sTitle}"></i></div>
            <div class="conteudo" id="c0">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig[name].sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig[name].colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig[name].colors} / 24%);"><p id="tituulo">${actualConfig[name].title}</p></span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig[name].colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig[name].colors} / 24%);"><p id="m0demo">TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM TEXTO MENSAGEM </p></span>
                            </div>
                        </div>
                        </div>
                        
                        
                </div></div></div></div>
            `
        }
    }


    if (notifyAllowedList[name]) {
        $(notifyAllowedList[name].html).prependTo('#previewnotifyC')
    } else {
        $(notifyAllowedListS['anuncio'].html).prependTo('#previewnotifyC')
    }



    $('#previewnotifyE').removeClass('invisible')

    $('#titulo').val(actualConfig[name].title)
    $('#cor-titulo').val(actualConfig[name].sTitle)
    $('#icone').val(actualConfig[name].src)
    $('#cor-brilho').val(actualConfig[name].colors)
    $('#tempo-brilho').val(actualConfig[name].time)
    $('#cor-degrade').val(actualConfig[name].pCollor)

}

$(document).on("input", "#titulo", function () {
    $("#tituulo").text($(this).val())
})

$(document).on("input", "#cor-titulo", function () {
    $("#tituulo").text($(this).val())
})

function showLogs() {
    Swal.fire({
        title: 'Fusion Logs',
        html: '<iframe src="https://logs.fusionhost.com.br/dashboard" style="position:fixed; top:5%; left:5%; bottom:0; right:0; width:90%; height:95%; border:none; margin:0; padding:0;"></iframe>',
        showCancelButton: false,
        showConfirmButton: false,
        confirmButtonColor: '#3085d6',
    })
}

function showConfig() {
    $("#mainWindow").show(250);
}

function saveCfg(config) {
    $.post("http://vrp_notifypush/saveCfg", JSON.stringify(config))
    Swal.fire({
        icon: 'success',
        title: 'Configuração Salva',
        showConfirmButton: false, timer: 1000
    })
    $.post("http://vrp_notifypush/focusOff")
}

$(document).on("click", ".notify-button", function () {
    $.post("http://vrp_notifypush/setWay", JSON.stringify({
        x: $(this).attr("data-x"),
        y: $(this).attr("data-y")
    }))
})

$(document).on("click", ".notification", function () {
    if (removingActive) {
        // console.log($(this).attr("id"))
        $.post("http://vrp_notifypush/removeNotify", JSON.stringify({
            id: $(this).attr("id")
        }));
    } else {
        $.post("http://vrp_notifypush/setWay2", JSON.stringify({
            x: $(this).attr("data-x"),
            y: $(this).attr("data-y")
        }));
    }
})

$(document).on("click", ".notification2", function () {
    if (removingActive) {
        // console.log($(this).attr("id"))
        $.post("http://vrp_notifypush/removeNotify", JSON.stringify({
            id: $(this).attr("id")
        }));
    } else {
        $.post("http://vrp_notifypush/setWay2", JSON.stringify({
            x: $(this).attr("data-x"),
            y: $(this).attr("data-y")
        }));
    }
})

$(document).on("click", ".notification3", function () {
    if (removingActive) {
        // console.log($(this).attr("id"))
        $.post("http://vrp_notifypush/removeNotify", JSON.stringify({
            id: $(this).attr("id")
        }));
    } else {
        $.post("http://vrp_notifypush/setWay2", JSON.stringify({
            x: $(this).attr("data-x"),
            y: $(this).attr("data-y")
        }));
    }
})

$(document).on("click", ".notify-button2", function () {
    $.post("http://vrp_notifypush/phoneCall", JSON.stringify({ phone: $(this).attr("data-phone") }))
})

$(document).on("click", "#previewntf", function () {
    var text = $('.swal2-textarea').val();
    $.post("http://vrp_notifypush/previewNotify", JSON.stringify({ mec: mec, text: text }))
})

$(document).on("click", "#inline-radio", function () {
    mec = "FUSIONRACE"
})

$(document).on("click", "#inline-2-radio", function () {
    mec = "STOPCAR"
})

$(document).on("input", "#emojiinput", function () {
    $("#m0demo").text($(this).val())
    $("#errordiv").remove()
    $('#emojiinput').removeClass('border-red-900 border-8')
})

var notifyLoaded = null

function loadNotify(n) {

    $('#previewnotify').empty()
    const notifyAllowedList = [
        {
            type: 'anuncioeb',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.anuncioeb.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anuncioeb.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anuncioeb.colors} / 24%);">${actualConfig.anuncioeb.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anuncioeb.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anuncioeb.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="criminal">Via Militar: Fusion Group</span>
                            </div></div></div>
            `
        },
        {
            type: 'policia',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.policia.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.policia.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.policia.colors} / 24%);">${actualConfig.policia.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.policia.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.policia.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="criminal">Via Copom: Fusion Group</span>
                            </div></div></div>
            `
        },
        {
            type: 'anunciohp',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.anunciohp.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anunciohp.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anunciohp.colors} / 24%);">${actualConfig.anunciohp.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anunciohp.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anunciohp.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="criminal">Via Médico: Fusion Group</span>
                            </div></div></div>
            `
        },
        {
            type: 'FURIACUSTOM',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.FURIACUSTOM.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.FURIACUSTOM.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.FURIACUSTOM.colors} / 24%);">${actualConfig.FURIACUSTOM.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.FURIACUSTOM.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.FURIACUSTOM.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="criminal">Via Mecânico: Fusion Group</span>
                            </div></div></div>
            `
        },
        {
            type: 'anunciooab',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.anunciooab.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anunciooab.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anunciooab.colors} / 24%);">${actualConfig.anunciooab.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anunciooab.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anunciooab.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="criminal">Via Staff: Fusion Group</span>
                            </div></div></div>
            `
        },
        {
            type: 'staff',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.staff.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.staff.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.staff.colors} / 24%);">${actualConfig.staff.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.staff.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.staff.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="criminal">Via Staff: Fusion Group</span>
                            </div></div></div>
            `
        },
        {
            type: 'festinha',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo rect" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.festinha.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.festinha.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.festinha.colors} / 24%);">${actualConfig.festinha.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.festinha.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.festinha.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="criminal">Via Repórter: Fusion Group</span>
                            </div></div></div>
            `
        },
        {
            type: 'anuncionews',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.anuncionews.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anuncionews.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anuncionews.colors} / 24%);">${actualConfig.anuncionews.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anuncionews.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anuncionews.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="criminal">Via Repórter: Fusion Group</span>
                            </div></div></div>
            `
        },
        {
            type: 'anunciobm',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.anunciobm.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anunciobm.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anunciobm.colors} / 24%);">${actualConfig.anunciobm.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.anunciobm.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.anunciobm.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="criminal">Via Bombeiro: Fusion Group</span>
                            </div></div></div>
            `
        },
        {
            type: 'creche',
            html: `
            <div class="max-w-[17vw] notification" id="0" data-x="0" data-y="0">
            <div class="conteudo custom-background" id="c534">
                        <div class="notify-info">
                            <div class="notify-title">
                            <span class="notify-title" style="${actualConfig.creche.sTitle};text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.creche.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.creche.colors} / 24%);">${actualConfig.creche.title}</span>
                            </div>
                            <div class="notify-body">
                            <span class="message" style="text-shadow: 0 0 0.5208333333333334vw rgb(${actualConfig.creche.colors} / 35%), 0 0 0.2604166666666667vw rgb(${actualConfig.creche.colors} / 24%);"><p id="m0demo">NADA</p></span>
                            <span class="name">Via BabyCare: Fusion Group</span>
                            </div></div></div>
            `
        }
    ]
    $(notifyAllowedList[n].html).prependTo('#previewnotify')
    notifyLoaded = notifyAllowedList[n].type
    $("#m0demo").text($("#emojiinput").val())

}

function sendNotify() {
    if ($('#emojiinput').val().length <= 15) {
        $('#emojiinput').addClass('border-red-900 border-8')
        var novaDiv = $('<div id="errordiv">');
        novaDiv.text('TEXTO MUITO PEQUENO');
        novaDiv.css({
            'color': 'red',
            'position': 'absolute',
            'top': 0,
            'left': 0
        });
        $('#emojiinput').after(novaDiv);
    } else {
        $.post("http://vrp_notifypush/sendNotify", JSON.stringify({
            type: notifyLoaded,
            text: $('#emojiinput').val(),
            perms: $('#message').val()
        }))
        $('#btnEnviar').hide()
        setTimeout(function () {
            $('#btnEnviar').show(250)
        }, 5000);
    }
}

function tabs() {
    return {
        previousTab: 0,
        activeTab: 0,
        width: 0,
        x: 0,

        setWidthAndXFromElement(element) {
            const width = element.clientWidth
            const x = element.offsetLeft

            this.x = x
            this.width = width
        },

        container: {
            ['x-on:load.window']() {
                const element = this.$refs.tabs.children[0]

                this.setWidthAndXFromElement(element)

                element.classList.add('text-slate-50')
            },
        },

        indicator: {
            ['x-bind:style']() {
                return `width: ${this.width}px; transform: translateX(${this.x}px)`
            }
        },

        tab: {
            ['@click'](event) {
                const element = event.target

                this.setWidthAndXFromElement(element)

                this.previousTab = this.activeTab

                this.activeTab = Array
                    .from(this.$refs.tabs.children)
                    .indexOf(element)

                this.$refs.tabs.children[this.previousTab]
                    .classList
                    .remove('text-slate-50')

                element.classList.add('text-slate-50')
            }
        }
    }
}

function selectRemovalNotify() {
    if (removingActive) {
        $('.notification').each(function () {
            $(this).addClass('outline outline-offset-2 outline-pink-500 animate-bounce');
        });
    }
}

setInterval(selectRemovalNotify, 1000);
var configHtml = ``;

function paginate(n) {
    $('#previewnotifyE').addClass('invisible')
    $('#previewnotifyC').html(``);
    $(".pages").each(function (index) {
        $(this).hide("slide", { direction: "left" }, 450).delay(100)
    });
    $("#page" + n).removeClass("invisible")
    $("#page" + n).show("slide", { direction: "right" }, 450).delay(100)
    if (n == 2) {
        removingActive = true
    } else {
        removingActive = false
    }
    if (n == 3) {
        $("#notifysConfig").html(``);
        $("#notifysConfigC").html(``);
        configHtml = ``
        var keys = Object.keys(actualConfig);
        Object.values(actualConfig).map((item, index) => {
            configHtml = configHtml + `
            <div class="config-item" id="cfg${index}" onclick="configSelected(${index},'${keys[index]}')">
   <div class="notification-CFG" style="width: 12.625vw;">
   <div class="linearGrad" style="background: linear-gradient(90deg,${item.pCollor}  0%, rgba(184,69,69,0.006039915966386533) 50%);">
            <div class="iconDiv"><i class="${item.src} fa-1x" style="${item.sTitle}"></i></div>
      <div class="conteudo">

         <div class="notify-info">
            <div class="notify-title">
               <span class="notify-title" style="${item.sTitle};text-shadow: 0 0 10px rgb(${item.colors} / 35%), 0 0 5px rgb(${item.colors} / 24%);">${item.title}</span>
            </div>
            <div class="notify-body">
            <span class="message" style="text-shadow: 0 0 10px rgb(${item.colors} / 35%), 0 0 5px rgb(${item.colors} / 24%);"><p">Pré Visualização</p></span>
            </div>
         </div>
      </div>
   </div>
   </div>
</div>`;
        });
        $("#notifysConfig").html(configHtml);
    }
};

let browserSupportsTextareaTextNodes;

/**
 * @param {HTMLElement} input          
 * @return {boolean}
 */
function canManipulateViaTextNodes(input) {
    if (input.nodeName !== "TEXTAREA") {
        return false;
    }
    if (typeof browserSupportsTextareaTextNodes === "undefined") {
        const textarea = document.createElement("textarea");
        textarea.value = 1;
        browserSupportsTextareaTextNodes = !!textarea.firstChild;
    }
    return browserSupportsTextareaTextNodes;
}

/**
 * @param {HTMLTextAreaElement|HTMLInputElement} input
 * @param {string} text
 * @returns {void}
 */
function emojipicker(input, text) {
    input.focus();

    if (document.selection) {
        const ieRange = document.selection.createRange();
        ieRange.text = text;

        ieRange.collapse(false);
        ieRange.select();

        return;
    }

    const isSuccess = document.execCommand("insertText", false, text);
    if (!isSuccess) {
        const start = input.selectionStart;
        const end = input.selectionEnd;
        if (typeof input.setRangeText === "function") {
            input.setRangeText(text);
        } else {
            const range = document.createRange();
            const textNode = document.createTextNode(text);

            if (canManipulateViaTextNodes(input)) {
                let node = input.firstChild;

                if (!node) {
                    input.appendChild(textNode);
                } else {
                    let offset = 0;
                    let startNode = null;
                    let endNode = null;

                    while (node && (startNode === null || endNode === null)) {
                        const nodeLength = node.nodeValue.length;

                        if (start >= offset && start <= offset + nodeLength) {
                            range.setStart((startNode = node), start - offset);
                        }

                        if (end >= offset && end <= offset + nodeLength) {
                            range.setEnd((endNode = node), end - offset);
                        }

                        offset += nodeLength;
                        node = node.nextSibling;
                    }

                    if (start !== end) {
                        range.deleteContents();
                    }
                }
            }

            if (canManipulateViaTextNodes(input) && range.commonAncestorContainer.nodeName === '#text') {
                range.insertNode(textNode);
            } else {
                const value = input.value;
                input.value = value.slice(0, start) + text + value.slice(end);
            }
        }

        input.setSelectionRange(start + text.length, start + text.length);

        const e = document.createEvent("UIEvent");
        e.initEvent("input", true, false);
        input.dispatchEvent(e);
    }
}

document.querySelector('emoji-picker').addEventListener('emoji-click', event => emojipicker(document.getElementById('emojiinput'), event.detail.unicode));