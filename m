Return-Path: <linux-can+bounces-8354-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XlBwBWMIVGrJhAMAu9opvQ
	(envelope-from <linux-can+bounces-8354-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 23:34:27 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 985D374607A
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 23:34:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=J5F4Wnev;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8354-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-can+bounces-8354-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0D2053002B0C
	for <lists+linux-can@lfdr.de>; Sun, 12 Jul 2026 21:34:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D59D376A0E;
	Sun, 12 Jul 2026 21:34:24 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F4D376BE0
	for <linux-can@vger.kernel.org>; Sun, 12 Jul 2026 21:34:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783892064; cv=none; b=MZvv29+D/+NBquIy1KGSjk0oASPSq/jjqsxWvKnc8RHuAZvAueEhgQ4UgDkheYGcsbLqylNvDp99gNzcRMRXuDHgv2O9p1pDkIb1ynCAcKD8Gpl1Qu2I9BL14EFGeZH5TpTYv590hkShpxxXq6DJE6nUnIEprnnwGjlmHv2Sw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783892064; c=relaxed/simple;
	bh=691QnKVCikUEeOzK2iPober+r8rx1L+vF3+ElTFwI+Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=efzbYNA5Ack+mL5KcdUYNOnRepmWp/DNa1jFEoUKpeec4epNGwlBcJ7lapvuea8poyV2407pO73BZ163or3lh7YBZQyczxb5ftMWGhrUz/yggcoG4A/1b4YDfHMV0sGFKBpYgu0c/zg2W60TicfxFM6ql4rMsKDAzsJ2/UgG+Lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5F4Wnev; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB1111F000E9;
	Sun, 12 Jul 2026 21:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783892063;
	bh=oZMBOvaH9k5qv9bXtn7fmBZR0CqLKKeItlVHzx3NEts=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5F4WnevB07QH47IAopn1kazdsfpSym1xKXR1kPDUJpNH26FPV6GqglRrYbpJdxvQ
	 0Hr2D901kIq5hJqsUhTV7i8Ei1+nRloG5OZDPmrFlwwceae6lOKIZ1XLI+yhhZf0xg
	 GegLXoSRcaG2Q8PjagRw6BZLkJTA4C/ZmzhLzUV3soGNNKOD/9K/9Qd9HNdD4SEr3s
	 o0NMCoVEb8r7iYFouaX/IDZRox2RGQmutOr2IKezVSk1vTpbkpgSsF817R1e3EwO9L
	 THK6gFauMcJP0hZgQKrZ+GsKgOb37EDsE66UR4cCSkA3aqO1ICsnsVfVKArWVdXZH9
	 uMzBUacee77dA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1] vxcan: Support per-netns device unregistration.
Reply-To: sashiko-reviews@lists.linux.dev
To: "Kuniyuki Iwashima" <kuniyu@google.com>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260712212113.181121-1-kuniyu@google.com>
References: <20260712212113.181121-1-kuniyu@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 12 Jul 2026 21:34:22 +0000
Message-Id: <20260712213422.DB1111F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8354-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,sashiko.dev:url];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:kuniyu@google.com,m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 985D374607A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] The patch calls the undefined function `unregister_netdevice_queue_=
net()`, resulting in a compilation error.
--

--- Patch [1]: [PATCH v1] vxcan: Support per-netns device unregistration. -=
--
commit 882fcd31630d9ce6b0a57cc99738c2ad0579763f
Author: Kuniyuki Iwashima <kuniyu@google.com>

vxcan: Support per-netns device unregistration.

This commit updates vxcan_dellink() to unregister local and peer devices
safely across different namespaces by using xchg(). The change aims to
prevent double-queuing of device destruction when RTNL is removed.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c

[ ... ]

> @@ -281,24 +284,25 @@ static int vxcan_newlink(struct net_device *dev,
> =20
>  static void vxcan_dellink(struct net_device *dev, struct list_head *head)
>  {

[ ... ]

>  	unregister_netdevice_queue(dev, head);
> =20
> -	if (peer) {
> -		priv =3D netdev_priv(peer);
> -		RCU_INIT_POINTER(priv->peer, NULL);
> -		unregister_netdevice_queue(peer, head);
> -	}
> +	priv =3D netdev_priv(peer);
> +	dev =3D unrcu_pointer(xchg(&priv->peer, NULL));
> +	if (dev)
> +		unregister_netdevice_queue_net(dev_net(dev), peer, head);

[Severity: Low]
Is this missing a prerequisite patch? It appears that
unregister_netdevice_queue_net() is not defined anywhere in the kernel
tree, which leads to a compilation error when building vxcan.c.

> +
> +	netdev_put(peer, peer_tracker);
> +	netdev_put(dev, &priv->peer_tracker);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260712212113.1811=
21-1-kuniyu@google.com?part=3D1

