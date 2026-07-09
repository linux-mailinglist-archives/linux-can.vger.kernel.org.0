Return-Path: <linux-can+bounces-8200-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id hHqDJKaDT2okigIAu9opvQ
	(envelope-from <linux-can+bounces-8200-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 13:19:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0527302D5
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 13:19:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ebdtkwDJ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8200-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8200-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F7E930071E8
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 10:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 852B73F928B;
	Thu,  9 Jul 2026 10:51:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBD63FE645
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 10:51:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594287; cv=none; b=XyLfrxXqcdK1+KbfKu3/2ql8YMJ9618bSMUTdQNJvDDHsYVM2GacrsrfQsjUMVy3Dt/I6GWiGz6xQfOknW4YE/8xLePEFuSSQ+LaNzy6KVjZDVg2EeaGNq53ZhZSnrLFcVErBxrdFFkWmv2j/uwI495GqqB0sNK7t9tOupolNFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594287; c=relaxed/simple;
	bh=ZO+jTfEvQPJmqHtABdihHhc6Q6quGpIwVPnurBKNCds=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=R7+dArIb7+EF57QNjNu47I8Zc/Te7wjHiLBaarf7Ut4C0mEXN4UmBDlzmweDZjQCMA+XEE+2AGR7yHk8UXByo6ly9EBiu/0b/nTbuEmGqt76vMtRgvaNSjfP8c4PeLaT20DpMz94mvmVFjbhSgjHLFaAMM/yJYEnm44iYhLXj0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ebdtkwDJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C9DB1F000E9;
	Thu,  9 Jul 2026 10:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783594279;
	bh=IBtmDV30W6MkCsJkjxnsKC8/iLmd1xOzsXxcjUwJixY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ebdtkwDJIDJ9R7xpzUXxSKnEcewSJSvBR35XqYAUWRGKuixSSgd2GLvUWYmC+6elU
	 zsgT9HZZehUusg+cv9KBAwMi1y6AY4sXoJkFNRn3aoIAdXnQ3uyl/ewrV0xUrh2pqG
	 oGPtGuevu5UZtO28/9L4niL86udxcyZjmPJIZ1WxTEKl5xHnWppB31vWevB73m2IkI
	 gZRUscunq5FSQctYv+IBeela/DJjn0fI46IlSMprMOwvtyqeFUmeCML3tbVhWhOycP
	 jSzCIqNz5ZW47DCeOe1zoxPLEHFdok1MtAAUKxyHHHn/iHpwGGXx1TJIaC1QEn70qM
	 6YhOX7+EQVaFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 08/10] can: bcm: add missing device refcount for CAN
 filter removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260709-bcm_fixes-v10-8-57fff38e34ce@hartkopp.net>
References: <20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net>
 <20260709-bcm_fixes-v10-8-57fff38e34ce@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:51:18 +0000
Message-Id: <20260709105119.0C9DB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MISSING_MIME_VERSION(2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8200-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,hartkopp.net:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: ED0527302D5

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] bcm_rx_setup() silently fails to re-register an existing CAN rec=
eive filter after a NETDEV_UNREGISTER event, causing silent packet drops.
--

--- Patch [8]: [PATCH v10 08/10] can: bcm: add missing device refcount for =
CAN filter removal ---
commit 1e97ac5794b00273de0d8b7a26438344b6bbef67
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing device refcount for CAN filter removal

This commit fixes a concurrent device unregistration issue by introducing a
netdevice_tracker. This ensures the bcm code safely holds a reference to the
CAN interface, preventing stale CAN filters from pointing at freed structur=
es
if the device is unlisted before the filter is removed.

Link: https://sashiko.dev/#/patchset/20260707094716.63578-1-socketcan@hartk=
opp.net

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 3cc3deb98a984..5660165cdf0eb 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1465,7 +1464,17 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
>  						      bcm_rx_handler, op,
>  						      "bcm", sk);
> =20
> -				op->rx_reg_dev =3D dev;
> +				/* keep a tracked reference so that a later
> +				 * unregister can safely reach the device even
> +				 * if a concurrent NETDEV_UNREGISTER has
> +				 * already unlisted it by ifindex
> +				 */
> +				if (!err) {
> +					op->rx_reg_dev =3D dev;
> +					netdev_hold(dev,
> +						    &op->rx_reg_dev_tracker,
> +						    GFP_KERNEL);
> +				}
>  				dev_put(dev);
>  			} else {
>  				/* the requested device is gone - do not

[Severity: Medium]
This isn't a bug introduced by this patch, but does bcm_rx_setup() silently
fail to re-register an existing CAN receive filter after a NETDEV_UNREGISTER
event?

If a device is unregistered, bcm_notifier() unregisters the filter and sets
op->rx_reg_dev =3D NULL, while keeping the op in the socket's list.

If the device is recreated with the same ifindex and the user sends another
RX_SETUP to reconfigure it, bcm_find_op() finds the existing op and
bcm_rx_setup() unconditionally forces do_rx_register to 0 for updates:

    /* Only an update -> do not call can_rx_register() */
    do_rx_register =3D 0;

Because of this, the RX_SETUP update succeeds from the user's perspective, =
but
can_rx_register() is skipped and the filter is left permanently detached,
causing silent packet drops.

Could we check if op->rx_reg_dev is NULL here to ensure we re-register the
filter when needed?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v10-0-57fff38e34ce@hartkopp.net?part=3D8

