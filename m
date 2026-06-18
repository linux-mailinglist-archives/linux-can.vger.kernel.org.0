Return-Path: <linux-can+bounces-7874-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RC3iIwesM2qmEwYAu9opvQ
	(envelope-from <linux-can+bounces-7874-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 10:27:51 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F177B69E723
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 10:27:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=GPCRee7v;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7874-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7874-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6D2F130078C3
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 08:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8161139AD33;
	Thu, 18 Jun 2026 08:27:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F5538F253
	for <linux-can@vger.kernel.org>; Thu, 18 Jun 2026 08:27:45 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771266; cv=none; b=kt1qQyzW+biXl/qwAq2UI0fzrN+8ofukGuqNrw7j1+AG25Q72Yl/ZzYBkAdDTxP/ucpf5Y57C7Ti9MZewduRwOTmjNdTGEbmlF3AT4S1e7yns98TOOTix9XLlWni8eEJdEktxc76qg2NTk9PP82zmWEFquTtqfcNHw0FUTKbTIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771266; c=relaxed/simple;
	bh=8PdXD+yuoAVL6mUGWXUeJPZSHrNQNr364FRH/Wwxs+8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rgGDItRYyUZVGiqJma8iT+QvDQraKMDHwiXXEEyGpIj6En6MjwybFbh1lRDzLMME4Hny07K9PySX2prHJlH0oOpAbEYSb7+M8An4rEEJv9wFB7xKbLpWIyrg6C8KH9q+LR8gVuV2CIo2FOTjgP4pXs6A4ljbrz1zu1EDNUlPhyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GPCRee7v; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9613C1F000E9;
	Thu, 18 Jun 2026 08:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771264;
	bh=leO6DzvsaKBwty+1Fw4OuUYYbgaiurBnWnqM0gWRBDM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GPCRee7vH51MK7DiHW0i71hlJlmloRyLJCsBo6S1GS3wQGypYrGsvafAZmJ4043Fz
	 GrfVugpM7GAvCblhwrtUNWPsqP2QsHrE2fG6FIp7g5Iksuf+nG4jCuPr0/jnziMTIy
	 7kI96v3KnO4HxUl3555Pc6jtdQ1IGBoHamNn5/RZgFN1iteuH6REdm2P+tTyYITY9J
	 KmvHQ+dCCmxpENeMjL4uFmr2hsRle72g6t6ObnqBZ+ivUu+tjd9T53CXpglSmLXORt
	 bbTex/wLxlVWEG6wn+TTku3T+q+c3/HNlJIeJE4HqpjMy2o9bsaHBq4Emz46h6DTAZ
	 QbWVvrNYZ9vlw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6.6.y] net: add missing ns_capable check for peer netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Heyne" <mheyne@amazon.de>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, linux-can@vger.kernel.org, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, "Marc Kleine-Budde" <mkl@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260617-sprain-dye-86c242ac@mheyne-amazon>
References: <20260617-sprain-dye-86c242ac@mheyne-amazon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:27:44 +0000
Message-Id: <20260618082744.9613C1F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-7874-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp,amazon.de:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mheyne@amazon.de,m:socketcan@hartkopp.net,m:linux-can@vger.kernel.org,m:o.rempel@pengutronix.de,m:mkl@pengutronix.de,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F177B69E723

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Using `ns_capable()` instead of `netlink_ns_capable()` bypasses fi=
le descriptor capability checks, leaving the kernel vulnerable to confused =
deputy privilege escalation attacks via netlink fd passing.
--

commit 7cb10271bfe1888c97bd5ddcadbd3ed1e69fb9b0
Author: Maximilian Heyne <mheyne@amazon.de>

net: add missing ns_capable check for peer netns

This commit attempts to fix CVE-2026-31692 by approximating the=20
netlink_ns_capable() check with ns_capable() directly in the respective=20
interface types. It assumes that because the newlink operation is=20
synchronous, this will result in the same behavior.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index 98c669ad51414..da4affff65476 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -211,6 +211,11 @@ static int vxcan_newlink(struct net *net, struct net=
_device *dev,
>  	if (IS_ERR(peer_net))
>  		return PTR_ERR(peer_net);
> =20
> +	if (!ns_capable(peer_net->user_ns, CAP_NET_ADMIN)) {

[Severity: High]
Does using ns_capable() instead of netlink_ns_capable() leave the kernel
vulnerable to confused deputy attacks via file descriptor passing?

Because ns_capable() only evaluates current_cred(), an unprivileged
attacker could create a netlink socket, craft an RTM_NEWLINK payload,
and pass the socket fd (e.g., via SCM_RIGHTS) to a privileged process.
When the privileged deputy writes to the socket, this ns_capable() check
would succeed using the deputy's credentials, ignoring the fact that the
socket was opened by an unprivileged user.

netlink_ns_capable() explicitly checks both the socket opener
(file_ns_capable) and the sender (ns_capable) to prevent exactly this
scenario. Could this approach be revised to ensure the socket opener's
credentials are also verified?

> +		put_net(peer_net);
> +		return -EPERM;
> +	}
> +
>  	peer =3D rtnl_create_link(peer_net, ifname, name_assign_type,
>  				&vxcan_link_ops, tbp, extack);

[ ... ]

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index 2b3b0beb55c88..ba4ca6c6bc9d8 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1857,6 +1857,11 @@ static int veth_newlink(struct net *src_net, struc=
t net_device *dev,
>  	if (IS_ERR(net))
>  		return PTR_ERR(net);
> =20
> +	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {

[Severity: High]
Would this ns_capable() check in veth_newlink() similarly bypass the
socket opener credential check?

As with vxcan_newlink(), using ns_capable() alone seems to bypass the
file descriptor capability checks that netlink_ns_capable() provides,
potentially allowing privilege escalation if the netlink fd is passed
to a more privileged process.

> +		put_net(net);
> +		return -EPERM;
> +	}
> +
>  	peer =3D rtnl_create_link(net, ifname, name_assign_type,
>  				&veth_link_ops, tbp, extack);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-sprain-dye=
-86c242ac@mheyne-amazon?part=3D1

