<#--

    Copyright © 2021 the Konveyor Contributors (https://konveyor.io/)

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

-->
<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled?? displayResetPassword=realm.password && realm.resetPasswordAllowed; section>
    <#if section = "header">
      ${msg("loginAccountTitle")}
    <#elseif section = "form">

      <#if realm.password>
        <form novalidate class="pf-c-form" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
          <#if messagesPerField.existsError('username','password')>            
            <p class="pf-c-form__helper-text pf-m-error">
              <span class="pf-c-form__helper-text-icon">
                <i class="fas fa-exclamation-circle" aria-hidden="false"></i>
              </span>${kcSanitize(messagesPerField.getFirstError('username','password'))?no_esc}
            </p>
          </#if>          
          
          <div class="pf-c-form__group">
            <label class="pf-c-form__label" for="username">
              <span class="pf-c-form__label-text"><#if !realm.loginWithEmailAllowed>${msg("username")}<#elseif !realm.registrationEmailAsUsername>${msg("usernameOrEmail")}<#else>${msg("email")}</#if></span>
              <span class="pf-c-form__label-required" aria-hidden="true">&#42;</span>
            </label>
            <#if usernameEditDisabled??>
              <input class="pf-c-form-control" required input="true" type="text" id="username" name="username" value="${(login.username!'')}" disabled />
            <#else>
              <input class="pf-c-form-control" required input="true" type="text" id="username" name="username" value="${(login.username!'')}" autofocus autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />                            
            </#if>
          </div>
          <div class="pf-c-form__group">
            <label class="pf-c-form__label" for="password">
              <span class="pf-c-form__label-text">${msg("password")}</span>
              <span class="pf-c-form__label-required" aria-hidden="true">&#42;</span>
            </label>
            <input class="pf-c-form-control" required input="true" type="password" id="password" name="password" autocomplete="off" aria-invalid="<#if messagesPerField.existsError('username','password')>true</#if>" />
          </div>
          <#if realm.rememberMe && !usernameEditDisabled??>
            <div class="pf-c-form__group">
              <div class="pf-c-check">
                <#if login.rememberMe??>
                  <input class="pf-c-check__input" type="checkbox" type="checkbox" id="rememberMe" name="rememberMe" checked />
                <#else>
                  <input class="pf-c-check__input" type="checkbox" type="checkbox" id="rememberMe" name="rememberMe" />
                </#if>
                <label class="pf-c-check__label" for="rememberMe">${msg("rememberMe")}</label>
              </div>
            </div>
          </#if>
          <div class="pf-c-form__group pf-m-action">
            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
            <input class="pf-c-button pf-m-primary pf-m-block" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
          </div>          
        </form>
      </#if>

    <#elseif section = "info">
      <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
        <p class="pf-c-login__main-footer-band-item">${msg("noAccount")} <a href="${url.registrationUrl}">${msg("doRegister")}</a></p>
      </#if>
    <#elseif section = "resetPassword">
      <#if realm.password && realm.resetPasswordAllowed>
        <p class="pf-c-login__main-footer-band-item"><a href="${url.loginResetCredentialsUrl}">${msg("doForgotPassword")}</a></p>
      </#if>
    </#if>    

</@layout.registrationLayout>
