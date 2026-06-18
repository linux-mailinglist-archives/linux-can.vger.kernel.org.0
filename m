Return-Path: <linux-can+bounces-7876-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id F0wzG0esM2quEwYAu9opvQ
	(envelope-from <linux-can+bounces-7876-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 10:28:55 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC34A69E73A
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 10:28:54 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=AC321LAV;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7876-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7876-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 13BA1300DDD5
	for <lists+linux-can@lfdr.de>; Thu, 18 Jun 2026 08:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C465E395AF2;
	Thu, 18 Jun 2026 08:28:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE00A39A07D
	for <linux-can@vger.kernel.org>; Thu, 18 Jun 2026 08:28:06 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781771287; cv=none; b=PEE4MszrmqkOYjkCLFvC0gJtqMyLWiY0QrcqX6+cfkrpYaIlt5dFacv8pPFamFQkTk2cqAdB2LtVBdo4nTY6tdf3pT+7/qeMao4N0lshBxBmPh13XfyY4glJK9fsrAHV2d8P+OlOkqFujf1HhyOqBcD+kWYloIw/JWRo9W+4dVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781771287; c=relaxed/simple;
	bh=FUrSYnK8WGW1DiEYrCuzXNl+E7/t4VPTyxsQWMlNM7o=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jVdCIuu8jT8r/P5KgfB0NkQzsuYpuSJHevFPI8lwg3ZdRpEMuQMvt3U+YN+8ldLUb5gt/JLEu59GHrVi9zU77dKlg4wdQum479frp8LrKo0XU4PG6k0Db72Oa1A9iT3zOZOT+YKYiyKMlVOJyl39RZXW3zMkshU0Qz2KJbO2KKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AC321LAV; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4123D1F00A3A;
	Thu, 18 Jun 2026 08:28:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781771286;
	bh=l0fylYSfbRnLcVDcfslexYZV7NNu5hthcOKJyuQUSZA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AC321LAVV+bmgP9PqFnIko85/lz94Lsbrw6xJs8u3H1YQJ2CD3plZckUnKlpOlhyU
	 glI4F3NWUQFkfvYhUkVjN9BH72nH0Jt83p/1AthluFyIZ+Xo3GAnnHsmK0A8lx/HUO
	 wQRSCTsaw198nizNUorC0BDqMQIJ/Ir/LnSbXYuQ3WCIxd4E2ppoJAg8SR6DKnFFft
	 /Jn7tqUZqeb1UkaFoECT17j6VSI+leEaAFPiHp8RtJsQpnNNMCvb+f0Yks2caf8JQ6
	 jWjsfMwdkOx8+nhkuaIUWX1YWEMoMXpE23ebHhBAeJHjX6n/31naFOxFWL7BOX7h7e
	 68w9yQjVjfjAg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5.15.y] net: add missing ns_capable check for peer netns
Reply-To: sashiko-reviews@lists.linux.dev
To: "Maximilian Heyne" <mheyne@amazon.de>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Oliver
 Hartkopp" <socketcan@hartkopp.net>
In-Reply-To: <20260617-forgot-manic-27dda774@mheyne-amazon>
References: <20260617-forgot-manic-27dda774@mheyne-amazon>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 18 Jun 2026 08:28:05 +0000
Message-Id: <20260618082806.4123D1F00A3A@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7876-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,amazon.de:email,sashiko.dev:url,lists.linux.dev:replyto,smtp.kernel.org:mid,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:mheyne@amazon.de,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,m:o.rempel@pengutronix.de,m:socketcan@hartkopp.net,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: CC34A69E73A

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Approximating `netlink_ns_capable()` with `ns_capable()` introduce=
s a confused deputy vulnerability by omitting the netlink socket opener cre=
dential check.
--

commit a7cbbc451870d23c0dbb2059e0abb94c500f495c
Author: Maximilian Heyne <mheyne@amazon.de>

net: add missing ns_capable check for peer netns

This commit attempts to fix CVE-2026-31692 by approximating
netlink_ns_capable() with ns_capable() directly in the vxcan and veth
interface types, as the upstream fix doesn't apply cleanly to older stable
kernels.

> diff --git a/drivers/net/can/vxcan.c b/drivers/net/can/vxcan.c
> index afd9060c5421c..8a61011fdaeef 100644
> --- a/drivers/net/can/vxcan.c
> +++ b/drivers/net/can/vxcan.c
> @@ -198,6 +198,11 @@ static int vxcan_newlink(struct net *net, struct net=
_device *dev,
>  	if (IS_ERR(peer_net))
>  		return PTR_ERR(peer_net);
> =20
> +	if (!ns_capable(peer_net->user_ns, CAP_NET_ADMIN)) {

[Severity: High]
Does approximating netlink_ns_capable() with ns_capable() here introduce a
confused deputy vulnerability?

netlink_ns_capable() ensures that both the opener of the netlink socket and
the current sender have the required capability. By directly using
ns_capable() in vxcan_newlink(), the netlink socket opener credential check
appears to be bypassed.

Could an unprivileged attacker open a netlink socket, connect it, and trick
a privileged SUID process into writing a crafted RTM_NEWLINK payload to it?

Since the SUID process performs the write, ns_capable() would see the
privileged credentials and succeed, potentially allowing the unprivileged
attacker to bypass the security fix and create devices in arbitrary
privileged network namespaces.

> +		put_net(peer_net);
> +		return -EPERM;
> +	}
> +
>  	peer =3D rtnl_create_link(peer_net, ifname, name_assign_type,
>  				&vxcan_link_ops, tbp, extack);

[ ... ]

> diff --git a/drivers/net/veth.c b/drivers/net/veth.c
> index cfacf8965bc59..c644d59d70900 100644
> --- a/drivers/net/veth.c
> +++ b/drivers/net/veth.c
> @@ -1664,6 +1664,11 @@ static int veth_newlink(struct net *src_net, struc=
t net_device *dev,
>  	if (IS_ERR(net))
>  		return PTR_ERR(net);
> =20
> +	if (!ns_capable(net->user_ns, CAP_NET_ADMIN)) {

[Severity: High]
Does this ns_capable() check in veth_newlink() have the same confused
deputy vulnerability as the one in vxcan_newlink(), allowing a bypass of
the socket opener credential check?

> +		put_net(net);
> +		return -EPERM;
> +	}
> +
>  	peer =3D rtnl_create_link(net, ifname, name_assign_type,
>  				&veth_link_ops, tbp, extack);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260617-forgot-man=
ic-27dda774@mheyne-amazon?part=3D1

