Return-Path: <linux-can+bounces-7338-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id k4UFJJGR0mnRYwcAu9opvQ
	(envelope-from <linux-can+bounces-7338-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 05 Apr 2026 18:45:05 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EF9F239F033
	for <lists+linux-can@lfdr.de>; Sun, 05 Apr 2026 18:45:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AC56A3005E85
	for <lists+linux-can@lfdr.de>; Sun,  5 Apr 2026 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 006252BE65B;
	Sun,  5 Apr 2026 16:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b="Xc4V0QjP"
X-Original-To: linux-can@vger.kernel.org
Received: from o38.sg.zoom.us (o38.sg.zoom.us [149.72.51.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DAE274652
	for <linux-can@vger.kernel.org>; Sun,  5 Apr 2026 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.72.51.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775407500; cv=none; b=geWGyGTS1hj3l8Ej3HOOB7hR1p0I3TgDVRdVTacrsirBusE7S1ayd7FSBAdOz7M/3isgs5rmwW6t+90mNSspZpzrMx8Vp8LcgAYNKyRQpF9zCpwrb3ta1VUen4LjGrNvXaesx17fPOy2KX2Uzf+SEk8DFlU4dSy9R5SO+xLpa9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775407500; c=relaxed/simple;
	bh=MA0YcLadQTMTEF3g/Kzs19Z6XTAlZ3lMwPtFHCOGzRA=;
	h=Content-Type:Date:From:Mime-Version:Message-ID:Subject:To; b=H4Gv/TKpg+UGAycghRyg4zwjzAdV8PywDEtRhZ2hZ9dElV9gyzLNOjRauXi8yFKX1IdB6xa8StNjOGOKuYDsY9B1MFxg1ut1d6UO/GA6YW8F9ZyFaCymCiCPNJPDL+KaiuTFw0OccfsqJYCkvnf7/h+Jo4gbMmJYo845Ujd2ybc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us; spf=pass smtp.mailfrom=bounce-sg.zoom.us; dkim=pass (2048-bit key) header.d=zoom.us header.i=@zoom.us header.b=Xc4V0QjP; arc=none smtp.client-ip=149.72.51.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=zoom.us
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bounce-sg.zoom.us
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zoom.us;
	h=content-type:date:from:mime-version:subject:reply-to:to:cc:
	content-type:date:from:subject:to;
	s=sg; t=1775407498; bh=BqyCc5Dy6UhGzKqQOe5ByoROGcwMDLMrlOI5Re/xkg8=;
	b=Xc4V0QjP72rn8d4MbM6U9xR/9MBUU8CmS5Pnv9Gbzk3paNsveXP3CzAVPCQd66icy1u5
	Dk2rtfwGweMT8m3T/lsroUQncHOIrThTwRSl3wyhIX2XD07rgZ4apH+U7hDzBLOeqVYsTl
	qaWPwGuELwd523iURdL4nth2NxIKkkM0zDp9aZ8l9lMwOb3B0XwkGF0H1QXwDz9whgsjXQ
	TPzGgL/aAfBnQ8GPtJ629OVH0fL2OWAJ8Vmtcuq1lBolhXGxXx9zV0+8wVcRhESxUqnj1s
	zzGvoYoxS9kFNZscaHgfu6jPmL87PS+OnIAG0aDgRqM1eitpVOq0DFWYFv16PoZA==
Received: by recvd-75d9db7f9f-fq447 with SMTP id recvd-75d9db7f9f-fq447-1-69D2918A-1C
	2026-04-05 16:44:58.231757735 +0000 UTC m=+503295.052094686
Received: from MjU5OTk1MjY (unknown)
	by geopod-ismtpd-46 (SG) with HTTP
	id Xhr5qzXNT4CuTlUpTYqKXw
	Sun, 05 Apr 2026 16:44:58.179 +0000 (UTC)
Content-Type: multipart/mixed; boundary=3ab3c093dfd7cef1675f8a0571c505a01d61737f761b1144010835ca8ef9
Date: Sun, 05 Apr 2026 16:44:58 +0000 (UTC)
From: Zoom Webinar <no-reply@zoom.us>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Message-ID: <Xhr5qzXNT4CuTlUpTYqKXw@geopod-ismtpd-46>
Subject: Discover How To Instantly Rank On Top Of Every Search From Google
 Rankings To AI Discovery In ChatGPT, Gemini, Claude, Perplexity, & Copilot
 Confirmation
Reply-To: Zoom Webinar <sanryarries@cheems.baby>
Feedback-ID: N22xJtKJSxKwfWS3SRg6HA:::zoom.us
X-SG-EID: 
 =?us-ascii?Q?u001=2ERgZnWCz8IFHH0kIZpn+qAiw7pwkTVFI=2FJtjtfe++gnUbGuPWuWXXvMnuq?=
 =?us-ascii?Q?lWvvHeZe7tGaFmya1Lib5mab1OpH1IhPzmHryq9?=
 =?us-ascii?Q?oWCZstM5lVUdftWbV7cvex6q6wz7rZ9ipZv8Sgg?=
 =?us-ascii?Q?0pn0CzWRXLJ1aHjrqnEd5Q8MtP7eLwHfV9urmH3?=
 =?us-ascii?Q?oupGxPeb4B6UWMCoh2aVmQc9KhN6sWqXY8DQCQx?=
 =?us-ascii?Q?hT3lagcOzCmMnYVja0XsIu6gmEe49w96SjOxgdR?= =?us-ascii?Q?iBcn?=
X-SG-ID: 
 =?us-ascii?Q?u001=2ESdBcvi+Evd=2FbQef8eZF3Bq+efGylwbz3q5X9xSK9XHyEixZMkOa8ilCgx?=
 =?us-ascii?Q?YOwpsXED6=2FoRQgRpyNwhJCp+NbSG4xP8sPpKkrO?=
 =?us-ascii?Q?K4yJNq1xr82QviQxGE14CPOuJjyZCJ7dRc8TPA=2F?=
 =?us-ascii?Q?5=2Fb366Dj6QxFXh13VWiJ1CYrhoKy=2FJ86DE+m=2F9Y?=
 =?us-ascii?Q?jLmLHMKOKabsVaVZgK3MZFxqMC=2F43SXal9w5zl8?=
 =?us-ascii?Q?Oo+ECRZxkujPZ+roXRYpxQXTlhk2RGxw2rW1Y6U?=
 =?us-ascii?Q?PTIsT4iBAhbjQdexuKO2wVDdrSPTgPRXyxKR8sz?=
 =?us-ascii?Q?ax35G2Ze68KbftYJagESNpn1aRBOyWwtvRx1GHr?=
 =?us-ascii?Q?XoI3=2FL995cLtFfVMAlaw2MhhDI0=2FTe3=2FEtqU6ZL?=
 =?us-ascii?Q?M2gKRE9UOaVcypdyG7GY2yYB5GBWWgvMCnyj2Ay?=
 =?us-ascii?Q?Lb2uKQ2UPjFnSDx2PsK=2FmvxWo8xK8UbSC2OYMmA?=
 =?us-ascii?Q?gYcis+LtIvKh3kGHfFoTJeFQ+FZe9YpOXHopYIe?=
 =?us-ascii?Q?FNTDTQQehS+WXEvItStnvmo=2FFmWl8O5dw3cuY+b?=
 =?us-ascii?Q?ihj24hiPEkgveqLoqCSJD2CBtp=2F0wRKxC88yamz?=
 =?us-ascii?Q?bj6JlG7CSnppTCfY=2F3EVZE+c9WnvVIHu+JgcJtM?=
 =?us-ascii?Q?uySUAxKChhOWfIuUXkA0=2F3i4QIMldRgTBcyV5jB?=
 =?us-ascii?Q?yhLKMeV8KFJOag7koENtElU2ows12U0V9phbkqV?=
 =?us-ascii?Q?QzQKHTgsMTlhf4BRKf1mQ+1ybdW8wYv=2FS9t9Xn7?=
 =?us-ascii?Q?u5knJHNED2UllSZ+zQInwq0+O8x2w7fe5w5MrHP?=
 =?us-ascii?Q?xlIiOTT1FMH9MKBwff4bl5FpAtza5QssDuv8BZu?=
 =?us-ascii?Q?POx0vQr7F2YpI7eU4ZnCOWZxwyAldOQ2SNDglEW?=
 =?us-ascii?Q?El5prg0CDiSBQARAWPEUmTfIuiE6JDe+1T27CX+?=
 =?us-ascii?Q?=2FVz3y0diqtEsPbApjL8F4ZyilZah9bv0QGn9YCv?=
 =?us-ascii?Q?AsfyuibEvH0=2FZ+XFlPGrMWFpCsISRUTjOrMjKqZ?=
 =?us-ascii?Q?bvJmINhFEUblDPZM0h5OwSpd3oVLVYBB5Lcjyt1?=
 =?us-ascii?Q?Ql+F72r=2Feb=2FD8Z8lBeM69njX=2FfGbUoaQF=2FsixUg?=
 =?us-ascii?Q?q5coYWb2QpSTEuxgixEoKB49vRqXaSs55ZC3K1R?=
 =?us-ascii?Q?UIO2EHGjq1CBNWPNV?=
To: linux-can@vger.kernel.org
X-Entity-ID: u001.2o4x06M7TQXGOcDa9LFkMA==
X-Spamd-Result: default: False [1.14 / 15.00];
	MIME_MA_MISSING_TEXT(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[zoom.us,reject];
	MV_CASE(0.50)[];
	MIME_HTML_ONLY(0.20)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[zoom.us:s=sg];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[multipart/mixed,multipart/alternative];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[zoom.us:+];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~,3:~,4:~];
	TAGGED_FROM(0.00)[bounces-7338-lists,linux-can=lfdr.de];
	RCPT_COUNT_ONE(0.00)[1];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[no-reply@zoom.us,linux-can@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	REDIRECTOR_URL(0.00)[twitter.com];
	TAGGED_RCPT(0.00)[linux-can];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[sanryarries@cheems.baby]
X-Rspamd-Queue-Id: EF9F239F033
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--3ab3c093dfd7cef1675f8a0571c505a01d61737f761b1144010835ca8ef9
Content-Type: multipart/alternative; boundary=b01169b0213ec1d4259c93bda7e72aefca591d5eb14de9d35425a941b2d7

--b01169b0213ec1d4259c93bda7e72aefca591d5eb14de9d35425a941b2d7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/html; charset=utf-8
Mime-Version: 1.0

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.=
w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns=3D"http://www.w3.org/1999/xhtml">
<head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
"/>
</head>
<body style=3D"height: 100% !important;width: 100% !important;margin: 0;pad=
ding: 0;">
<table border=3D"0" cellpadding=3D"0" cellspacing=3D"0" align=3D"center" bg=
color=3D"#f1f1f4" width=3D"100%" style=3D"font-size: 13px;font-family: Aria=
l;height:100%;">
    <tr>
        <td>
            <table id=3D"table-new-invitation" border=3D"0" cellpadding=3D"=
0" cellspacing=3D"0" align=3D"center" style=3D"padding: 40px 0;max-width: 9=
60px;min-width: 600px;width: 60%;">
                    <tr><td style=3D"height: 8px;"></td> </tr>
                <tr>
                    <td valign=3D"top" bgcolor=3D"#ffffff">
                        <table border=3D"0" cellpadding=3D"0" cellspacing=
=3D"0" align=3D"center" width=3D"100%" style=3D"margin-left: 0;margin-right=
: 0;">
                            <tr>
                                <td style=3D"padding-left: 32px;padding-rig=
ht: 32px;">
                                    <table border=3D"0" cellpadding=3D"0" c=
ellspacing=3D"0" align=3D"center" width=3D"100%" style=3D"font-size: 13px;c=
olor: #39394d;font-family: Arial;">
                                        <tr> <td colspan=3D"2" valign=3D"to=
p" style=3D"padding-top:32px;font-size: 14px;font-weight: 400;color: #13161=
9;font-family: Arial;line-height: 24px;">Hi  linux-can@vger<span>.</span>ke=
rnel<span>.</span>org,</td> </tr>
                                        <tr> <td colspan=3D"2" valign=3D"to=
p" style=3D"padding-top:32px;font-size: 14px;font-weight: 400;color: #13161=
9;font-family: Arial;line-height: 24px;">Thank you for registering for Disc=
over How To Instantly Rank On Top Of Every Search From Google Rankings To A=
I Discovery In ChatGPT, Gemini, Claude, Perplexity, &amp; Copilot. You can =
find information about this webinar below.</td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"padding-bottom: 8px;height:auto;font-size: 14px;font-weig=
ht: 400;color: #131619;font-family: Arial;line-height: 24px;"> BONUS: Get T=
he World&#39;s First AI Agent That Builds, Runs &amp; Monetizes A Complete =
Faceless YouTube Channel. Press ONE Button=E2=80=A6 And Watch ChannelAgent =
Research Your Niche, Write Your Scripts, Record Your Voiceovers, Create 10-=
50 Videos at go, Design Your Thumbnails, Handle Your SEO, Upload To YouTube=
, AND Monetize Everything=E2=80=A6 All On Complete Autopilot. Click here ht=
tps://lik.wiki/get-y0utube-payments<br><br>NOTE: If you don&#39;t want futu=
re invitation to our special trainings kindly send an email with the subjec=
t &quot;END&#39;&#39; to adah43397@gmail.com </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #131619;font-fami=
ly: Arial;line-height: 24px;"> Please submit any questions to: <a target=3D=
"_blank" style=3D"color: #000000;text-decoration:none;"> sanryarries@cheems=
.baby</a> </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                            <tr> <td colspan=3D"2" style=3D=
"font-size: 14px;font-weight: 400;color: #000;font-family: Arial;line-heigh=
t: 24px;" valign=3D"top"> You can <a href=3D"https://us06web.zoom.us/webina=
r/register/WN_XX_nL7sISOu84_gZN3aKLg?tk=3DVsShHNxiJvAIueBAd1z3LA7OTYpL4-EbR=
rpJ2YfgH0I.DQkAAAAUjy2STBZXUFRzSlZjVVF6aWU3RGk0bGJsTmpRAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAA#detail" target=3D"_blank">cancel</a> your registrat=
ion at any time. </td> </tr>
                                        <tr><td style=3D"height: 32px"></td=
></tr>
                                        <tr> <td colspan=3D"2" style=3D"fon=
t-size: 14px;font-weight: 400;color: #000;font-family: Arial;line-height: 2=
4px;" valign=3D"top"> Thank you! </td> </tr>
                                        <tr>
                                            <td width=3D"100%">
                                                <table style=3D"width:100%;=
border-radius: 8px;background-color: #F7F7FC;">
                                                        <tr> <td colspan=3D=
"3" style=3D"padding: 12px 16px 8px 16px;font-size: 14px;font-weight: 700;l=
ine-height: 24px;" valign=3D"top">  <strong>Discover How To Instantly Rank =
On Top Of Every Search From Google Rankings To AI Discovery In ChatGPT, Gem=
ini, Claude, Perplexity, &amp; Copilot</strong> </td> </tr>
                                                            <tr>
                                                                <td valign=
=3D"top" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;f=
ont-weight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Date & Time=
</td>
                                                                <td valign=
=3D"top" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color:=
 #233333;padding: 4px 16px 8px 0;">Apr 5, 2026 03:00 PM Eastern Time (US an=
d Canada)</td>
                                                            </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Webinar ID</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">883 0147 4380</td>
                                                        </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Passcode</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">620874</td>
                                                        </tr>
                                                        <tr>
                                                            <td valign=3D"t=
op" style=3D"padding: 4px 16px 8px 16px;width: 112px;font-size: 13px;font-w=
eight: 400;line-height: 16px;color: rgba(4, 4, 19, 0.56);">Description</td>
                                                            <td valign=3D"t=
op" style=3D"font-weight: 400;font-size: 13px;line-height: 16px;color: #233=
333;padding: 4px 16px 8px 0;">BONUS: Get The World&#39;s First AI Agent Tha=
t Builds, Runs &amp; Monetizes A Complete Faceless YouTube Channel. Press O=
NE Button=E2=80=A6 And Watch ChannelAgent Research Your Niche, Write Your S=
cripts, Record Your Voiceovers, Create 10-50 Videos at go, Design Your Thum=
bnails, Handle Your SEO, Upload To YouTube, AND Monetize Everything=E2=80=
=A6 All On Complete Autopilot. Click here https://lik.wiki/get-y0utube-paym=
ents<br/>
<br/>
NOTE: If you don&#39;t want future invitation to our special trainings kind=
ly send an email with the subject &quot;END&#39;&#39; to adah43397@gmail.co=
m</td>
                                                        </tr>
                                                    <tr>
                                                        <td style=3D"paddin=
g: 8px 16px 0;width: 112px;"></td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>
                                        <tr><td style=3D"height: 8px;"></td=
> </tr>
                                            <tr> <td colspan=3D"2" style=3D=
"line-height: 32px;padding-top: 16px;padding-bottom: 30px;"> <span style=3D=
"font-size: 14px;font-weight: bold;line-height: 20px;color: #222230;vertica=
l-align: middle;">Add to:</span>  <a href=3D"https://us06web.zoom.us/webina=
r/tZwud-isqT8pEtT8kTChlhXwKmffveEDtb55/calendar/google/add?user_id=3DLGtM0B=
GmDj2C8JLQ0XT_oTPBVitc8_IiOKXXAP4jaueM_ScqNaE.J-jKJwjoDsCW1ee5&type=3Dgoogl=
e" style=3D"letter-spacing: 0;border: 1px solid #3171BB;color: #3171BB;bord=
er-radius: 8px;padding: 3px 5px;text-decoration: none;font-weight: 400;font=
-size: 14px;line-height: 30px;height: 24px;display:inline-flex;vertical-ali=
gn:middle;"> <i class=3D"glyphicon" style=3D"width: 20px;display:inline-blo=
ck;"> <img src=3D"https://us06st3.zoom.us/static/6.3.55196/image/new/google=
.png" /> </i><span style=3D"display:inline-flex;line-height:24px;">&nbsp;Go=
ogle Calendar</span> </a>&nbsp;  <a href=3D"https://us06web.zoom.us/webinar=
/tZwud-isqT8pEtT8kTChlhXwKmffveEDtb55/ics?user_id=3D3SchrHgDNPD0TvGe1zsbuKv=
Q3cDX6KrqR6h75I0vpNRJHXWE2Xo.PAmamUJoKFpCy2IF&type=3Dicalendar" style=3D"bo=
rder: 1px solid #0E72ED;color: #0E72ED;border-radius: 8px;padding:3px 5px;t=
ext-decoration: none;font-weight: 400;font-size: 14px;line-height: 30px;ver=
tical-align:middle;height: 24px;display:inline-flex;letter-spacing: 0;"> <i=
 class=3D"glyphicon" style=3D"width: 20px;display:inline-block;"> <img src=
=3D"https://us06st3.zoom.us/static/6.3.55196/image/new/outlook.png" /> </i>=
<span style=3D"display:inline-flex;line-height:24px;">&nbsp;Outlook Calenda=
r(.ICS)</span> </a>&nbsp; <a href=3D"https://us06web.zoom.us/webinar/tZwud-=
isqT8pEtT8kTChlhXwKmffveEDtb55/ics?user_id=3DuQoxCdKYG9fA67o_uZq1vt9Vu7BnTN=
0DbbfbXExJl42P0nUXMU8.ucpHEGMyTxIMBdul&type=3Dyahoo" style=3D"border: 1px s=
olid #952BCE;color: #952BCE;border-radius: 8px;padding: 3px 5px;text-decora=
tion: none;font-weight: 400;font-size: 14px;line-height: 30px;vertical-alig=
n:middle;height: 24px;display:inline-flex;letter-spacing: 0;"> <i class=3D"=
glyphicon" style=3D"width: 20px;display:inline-block;"> <img src=3D"https:/=
/us06st3.zoom.us/static/6.3.55196/image/new/yahoo.png" /> </i><span style=
=3D"display:inline-flex;line-height:24px;">&nbsp;Yahoo Calendar</span> </a>=
 </td> </tr>
                                        <tr></tr>
                                        <tr> <td> <table align=3D"left" cel=
lpadding=3D"0" cellspacing=3D"0" style=3D"width:100%;"> <tr> <td bgcolor=3D=
"#ffffff" style=3D"padding: 32px 0 0 0;padding-top: 30px !important;width: =
182px;font-size: 12px;line-height: 18px;color: rgba(4, 4, 19, 0.56);font-we=
ight: 700;" valign=3D"top"> WAYS TO JOIN THIS WEBINAR </td> <td bgcolor=3D"=
#ffffff" style=3D"padding: 32px 0 0 8px;padding-top: 38px !important;" vali=
gn=3D"top"> <div style=3D"height: 1px;border-top: 1px dashed rgba(82, 82, 1=
28, 0.18);"></div> </td> </tr> </table> </td> </tr>
                                        <tr> <td colspan=3D"2" style=3D"pad=
ding-left:12px;padding-top: 28px !important;padding-bottom: 12px !important=
;font-family: Arial;font-size: 16px;font-weight: 700;line-height: 24px;colo=
r: #233333;" valign=3D"top"> <ul style=3D"padding:0;margin:0;"><li class=3D=
"join1" style=3D"margin-left:0;list-style-type: disc;">Join from PC, Mac, i=
Pad, or Android</li></ul> </td> </tr>
                                            <tr> <td bgcolor=3D"#ffffff" wi=
dth=3D"122" height=3D"30" style=3D"padding-bottom: 16px;" valign=3D"middle"=
> <div style=3D"height: 24px;border-radius: 8px;line-height: 30px;mso-line-=
height-rule: exactly;"> <a type=3D"button" href=3D"https://us06web.zoom.us/=
w/88301474380?tk=3DVsShHNxiJvAIueBAd1z3LA7OTYpL4-EbRrpJ2YfgH0I.DQkAAAAUjy2S=
TBZXUFRzSlZjVVF6aWU3RGk0bGJsTmpRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
&pwd=3DpXWLcjEPli4qoHjpmE6NdMLS1IwIMQ.1&uuid=3DWN_XX_nL7sISOu84_gZN3aKLg" t=
arget=3D"_blank" style=3D"height:24px;text-decoration:none;font-size: 14px;=
font-weight: 500;color: #fff;background: #0E72ED;border-radius: 8px;line-he=
ight: 30px;vertical-align:middle;padding: 7px 20px;mso-line-height-rule:exa=
ctly;">&nbsp;&nbsp;&nbsp;&nbsp;<span style=3D"line-height:30px;mso-line-hei=
ght-rule:exactly;">Join Webinar</span>&nbsp;&nbsp;&nbsp;&nbsp;</a> </div> <=
/td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" style=3D"font-size: 14px;font-weight: 400;color: #000000;font-fami=
ly: Arial;line-height: 24px;"> If the button above does not work, paste thi=
s into your browser:=E2=80=A8<br/> </td> </tr>
                                            <tr> <td colspan=3D"2" valign=
=3D"top" width=3D"536" style=3D"word-break: break-all;font-size: 14px;font-=
weight: 400;color: #000000;font-family: Arial;line-height: 24px;"> <a href=
=3D"https://us06web.zoom.us/w/88301474380?tk=3DVsShHNxiJvAIueBAd1z3LA7OTYpL=
4-EbRrpJ2YfgH0I.DQkAAAAUjy2STBZXUFRzSlZjVVF6aWU3RGk0bGJsTmpRAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAA&pwd=3DpXWLcjEPli4qoHjpmE6NdMLS1IwIMQ.1&uuid=3D=
WN_XX_nL7sISOu84_gZN3aKLg" style=3D"width: 536px;text-decoration:underline;=
color: #000000;word-wrap:break-word;">https://us06web.zoom.us/w/88301474380=
?tk=3DVsShHNxiJvAIueBAd1z3LA7OTYpL4-EbRrpJ2YfgH0I.DQkAAAAUjy2STBZXUFRzSlZjV=
VF6aWU3RGk0bGJsTmpRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&pwd=3DpXWLcj=
EPli4qoHjpmE6NdMLS1IwIMQ.1&uuid=3DWN_XX_nL7sISOu84_gZN3aKLg</a> </td> </tr>
                                        <tr> <td colspan=3D"2" style=3D"fon=
t-family: Arial;font-size: 14px;font-weight: 700;line-height: 17px;color: #=
222230;padding-top: 12px;" valign=3D"top"> To keep this webinar secure, do =
not share this link publicly. </td> </tr>
                                                <tr>
                                                    <td width=3D"100%">
                                                        <table align=3D"lef=
t" border=3D"0" cellpadding=3D"0" cellspacing=3D"0" style=3D"width:auto;pad=
ding:0;margin:0;">
                                                            <tr> <td colspa=
n=3D"2" valign=3D"top" style=3D"padding:32px 0 8px 12px;font-family: Arial;=
font-size: 16px;font-weight: 700;line-height: 24px;color: #233333;"> <ul st=
yle=3D"padding:0;margin:0;"><li style=3D"margin-left:0;list-style-type: dis=
c;">Join via audio</li></ul> </td> </tr>
                                                            <tr> <td width=
=3D"600" colspan=3D"2" valign=3D"top" style=3D"word-break: break-word;paddi=
ng-bottom: 4px;font-size: 14px;font-weight: 400;color: #233333;font-family:=
 Arial;line-height: 24px;"> <span style=3D"color: #000000;word-wrap: break-=
word;"> US: <a style=3D"color: #233333;text-decoration: underline;" href=3D=
"tel:+16469313860,,88301474380#">+16469313860,,88301474380#</a>   or <a sty=
le=3D"color: #233333;text-decoration: underline;" href=3D"tel:+16694449171,=
,88301474380#">+16694449171,,88301474380#</a>  </span> </td> </tr>
                                                            <tr> <td style=
=3D"width: 100px;padding-left: 0;padding-right: 6px;font-weight: 600;font-s=
ize: 14px;color: #233333;font-family: Arial;line-height: 24px;" valign=3D"t=
op"> Or, dial: </td> <td width=3D"836" style=3D"word-break: break-word;padd=
ing-left: 0;padding-bottom: 4px;font-size: 14px;font-weight: 400;color: #23=
3333;font-family: Arial;line-height: 24px;" valign=3D"top"> <span style=3D"=
color: #000000;word-wrap: break-word;">    US:  +1 646 931 3860      or +1 =
669 444 9171      or +1 669 900 6833      or +1 689 278 1000      or +1 719=
 359 4580      or +1 253 205 0468      or +1 253 215 8782      or +1 301 71=
5 8592      or +1 305 224 1968      or +1 309 205 3325      or +1 312 626 6=
799      or +1 346 248 7799      or +1 360 209 5623      or +1 386 347 5053=
      or +1 507 473 4847      or +1 564 217 2000      or +1 646 558 8656   =
  <br><a href=3D"https://us06web.zoom.us/u/kdkwhB46zb" target=3D"_blank" st=
yle=3D"font-size: 14px;font-weight: 400;color: #233333;font-family: Arial;l=
ine-height: 24px;vertical-align: top;">More International numbers</a>  </sp=
an> </td> </tr>
                                                                <tr> <td va=
lign=3D"top" style=3D"width: auto;padding-left: 0;padding-right: 6px;font-s=
ize: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height: 2=
4px;">Webinar ID:</td> <td style=3D"padding-left:0;padding-bottom: 4px;font=
-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height:=
 24px;" valign=3D"top">883 0147 4380</td> </tr>
                                                                <tr> <td va=
lign=3D"top" style=3D"width: auto;padding-left: 0;padding-right: 6px;font-s=
ize: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height: 2=
4px;"> Passcode: </td> <td style=3D"padding-left:0;padding-bottom: 4px;font=
-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height:=
 24px;" valign=3D"top"> 620874 </td> </tr>
                                                        </table>
                                                    </td>
                                                </tr>
                                        <tr><td colspan=3D"2" style=3D"font=
-size: 14px;font-weight: 400;color: #233333;font-family: Arial;line-height:=
 24px;" valign=3D"top">BONUS: Get The World&#39;s First AI Agent That Build=
s, Runs &amp; Monetizes A Complete Faceless YouTube Channel. Press ONE Butt=
on=E2=80=A6 And Watch ChannelAgent Research Your Niche, Write Your Scripts,=
 Record Your Voiceovers, Create 10-50 Videos at go, Design Your Thumbnails,=
 Handle Your SEO, Upload To YouTube, AND Monetize Everything=E2=80=A6 All O=
n Complete Autopilot. Click here https://lik.wiki/get-y0utube-payments<br><=
br>NOTE: If you don&#39;t want future invitation to our special trainings k=
indly send an email with the subject &quot;END&#39;&#39; to adah43397@gmail=
.com</td></tr>
                                       =20
                                       =20
                                    </table>
                                </td>
                            </tr>
                            <tr>
                                <td height=3D"32"></td>
                            </tr>
                            <tr><td style=3D"padding-top: 32px;padding-left=
: 32px;padding-right: 32px;"><div style=3D"height: 1px; border-top-width: 1=
px; border-top-style: inset; border-top-color: #DFE3E8;"></div></td></tr>
                            <tr>
                                <td style=3D"padding-top: 24px;padding-bott=
om: 24px;">
                                    <table align=3D"center" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" style=3D"width:auto;">
                                        <tbody>
                                        <tr>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://linkedin.com/company/zoom/" class=3D"no-decortaion" style=3D"=
margin-right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32"=
 src=3D"https://file-paa.zoom.us/kNH2urxhRLqXnWNb_EN1lQ/MS4yLoS79VBM36fz9x0=
Qu-Vm3_05uKEgidDZkSkBh6nf5jHh/Linkedin.png" style=3D"border-width: 0px;bord=
er-style: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://twitter.com/zoom" class=3D"no-decortaion" style=3D"margin-rig=
ht: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D"ht=
tps://file-paa.zoom.us/A9z6enYnRciVty2WD69K5Q/MS4yLlA3EEXVxtd5BnQvHzaVmWfiw=
_MyODrLSm1FTgct1k_x/X.png" style=3D"border-width: 0px;border-style: solid;w=
idth: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://instagram.com/zoom" class=3D"no-decortaion" style=3D"margin-r=
ight: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D"=
https://file-paa.zoom.us/6OcdBBJUSUO39GlRevwBpw/MS4yLhjC22e6R_ad3qd4NWLCKth=
WlIu8Y716iX4jSiBD42Rx/Instagram.png" style=3D"border-width: 0px;border-styl=
e: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://www.facebook.com/zoom" style=3D"text-decoration: none;margin-=
right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D=
"https://file-paa.zoom.us/XiUNdDxVRN227pWtZejqng/MS4yLjBX8SUlVoub9cJv-VllS5=
alt7U-cZRNnpyJTwbWNBPX/Facebook.png" style=3D"border-width: 0px;border-styl=
e: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://www.youtube.com/@Zoom" style=3D"text-decoration: none;margin-=
right: 16px;"> <img alt=3D"" border=3D"0" width=3D"32" height=3D"32" src=3D=
"https://file-paa.zoom.us/AQII00caTNmcRtOxZA9CHw/MS4yLluoNlumbwBzheCXQU4wTL=
FvBAvxtt0j2Se_SPtGrimT/YouTube.png" style=3D"border-width: 0px;border-style=
: solid;width: 32px;height: 32px;" /> </a> </td>
                                            <td style=3D"padding:0;"> <a hr=
ef=3D"https://blog.zoom.us/" style=3D"text-decoration: none;"> <img alt=3D"=
" border=3D"0" width=3D"32" height=3D"32" src=3D"https://file-paa.zoom.us/y=
3B837SCRhewJhRfIQAbNQ/MS4yLjSNE-R1r6XOy5Splz-i8Kl5uvaFt1JIWRutwY3W9uAP/Blog=
.png" style=3D"border-width: 0px;border-style: solid;width: 32px;height: 32=
px;" /> </a> </td>
                                        </tr>
                                        </tbody>
                                    </table>
                                    <table align=3D"center" border=3D"0" ce=
llpadding=3D"0" cellspacing=3D"0" width=3D"100%" style=3D"margin-top: 16px;=
color:#6E7680;font-size: 12px;line-height: 16px;font-weight: 400;">
                                        <tbody>
                                        <tr> <td align=3D"center" style=3D"=
font-size:12px;font-weight: 400;line-height:16px;color:#747487;" valign=3D"=
top"> <a style=3D"color: #0D6BDE; font-size: 14px;font-style: normal;font-w=
eight: 590;line-height: 18px;text-decoration:none; letter-spacing: -0.15px;=
">Zoom.com</a> <br> <a style=3D"color: #2A2B2D; font-size: 10px; font-style=
: normal;font-weight: 400;line-height: 16px;text-decoration:none; letter-sp=
acing: 0.12px;" target=3D"_blank"> 55 Almaden Blvd<br> San Jose, CA 95113</=
a> </td> </tr>
                                        <tr> <td align=3D"center"style=3D"p=
adding: 16px 0 0;font-size:12px;font-weight: 400;line-height:16px;color:#74=
7487;" valign=3D"top"> <a href=3D"tel:1-888-799-9666" style=3D"color: #0D6B=
DE; text-decoration: none; font-size: 14px; font-style: normal;font-weight:=
 590;line-height: 18px; letter-spacing: -0.15px;">+1.888.799.9666</a> <br> =
</td> </tr>
                                        <tr> <td align=3D"center"style=3D"f=
ont-size:12px;font-weight: 400;line-height:16px;color:#747487;" valign=3D"t=
op"> <a style=3D"color:#686F79;margin:0;font-size:10px; font-weight: 400;li=
ne-height: 16px;text-decoration: none; letter-spacing: 0.12px;" target=3D"_=
blank">&copy;2026 Zoom Communications, Inc.</a> <br> </td> </tr>
                                        </tbody>
                                    </table>

                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </td>
    </tr>
</table>
</body>
</html>

<html xmlns=3D"http://www.w3.org/1999/xhtml">
<head>
    <meta content=3D"text/html; charset=3Dutf-8" http-equiv=3D"Content-Type=
"/>
</head>
<body style=3D"height: 100% !important;width: 100% !important;margin: 0;pad=
ding: 0;">
            <table align=3D"center" border=3D"0" cellpadding=3D"0" cellspac=
ing=3D"0" width=3D"100%" style=3D"padding-top: 16px;">
            <tbody>
                <tr>
                    <td align=3D"center" style=3D"padding-top:16px;padding-=
left: 32px;padding-right: 32px;color:#6e7680;font-size:18px;line-height:22p=
x;font-weight:400" valign=3D"top">
                        <a style=3D"color:#6E7680;text-decoration: none;" t=
arget=3D"_blank">
                            To unsubscribe, [<a href=3D'https://us06web.zoo=
m.us/webinar/email/4f6a35f2-e97b-4fd9-ad20-bac1ad572f71/unsubscribe?email=
=3DDE9PazeS2n4Kiz2RQAAAGQAAACO-2iOV-ZDeKHPh7KeghKqiPbicOs5P7SAOEbOk6YOauGNa=
8R_eeTJGMDAwMDAx&amp;host=3DDIdKR2Zhd4XdhP7ZnAAAFwAAAPdm4jJvFWp5qBu4bkhqov_=
Wweh_T9g9PR24en_eGhqQQLsPBUGXGjAwMDAwMQ&amp;language=3Den-US&amp;view=3Dfal=
se'>Click here</a>]
                        </a>
                    </td>
                </tr>
            </tbody>
        </table>
</body>
</html>
--b01169b0213ec1d4259c93bda7e72aefca591d5eb14de9d35425a941b2d7
Content-Transfer-Encoding: quoted-printable
Content-Type: text/calendar; method=REQUEST;; charset=UTF-8
Mime-Version: 1.0

BEGIN:VCALENDAR
PRODID:-//zoom.us//iCalendar Event//EN
VERSION:2.0
CALSCALE:GREGORIAN
METHOD:REQUEST
BEGIN:VTIMEZONE
TZID:America/New_York
LAST-MODIFIED:20260306T231828Z
TZURL:https://www.tzurl.org/zoneinfo-outlook/America/New_York
X-LIC-LOCATION:America/New_York
BEGIN:DAYLIGHT
TZNAME:EDT
TZOFFSETFROM:-0500
TZOFFSETTO:-0400
DTSTART:19700308T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D3;BYDAY=3D2SU
END:DAYLIGHT
BEGIN:STANDARD
TZNAME:EST
TZOFFSETFROM:-0400
TZOFFSETTO:-0500
DTSTART:19701101T020000
RRULE:FREQ=3DYEARLY;BYMONTH=3D11;BYDAY=3D1SU
END:STANDARD
END:VTIMEZONE
BEGIN:VEVENT
DTSTAMP:20260405T161741Z
DTSTART;TZID=3DAmerica/New_York:20260405T150000
DTEND;TZID=3DAmerica/New_York:20260405T160000
SUMMARY:Discover How To Instantly Rank On Top Of Every Search From Google Ra=
nkings To AI Discovery In ChatGPT\, Gemini\, Claude\, Perplexity\, & Copilot
UID:b97kuj9o70pj0c9k6sq36e1gdhkmstbo5lhm2ri0epjmasheddin4rj5dgn6usj7
TZID:America/New_York
DESCRIPTION:Topic: Discover How To Instantly Rank On Top Of Every Search Fro=
m Google Rankings To AI Discovery In ChatGPT\, Gemini\, Claude\, Perplexity\=
, & Copilot\nDescription: BONUS: Get The World's First AI Agent That Builds\=
, Runs & Monetizes A Complete Faceless YouTube Channel. Press ONE Button=E2=
=80=A6 And Watch ChannelAgent Research Your Niche\, Write Your Scripts\, Rec=
ord Your Voiceovers\, Create 10-50 Videos at go\, Design Your Thumbnails\, H=
andle Your SEO\, Upload To YouTube\, AND Monetize Everything=E2=80=A6 All On=
 Complete Autopilot. Click here https://lik.wiki/get-y0utube-payments\n\nNOT=
E: If you don't want future invitation to our special trainings kindly send =
an email with the subject "END'' to adah43397@gmail.com\n\nJoin from PC\, Ma=
c\, iPad\, or Android:\nhttps://us06web.zoom.us/w/88301474380?tk=3DVsShHNxiJ=
vAIueBAd1z3LA7OTYpL4-EbRrpJ2YfgH0I.DQkAAAAUjy2STBZXUFRzSlZjVVF6aWU3RGk0bGJsT=
mpRAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&pwd=3DpXWLcjEPli4qoHjpmE6NdML=
S1IwIMQ.1&uuid=3DWN_XX_nL7sISOu84_gZN3aKLg\nPasscode:620874\n\nPhone one-tap=
:\n+16469313860\,\,88301474380#\,\,\,\,*620874# US\n+16694449171\,\,88301474=
380#\,\,\,\,*620874# US\n\nJoin via audio:\n+1 646 931 3860 US\n+1 669 444 9=
171 US\n+1 669 900 6833 US (San Jose)\n+1 689 278 1000 US\n+1 719 359 4580 U=
S\n+1 253 205 0468 US\n+1 253 215 8782 US (Tacoma)\n+1 301 715 8592 US (Wash=
ington DC)\n+1 305 224 1968 US\n+1 309 205 3325 US\n+1 312 626 6799 US (Chic=
ago)\n+1 346 248 7799 US (Houston)\n+1 360 209 5623 US\n+1 386 347 5053 US\n=
+1 507 473 4847 US\n+1 564 217 2000 US\n+1 646 558 8656 US (New York)\nWebin=
ar ID: 883 0147 4380\nPasscode: 620874\nInternational numbers available: htt=
ps://us06web.zoom.us/u/kdkwhB46zb\n\n\n
LOCATION:https://us06web.zoom.us/w/88301474380?tk=3DVsShHNxiJvAIueBAd1z3LA7O=
TYpL4-EbRrpJ2YfgH0I.DQkAAAAUjy2STBZXUFRzSlZjVVF6aWU3RGk0bGJsTmpRAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA&pwd=3DpXWLcjEPli4qoHjpmE6NdMLS1IwIMQ.1&uuid=
=3DWN_XX_nL7sISOu84_gZN3aKLg
SEQUENCE:1775405209
ORGANIZER;ROLE=3DREQ-PARTICIPANT;CN=3DZoom Webinar:no-reply@zoom.us
ATTENDEE;ROLE=3DREQ-PARTICIPANT;CN=3Dlinux-can@vger.kernel.org:mailto:linux-=
can@vger.kernel.org
BEGIN:VALARM
TRIGGER:-PT10M
ACTION:DISPLAY
DESCRIPTION:Reminder
END:VALARM
END:VEVENT
END:VCALENDAR

--b01169b0213ec1d4259c93bda7e72aefca591d5eb14de9d35425a941b2d7--

--3ab3c093dfd7cef1675f8a0571c505a01d61737f761b1144010835ca8ef9
Content-Disposition: attachment; filename="invite.ics"
Content-Transfer-Encoding: base64
Content-Type: text/calendar; name="invite.ics"

QkVHSU46VkNBTEVOREFSDQpQUk9ESUQ6LS8vem9vbS51cy8vaUNhbGVuZGFyIEV2ZW50Ly9FTg0K
VkVSU0lPTjoyLjANCkNBTFNDQUxFOkdSRUdPUklBTg0KTUVUSE9EOlJFUVVFU1QNCkJFR0lOOlZU
SU1FWk9ORQ0KVFpJRDpBbWVyaWNhL05ld19Zb3JrDQpMQVNULU1PRElGSUVEOjIwMjYwMzA2VDIz
MTgyOFoNClRaVVJMOmh0dHBzOi8vd3d3LnR6dXJsLm9yZy96b25laW5mby1vdXRsb29rL0FtZXJp
Y2EvTmV3X1lvcmsNClgtTElDLUxPQ0FUSU9OOkFtZXJpY2EvTmV3X1lvcmsNCkJFR0lOOkRBWUxJ
R0hUDQpUWk5BTUU6RURUDQpUWk9GRlNFVEZST006LTA1MDANClRaT0ZGU0VUVE86LTA0MDANCkRU
U1RBUlQ6MTk3MDAzMDhUMDIwMDAwDQpSUlVMRTpGUkVRPVlFQVJMWTtCWU1PTlRIPTM7QllEQVk9
MlNVDQpFTkQ6REFZTElHSFQNCkJFR0lOOlNUQU5EQVJEDQpUWk5BTUU6RVNUDQpUWk9GRlNFVEZS
T006LTA0MDANClRaT0ZGU0VUVE86LTA1MDANCkRUU1RBUlQ6MTk3MDExMDFUMDIwMDAwDQpSUlVM
RTpGUkVRPVlFQVJMWTtCWU1PTlRIPTExO0JZREFZPTFTVQ0KRU5EOlNUQU5EQVJEDQpFTkQ6VlRJ
TUVaT05FDQpCRUdJTjpWRVZFTlQNCkRUU1RBTVA6MjAyNjA0MDVUMTYxNzQxWg0KRFRTVEFSVDtU
WklEPUFtZXJpY2EvTmV3X1lvcms6MjAyNjA0MDVUMTUwMDAwDQpEVEVORDtUWklEPUFtZXJpY2Ev
TmV3X1lvcms6MjAyNjA0MDVUMTYwMDAwDQpTVU1NQVJZOkRpc2NvdmVyIEhvdyBUbyBJbnN0YW50
bHkgUmFuayBPbiBUb3AgT2YgRXZlcnkgU2VhcmNoIEZyb20gR29vZ2xlIFJhbmtpbmdzIFRvIEFJ
IERpc2NvdmVyeSBJbiBDaGF0R1BUXCwgR2VtaW5pXCwgQ2xhdWRlXCwgUGVycGxleGl0eVwsICYg
Q29waWxvdA0KVUlEOmI5N2t1ajlvNzBwajBjOWs2c3EzNmUxZ2Roa21zdGJvNWxobTJyaTBlcGpt
YXNoZWRkaW40cmo1ZGduNnVzajcNClRaSUQ6QW1lcmljYS9OZXdfWW9yaw0KREVTQ1JJUFRJT046
VG9waWM6IERpc2NvdmVyIEhvdyBUbyBJbnN0YW50bHkgUmFuayBPbiBUb3AgT2YgRXZlcnkgU2Vh
cmNoIEZyb20gR29vZ2xlIFJhbmtpbmdzIFRvIEFJIERpc2NvdmVyeSBJbiBDaGF0R1BUXCwgR2Vt
aW5pXCwgQ2xhdWRlXCwgUGVycGxleGl0eVwsICYgQ29waWxvdFxuRGVzY3JpcHRpb246IEJPTlVT
OiBHZXQgVGhlIFdvcmxkJ3MgRmlyc3QgQUkgQWdlbnQgVGhhdCBCdWlsZHNcLCBSdW5zICYgTW9u
ZXRpemVzIEEgQ29tcGxldGUgRmFjZWxlc3MgWW91VHViZSBDaGFubmVsLiBQcmVzcyBPTkUgQnV0
dG9u4oCmIEFuZCBXYXRjaCBDaGFubmVsQWdlbnQgUmVzZWFyY2ggWW91ciBOaWNoZVwsIFdyaXRl
IFlvdXIgU2NyaXB0c1wsIFJlY29yZCBZb3VyIFZvaWNlb3ZlcnNcLCBDcmVhdGUgMTAtNTAgVmlk
ZW9zIGF0IGdvXCwgRGVzaWduIFlvdXIgVGh1bWJuYWlsc1wsIEhhbmRsZSBZb3VyIFNFT1wsIFVw
bG9hZCBUbyBZb3VUdWJlXCwgQU5EIE1vbmV0aXplIEV2ZXJ5dGhpbmfigKYgQWxsIE9uIENvbXBs
ZXRlIEF1dG9waWxvdC4gQ2xpY2sgaGVyZSBodHRwczovL2xpay53aWtpL2dldC15MHV0dWJlLXBh
eW1lbnRzXG5cbk5PVEU6IElmIHlvdSBkb24ndCB3YW50IGZ1dHVyZSBpbnZpdGF0aW9uIHRvIG91
ciBzcGVjaWFsIHRyYWluaW5ncyBraW5kbHkgc2VuZCBhbiBlbWFpbCB3aXRoIHRoZSBzdWJqZWN0
ICJFTkQnJyB0byBhZGFoNDMzOTdAZ21haWwuY29tXG5cbkpvaW4gZnJvbSBQQ1wsIE1hY1wsIGlQ
YWRcLCBvciBBbmRyb2lkOlxuaHR0cHM6Ly91czA2d2ViLnpvb20udXMvdy84ODMwMTQ3NDM4MD90
az1Wc1NoSE54aUp2QUl1ZUJBZDF6M0xBN09UWXBMNC1FYlJycEoyWWZnSDBJLkRRa0FBQUFVanky
U1RCWlhVRlJ6U2xaalZWRjZhV1UzUkdrMGJHSnNUbXBSQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQSZwd2Q9cFhXTGNqRVBsaTRxb0hqcG1FNk5kTUxTMUl3SU1RLjEm
dXVpZD1XTl9YWF9uTDdzSVNPdTg0X2daTjNhS0xnXG5QYXNzY29kZTo2MjA4NzRcblxuUGhvbmUg
b25lLXRhcDpcbisxNjQ2OTMxMzg2MFwsXCw4ODMwMTQ3NDM4MCNcLFwsXCxcLCo2MjA4NzQjIFVT
XG4rMTY2OTQ0NDkxNzFcLFwsODgzMDE0NzQzODAjXCxcLFwsXCwqNjIwODc0IyBVU1xuXG5Kb2lu
IHZpYSBhdWRpbzpcbisxIDY0NiA5MzEgMzg2MCBVU1xuKzEgNjY5IDQ0NCA5MTcxIFVTXG4rMSA2
NjkgOTAwIDY4MzMgVVMgKFNhbiBKb3NlKVxuKzEgNjg5IDI3OCAxMDAwIFVTXG4rMSA3MTkgMzU5
IDQ1ODAgVVNcbisxIDI1MyAyMDUgMDQ2OCBVU1xuKzEgMjUzIDIxNSA4NzgyIFVTIChUYWNvbWEp
XG4rMSAzMDEgNzE1IDg1OTIgVVMgKFdhc2hpbmd0b24gREMpXG4rMSAzMDUgMjI0IDE5NjggVVNc
bisxIDMwOSAyMDUgMzMyNSBVU1xuKzEgMzEyIDYyNiA2Nzk5IFVTIChDaGljYWdvKVxuKzEgMzQ2
IDI0OCA3Nzk5IFVTIChIb3VzdG9uKVxuKzEgMzYwIDIwOSA1NjIzIFVTXG4rMSAzODYgMzQ3IDUw
NTMgVVNcbisxIDUwNyA0NzMgNDg0NyBVU1xuKzEgNTY0IDIxNyAyMDAwIFVTXG4rMSA2NDYgNTU4
IDg2NTYgVVMgKE5ldyBZb3JrKVxuV2ViaW5hciBJRDogODgzIDAxNDcgNDM4MFxuUGFzc2NvZGU6
IDYyMDg3NFxuSW50ZXJuYXRpb25hbCBudW1iZXJzIGF2YWlsYWJsZTogaHR0cHM6Ly91czA2d2Vi
Lnpvb20udXMvdS9rZGt3aEI0NnpiXG5cblxuDQpMT0NBVElPTjpodHRwczovL3VzMDZ3ZWIuem9v
bS51cy93Lzg4MzAxNDc0MzgwP3RrPVZzU2hITnhpSnZBSXVlQkFkMXozTEE3T1RZcEw0LUViUnJw
SjJZZmdIMEkuRFFrQUFBQVVqeTJTVEJaWFVGUnpTbFpqVlZGNmFXVTNSR2swYkdKc1RtcFJBQUFB
QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBJnB3ZD1wWFdMY2pFUGxpNHFv
SGpwbUU2TmRNTFMxSXdJTVEuMSZ1dWlkPVdOX1hYX25MN3NJU091ODRfZ1pOM2FLTGcNClNFUVVF
TkNFOjE3NzU0MDUyMDkNCk9SR0FOSVpFUjtST0xFPVJFUS1QQVJUSUNJUEFOVDtDTj1ab29tIFdl
YmluYXI6bm8tcmVwbHlAem9vbS51cw0KQVRURU5ERUU7Uk9MRT1SRVEtUEFSVElDSVBBTlQ7Q049
bGludXgtY2FuQHZnZXIua2VybmVsLm9yZzptYWlsdG86bGludXgtY2FuQHZnZXIua2VybmVsLm9y
Zw0KQkVHSU46VkFMQVJNDQpUUklHR0VSOi1QVDEwTQ0KQUNUSU9OOkRJU1BMQVkNCkRFU0NSSVBU
SU9OOlJlbWluZGVyDQpFTkQ6VkFMQVJNDQpFTkQ6VkVWRU5UDQpFTkQ6VkNBTEVOREFSDQo=
--3ab3c093dfd7cef1675f8a0571c505a01d61737f761b1144010835ca8ef9--

