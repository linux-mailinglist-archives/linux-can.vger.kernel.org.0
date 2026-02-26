Return-Path: <linux-can+bounces-6648-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cD8WFw2MoGkNkwQAu9opvQ
	(envelope-from <linux-can+bounces-6648-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 19:08:13 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AFAA21AD456
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 19:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CF71A3533567
	for <lists+linux-can@lfdr.de>; Thu, 26 Feb 2026 16:55:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB34449EB4;
	Thu, 26 Feb 2026 16:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="bwcGROu8"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C5A428824
	for <linux-can@vger.kernel.org>; Thu, 26 Feb 2026 16:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772123965; cv=none; b=Bre/XZlilymQh4HIF3uX9OtkpR6ZeUHkMuoZWOeS2x8BM1wn9Yyt0PPB8duSgZJI04XgnLaRrKaQYI/oT676KObZ9wtqM9y7HhHrDEgbPls9dWoolnnwP2VO7eE4vlOZ2f+f1z14IZ+1rxnZuCwhDnb+1KYhaWj9Xvw/h2L/HvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772123965; c=relaxed/simple;
	bh=RGWiSz0OZmp56vuOsH1lOEqi0n+JuVLSekK0RKtPb+k=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=mTWcnLoj5KQfqPDvlbKcZOBjM5g5IPVZ9RR8M+l9tjb+Lgww1jfOliGEdYvDCq27XfrwcMA+e7tytruC0EGddzNUQnoAMSMSKbybZzpZj+B9ufIgxZbNpspmdsC97Cr2bYru0q3imqUuIEX0krl4Dk4tP0xu50u+ecebxd1Q7EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=bwcGROu8; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-436e87589e8so1054867f8f.3
        for <linux-can@vger.kernel.org>; Thu, 26 Feb 2026 08:39:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1772123961; x=1772728761; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=T5B6phFCzYt+HE2CB08nF7/uTT/Fn+s/IX1ktent940=;
        b=bwcGROu8ySlq6V8VV5fUlZS2BAQO4EwVTN7MGR+EKIKA9rPR39Oa7nYhkrBFMhO/zs
         zeq5RZVMM7AVUr6fajkAMfZ164aRieMyR9GpGnoX+1jw5weALsVNKGDXhUVI0aqCENCS
         j42ZUEB1hVcluGyz+IchK4YEYq74c8bhKcqRrfSLYX76spjJeKUV60u3vHDl2taIffx0
         ZnKfggnJFxP9iStsykERxVo71pvjbZvYtm3qSMyirzSDMoLxE6WZ30izQSUwkUGTYVQ0
         OaYFJvuDOPRAtRY+RRY95dGY/gIh8vT95t53ud0azuXxtqWOgrF7GBphP2HT+D0n+0XA
         2p4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772123961; x=1772728761;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T5B6phFCzYt+HE2CB08nF7/uTT/Fn+s/IX1ktent940=;
        b=r/Yo7nLVbdAPFlu9RIoEN0sGBJC2VEXDplqRbXaj6cuMfkwZ0/0tGbCn160Ti33+Hc
         1RIyY0UXbz0FSLfUX+fzwy3hC1lBX1Xfxd/vCyGzcViDrLT+CDVD6pBK5k1JCrr//u9T
         76m338qcYmh9knzhdcNrJju3IxOzcZwTFhsqN+2JDGt0N4THrYi1RZ+zb+evESKOknBW
         zSFhgi7EqvU7I/9Q/ysjBuofkakr8H2KNek3NKlMZMJ0NEKp3k5ikvxNvACmVhi45SgY
         KSy3x44GKMMDx8dfwWpPbrBOsqc+808HO+sRuE45u5YrLXCtXgl5BKhKD7wbZXPKAFB/
         KeEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXKCJ/crtE3yHF2snAUHH7eTCkH00pyZwnFYhaR40NjEHcAMRNJd9WO+MjsK5PXv/VPxd7yA1i61HM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yygb+Q2g4N3eV3XPMiTWXt1rLPVU0mws1qtIJs3suwE+F5W5rQV
	1zNXtdtGfU2/f+ul5NpiGxNgHfrw1ntX7LB3pmXY5xQJVkDPHj3RlM2kyy9sgq0Jm+E=
X-Gm-Gg: ATEYQzw/vPM5uGu4IOxURlNWl3i0JNnMBy7Ok3yya77nGq0sVQAZ5WwNQdvRMHq3AiL
	gcH0ydUmFM2sIM8HhsOgr1XLaPo8wfyABZelXmqI+zFIyRpMYndmVhIvXF0CnhTPbhZ/1u2kyfa
	Jp2yL/GQmrbbjaFBIC9/dvVmxmfztdaQaPqDjj50bZwBmpEqF4l6LvH4wB/G/G5ctQGI8AMX1vC
	9KtBa5J6ERoPOy0AWpBT20lHz2TWKc3ou/jNXzfX9yLdF50FzDhu9dmVYHkCLcUrWxd4BK3LHUO
	RXTFWSJ6rehmlAeO28sCinTq0Hidx4Dk2hRiTEbmxr27tNIKy5vXi3RZ/9d8+vYbwtEF1UANE+y
	pRNArrE0qdMoIkimgb6tILPQmPServyoqqxRan6svJr+y1TWCds3siQ4oUOLlPByrPNt7dBCh7y
	095q9sT7PiqiYczgVxdkiy1I5fPg==
X-Received: by 2002:a05:600c:37cc:b0:47e:e20e:bbbe with SMTP id 5b1f17b1804b1-483a95e9b65mr334329625e9.25.1772123961331;
        Thu, 26 Feb 2026 08:39:21 -0800 (PST)
Received: from localhost ([195.52.25.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b770c2sm51360545e9.10.2026.02.26.08.39.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Feb 2026 08:39:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=e79d1022041faa676f36278d4e8685f754cef59bbd011f58fe85541a5fd0;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Thu, 26 Feb 2026 17:39:10 +0100
Message-Id: <DGP1IG1JH4NE.17BPCN6IDT2OR@baylibre.com>
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
Cc: <sebin.francis@ti.com>, <d-gole@ti.com>, <vishalm@ti.com>,
 <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: set out-of-band wakeup if wakeup pinctrl
 exists
X-Mailer: aerc 0.21.0
References: <20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com>
 <DGI13PI02XEN.3MNAWATF73XVL@baylibre.com>
 <b330487e-0564-47b8-95a3-c6c207964056@ti.com>
In-Reply-To: <b330487e-0564-47b8-95a3-c6c207964056@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6648-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msp@baylibre.com,linux-can@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.997];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ti.com:email,baylibre.com:mid,baylibre-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: AFAA21AD456
X-Rspamd-Action: no action

--e79d1022041faa676f36278d4e8685f754cef59bbd011f58fe85541a5fd0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kendall,

On Thu Feb 19, 2026 at 9:31 PM CET, Kendall Willis wrote:
> Hi Markus,
> On 2/18/26 04:51, Markus Schneider-Pargmann wrote:
>> Hi Kendall,
>>=20
>> On Fri Feb 13, 2026 at 7:08 PM CET, Kendall Willis wrote:
>>> In TI AM62X, AM62A, and AM62P SoCs, the m_can pins can act as a wakeup
>>> source in the deepest low power states. However, the m_can pins are a p=
art
>>> of the MCU domain which is OFF in deeper low power states. Since the m_=
can
>>> pins continue to be ON even if the MCU domain is turned off, set
>>> out-of-band wakeup for CAN device if `wakeup` pinctrl state exists and
>>> device may wakeup.
>>=20
>> Thank you for your patch.
>>=20
>>>
>>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>>> ---
>>> Tested on CAN IO wakeup from DeepSleep low power mode on AM62P EVM.
>>> ---
>>>   drivers/net/can/m_can/m_can.c | 4 +++-
>>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_ca=
n.c
>>> index eb856547ae7df27a844b236a0c1d4498cbb8b60f..8b277f5e208ffa634439b9e=
a8495ed56f12cfccb 100644
>>> --- a/drivers/net/can/m_can/m_can.c
>>> +++ b/drivers/net/can/m_can/m_can.c
>>> @@ -2622,7 +2622,9 @@ int m_can_class_suspend(struct device *dev)
>>>   		cdev->can.state =3D CAN_STATE_SLEEPING;
>>>   	}
>>>  =20
>>> -	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
>>> +	if (m_can_class_wakeup_pinctrl_enabled(cdev))
>>> +		device_set_out_band_wakeup(dev);
>>=20
>> This will set out of band wakeup for every m_can that has a
>> wakeup-pinctrl set. am62* is currently probably the only platform that
>> uses the wakeup pinctrl setting but that may change at some point in the
>> future. Can we narrow down setting the out of band wakeup to the
>> platforms that support it?
>>=20
>> One idea could be to parse the supported system-idle-states from the
>> list of wakeup-sources and see if deep states are supported that would
>> require m_can to be off, e.g. mem-deep, off-wake. I think that would be
>> a clear indicator that out of band wakeups are supported.
>>=20
>> For the list of state names you can have a look in the dtschema
>> repository:
>>    https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schema=
s/system-idle-states.yaml
>>=20
>> What do you think?
>
> I agree that we should narrow down setting the out of band wakeup to the=
=20
> platform, but I am unsure of parsing the supported system-idle-states as=
=20
> the solution. Since we don't know how the power domains in other=20
> platforms are organized, it would be hard to say that if deeper idle=20
> states are supported mcan has out of band wakeup logic. It could be the=
=20
> whole power domain was designed for the deeper power states.
>
> Additionally, without out of band wakeup for mcan on AM62 devices, mcan=
=20
> can only wakeup from mem-mcu-active idle state, and adding out of band=20
> wakeup allows for wakeup from mem idle state and deeper. Checking for=20
> mem idle state doesn't seem deep enough to warrant setting out of band=20
> wakeup for all platforms since some platforms could have mcan in a power=
=20
> domain that is ON during the mem idle state.
>
> Another idea would be to add some sort of property to the device tree to=
=20
> denote the wakeup source is an out of band wakeup source.

Sure, a generic DT property would be good as well. Do you already have
something in mind?

Best
Markus

--e79d1022041faa676f36278d4e8685f754cef59bbd011f58fe85541a5fd0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaaB3MBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMe
VgD9Gjh9TrBAM9VIzW+ZXCPWjq0RhP/Cq0x/tDWE6Yws6psA/3Ju/Es4ea9yQkhw
H2mtiB3MXzHE76zIt4Qrn74QLm4M
=tFV9
-----END PGP SIGNATURE-----

--e79d1022041faa676f36278d4e8685f754cef59bbd011f58fe85541a5fd0--

