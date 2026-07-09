Return-Path: <linux-can+bounces-8197-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id McUCMeCBT2p5iQIAu9opvQ
	(envelope-from <linux-can+bounces-8197-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 13:11:28 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 20108730125
	for <lists+linux-can@lfdr.de>; Thu, 09 Jul 2026 13:11:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ImbWn0Ig;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8197-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8197-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C52D8308E63C
	for <lists+linux-can@lfdr.de>; Thu,  9 Jul 2026 10:44:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA799408636;
	Thu,  9 Jul 2026 10:44:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FC4405844
	for <linux-can@vger.kernel.org>; Thu,  9 Jul 2026 10:44:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783593883; cv=none; b=Il2dKXf19zJcUewt8f2xfB46PclsrSlJ2xpC8HJm6bQ+pHxxWkxzkKGJ37ZRnRzs9+0/N6wGXAzFSwcEp3OcQ0LIAeI0XK3McUsgHsXhcQQOIzSEGildUcfKcMwIv4ZhH3ajCLbjqRBrrt7eC7TmIDhTnnTroegWyNDJjvb8WWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783593883; c=relaxed/simple;
	bh=SNxWwYO03b15JQU+3WTH4BnBEQI0zXBOga2MsSYZtCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=OoGmsHcH2CoYXs7ouit+8sXXr9ru9Da2+9g/X7yRRLm7YP6RH6jnjrXevV4wILX8jVO9lFZt4tYBC1UT4UwWsFDAjZg6BJwBgmhbWc1gJzixCTP3lxbXZ8qFBv007eUsYJjV/RGuM5V7mCGp/6p2YAQJjmyRxmF0h5luwBJY58I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ImbWn0Ig; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8221F000E9;
	Thu,  9 Jul 2026 10:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783593880;
	bh=t8RNgCF/phPlkQKREtbgxQKJmrxwnXY+JEscLIpjNx4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ImbWn0IggmJMJtLQvqM5OqiU6YPVis+GQQkCHNmoHHkAOJH6NJXpcDuFXf2wirXpQ
	 GwZ3PwqOE8MY2EQrGHBkyRppHRZPhXvzawMHalKHnpPzZXv6fy+WVazB7i5t+8IGAT
	 Rfum177O27X8PjGtNhhIYjJAtDaBC1njrV3x22w7FKtr7Fyresq0sB+FnPDoG09afv
	 Y4e3DJMYdqH2YAxLv3pSuhbeKOJ4bpYPdh0hX1NHom0vBpNoag8fwjbm6Ml7wV8PYg
	 4qsw6Eeg5gHt7gQ4z4436eAgVL05N/PK0toGh5+ekP1zWBkRsJ09JRiSfKPUKiPyqB
	 TWj5QRa96otTg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/10] can: bcm: fix lockless bound/ifindex race and
 silent RX_SETUP failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Vincent Mailhol" <mailhol@kernel.org>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260709-bcm_fixes-v10-2-57fff38e34ce@hartkopp.net>
References: <20260709-bcm_fixes-v10-0-57fff38e34ce@hartkopp.net>
 <20260709-bcm_fixes-v10-2-57fff38e34ce@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 10:44:39 +0000
Message-Id: <20260709104440.6E8221F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8197-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url,lists.linux.dev:replyto,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mkl@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: 20108730125

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing RCU protection and memory barriers for `tx_ops` and `rx_op=
s` list modifications and traversals.
- [High] Lockless modification of CAN frames and filters from process conte=
xt while they are concurrently read by softirq handlers.
--

--- Patch [2]: [PATCH v10 02/10] can: bcm: fix lockless bound/ifindex race =
and silent RX_SETUP failure ---
commit 14fe77d5df361ef7f02ad605d5649032b1cb3565
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix lockless bound/ifindex race and silent RX_SETUP failure

This commit fixes an unordered read/write race in bcm_sendmsg() between
bo->bound and bo->ifindex by moving the re-check into the locked section.
It also ensures bcm_rx_setup() returns an error if the target device
disappears concurrently instead of silently succeeding.

Link: https://lore.kernel.org/linux-can/CAGp+u1aBK8QVjsvAxM2Ldzep4rEbsP9x_p=
V3At4g=3Dh1kVEtyhA@mail.gmail.com/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index bdf53241bd7b3..b612135b017d1 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
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
This is a pre-existing issue, but does this lack of RCU protection and memo=
ry
barriers allow a lockless reader to observe uninitialized fields?

Looking at bcm_proc_show(), it traverses bo->tx_ops locklessly under
rcu_read_lock():

    list_for_each_entry(op, &bo->tx_ops, list) {

Concurrently, bcm_tx_setup() can add a new operation to this list:

    list_add(&op->list, &bo->tx_ops);

Because list_add() lacks the smp_store_release() memory barrier provided
by list_add_rcu(), and the traversal uses the non-RCU
list_for_each_entry() macro, can concurrent readers see torn pointers or
uninitialized bcm_op fields, potentially causing a kernel crash when
reading uninitialized memory?

[Severity: High]
This is a pre-existing issue, but does this lockless modification of CAN
frames allow softirq readers to see partially updated data?

In bcm_tx_setup() and bcm_rx_setup(), op->frames are modified directly
from process context:

bcm_tx_setup():
    err =3D memcpy_from_msg((u8 *)cf, msg, op->cfsiz);

bcm_rx_setup():
    err =3D memcpy_from_msg(op->frames, msg, msg_head->nframes * op->cfsiz);

Concurrently, softirq handlers read these frames locklessly. For example,
bcm_can_tx() reads frames from timer context to transmit:

    skb_put_data(skb, cf, op->cfsiz);

And bcm_rx_cmp_to_index() reads filter mask frames from RX softirq context:

    if ((get_u64(cf, i) & get_u64(rxdata, i)) !=3D ...

Can this data race result in transmitting torn or functionally corrupted
CAN frames to the network bus, or incorrect evaluation of incoming packets
against partially updated filter masks?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-bcm_fixes-=
v10-0-57fff38e34ce@hartkopp.net?part=3D2

