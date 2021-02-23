<#macro registrationLayout bodyClass="" displayInfo=false displayResetPassword=false displayMessage=true displayRequiredFields=false showAnotherWayIfPresent=true>
    <!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"  "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
    <html xmlns="http://www.w3.org/1999/xhtml">

    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
        <meta name="robots" content="noindex, nofollow">

        <#if properties.meta?has_content>
            <#list properties.meta?split(' ') as meta>
                <meta name="${meta?split('==')[0]}" content="${meta?split('==')[1]}"/>
            </#list>
        </#if>
        <title>${msg("loginTitle",(realm.displayName!''))}</title>
        <link rel="icon" href="${url.resourcesPath}/img/favicon.ico"/>
        <#if properties.stylesCommon?has_content>
            <#list properties.stylesCommon?split(' ') as style>
                <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet"/>
            </#list>
        </#if>
        <#if properties.styles?has_content>
            <#list properties.styles?split(' ') as style>
                <link href="${url.resourcesPath}/${style}" rel="stylesheet"/>
            </#list>
        </#if>
        <#if properties.scripts?has_content>
            <#list properties.scripts?split(' ') as script>
                <script src="${url.resourcesPath}/${script}" type="text/javascript"></script>
            </#list>
        </#if>
        <#if scripts??>
            <#list scripts as script>
                <script src="${script}" type="text/javascript"></script>
            </#list>
        </#if>

        <script type="module" src="${url.resourcesPath}/node_modules/@patternfly/pfe-dropdown/dist/pfe-dropdown.min.js"></script>
    </head>

    <body>

      <div class="pf-c-background-image">
        <svg xmlns="http://www.w3.org/2000/svg" class="pf-c-background-image__filter" width="0" height="0">
          <filter id="image_overlay">
            <feColorMatrix type="matrix" values="1 0 0 0 0 1 0 0 0 0 1 0 0 0 0 0 0 0 1 0"></feColorMatrix>
            <feComponentTransfer color-interpolation-filters="sRGB" result="duotone">
              <feFuncR type="table" tableValues="0.086274509803922 0.43921568627451"></feFuncR>
              <feFuncG type="table" tableValues="0.086274509803922 0.43921568627451"></feFuncG>
              <feFuncB type="table" tableValues="0.086274509803922 0.43921568627451"></feFuncB>
              <feFuncA type="table" tableValues="0 1"></feFuncA>
            </feComponentTransfer>
          </filter>
        </svg>
      </div>

      <div class="pf-c-login">
        <div class="pf-c-login__container">
          <header class="pf-c-login__header">
            <img class="pf-c-brand" src="${url.resourcesPath}/img/konveyor_logo.svg" alt="Project Logo"/>
          </header>

          <main class="pf-c-login__main">
            <header class="pf-c-login__main-header">              
              <#if !(auth?has_content && auth.showUsername() && !auth.showResetCredentials())>
                <h1 class="pf-c-title pf-m-3xl"><#nested "header"></h1>
              <#else>
                <#nested "show-username">
                <div id="kc-username" class="${properties.kcFormGroupClass!}">
                    <label id="kc-attempted-username">${auth.attemptedUsername}</label>
                    <a id="reset-login" href="${url.loginRestartFlowUrl}">
                        <div class="kc-login-tooltip">
                            <i class="${properties.kcResetFlowIcon!}"></i>
                            <span class="kc-tooltip-text">${msg("restartLoginTooltip")}</span>
                        </div>
                    </a>
                </div>
              </#if>            

              <#--  Languages dropdown  -->
              <#if realm.internationalizationEnabled  && locale.supported?size gt 1>
                <div class="pf-c-dropdown">
                  <pfe-dropdown label="${locale.current}">
                    <#list locale.supported as l>
                      <pfe-dropdown-item item-type="link">
                        <a href="${l.url}">${l.label}</a>
                      </pfe-dropdown-item>
                    </#list>
                  </pfe-dropdown>
                </div>
              </#if>
            </header>

            <div class="pf-c-login__main-body">
              <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                <div class="alert-${message.type} ${properties.kcAlertClass!} pf-m-<#if message.type = 'error'>danger<#else>${message.type}</#if>">
                  <div class="pf-c-alert__icon">
                    <#if message.type = 'success'><span class="${properties.kcFeedbackSuccessIcon!}"></span></#if>
                    <#if message.type = 'warning'><span class="${properties.kcFeedbackWarningIcon!}"></span></#if>
                    <#if message.type = 'error'><span class="${properties.kcFeedbackErrorIcon!}"></span></#if>
                    <#if message.type = 'info'><span class="${properties.kcFeedbackInfoIcon!}"></span></#if>
                  </div>
                  <span class="${properties.kcAlertTitleClass!}">${kcSanitize(message.summary)?no_esc}</span>
                </div>
              </#if>

              <#nested "form">

              <#if auth?has_content && auth.showTryAnotherWayLink() && showAnotherWayIfPresent>
                <form id="kc-select-try-another-way-form" action="${url.loginAction}" method="post">
                  <div class="${properties.kcFormGroupClass!}">
                      <input type="hidden" name="tryAnotherWay" value="on"/>
                      <a href="#" id="try-another-way" onclick="document.forms['kc-select-try-another-way-form'].submit();return false;">${msg("doTryAnotherWay")}</a>
                  </div>
                </form>
              </#if>

              
            </div>

            <footer class="pf-c-login__main-footer">              
              <#if realm.password && social.providers??>
                <ul class="pf-c-login__main-footer-links">
                    <#list social.providers as p>
                        <li id="social-${p.alias}" class="pf-c-login__main-footer-links-item">
                          <a href="${p.loginUrl}" class="pf-c-login__main-footer-links-item-link" aria-label="Log in with ${p.displayName!}">
                            <#if p.iconClasses?has_content>
                              <i class="${properties.kcCommonLogoIdP!} ${p.iconClasses!}" aria-hidden="true"></i>
                              <span class="${properties.kcFormSocialAccountNameClass!} kc-social-icon-text">${p.displayName!}</span>
                            <#else>
                              <span class="${properties.kcFormSocialAccountNameClass!}">${p.displayName!}</span>
                            </#if>
                          </a>
                        </li>
                    </#list>
                </ul>
              </#if>
              <#if displayInfo || displayResetPassword>
                <div class="pf-c-login__main-footer-band">
                  <#if displayInfo>
                    <#nested "info">
                  </#if>
                  <#if displayResetPassword>
                    <#nested "resetPassword">
                  </#if>
                </div>
              </#if>
            </footer>
          </main>

          <footer class="pf-c-login__footer">
            <p>This is placeholder text only. Use this area to place any information or introductory message about your application that may be relevant to users.</p>
            <ul class="pf-c-list pf-m-inline">
              <li>
                <a href="#" target="_blank" rel="noopener noreferrer">Terms of use</a>
              </li>
              <li>
                <a href="#" target="_blank" rel="noopener noreferrer">Help</a>
              </li>
              <li>
                <a href="#" target="_blank" rel="noopener noreferrer">Privacy policy</a>
              </li>
            </ul>
          </footer>
        </div>
      </div>

    </body>
    </html>
</#macro>
