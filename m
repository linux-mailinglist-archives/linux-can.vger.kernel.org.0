Return-Path: <linux-can+bounces-4368-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B75B9B34826
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 19:01:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9B54C4E36C7
	for <lists+linux-can@lfdr.de>; Mon, 25 Aug 2025 17:01:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8C4C221F32;
	Mon, 25 Aug 2025 17:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b="ovIdDuVP"
X-Original-To: linux-can@vger.kernel.org
Received: from mout.web.de (mout.web.de [212.227.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29EBC19066B;
	Mon, 25 Aug 2025 17:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756141299; cv=none; b=FjEqI5dYIPR4OVj0i4qFVtqDB1wcYb5vMDpr5W17STF1wSNNs5Mp/vpd3RtdrDpvTvxC5NKeURRcbitWj9NJSXEwSH9LURgBV+PNMjGKLiL2Eq0UyxGKg+SuOUCy+BArJM1TulalSO+ato64GEgLzwV7op6H1CKz7uuI1LfkiAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756141299; c=relaxed/simple;
	bh=3wT4+cJCbtEBMfkn1HV11WXDCBAs2H4x33a78KBnBfw=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=bTDIL/sNRGpUpWkh1vY2choA9Jwo1qXU6qDRgla+JODILoyBP0oY8M8FHqXo0gfQ2oqsfiBpOz0NdtBw3SnyW/nIPFDFaf57BcgHqYG6aW1luuiv1cGuvbwGDg9vZJGAFlKQw+iCUMMc1LCSGlIKe6xLoq5f4ERpLq9hS/WXYVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de; spf=pass smtp.mailfrom=web.de; dkim=pass (2048-bit key) header.d=web.de header.i=markus.elfring@web.de header.b=ovIdDuVP; arc=none smtp.client-ip=212.227.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=web.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=web.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
	s=s29768273; t=1756141274; x=1756746074; i=markus.elfring@web.de;
	bh=56WlR5aMs7NIfYzW089ZcglyaaLzKpP3wQDYxiyC27c=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:To:Cc:References:
	 Subject:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 cc:content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=ovIdDuVP6aisp+jswCHOctNu/YGw2JvODpq2hbNNfxXWM2YF0kQWw9H3e+aMjMGT
	 hndDNAu5XuFOpM1d7wDUd+Hk8Lv6zI7L7LvGVtBnQc2vRqXJFqHICNbCNQoKrFV/5
	 54/+1PLae8assXe12QwcT4YaEEVnq1wqWJ/jJWAQToI9F7+T7kYaR4x3UEscl7s5V
	 2RvydD91bG4xu12aUbCUXOw9gvyRELuxZzV8AKVHXt5bNWmWrh3m7ocuElpJMFwmx
	 xgINiTmO1bxqmkuYNqszsPoVDT8PkUghMKIwuGOgFTXkrOX1uBQ4Z3FJrlqX083+i
	 XPb5SjTJtVR67NVO4g==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from [192.168.178.29] ([94.31.69.250]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1Mft7j-1uJiiZ1p3R-00gkMB; Mon, 25
 Aug 2025 19:01:14 +0200
Message-ID: <6ff39d21-5770-44da-9d1f-c4447b8baa3f@web.de>
Date: Mon, 25 Aug 2025 19:01:12 +0200
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Xichao Zhao <zhao.xichao@vivo.com>, linux-can@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>,
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
 Marc Kleine-Budde <mkl@pengutronix.de>,
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
References: <20250825090904.248927-1-zhao.xichao@vivo.com>
Subject: Re: [PATCH] can: m_can: use us_to_ktime() where appropriate
Content-Language: en-GB, de-DE
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <20250825090904.248927-1-zhao.xichao@vivo.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:YXWeqkmT93KWxkoKEXLEZTYYe1auFE5xp82/7U7roJJkyy8WSe3
 TY6t3B9wSLlKWlyY/2iS05E71+KGe/ykopFykSh2dM52TnQ9mmdFBxS4R0nCNSnjjXD2r+p
 5oT575DSRSoYAT7ZcMfMu/enh+lJzJxLF7iZhtMtt0/HCQJ3czNN/vfuxBrAfY5hg4Sk5nC
 UPM+bgq5SN7ZiVetWTFTw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:AJF+mitjp1E=;bwt/qViwIqV+HxkTWo4t09j3FEX
 kk4BxmYO5JeKujvwIr2dZEdM+/lPPBpYrwrzkzLJobxjL70jIdBMId2EUq8UIC++YMC37mItf
 RNUp8aUEqaJyCBHUWGvqxJn8BDlGPPb0DVgFFGFkB3h0uU22p3vnUpegDnkWec1CPBoxu+bv+
 dnNpzlRoQvv2hAnGvP1RvXSKBkCvlp4EIETAu8mErHIFTD+NMntuFi+Zk7XM6KWcnafS7KmGc
 KhG7TY/ZUBGLNrlnO3QjuzDIjpnwRPJiDRRSWa8LuQC2PSS7PbnhLhnh6whZ6GNudoKNoASEa
 x4xaNJzD4KyvFNPilf3WIgcuVCFS8pDZDqDeKe8H0uTtRqSV2rL8xx/bJ6MRVLR0UxO0POIz/
 VziEDJIuYtYJ1IMMY2eut9Zip0nYnOMsbdXPOU9nXY2mGOD0dcBT9kRSpAROerHdnTVgdAlG0
 EXPGU6lPMiJ5kxs7j6/ZjcavOd8VvaMLUFNpOUnhWaFyZWLL4G+Mnf92bWHGceoUGlpPIR1nJ
 QrgDK+vTtGOR6GfVZ+BJ8eq6/d7GOsdsngD6YtXT/bRIQuurBgnUTKCS6Fs5pQ4+EUoLZnqs6
 wLr4rMOqIkDhS/w4POgEh573Qq1nghE4cJsAUWovWV1EJ+wy/Fbw94PeeJwDgRdTjSEveo4WS
 rT5YCUmjs18xQRQaRqIdvHN4rFoTjxy+xdZSFEdo+RG3vFnHi+6Ovp2NeXMl+TmD/Dttp7NZa
 VQv6QuPgCO8W+xttuyM6JNCaRM+LpzjfM6/LTqTuy8gcAmF96ZpHdPxXaejISNyZpZD3SkRp3
 Zkos6LV5qezfDPtKWCbuUuG9BLkZJbutvtBHpePI7fkq//b75SfPgCS46KkDkOP5uRaqR0gTm
 4P4Rsz3O7JKXaIcQhiCUB3s5x/no9eaRZX9PMVBLy4fNt7YZbMFxN3ffCApopWSvRYtDa1y/N
 zZXo/R9gXFQRp0nQwhLBg4Xv/f2TKxkl+A48JwUMHxTDtM6/prdsl5mSMwRC5oITa0I8Me3L2
 vaX0M03pbuaGltRCcYcIVUTTENTpZs5myfrtGIiLV/3qMYVVhWbG8ERNlKWkyTwSY2C68IHrU
 UsvK8u60P/nYCe6BYqSYBxNuVo9qmGDtVzAdI5HhkKzDZHjqLL/zwqRZ1Vf/nwvb5Y92E79BO
 qrrm7GQHCate6XFGnErmOminCcXQD+yj18Xwp9jBoisDvsyl9kem/4K6arPL1Qa170fEZlSOn
 o6buMH/XgC2hU0ExK1JRYZ9RJy3Q09QhDBlshfREDKg0jOIAjXY8ZUK4QSKZwGKreC7uVYcRk
 R1m8yqFDwjpcl1g0TtzaZJV6SvmuJ8plLFIqtj+xfcYu5NHxuVnxyvn3cmZ/a5IrlnUzly1dW
 zgT9/NgwIhRMQVNglbnoxETLedcX6w9mMM3VbZxVcTD4ZRMrHo1DdtPFVk/UjYvs8GojQp6kH
 K2TYsA8TZE6AVsWp5DSwXB0fCdk1zlGP0rtzoffkcVIqdCGQjXtIFuiUXuYhds/5ZJQDbuwiL
 6YnsT1QWRlt9TL8VdDX5HkDEyuGPj3VDCnJoAYpk8i+R8yW2MMJHfYl1fVAKaZtVERWT6fJZ8
 T9EnD7Pd2K3uECVLTOG51rCNIA/qIdoPPSgG7bPpqc+ig/7SpypSDyxr12G0O8slA3cpSDfXq
 Q22sRVHeLzoSfI5TBbKwFp8zvaQSI9FH9u3ehCkMS3flXQbQhIpc1e5E7GK72231XTFvW5b6W
 34+cUveFUaI4m6+8E1qD8kUynI74i4v7txlNCHt+1DvGn5BPiDW3voGDx0dZ97B0DuUcJVIIf
 M76XObQRjfBbxDwe9WCvSY40FMQLOWm1fXTQb1NjwFNE+a+gbFHNT+8yLvX/JftHbmSasgJE0
 iz1/4htpZ7dYQixZGBxBhD1ULo3tDHFh1FdQktVdR7vkfPklo/9h0nDGius3yi8BOegsSMB2g
 Bs5oxfb41j2YjdWGYfO03v2bS9BkurnbtedUxQlqO94Sv+nR1ht1zM3sjlgNgCv7kGdIdK/3W
 PwIvOLZVVCQE1uoBSSUPdx06uTW/0F28kKLrsNO1l8k/ggSgvjSdGzUeqx1ZP0XLY62Dn8SBu
 MgJ07QDPxT09nnQIlWoKabBBNw64decgM6RpnRheVCj3tr1/+w/7FkppO3vSeb9/87jhskbWt
 gLYU3uBoGxjEqyr3X8xwZpa1pF95XBVE0wFrUyvq116KBmuAKr7zPNF1BohyQROAMRzijrOLu
 L83sMkinE+9CrSwLoJNwH0ZwRySa6zPJI4y510GFlnVJ08RuDym46uFcCGtnEPt1xl2ViLnmC
 y93sftr4dSjFiBU/mhnNwreG/xLy+Y8URz33H7gtasWE7xRr6kmAgeQNLhrsPfcN3y0iI3wWX
 muYUCNxoI4NpaoVk91m915mAqB0+Qm+6H8uETzDLi1h68iPZytD/IcipyC2PG4+Iax871K7ph
 6J+tqoQWFeTRUr0/7upaeCpGJAKVkZd4eJ3XxrAETuo76unGKfzF8nBMDBQO7sQjtvKuyyFcp
 06Zt5lan5eKCx9JoxrGmoQ02hsBKYTxZ3XpLpN9fnUmk0+guR5+y6uEVpM7NCeMoJ0WPVC/w8
 AFz3xjW6twrSBFm5IUU8M9PVOclWLus/6CclygJRXaKznEg8sxsNETu2Z+nG9W7B7GQxP5GA/
 DNU+gg6rr8rwpgF9jSqh0w2KMh5Bw3KRPJOku53ZWNIELR+P+CXvKL2+HFtHH61DWOW72bG84
 Ns9/VrH9l1GOv2kKSu+7cPbfNgdv0IodPdWITL2AUc9wBV+ZtVJf0NVKNSYUtbdPmdInzYYLP
 H8+NQDEkDbSvsiwEhsC0zOh5Gj5RdJzLbIWTekR/kKL6uNeIn/YYUy/zfj+iV6azcC+leahz8
 0gmVRgDc2F+IYrIzSXsF839mXmcJjliKhKFskIDZC1v3Mb1nuc7ImJ3Unom86Ybg8GH5g7PpL
 ZWL4l++IqE2VZp42cxvsTWesmncZ95/Ienkbh+DXIpK7fjCz4ywLOq5yPZqLJWpNqmUZr7Yi4
 q3nw/UJVf/syJaTsHl/xi3+RRP6lxxsH0p1bb1+RtrqfjabbSc26F+QtzK7/K5hrLBPO2pySh
 ul6nPDdl4GvDNJlUlCB+xrFqQKnIf0eoYTO5S34j0i+AhdMemPdtv2UWm63A883UxAhLbLzX8
 gg0OZY0FyhDyr64RD9uMk2xBimHo3+p2liCNWYoJy96OL9ZY6+6oi2lNejIcteN4D++0L5Y2Y
 tmJ3olUXNMcruqlpjPyAXg/qnhhIrb+YXWMCsw1Z/O2ScJOwEHDJ2oh3Y96NPPrQzXpOtAfWu
 tLlkDiDnuXbsIiqVTItubQOmxrfHJlevW6n3AElDj0KOQRTDKUUYKE/YyBAYi/w8/DFd2HQbg
 iinKUXMsUi/1T5Z4uPsTbi2RwrYhU9kh0En62MZzW9nTcRXD4s8JSbW0ZZe0qJjYwbouhyNhG
 zCQs9xWozPYkNZmpmJYi1uGpsnl5iomJNtT4McKhKu9fwgkpVJTZSEm2eCuA63q8GcDVWZMmt
 OB/myhh8EcIsLDGJ+KCW39WukzcYjcS954Hd0P/jsHGL1xJOzaY7jbAz0L0Sz98LpuTvOCL/c
 5QFbQgdEn2S8825v5jpA8EPVYjGP5rRXZEsk20cFQLyx/So57IVjzs9Jlgd54+eTEOQBy1I/D
 U386Ezm+DoonTmg9V8UfBREksyG+qFVd0r2QqBA8bC1gWsUXZgNdahU4MtMbvEJrqFuvLuIi3
 I9TdHqtIdeWXqGq1AGrIj4el1p+bgpAD/Uo6oyTAMw9D3Cfo8YL36HH84xCT2In08vHEdwKJ+
 woJG4s7MllI82hpqM3pAUlF7e/AXUov9ZG0WVS/x8WgACq59zQBYUxgvKEjV4inaMCTSBpmev
 KHAYm1YsxTjUB7PH7d7mvKPisMsNDvCN7Q5gp1mn2QY6JxCbnxuM2k0pCxPIn1o6vt9xaqklw
 EyvmsTfMds8c8DLgw0060XYy2KZlUwH1tYrMxTlZQtJPc1poZUXRc32W/Ep4SlIREuYcnUwMp
 91F3lfLDJ74k3eHN810H7CdHL9co1wtA1kCIks12xlaTjLlJNysZTCzhQQ5QNIsep6UtpKHzu
 UDK22cGBRkQeY52E8eIeNh/zqZIkE1jZ7Nlh7jJKQp4UWCbQ+I8ktRxmghsGttVyYCBiw8o5Y
 z7B3mUaouzEWw0B7qw/sktUeJSI7O2lcjwK4uVHqRT76LP5RV7rZWvYNubHR0kpvhwan9vAGB
 8ErNE+BoxpkI3JK4c1VL5iR73v6vsk1deQqvqaEfE2tNwJu9wC4euJ3ppqfkN85+l+9wuo+Fj
 yj9sv9g08qiJ/xEAvrhc28Z33SPibf6L/Qpua5dogwCIALAhDc9jfK0S4TEQOfiTvZ13mQEzk
 pAyOCasgW8DlAmJfyWJ2IBtgXe9N2KK9fxjM1TRMGYKARORSnLsSFMSRoKOvflD9/bEmgkeuw
 JTlTy6EoRPsOoD+WO1ndu9B7+OVwln9I/Ibq3D1pArx8/vxAEJwKwnjDj69Rgt/MmpHgBxXxr
 NuewcsKLiaVDA9NoMYtux0+kZW4vkWhtmsE1kCqr+bnzW2rAoZ0amIsdxGMGl/guKAWn3+YhY
 tCYKffAAB9bXFPWs4gPEFezxl1FkwOPIkWmnhw+7QxW55KSawYiDvaZnqpw==

> The tx_coalesce_usecs_irq are more suitable for using the
> us_to_ktime(). This can make the code more concise and
> enhance readability.

Wording suggestion:
  The data structure members =E2=80=9Crx_coalesce_usecs_irq=E2=80=9D and
  =E2=80=9Ctx_coalesce_usecs_irq=E2=80=9D are more suitable for using us_t=
o_ktime()
  instead of calling ns_to_ktime().
  Thus make the code more concise and enhance readability.


Should the information =E2=80=9Cwhere appropriate=E2=80=9D be replaced by =
the hint
=E2=80=9Cin m_can_set_coalesce()=E2=80=9D for the summary phrase?


=E2=80=A6
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2214,10 +2214,10 @@ static int m_can_set_coalesce(struct net_device =
*dev,
> =20
>  	if (cdev->rx_coalesce_usecs_irq)
>  		cdev->irq_timer_wait =3D
> -			ns_to_ktime(cdev->rx_coalesce_usecs_irq * NSEC_PER_USEC);
> +			us_to_ktime(cdev->rx_coalesce_usecs_irq);
>  	else
>  		cdev->irq_timer_wait =3D
> -			ns_to_ktime(cdev->tx_coalesce_usecs_irq * NSEC_PER_USEC);
> +			us_to_ktime(cdev->tx_coalesce_usecs_irq);
=E2=80=A6

How do you think about to apply the following source code variant instead?

	cdev->irq_timer_wait =3D us_to_ktime(cdev->rx_coalesce_usecs_irq
					   ? cdev->rx_coalesce_usecs_irq
					   : cdev->tx_coalesce_usecs_irq);


Regards,
Markus

