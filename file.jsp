<!--
Copyright (c) 2007, CA Inc. All rights reserved.
CA Inc. makes no representations concerning either
the merchantability of this software or the suitability of this
software for any particular purpose. It is provided "as is"
without express or implied warranty of any kind.
-->

<! ************************************************************************************* -->
<!--- This JSP to be used where CAPCTHA is presented from another JSP named captcha.jsp -->
<! ************************************************************************************* -->

<!----------------------------------------------------------------------------->
<!--- WARNING  WARNING WARNING WARNING ---------------------------------------->
<!----------------------------------------------------------------------------->
<!--  DO NOT CHANGE ANY JSP CODE -->
<!--- YOU MAY CHANGE THE HTML CODE FOR LOOK AND FEEL.
<!--  BUT DO NOT CHANGE THE NAME OF THE PARAMETERS THAT ARE POSTED TO THE FCC-->


<FORM NAME="mainForm" METHOD=POST>


<%@ page import = "java.util.*" %>
<%@ page import = "java.io.*" %>


<jsp:useBean
                        id = "smdecoder"
                        class="com.ca.captchaauth.SmDecoder"
                        scope="application"
/>




<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">

<HTML>
<BODY BGCOLOR="#ffffff" TEXT="#000000" LINK="#333399" VLINK="purple" ALINK="purple" >



<FORM NAME="mainForm" METHOD=POST>
<HEAD>
<TITLE> Login Page </TITLE>

</HEAD>



<center>
<!-- outer table with border -->
<table width="50%" border="1" cellpadding="0" cellspacing="0">
<tr> <td>

<!-- Login table -->
<table width="100%" border="0" bgcolor="#ffefd5" height=200 cellpadding="0" cellspacing="0">


<tr> <td colspan=4 height=20> <font size=1> &nbsp; </font> </td> </tr>



<%

  String query   = request.getQueryString();
  String target  = null;
  String msg  = "";
  String decodedTarget = null;




  int    tokenN = -1;
  if (null != query)
  {

                  tokenN = query.indexOf("TARGET=");

                  if (-1 != tokenN)
                        target = query.substring (tokenN + "TARGET=".length());

                  if (null != target)
                  {
                          decodedTarget = smdecoder.smdecode(target);
                  }

  }


  String username = "";
  String challenge = "";
  String smcaptchatoken = "";


  String reasonCode = "";

  
  Enumeration paramNames = request.getParameterNames();

  while(paramNames.hasMoreElements())
  {
                        String paramName = (String)paramNames.nextElement();
                        if( (!paramName.equals("TARGET")) && (!paramName.equals("CHALLENGE")) && (!paramName.equals("USERNAME")) )
                        {

                                out.println ("<INPUT TYPE=HIDDEN NAME=\"" +paramName + "\" VALUE=\"" + request.getParameter(paramName) + "\"> </input>");
                        }

                        if(paramName.equals("USERNAME"))
                        {
                                 username = request.getParameter(paramName);
                                 if (null != username)
                                 {
                                        out.println ("<INPUT TYPE=HIDDEN NAME=\"" +paramName + "\" VALUE=\"" + request.getParameter(paramName) + "\"> </input>");
                                 }
                        }

                    if(paramName.equals("CHALLENGE"))
                        {
                                 challenge = request.getParameter(paramName);
                        }

                        else if(paramName.equals("SMCAPTCHATOKEN"))
                        {
                                 smcaptchatoken = request.getParameter(paramName);
                        }

                        else if(paramName.equals("SMAUTHREASON"))
                        {
                                 reasonCode = request.getParameter(paramName);
                        }

        }



                if (null != target)
                  out.println ("<INPUT TYPE=HIDDEN NAME=\"TARGET\" VALUE=\"" + decodedTarget + "\"> </input>");



     //If challenge  and smcaptchatoken both are empty -- first time -show username and password fields -  Case1
         //If challenge  and smcaptchatoken both are non empty - second time - show capcha and password both, and optionally username - Case2

    //Case1
         if ( challenge.equals("") && smcaptchatoken.equals("") )
         {
%>

                <!-- START SHOWING USER NAME FIELD  -->

                <tr align="center" >
                  <td WIDTH=10 >&nbsp;</td>
                  <td align="left">
                        <b><font size=-1 face="arial,helvetica" > User Name: </font></b>

                        <td align="left"><INPUT name="USERNAME" type="text" size=30></input></td>
                  </td>
                </tr>

                <!-- END SHOWING USER NAME FIELD -->

        <!-- START SHOWING PASSWORD FIELD  -->


                <tr align="center" >
                  <td WIDTH=10 >&nbsp;</td>
                  <td align="left">
                        <b><font size=-1 face="arial,helvetica" >PASSWORD: </font></b>

                        <td align="left"><INPUT name="CREDENTIAL" type="PASSWORD" size=30></input></td>
                  </td>
                </tr>

                <!-- END SHOWING PASSWORD FIELD  -->
<%
         }
     else if ( !challenge.equals("") && !smcaptchatoken.equals("") )
         //Case 2
         {

         //if username is not in the query, then show it
      if ( (username == null) || (username.equals("")) )
          {
%>
                <!-- START SHOWING USER NAME FIELD  -->

                <tr align="center" >
                  <td WIDTH=10 >&nbsp;</td>
                  <td align="left">
                        <b><font size=-1 face="arial,helvetica" > User Name: </font></b>

                        <td align="left"><INPUT name="USERNAME" type="text" size=30></input></td>
                  </td>
                </tr>
                <tr> <td colspan=4 height=20> <font size=1> &nbsp; </font> </td> </tr>

                <!-- END SHOWING USER NAME FIELD -->
<%
}
%>

    <!-- START SHOWING PASSWORD FIELD  -->

    <tr align="center" >
                  <td WIDTH=10 >&nbsp;</td>
                  <td align="left">
                        <b><font size=-1 face="arial,helvetica" >PASSWORD: </font></b>

                        <td align="left"><INPUT name="CREDENTIAL" type="PASSWORD" size=30></input></td>
                  </td>
        </tr>

        <!-- END SHOWING PASSWORD FIELD  -->

        <!--START SHOWING CAPTCHA  -->

        <tr align="center">
                <td WIDTH=10 >&nbsp;</td>
                <td align="left">
                <b><font size=-1 face="arial,helvetica" > Enter the characters: </font></b>
                <img src="/captcha/captcha.jsp?CHALLENGE=<%= java.net.URLEncoder.encode(challenge) %>" align="middle" alt="Enter the characters appearing in this image" border="1"/>

                <td align="left"><INPUT name="CAPTCHARESP" type="text" maxlength="<%= challenge.length() %>" size=30></input></td>
                </td>

         </tr>

        <!--END SHOWING CAPTCHA  -->


<%
}

%>

      <!--START SHOWING LOGIN BUTTON  -->

        <tr> <td colspan=4 height=20> <font size=1> &nbsp; </font> </td> </tr>
                <tr align="center" >
                  <td height=30 colspan=4>
                        <INPUT name="login" type="BUTTON" onClick="checkLogin();" value="Submit"></input>
                  </td>
                </tr>

        <!-- END SHOWING LOGIN BUTTON  -->


</table>
</td>
</tr>
</table>
</form>

</BODY>
</HTML>

<script>

function checkLogin()
{

   document.mainForm.action ="/siteminderagent/forms/captchalogin.fcc";
   document.mainForm.submit();
}

</script>
