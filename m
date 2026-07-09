Return-Path: <linux-can+bounces-8259-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K0UOHS8GUGpIsAIAu9opvQ
	(envelope-from <linux-can+bounces-8259-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:35:59 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2C7735719
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 22:35:58 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=dd0SwSf7;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8259-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8259-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 33CB4300BCA7
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 20:35:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF8033806DC;
	Thu,  9 Jul 2026 20:35:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6CF3BB101
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 20:35:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783629354; cv=none; b=Naihk3mqsqDRupbKBofCoAjJWgrCYHBEPI375gsV3jTX2vYxTr6gttNgbgF8OhuZn7xptfxlKN5iJu7YTtBEDa8fGh97dx7fNfs2VBpdwrhI/3+6zgnn1hwkl9cGk/EED59DFr+458QtKR20Nt+IU71eDDwOUus9y5uLjurE/ko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783629354; c=relaxed/simple;
	bh=X4IV0ZzpMUfxEfmuzWB7oImxhh0GESZZ+aYtwRNKWms=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jS/LNzQvwY3+zJWMsmDTCeX37GkxJ4d/M7I4H9+NOu2F9ymlx1dFTn3Tmpd+vf7S34IzJZ7J6RwwVSsFVt8wTbYjfRsfZIs5bDi3KzqF1as33PfIIs2JaSAdtknpNFGK2xzY9oGNzp+WEYbwhFCXxxaHOiYw6Wqn83YoxrG80gs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dd0SwSf7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D473D1F00A3D;
	Thu,  9 Jul 2026 20:35:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783629353;
	bh=GYXyNdYcv2AfWaqtLxntJa1uEVa+aeLkXgmEbC6oFKU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dd0SwSf7roKtYmUeZ933F/yXeHNrA3ZURMiAuEed4Vvikw47x0jje7K/kDRzL8qVC
	 taDEkmbKXDLgurnMT4KsNWyxt3lRHbyGhavcxvdG2SH6yizIE7eXlDuIDooyD3g6sR
	 z+etWXSauHjAb1yZNw1sudF0F0yp/d7hvESzftCM75kulm4M8iOd6JnLU3vSM/5+U/
	 ryXgSe89Ha0tloodPeYqbyWsgpZOPhyEFuSSxIikTNgfRz3nHRfwkgxBMl+MRkeOR9
	 0bIimSd8bePMimGaCIxE/6dVq/aBsVFs0Fg3eqzyhyG2pa0ht9eX9kfpCAcDaNLH9/
	 OVSAwn0PawJBA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 05/11] can: bcm: add missing rcu list annotations
 and operations
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, linux-can@vger.kernel.org
In-Reply-To: <20260709-bcm_fixes-v12-5-61c06291bf1c@hartkopp.net>
References: <20260709-bcm_fixes-v12-0-61c06291bf1c@hartkopp.net>
 <20260709-bcm_fixes-v12-5-61c06291bf1c@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 20:35:52 +0000
Message-Id: <20260709203552.D473D1F00A3D@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8259-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp,sashiko.dev:url,hartkopp.net:email,lists.linux.dev:replyto,smtp.kernel.org:mid];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 6D2C7735719

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] List corruption when updating an existing RX operation after a dev=
ice unregistration.
--

--- Patch [5]: [PATCH v12 05/11] can: bcm: add missing rcu list annotations=
 and operations ---
commit d541f7be2b7c689e5da6382dd975710ba6b59607
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: add missing rcu list annotations and operations

This commit adds missing list_add_rcu() calls in the BCM setup paths to ens=
ure
proper initialization before traversing bcm_op structures under RCU. It also
fixes the removal side by explicitly unlinking ops with list_del_rcu() befo=
re
freeing them.

Closes: https://lore.kernel.org/linux-can/20260610094654.A1FFE1F00893@smtp.=
kernel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 38c3f690c1cd0..940cd9df1cca3 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c

[ ... ]

> @@ -1357,9 +1361,6 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_he=
ad, struct msghdr *msg,
>  		hrtimer_setup(&op->thrtimer, bcm_rx_thr_handler, CLOCK_MONOTONIC,
>  			      HRTIMER_MODE_REL_SOFT);
> =20
> -		/* add this bcm_op to the list of the rx_ops */
> -		list_add(&op->list, &bo->rx_ops);
> -
>  		/* call can_rx_register() */
>  		do_rx_register =3D 1;
> =20

[ ... ]

> @@ -1431,10 +1432,12 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  					      bcm_rx_handler, op, "bcm", sk);
>  		if (err) {
>  			/* this bcm rx op is broken -> remove it */
> -			list_del_rcu(&op->list);
>  			bcm_remove_op(op);
>  			return err;
>  		}
> +
> +		/* add this bcm_op to the list of the rx_ops */
> +		list_add_rcu(&op->list, &bo->rx_ops);

[Severity: High]
Can this unconditionally add an already-linked operation to the list?

If a CAN interface is unregistered, the NETDEV_UNREGISTER notifier clears
op->rx_reg_dev but leaves the operation linked in bo->rx_ops.

If bcm_rx_setup() is called again for the same CAN ID on this existing op,
it sees op->rx_reg_dev is NULL and sets do_rx_register to 1:

		do_rx_register =3D (ifindex && !op->rx_reg_dev) ? 1 : 0;

After successfully re-registering with the CAN core, this list_add_rcu()
executes. Since the op was never removed from bo->rx_ops, won't this
overwrite the list pointers and corrupt the RCU list?

Should this be guarded by the new_op flag, similar to how bcm_tx_setup()
guards its list_add_rcu() with add_op_to_list?

>  	}
> =20
>  	return msg_head->nframes * op->cfsiz + MHSIZ;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v12-0-61c06291bf1c@hartkopp.net?part=3D5

