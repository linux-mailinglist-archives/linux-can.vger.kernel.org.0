Return-Path: <linux-can+bounces-8146-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 45mEGkRwTmr+MgIAu9opvQ
	(envelope-from <linux-can+bounces-8146-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 17:44:04 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06040728315
	for <lists+linux-can@lfdr.de>; Wed, 08 Jul 2026 17:44:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=BQdF4npY;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8146-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8146-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id AA7B7308DE23
	for <lists+linux-can@lfdr.de>; Wed,  8 Jul 2026 15:41:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0640E409294;
	Wed,  8 Jul 2026 15:40:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE0CA30D3ED
	for <linux-can@vger.kernel.org>; Wed,  8 Jul 2026 15:40:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783525240; cv=none; b=FPiHSBazmEDpCpalYkl4LpEThKCIKMDYWNjCqX9b5GRDapQJ/dlBKQ8A2vtOdisrlPFAV9S5Oh2Dq2eqLmRKX6OhdO/E0CMPd2auNH2z3msh+XRCFb+fDgyDh0uZ2zhw5oFA/wIJR8ADUvIMOK/n46+le26+YCnG9yMP1gXDhwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783525240; c=relaxed/simple;
	bh=EFMnxnmjCcZZ0rRtchnjGxpZCS6hrutLiR9mhWKDKg0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UwW9etqy1mU6UXqzqX1qekjzcNqq78t15JYAHF3AmVXaz9o3recc+YS/JdJge7sRFOLCw1kKqcIzaJU/KS0PF5MSn6ZFzztRBf62Wu6WQjukx0yDdfkl3KB+EM+PV6v7w5nFAPo6Lcfj/xsUakFjSTEx+jmLl7BVtb+sqik2Ae8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BQdF4npY; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 347ED1F000E9;
	Wed,  8 Jul 2026 15:40:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783525239;
	bh=0Bt3v0I59yNiYg3lFf+fSqk5hvoM7aQPwF/7vRX5h9A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=BQdF4npYIyUr25tjzcQiZl6hGNdBAL1+HD3QT/mi6KhOOOO/1/d4CDyH1XdvlS2tD
	 NdMirZNfobfd34h1pDKGHLyIm4iUimVCAlbunhsJSCkCkUico9rhbSoqjDiTOEB/kN
	 Rd4eZBIaH6Q0k13BcjpJYl05zxiLT3lzPgVFOusS8aPvQGEZMx6a7J0qEJIfOMJp8W
	 nzcYUMw0JYp0ALAMwqQwOJRzHvcpY0WCsBsevQv/ndbcgcuSwnIiit+istMevm+EN/
	 uB1NEF3U95nBSljaH1jq4WsGCHwZaywyGD0tjIjuzl1u8YSM4TQ1tRuHE8xoSub3+7
	 PpEBDs+DBt7SQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] can: bcm: fix stale rx/tx ops after device
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260708-bcm_fixes-v7-9-c78896b342e4@hartkopp.net>
References: <20260708-bcm_fixes-v7-0-c78896b342e4@hartkopp.net>
 <20260708-bcm_fixes-v7-9-c78896b342e4@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 08 Jul 2026 15:40:38 +0000
Message-Id: <20260708154039.347ED1F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8146-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,lists.linux.dev:replyto,sashiko.dev:url,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 06040728315

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Setting `op->ifindex =3D 0` for `tx_ops` on NETDEV_UNREGISTER orph=
ans the operations, preventing reconfiguration and causing memory leaks.
- [Medium] `bcm_rx_setup()` silently ignores registration failures for exis=
ting operations, falsely reporting success to userspace.
--

--- Patch [9]: [PATCH v7 09/10] can: bcm: fix stale rx/tx ops after device =
removal ---
commit 685050073b3ab1afd17b250b634cb2dfd5941250
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix stale rx/tx ops after device removal

This commit modifies bcm_rx_setup() to correctly re-register an RX operatio=
n=20
when a concurrent NETDEV_UNREGISTER has torn down its previous registration=
.=20
It also updates bcm_notify() to stop the TX timer and clear op->ifindex=20
for affected tx_ops when a device is unregistered, preventing cyclic frames=
=20
from being transmitted to unrelated devices.

Link: https://lore.kernel.org/linux-can/20260708094536.DDF821F00A3A@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 4bdca72f9327f..9d01931708081 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1473,18 +1485,21 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  				err =3D -ENODEV;
>  			}
> =20
> -		} else
> +		} else {
>  			err =3D can_rx_register(sock_net(sk), NULL, op->can_id,
>  					      REGMASK(op->can_id),
>  					      bcm_rx_handler, op, "bcm", sk);
> -		if (err) {
> +		}
> +
> +		if (err && new_op) {

[Severity: Medium]
Does adding the new_op check here silently swallow registration errors for =
existing
operations?

If an existing operation (new_op =3D=3D 0) attempts to re-register after be=
ing unregistered,
and dev_get_by_index() or can_rx_register() fails, err will be set (e.g., -=
ENODEV).
Because of the && new_op condition, the error is ignored and the function w=
ill return=20
success to userspace, despite the comment above indicating "do not silently=
 succeed=20
without registering".

>  			/* this bcm rx op is broken -> remove it */
>  			bcm_remove_op(op);
>  			return err;
>  		}

[ ... ]

> @@ -1704,11 +1719,25 @@ static void bcm_notify(struct bcm_sock *bo, unsig=
ned long msg,
>  	case NETDEV_UNREGISTER:
>  		lock_sock(sk);
> =20
> -		/* remove device specific receive entries */
> +		/* rx_ops: remove device specific receive entries */
>  		list_for_each_entry(op, &bo->rx_ops, list)
>  			if (op->rx_reg_dev =3D=3D dev)
>  				bcm_rx_unreg(dev, op);
> =20
> +		/* tx_ops: stop device specific cyclic transmissions on the
> +		 * vanishing ifindex and invalidate the op->ifindex.
> +		 */
> +		list_for_each_entry(op, &bo->tx_ops, list) {
> +			if (op->ifindex !=3D dev->ifindex)
> +				continue;
> +
> +			spin_lock_bh(&op->bcm_tx_lock);
> +			op->ifindex =3D 0;

[Severity: High]
Does setting op->ifindex =3D 0 permanently orphan the operation and cause a=
 memory leak?

The commit message states the index is cleared "so that a later TX_SETUP up=
date can=20
reconfigure it". However, bcm_tx_setup() rejects an ifindex of 0 with -ENOD=
EV:

bcm_tx_setup() {
    ...
	if (!ifindex)
		return -ENODEV;
    ...
}

Furthermore, bcm_find_op() strictly requires an exact match on ifindex.=20
Since userspace can't pass 0, and passing the old valid index will no longe=
r match=20
the zeroed op->ifindex, any subsequent TX_SETUP will fail to find it and wi=
ll allocate a=20
duplicate bcm_op. A TX_DELETE will similarly fail to find and remove the op=
eration,=20
leaving it as a zombie.

> +			spin_unlock_bh(&op->bcm_tx_lock);
> +
> +			hrtimer_cancel(&op->timer);
> +		}
> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260708-bcm_fixes-=
v7-0-c78896b342e4@hartkopp.net?part=3D9

