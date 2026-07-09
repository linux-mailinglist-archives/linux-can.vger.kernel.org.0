Return-Path: <linux-can+bounces-8225-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XaZgLAbkT2pHpwIAu9opvQ
	(envelope-from <linux-can+bounces-8225-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:10:14 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 78641734243
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 20:10:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cm1jR0qq;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8225-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8225-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5B5313006993
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 18:10:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E7D74DB569;
	Thu,  9 Jul 2026 18:10:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C664657F1
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 18:09:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620599; cv=none; b=UiifNi+xPVhENOtB8Kbbk8Fs/1YfWbACsMfkRHHhzodYzyDqm392/7M1p6UiIg+sdeeK4jOB2beK2axPqSalXjfiF+Ij5Pj+qA4X+lm19dOc8nx2pzMKeYO1jbGKsvGEPbGwYjx1nmeMmIrpvSK8ZzhkpqC6uy9pXuXn94TmnAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620599; c=relaxed/simple;
	bh=wwQAHVQ29BmdX6PM4BW7Wp6P0JwnAzMmn5HV5UyQRGQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cMsTekkdDOwDZNHeXuw3BOhV097Q2gQs1dSQ52JFZECtbyqSd5svwunjDjMiLNYlhoOlv0hxDodAuFdrE7Q41apikeNbHXXFCUAlBx4Cdpcx6js6iYTnrsX8pEpXwP1xVtBIioGu+bYyRNNVjf5uV+njyuCUlQew+OW5lJ2WAwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cm1jR0qq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63B2B1F000E9;
	Thu,  9 Jul 2026 18:09:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783620598;
	bh=237cRHXgOdEmCMJHNIBTsdmNPiuvTVDpN7ke09asIng=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cm1jR0qqO/+2KTbWIRdpuhRDz+dTmuCZNybDnKHJO07n1phFHKtAiJ78SK4U+UgD/
	 535tdRGNqH2fLvmFOlRQ3we4oxREhfjX5AMOi2gbK13KTof11oS+bCgvOWw0OE/W1I
	 u6TF6XKuSsVCFWSlABgVlEX5WCMdnI8v5DxnkurwpLO7yxFRYB2z5/zyqtikBlBZ0r
	 wigFJEKKW011/ojRFggVOx/X9d3fqE9xe6wWldBcfZPCU5hftyKrBedo6hxbbMJ3Ev
	 sLsS8Q4Z2aIHtu/5eAOnTINwbDGb9p0xS0p45v+dt+B8K24Y3ggTfu7rmLnp/2RWEr
	 IFdJQLZMPeuqw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 02/11] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v11-2-067ba11bec5c@hartkopp.net>
References: <20260709-bcm_fixes-v11-0-067ba11bec5c@hartkopp.net>
 <20260709-bcm_fixes-v11-2-067ba11bec5c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 18:09:57 +0000
Message-Id: <20260709180958.63B2B1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8225-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,lists.linux.dev:replyto,sashiko.dev:url,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 78641734243

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless data race in BCM operation updates corrupts active TX/RX =
CAN frames.
--

--- Patch [2]: [PATCH v11 02/11] can: bcm: fix lockless bound/ifindex race =
and silent RX_SETUP failure ---
commit 86f16dbfed96fce9e0564ffdb9d5e63f4ec62cce
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes a race condition in bcm_sendmsg() by moving the bo->ifind=
ex
read and bo->bound check under the socket lock. It also ensures bcm_rx_setu=
p()
returns -ENODEV when the target device concurrently disappears.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
> @@ -1323,6 +1323,11 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_h=
ead, struct msghdr *msg,
> =20
>  				op->rx_reg_dev =3D dev;
>  				dev_put(dev);
> +			} else {
> +				/* the requested device is gone - do not
> +				 * silently succeed without registering
> +				 */
> +				err =3D -ENODEV;
>  			}
> =20
>  		} else

[Severity: High]
This is a pre-existing issue, but does bcm_rx_setup() modify the active
op->frames array locklessly on the RX side?

Looking at the earlier part of bcm_rx_setup():

    /* update CAN frames content */
    err =3D memcpy_from_msg(op->frames, msg,
                          msg_head->nframes * op->cfsiz);

Could this data race with the softirq reader bcm_rx_handler() while it is
actively processing frames?

[ ... ]

> @@ -1436,20 +1463,21 @@ static int bcm_sendmsg(struct socket *sock, struc=
t msghdr *msg, size_t size)
>  			struct net_device *dev;
> =20
>  			dev =3D dev_get_by_index(sock_net(sk), ifindex);
> -			if (!dev)
> -				return -ENODEV;
> +			if (!dev) {
> +				ret =3D -ENODEV;
> +				goto out_release;
> +			}
> =20
>  			if (dev->type !=3D ARPHRD_CAN) {
>  				dev_put(dev);
> -				return -ENODEV;
> +				ret =3D -ENODEV;
> +				goto out_release;
>  			}
> =20
>  			dev_put(dev);
>  		}
>  	}
> =20
> -	lock_sock(sk);
> -
>  	switch (msg_head.opcode) {
> =20
>  	case TX_SETUP:

[Severity: High]
This is also a pre-existing issue, but does bcm_tx_setup() write to the
active op->frames array locklessly before validating the frame length?

When TX_SETUP is called, bcm_tx_setup() copies user data:

    cf =3D op->frames + op->cfsiz * i;
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

    if (op->flags & CAN_FD_FRAME) {
        if (cf->len > 64)
            err =3D -EINVAL;

If an invalid length is provided from userspace, it is written to op->frames
first. The function catches the error and returns -EINVAL, but the
corrupted frame remains in the array.

Concurrently, can the high-resolution timer callback bcm_can_tx() transmit
this corrupted frame?

bcm_can_tx() reads the frame contents outside of bcm_tx_lock:

    spin_lock_bh(&op->bcm_tx_lock);
    cf =3D op->frames + op->cfsiz * op->currframe;
    spin_unlock_bh(&op->bcm_tx_lock);

    skb_put_data(skb, cf, op->cfsiz);

Could this pass an unvalidated cf->len down to the hardware driver and
potentially overflow device buffers? An attacker creating a cyclic
transmission via TX_SETUP, then issuing a concurrent TX_SETUP update with
an invalid length, might be able to trigger this condition.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v11-0-067ba11bec5c@hartkopp.net?part=3D2

