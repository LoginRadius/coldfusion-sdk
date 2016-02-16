<script type="text/html" id="loginradiuscustom_tmpl">
    <span class="lr-icon-frame" alt ="<#= Name.toLowerCase() #>">
            <span class="lr-icon lr-raas-<#= Name.toLowerCase() #>">
                    <span class="lr-provider-label" onclick="return $SL.util.openWindow('<#= Endpoint #>&is_access_token=true&callback=<cfoutput>#YOUR_DOMAIN#</cfoutput>');" title="<#= Name #>" alt="Sign in with <#=Name#>"><#=Name#>
                    </span>
                </span>
         </span>
</script>
<script type="text/javascript">
$(document).ready(function () {
    initializeRaasForms(raasoption);
    LoginRadiusRaaS.CustomInterface(".interfacecontainerdiv", raasoption);
    show_birthdate_date_block();
    });
</script>
<cfinclude template="../front/header.cfm">

<!-- Social Login Interface -->
  <div class="lr-frame lr-input-style">
      <div class="lr-heading">Login with</div>
      <div class="lr-login-buttons-frame lr-space-fix">
          <div class="interfacecontainerdiv"></div>
</div>
      <!-- Traditional login interface -->
      <div id="lr-sign-in" class="lr-traditional-frame lr-pos-r lr-trad-login">
          <div class="lr-heading lr-small lr-pos-a lr-or-bubble"><span>Or with email</span></div>
          <div class="lr-form-frame lr-align-left">
              <div id="login-container"></div>
              <div class="lr-submit-frame lr-align-right">
                  <!-- lr-pull-left pulls the submit button to left with float. you can change it to right, or left. no center, sorry :( -->
                        <span class="lr-link-frame lr-pull-left">
                            <span class="lr-link lr-register" data-form="lr-register"><a>Register</a></span>
                            <span class="lr-link lr-forgot-pass" data-form="lr-forgot-pw"><a>Forgot Password?</a></span>
                        </span>
              </div>
              <div style="clear: both"></div>
              </div>
          </div>
          <!-- Traditional Register interface -->
      <div id="lr-register" class="lr-traditional-frame lr-trad-register lr-pos-r">
          <div class="lr-heading lr-small lr-pos-a lr-or-bubble"><span>Or create your account</span></div>
          <div class="lr-form-frame lr-align-left">
              <div id="registeration-container">
              </div>
              <div class="lr-submit-frame lr-align-right">
                  <!-- lr-pull-left pulls the submit button to left with float. you can change it to right, or left. no center, sorry :( -->
                        <span class="lr-link-frame lr-pull-left">
                            <span class="lr-link lr-sign-in" data-form="lr-sign-in"><a>Sign In</a></span>
                            <span class="lr-link lr-forgot-pass" data-form="lr-forgot-pw"><a>Forgot Password?</a></span>
                        </span>
              </div>
              <div style="clear: both"></div>
          </div>
      </div>
      <!-- Show Social registration form.  -->
      <div id="lr-social-register" class="lr-traditional-frame lr-social-register lr-pos-r">
          <div class="lr-heading lr-small lr-pos-a lr-or-bubble"><span>Complete your profile to Register</span></div>
          <div class="lr-form-frame lr-align-left">
              <div id="social-registration-container">

              </div>
              <div class="lr-submit-frame lr-align-right">
                  <!-- lr-pull-left pulls the submit button to left with float. you can change it to right, or left. no center, sorry :( -->
                        <span class="lr-link-frame lr-pull-left">
                            <span class="lr-link lr-sign-in" data-form="lr-sign-in"><a>Sign In</a></span>
                            <span class="lr-link lr-forgot-pass" data-form="lr-forgot-pw"><a>Forgot Password?</a></span>
                        </span>
              </div>
              <div style="clear: both"></div>
          </div>
      </div>
      <!-- Forgot Password Form  -->
      <div id="lr-forgot-pw" class="lr-traditional-frame lr-pos-r lr-trad-forgot-pw">
          <div class="lr-heading lr-small lr-pos-a lr-or-bubble"><span>Forgot Password</span></div>
          <div class="lr-form-frame lr-align-left">
              <div id="forgotpassword-container">

              </div>
              <div class="lr-submit-frame lr-align-right">
                  <!-- lr-pull-left pulls the submit button to left with float. you can change it to right, or left. no center, sorry :( -->
                        <span class="lr-link-frame lr-pull-left">
                            <span class="lr-link lr-sign-in" data-form="lr-sign-in"><a>Sign In</a></span>
                            <span class="lr-link lr-register" data-form="lr-register"><a>Register</a></span>
                        </span>
              </div>
              <div style="clear: both"></div>
              </div>
          </div>
           <!-- Reset Password Form  -->
      <div id="lr-reset-pw" class="lr-traditional-frame lr-pos-r lr-trad-reset-pw">
          <div class="lr-heading lr-small lr-pos-a lr-or-bubble"><span>Reset Password</span></div>
          <div class="lr-form-frame lr-align-left">
              <div id="resetpassword-container">

              </div>
              <div class="lr-submit-frame lr-align-right">
                  <!-- lr-pull-left pulls the submit button to left with float. you can change it to right, or left. no center, sorry :( -->
                        <span class="lr-link-frame lr-pull-left">
                            <span class="lr-link lr-sign-in" data-form="lr-sign-in"><a>Sign In</a></span>
                            <span class="lr-link lr-register" data-form="lr-register"><a>Register</a></span>
                        </span>
              </div>
              <div style="clear: both"></div>
          </div>
      </div>
</div>
<!---//End-wrap---->
<footer>
    <cfinclude template="../front/footer.cfm">
</footer>
</div>
