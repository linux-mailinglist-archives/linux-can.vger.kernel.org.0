Return-Path: <linux-can+bounces-6582-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KA8UGbiZlWk1SgIAu9opvQ
	(envelope-from <linux-can+bounces-6582-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 11:51:36 +0100
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C8BA1155A99
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 11:51:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8B8D43016D1D
	for <lists+linux-can@lfdr.de>; Wed, 18 Feb 2026 10:51:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 256472FF67A;
	Wed, 18 Feb 2026 10:51:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="ImCfVtY0"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34822FF15B
	for <linux-can@vger.kernel.org>; Wed, 18 Feb 2026 10:51:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771411892; cv=none; b=khXdVk7rURi0oY5d6V+ekLOq297CxqzDuIUgP389ZLWOC4RE8ZcYgQYND3HFUAfZrnjc1lLFbzI920EDIb/b+SkvFgrovnQcwRYxh3gQ8AESMPxXWBipPB8lgw9UjDfLA/2/gSB/bNzz+25ssD6fxflEqG7JayIGsj0c9bYDDmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771411892; c=relaxed/simple;
	bh=CydTGmiSH8XUrLBmcxjsPqCgbLAhWDUUfkZOVx5TpK0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=dEN1TyihVEEttwtXiN3u0oWus6cSMIk1pQGBNKUa+SHpYF3RizF9DlvZUf06lIbZK70pKUsc21YZUhF7s6kZT4J+80Gx0rCXlTHIs+vlIiYUfDnbjVEu09LyH8pBeVZE1TExwJ7FOazbHGabkmkpyhrbsKJwOY2nOLuEIJBwvGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=ImCfVtY0; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-436356740e6so6070518f8f.2
        for <linux-can@vger.kernel.org>; Wed, 18 Feb 2026 02:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1771411888; x=1772016688; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qVYKcEiiNIQD9l4I4W+E1mrWwoLh1UDUICRzH/s0zMU=;
        b=ImCfVtY0yvKn285A9w+nd2MmGwemn6UeDgsQlEePaXFULaCq8Pv6LQ8vcCHlWQ28Ba
         sewKvgB3xZ4Q4htb1IMsMSv52TviHb6FPfGEAeSo5mNQtUPjiB782SYSs1ljwIpgUuB8
         w03T2KtYRjcNBvqI+tqVimTtelAeyOFRDo/9PZcWBlmxcBpiQOCKfv6Jj0mGqHVz6XTN
         jzdKsQmBXyP4zHV70O2clyxdb5iqHmooFgrlL22BuHxvcMDV7S7diPQF+kKOeK91MXTv
         Yks3ideseFfq5j0ajPc15v/fXPo2GDP7SsWfXrztVgs/vh0yHbSs8bShGQ5xyVga5Byp
         w9MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771411888; x=1772016688;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qVYKcEiiNIQD9l4I4W+E1mrWwoLh1UDUICRzH/s0zMU=;
        b=ME/ZODLT1dlTmqX0EbdfjbM9+tmG24O0bJACna5iqZiPrYsvbtWXvYliNwZ2/Jphb3
         7H82hnBsrln7ZsndffeGilOHgiFQHXgcH5Se2pPPWcXdPYs//GrC9K3sXbdX3qv/SHkI
         j2AJnJiFMnPe86KAu1NZq18NDVf4nR4QIpd37C8jxleTWOiiJsChViUmAE+KgVgme/6C
         XNSkj/fcIdeD6MdDV2wxkyO0iYR70/NWes0zKRZlODRvQn7IpKMeQrMre+slk6aEnNBI
         JthWpkBfLkK+uTbC/AGBTmGG8zCh3XipQcyf8TSh7RI3/xds4TGRvwLgBnSE59+QV1X/
         D/Kw==
X-Forwarded-Encrypted: i=1; AJvYcCUpgb8YuBTeYTz2kZgfGhfKns21itfT/uy+3Lh8ud24r02FaAMHHYz/ImmXAWeeEHs4GZYFDeNH+BI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1DutAT5GZtUqvw89jmT6iOtDMwQn8r9C+Pargiy2vOEIxEgKc
	fCGEWFT+0RJkGlEG5DtX44My7jyaWmaZX5cTHV46gsBiP+n7+vobvBI3J6fmRw+WNOE=
X-Gm-Gg: AZuq6aJKsvXGBxzPSInxF9tfLqRct8Ys7cHhAULdqSnJoMj4eb9mQ/RDh/Osr5y0Ej6
	ZorBhkFtbQbm3QtbV62xOCJb4g5qtBUyn4PifjqKeLXAFpaJ74yRGwe92ZUgRqoFmYPUmvNqeJU
	gcIXxAbQumxok4ujH0hDKxu4qRn5OD7ATTJOc+rag5chzzWKRMCdWS52RuNfjf5ICfeQvwAUJiW
	CwFAVyfPh5oYdjZxVhZit53aiAa0qxKWbyM+gZtlgexAtTpkdBGjEw8BCxOvVoNtaXgiIxRL80D
	09pFffuABsuV2eoQhKKD+hPFUtT0TAOixXVyXurHNWQEB8mrc40ueIUnpW2CKNup0E9esMCHEiH
	EJQVOhvIYGIfBY/9nF/nBvayqYJIdicq31/0lOyvuFnnEyg2HKuI9T9iZ/5zHwas+FyxII4W1tN
	cqq0vk18oBLpY0708=
X-Received: by 2002:a05:6000:1844:b0:434:32cc:6c86 with SMTP id ffacd0b85a97d-4379db61567mr23289999f8f.14.1771411888157;
        Wed, 18 Feb 2026 02:51:28 -0800 (PST)
Received: from localhost ([195.52.25.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abc85csm40700127f8f.22.2026.02.18.02.51.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 02:51:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=ab1547405f0fc9e8a57e2e08b4d29286d8d006d625bb9f2c77f8ee810dfc;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Wed, 18 Feb 2026 11:51:15 +0100
Message-Id: <DGI13PI02XEN.3MNAWATF73XVL@baylibre.com>
To: "Kendall Willis" <k-willis@ti.com>, "Markus Schneider-Pargmann"
 <msp@baylibre.com>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
Cc: <sebin.francis@ti.com>, <d-gole@ti.com>, <vishalm@ti.com>,
 <linux-can@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] can: m_can: set out-of-band wakeup if wakeup pinctrl
 exists
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
X-Mailer: aerc 0.21.0-119-g0a449d4a7ff3
References: <20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com>
In-Reply-To: <20260213-mcan-out-of-band-v1-1-af68d4c570b3@ti.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-3.26 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[baylibre-com.20230601.gappssmtp.com:s=20230601];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-6582-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[baylibre.com];
	DKIM_TRACE(0.00)[baylibre-com.20230601.gappssmtp.com:+];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[msp@baylibre.com,linux-can@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ti.com:email,baylibre.com:mid]
X-Rspamd-Queue-Id: C8BA1155A99
X-Rspamd-Action: no action

--ab1547405f0fc9e8a57e2e08b4d29286d8d006d625bb9f2c77f8ee810dfc
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

Hi Kendall,

On Fri Feb 13, 2026 at 7:08 PM CET, Kendall Willis wrote:
> In TI AM62X, AM62A, and AM62P SoCs, the m_can pins can act as a wakeup
> source in the deepest low power states. However, the m_can pins are a par=
t
> of the MCU domain which is OFF in deeper low power states. Since the m_ca=
n
> pins continue to be ON even if the MCU domain is turned off, set
> out-of-band wakeup for CAN device if `wakeup` pinctrl state exists and
> device may wakeup.

Thank you for your patch.

>
> Signed-off-by: Kendall Willis <k-willis@ti.com>
> ---
> Tested on CAN IO wakeup from DeepSleep low power mode on AM62P EVM.
> ---
>  drivers/net/can/m_can/m_can.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.=
c
> index eb856547ae7df27a844b236a0c1d4498cbb8b60f..8b277f5e208ffa634439b9ea8=
495ed56f12cfccb 100644
> --- a/drivers/net/can/m_can/m_can.c
> +++ b/drivers/net/can/m_can/m_can.c
> @@ -2622,7 +2622,9 @@ int m_can_class_suspend(struct device *dev)
>  		cdev->can.state =3D CAN_STATE_SLEEPING;
>  	}
> =20
> -	if (!m_can_class_wakeup_pinctrl_enabled(cdev))
> +	if (m_can_class_wakeup_pinctrl_enabled(cdev))
> +		device_set_out_band_wakeup(dev);

This will set out of band wakeup for every m_can that has a
wakeup-pinctrl set. am62* is currently probably the only platform that
uses the wakeup pinctrl setting but that may change at some point in the
future. Can we narrow down setting the out of band wakeup to the
platforms that support it?

One idea could be to parse the supported system-idle-states from the
list of wakeup-sources and see if deep states are supported that would
require m_can to be off, e.g. mem-deep, off-wake. I think that would be
a clear indicator that out of band wakeups are supported.

For the list of state names you can have a look in the dtschema
repository:
  https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/sy=
stem-idle-states.yaml

What do you think?

Best
Markus

--ab1547405f0fc9e8a57e2e08b4d29286d8d006d625bb9f2c77f8ee810dfc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCaZWZpBsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMSwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlMH
MAD/X+MceNaurc00f99Z7t+gTwagT/YGrv3upF62Ma0LPggA/iN4IA/KZyvjyPn6
DthQJy5ZgCI3v1YX2jM40faUjCAD
=y7Ft
-----END PGP SIGNATURE-----

--ab1547405f0fc9e8a57e2e08b4d29286d8d006d625bb9f2c77f8ee810dfc--

