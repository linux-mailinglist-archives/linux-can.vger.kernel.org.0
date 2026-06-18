Return-Path: <linux-can+bounces-7877-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id P0/QDiWsM2qsEwYAu9opvQ
	(envelope-from <linux-can+bounces-7877-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 10:28:21 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 84D5069E734
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 10:28:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Q8utGEy8;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7877-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-can+bounces-7877-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8467C300D71F
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 08:28:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD5A395AF2;
	Thu, 18 Jun 2026 08:28:18 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F72D395AC4
	for <linux-can@vger.kernel.org>; Thu, 18 Jun 2026 08:28:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771298; cv=none; b=ShZO8ROz2pY7qA9I8eOF6e/ixBYzZJ+C/BRUlvIR4NacLkUcW8O2sr/x4DF8rFKlpgJ/UsdN3kNXEB65zmkPmXEAomRbZnMh4hPUyGCfFMSxQaeu2Jhry7CEDQLFqRRpbT73ZTK8D8A8yEHQXs/zA4UF/BJHqtRl1hL9AbZV4Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771298; c=relaxed/simple;
	bh=BuPEm06AzBZF58qY5zDAxjjhc242BpSwyrqstpCUtdM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=J1Vot0zOamr11tDLzG4VZoNd0wEoPzwx9NnYTW9HJuG34yGY+qy09Fdhaq4Bg+QeA9gA38W9Lh04z1id7d6L7HooAeL6JcWs7DxhryQEUfzzlQd95EC1/Z4+jMFDfTSA01hPq7+tn6nWgODBQvkkEXffdVfUc3PfSb9yJhVMivk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q8utGEy8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15B371F00A3A;
	Thu, 18 Jun 2026 08:28:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771297;
	bh=u9ajkaAbLDi13QDqSfAAfCuPgustthxuZjOSOSjFCNk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q8utGEy8Bt74Gz4S0YnqUcjeHw5oIMVyNfu9mmJ+6jOORQtCIBoJR8afsGKwK6ZD/
	 Kuxs3t43mcL6RHeZURKElXkVugZlPzdUIV5pqrs5yr16M144YsYd2xwh/j2ADC/q/v
	 SE5ESAp407GtnUNCoDBkPXm+dhQw+ORV7/ZNJimx9kpW0wnSlpWjxSi3RdonS8SAiM
	 92t48bWbSsbaCynsjaSMjZVqsMvgG1cY5O6QMUjG+RNx2sknF/pHiDpQDxLwtv7ZTm
	 RxNHsWslLgkohThie7p0Z0hYC5fjnDfXIaHusmlS5JdOphKM90uawxvkj6HBSIGPyD
	 aZhVu+SktsW3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.10.y] net: add missing ns_capable check for peer netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Heyne" <mheyne@amazon.de>
Cc: "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>
In-Reply-To: <20260617-thaws-enid-af4ad67d@mheyne-amazon>
References: <20260617-thaws-enid-af4ad67d@mheyne-amazon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:28:16 +0000
Message-Id: <20260618082817.15B371F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7877-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amazon.de:email,sashiko.dev:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mheyne@amazon.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84D5069E734

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] The use of `ns_capable()` instead of `netlink_ns_capable()` in=
troduces a Confused Deputy vulnerability, leading to an incomplete CVE fix.
--

commit d08a46769cbdf6769103f5b2c4165c49f427aec5
Author: Maximilian Heyne <mheyne@amazon.de>

net: add missing ns_capable check for peer netns

This commit attempts to fix CVE-2026-31692 on older stable kernels by adding
an ns_capable check directly to interface types like veth and vxcan. It is
intended to approximate the upstream netlink_ns_capable check.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -198,6 +198,11 @@ static int vxcan_newlink(struct net *net, struct net=
_device *dev,
>  	if (IS_ERR(peer_net))
>  		return PTR_ERR(peer_net);
> =20
> +	if (!ns_capable(peer_net->user_ns, CAP_NET_ADMIN)) {
        ^^^^^^^^^^

[Severity: Critical]
Does using ns_capable() instead of netlink_ns_capable() leave open a
confused deputy vulnerability?

Since ns_capable() only evaluates the credentials of the current executing
task, an unprivileged user might be able to open a netlink socket, prepare a
malicious RTM_NEWLINK payload, and pass the socket file descriptor to a
privileged process.

If the privileged process writes to the socket, ns_capable() will check the
privileged current task instead of the netlink socket creator's credentials
and incorrectly allow the operation.

> +		put_net(peer_net);
> +		return -EPERM;
> +	}
> +
>  	peer =3D rtnl_create_link(peer_net, ifname, name_assign_type,
>  				&vxcan_link_ops, tbp, extack);
>  	if (IS_ERR(peer)) {

[ ... ]

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1341,6 +1341,11 @@ static int veth_newlink(struct net *src_net, struc=
t net_device *dev,
>  	if (IS_ERR(net))
>  		return PTR_ERR(net);
> =20
> +	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {
        ^^^^^^^^^^

[Severity: Critical]
Is it possible this check suffers from the same confused deputy issue as the
one in vxcan_newlink(), where it evaluates the current task instead of the
socket creator?

> +		put_net(net);
> +		return -EPERM;
> +	}
> +
>  	peer =3D rtnl_create_link(net, ifname, name_assign_type,
>  				&veth_link_ops, tbp, extack);
>  	if (IS_ERR(peer)) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-thaws-enid=
-af4ad67d@mheyne-amazon?part=3D1

