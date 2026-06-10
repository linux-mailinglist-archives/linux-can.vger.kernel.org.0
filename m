Return-Path: <linux-can+bounces-7823-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QlkNMwqhKWrDawMAu9opvQ
	(envelope-from <linux-can+bounces-7823-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:38:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6466C00C
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 19:38:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NggpBVke;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7823-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7823-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9F6E03003838
	for <lists+linux-can@lfdr.de>; Wed, 10 Jun 2026 17:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3A923491D0;
	Wed, 10 Jun 2026 17:38:13 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2092E2286
	for <linux-can@vger.kernel.org>; Wed, 10 Jun 2026 17:38:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781113093; cv=none; b=eLDDO0xMC2amIQr20hG+HZIx/lhOa3JR28plaZPip9owzCg8Hq9At0hco8Mc1yweRyl52TQ89O2WHwBS/KGInqKzMtUB1tSsUUafeJckmJWIpH43j5guBgiW03P1Uf/1abSY5eIoJe15fXleB+76Zpv6rS2aR0KK1f6PuPwjvPQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781113093; c=relaxed/simple;
	bh=FMRLCq20oZozdHnKtGsDwHC5V84I+M4/M24tX6nI3PU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=piKZ9UEDUWB6/RaM1WrasOXyBCcM9Qz5VUOFPb1oDdEImZp0WS1ObdDPKX72lmPREMffuxeOzS0BfvOmuujn0U6Wp35rDfiO3ehl+wVKVX9Jo0UTQe5L1K0pcxYq2ojjuSO4ygWgybg4sH0p3fsKVUQKR+Jo4OTQ5G7P2+MXUtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NggpBVke; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3BA1F00898;
	Wed, 10 Jun 2026 17:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781113092;
	bh=sZXeLrSPkh3FzI9LMv6q7kyxJymbwQ55sYcDzKRlcrU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NggpBVkepkGb9nZGO2atHcshbgWzBKqa4ghLa+cnL9bxaYWUoMUOW8IH0mAeW3kRq
	 II4v90gA1HkQv5KzZubdBWFC+cPR6UKVN1uUphqK1ziy+PQ+GU15tj7NDIY0cy6CqS
	 Qr4hQq45UNZX4avW55d8lcbkSQ4z/TY2P4uWuANhSsF7fp7hQKMuY6fKgTl6AQ3bAR
	 DT8blIPeDVtZdDNzbS1XYqn8aGuvESi4dPJl0gT9nFRxvOD6yVEgcfaplz4Lhq+wya
	 BWqICT8mLbwc3LZpGFcIPK22qImKcF4LpW0CuNTPODSnxboo1cQlJ7kecMfYJ974aU
	 G8soGp3lfkoKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH can-next 3/3] can: add can diag interface
Reply-To: sashiko-reviews@lists.linux.dev
To: "Filippo Storniolo" <fstornio@redhat.com>
Cc: linux-can@vger.kernel.org, "Vincent Mailhol" <mailhol@kernel.org>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>
In-Reply-To: <20260610-feat-can-diag-v1-3-021e3f1631a0@redhat.com>
References: <20260610-feat-can-diag-v1-3-021e3f1631a0@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 17:38:11 +0000
Message-Id: <20260610173811.CF3BA1F00898@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-7823-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,j1939_addr.name:url,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:fstornio@redhat.com,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: C4A6466C00C

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] The `can_diag` module fails to enforce a dependency on the core `c=
an` module, leading to a crash when locking an uninitialized mutex.
- [Medium] Binary structures are embedded directly inside Netlink attribute=
s, violating Netlink design rules.
--

commit 058ea09f4025994f935c1bd793eb19a873974e20
Author: Filippo Storniolo <fstornio@redhat.com>

can: add can diag interface

Add the can_diag interface for querying sockets from userspace.
ss(8) tool can use this interface to list open sockets. The userspace ABI
is defined in <linux/can_diag.h> and includes netlink request and response
structs.

> diff --git a/include/uapi/linux/can/diag.h b/include/uapi/linux/can/diag.h
> new file mode 100644
> index 0000000000000..7f99f85c42425
> --- /dev/null
> +++ b/include/uapi/linux/can/diag.h
[ ... ]
> +struct can_diag_j1939_addr {
> +	__u64	name;
> +	__u32	pgn;
> +	__u8	addr;
> +};

[Severity: Medium]
Does this violate the Netlink subsystem design guidelines?

The Netlink documentation states to avoid binary structures inside attribut=
es
and suggests breaking each member into its own attribute.

Also, does this structure have implicit trailing padding? Without explicit
padding after the 1-byte field, we might run into architecture-dependent si=
ze
differences, breaking 32-bit vs 64-bit compatibility.

[ ... ]
> diff --git a/net/can/diag.c b/net/can/diag.c
> new file mode 100644
> index 0000000000000..eb623ed118af5
> --- /dev/null
> +++ b/net/can/diag.c
[ ... ]
> +	case CAN_J1939:
> +	{
> +		struct can_diag_j1939_addr j1939_addr;
> +
> +		memset(&j1939_addr, 0, sizeof(j1939_addr));
> +
> +		j1939_addr.name =3D can_addr.can_addr.j1939.name;
> +		j1939_addr.pgn =3D can_addr.can_addr.j1939.pgn;
> +		j1939_addr.addr =3D can_addr.can_addr.j1939.addr;
> +
> +		err =3D nla_put(skb, CAN_DIAG_J1939_ADDR, sizeof(struct can_diag_j1939=
_addr),
> +			      &j1939_addr);

[Severity: Medium]
Does this directly write the binary struct into the Netlink message attribu=
te?
The Netlink guidelines discourage putting binary structs into attributes for
new families.

[ ... ]
> +static int can_diag_dump(struct sk_buff *skb, struct netlink_callback *c=
b)
> +{
> +	int num =3D 0, s_num =3D cb->args[0];
> +	struct can_diag_req *req;
> +	struct net *net;
> +	struct sock *sk;
> +
> +	net =3D sock_net(skb->sk);
> +	req =3D nlmsg_data(cb->nlh);
> +
> +	mutex_lock(&net->can.sklist_lock);

[Severity: High]
Can this attempt to lock an uninitialized mutex?

Since can_diag.ko does not call any exported symbols from can.ko, the kernel
module loader will not enforce a load dependency between them. If a userspa=
ce
tool queries CAN sockets, the kernel might autoload can_diag.ko without loa=
ding
can.ko.

Because can.ko is responsible for registering the pernet operations that
initialize net->can.sklist_lock, can_diag_dump() could end up calling
mutex_lock() on a zeroed, uninitialized mutex, leading to lockdep warnings
or crashes.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610-feat-can-d=
iag-v1-0-021e3f1631a0@redhat.com?part=3D3

