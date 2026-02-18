Return-Path: <linux-can+bounces-6583-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LgjIA2blWmsSgIAu9opvQ
	(envelope-from <linux-can+bounces-6583-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 11:57:17 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F08FE155B34
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 11:57:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 700F13013A53
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 10:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50BB43033C2;
	Wed, 18 Feb 2026 10:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="zaYTlliX"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EF6302773
	for <linux-can@vger.kernel.org>; Wed, 18 Feb 2026 10:57:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771412232; cv=none; b=WwvHPvxfcxiUgLt+ULlVReSC5hepmulK8Z2OqKT8flvpK+uvtCc03cue6Lc7kFOQONHvHatgqZAj0Qn6b7bi00Vi3RG0uXG6fTz0aaQRMZzvQeVgX3aUVYMoXnONpNXWvglVxR3DZFkQ7WtHuAKExKVjWkpDNBby3bQEVXF8eH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771412232; c=relaxed/simple;
	bh=pTjhGrp/1yFoC3l0SnmA/XeP6V/d28s1hteX71wVtzQ=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=cR448EvAzCdxRKBajQrT/0O4XWhSDpSpKp+zSu8QCpYBECPnbBeg9/kbzZuVMY3XdkLA7e8KgJhAQlwq3jZ/J2COdmx2Qk6bOgApIIwsVytPPoQWVuZNj8xom14McEK2HEYmKLvPYFgTdDNGXWUGauECV1M9e+Y/LHa1/hq+p9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=zaYTlliX; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-48372efa020so38053875e9.2
        for <linux-can@vger.kernel.org>; Wed, 18 Feb 2026 02:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771412229; x=1772017029; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SJKmjcopn0GeXwcBkFSkCi5fFaZptlJhauETgGPH6T0=;
        b=zaYTlliXY6db6awcKC62ZN/bSkzpX6laUPTEiDrtJ0fvsl9cmbodjBK5IZnAzAKUcS
         OfMP1cYsIlTrv/eFEuUWmSw2+PBl3i3fHml52rydVMo4T2UUY9+9hKbPv+Mc1jBSY6bx
         K3YWqMnQieXuR5JV+hPg8IeDzc35+uXR2bmfsuao4skkJc9DfTlmfOsve89lkKVwlrSw
         3p/X4xsOAclHPCwpJnlEXQQvsjxe5ox+5l9AhJikdiwzW+gI0+z+HZ/dLkGAvXu2EQtI
         JO2qpBZjiuUj2uvl1itNY6/RAw2fMeAozXQY0GxLYhdXHH7ODM0E7433/i/SvJpZX8ym
         G45w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771412229; x=1772017029;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SJKmjcopn0GeXwcBkFSkCi5fFaZptlJhauETgGPH6T0=;
        b=C1IRH+lbAxdOAgVbjJjNb2NA3/sX7bJP9S5Ca2cF2KGFlx3uwCn2QDe4lAcp7Dg5O+
         Ka4Tas4BVB1H49fN572aSLWxw5RepF7vg2Iq07n2fHPQI+46Gf5ElN6XmBbKd7QFK5M7
         +px3Ubr6pLTf8RL1u5bTTRlFefJFWWWPEOwMfO3tIqhF8lnic8i7c2NDwrnG11xP2V1V
         aJTprD/Xj5bqP3M8CaJUA9FJoodJTiHMsW1ZG6gcsfx24smqz7dehScNMJD/rPESQfWJ
         t93nB1bTRD32P6MDoO6GOiBthxqt8vBrzPqoVz7vjS6l2FYAKEhpIZHKWSpjk+BmUvMY
         geEA==
X-Forwarded-Encrypted: i=1; AJvYcCWj81RORsvry0CDXQsrfKIys4Tlj8Rq37v9tSajRw9IJ4anrY7Xgj2pPa2ORuELTy1uJym7sR4aM1I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx0APiELBGJVFAhLNZMwKXiEY0CZ4Vup2wT7w8Bju8SNOJYi9JV
	KUvu3RIx/vUN95Y64DU1U1KFEMzLSMXVG7Irv3Ewf239A7Mv1qYH2ZzL/SPJttFMSws=
X-Gm-Gg: AZuq6aJKFEezaXV2GaUxgqYVBpCLYZgKTGgZoYxro19uYtXY73RcMxq08QpcdlWk9SE
	pdlvZJNejEnXd9OicdLK9b8mzor3kvvNWcud0lWj8lAjWaSKt65WpiWYfOTdHM7K1P0qjfyJQc/
	jJI6cN2Q+K2wXbbUS8dGQvla33I01DhnGi7yiSyKLyOAHpVfMuc/JQugiAPcL9e2wWa5U6619sx
	oCK0jlzSQ8za5WxVJu0q6LizqJszSM0PriXZbY7LBWTSbkTu8tt27BsBIxKQewB/IOgEMVdSTLV
	F8+xJE/E+LeT2TPysbOF/Of2/J3PHyLcyX0FMFprWvsjEihW0+7zXOSMW/yfsY2IKSj92LnYRf/
	+kmexyoQIPynKneBHo3tYDivl/bEXAACSLejq9O3pq0IOeeAVPTupOS1W14Vw8hHxupXqdWxDL4
	xiobGhOTFjnmQx/xQ=
X-Received: by 2002:a05:600c:3106:b0:46e:1a5e:211 with SMTP id 5b1f17b1804b1-48379bfd705mr259932745e9.21.1771412228786;
        Wed, 18 Feb 2026 02:57:08 -0800 (PST)
Received: from localhost ([195.52.25.213])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48397318da6sm34271205e9.2.2026.02.18.02.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 02:57:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=0ce6e9ff61adc7cca84f98e94a09068b160ab26ef70523e44bd3b8a5507b;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 18 Feb 2026 11:57:03 +0100
Message-Id: <DGI1850U6GMU.AMN60BPYQ73I@baylibre.com>
Cc: "Markus Schneider-Pargmann" <msp@baylibre.com>, "Vincent Mailhol"
 <mailhol@kernel.org>, <sebin.francis@ti.com>, <d-gole@ti.com>,
 <vishalm@ti.com>, <linux-can@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: set out-of-band wakeup if wakeup pinctrl
 exists
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Kendall Willis"
 <k-willis@ti.com>
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com>
 <20260217-remarkable-jasmine-sturgeon-3edb31-mkl@pengutronix.de>
In-Reply-To: <20260217-remarkable-jasmine-sturgeon-3edb31-mkl@pengutronix.de>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6583-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msp@baylibre.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[baylibre.com:mid,ti.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: F08FE155B34
X-Rspamd-Action: no action

--0ce6e9ff61adc7cca84f98e94a09068b160ab26ef70523e44bd3b8a5507b
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Marc,

On Tue Feb 17, 2026 at 10:08 PM CET, Marc Kleine-Budde wrote:
> On 13.02.2026 12:08:19, Kendall Willis wrote:
>> In TI AM62X, AM62A, and AM62P SoCs, the m_can pins can act as a wakeup
>> source in the deepest low power states. However, the m_can pins are a pa=
rt
>> of the MCU domain which is OFF in deeper low power states. Since the m_c=
an
>> pins continue to be ON even if the MCU domain is turned off, set
>> out-of-band wakeup for CAN device if `wakeup` pinctrl state exists and
>> device may wakeup.
>>
>> Signed-off-by: Kendall Willis <k-willis@ti.com>
>
> @Markus, can you review the patch?
>
> To both of you: Do we need a fixes tag?

I don't think so. device_out_band_wakeup() was introduced after the
wakeup pinctrl was added to this driver. So I don't think this qualifies
as a fix.

  4acbfb6c116b ("PM: wakeup: Add out-of-band system wakeup support for devi=
ces")

Best
Markus

--0ce6e9ff61adc7cca84f98e94a09068b160ab26ef70523e44bd3b8a5507b
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaZWa/xsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMN
yQEApWFdfafaZJUnyQzKmNHf9kQZsxHForR/Pw/E/8Urvl8BAP4E0YBiIuP8nHmx
lL8TUl2xdbAaEk8l5BLkmYvzWggP
=Y82s
-----END PGP SIGNATURE-----

--0ce6e9ff61adc7cca84f98e94a09068b160ab26ef70523e44bd3b8a5507b--

