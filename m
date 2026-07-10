Return-Path: <linux-can+bounces-8284-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yy3pA5jcUGre6QIAu9opvQ
	(envelope-from <linux-can+bounces-8284-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 13:50:48 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CEF73A6CE
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 13:50:47 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=mdz9HbYE;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8284-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-8284-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 26350302ECC1
	for <lists+linux-can@lfdr.de>; Fri, 10 Jul 2026 11:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0C342A78A;
	Fri, 10 Jul 2026 11:49:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF95A42669E
	for <linux-can@vger.kernel.org>; Fri, 10 Jul 2026 11:48:56 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684149; cv=none; b=easCwf+qbka1UAzHoINP17aHXVV/ZPgSEmme1xhccPAXaiEs7XiSeoZYldkyxc5vrOdF/uhOwCtyNF9X9GUn1SKWoahBnmjhMho3kCbngsBFNy4s6QBQE+B8H6XFTzA73xnlAeL75QttsypxgYr2NDTGfuSAMpkZDE3ZgHQBr2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684149; c=relaxed/simple;
	bh=8xHeJXG8oxT9LQ98Bpi1smvkdxzikICAGJF5IzhuE7Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QkKWn9GsZuBRaOpEfq3mSHUre2qxDrn9QL8tDS28AqtqM8M1mbRy/fttdkReexYbc08WweU8QByMJN1m95t8I+BKWBYmRiyK9D1PuSWtJr7m4fiwhuZlfx50NZFH2eU2SZ2LKeSy6y1UDiOB7MTYVXbabSfU89nlLhQDUyv/0Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mdz9HbYE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CBD41F000E9;
	Fri, 10 Jul 2026 11:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783684131;
	bh=Objfi6YL8rR+z+eayn4BTVMFcQUIrBLn8hfZXR/a6BA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mdz9HbYERPij4ZmZMwcrYW1CUUfUr2CXDmtJLC2Q/i7DguMxL9hvLhtnnTn2Vf7Sx
	 RHmQou6aFy7bL2P4yudynatC/Oi7zdOEeA+9JbkFv+f0I4NjFgtr5/Xcxemb7uTIHi
	 iH93r18XnNMb5TP2zFyLVsuSgZvip2xtnENpM5CpPwZRBaD75wtJ7lmUVOh28l4mOV
	 xuGkljk47CR6S+8xxK2f+9NjdPJNIPP7rlqSMYmcPZHTN7Pjn7/ePNvR/rJvPrCez/
	 tTeguvDMyZJ2oat4NTftQP7gtiaib1buSWz9jWpqA1GlRRtSwOaL9mt+en8jLt9DKy
	 Dagka0OMDSVbA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] can: isotp: use unconditional synchronize_rcu()
 in isotp_release()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij Rempel" <o.rempel@pengutronix.de>, "Vincent
 Mailhol" <mailhol@kernel.org>, "Marc Kleine-Budde" <mkl@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260710-isotp-fixes-v2-1-bc57e26594b2@hartkopp.net>
References: <20260710-isotp-fixes-v2-0-bc57e26594b2@hartkopp.net>
 <20260710-isotp-fixes-v2-1-bc57e26594b2@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 11:48:49 +0000
Message-Id: <20260710114850.4CBD41F000E9@smtp.kernel.org>
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
	TAGGED_FROM(0.00)[bounces-8284-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,sashiko.dev:url,lists.linux.dev:replyto,vger.kernel.org:from_smtp,smtp.kernel.org:mid,hartkopp.net:email];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:o.rempel@pengutronix.de,m:mailhol@kernel.org,m:mkl@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
X-Rspamd-Queue-Id: A2CEF73A6CE

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Race condition between `isotp_release()` and netdevice unregis=
tration skips CAN filter unregistration, leading to a permanent memory leak=
 and potential use-after-free.
--

--- Patch [1]: [PATCH v2 1/2] can: isotp: use unconditional synchronize_rcu=
() in isotp_release() ---
commit 554fcaa84431e4410ac9203b4f4a5bfeadc94ccf
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: isotp: use unconditional synchronize_rcu() in isotp_release()

This commit makes isotp_release() unconditionally call synchronize_rcu()
before cancelling timers. This closes a race where a concurrent
NETDEV_UNREGISTER could clear so->bound without waiting for in-flight
isotp_rcv() callers.

Link: https://lore.kernel.org/linux-can/20260707085210.6B6C01F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/isotp.c b/net/can/isotp.c
> index c48b4a818297e..d30937345bcdc 100644
> --- a/net/can/isotp.c
> +++ b/net/can/isotp.c
> @@ -1237,11 +1237,18 @@ static int isotp_release(struct socket *sock)
>  						  SINGLE_MASK(so->txid),
>  						  isotp_rcv_echo, sk);
>  				dev_put(dev);

[Severity: Critical]
This is a pre-existing issue, but is there a race condition between
isotp_release() and netdevice unregistration that can skip CAN filter
unregistration?

If unregister_netdevice_many() unlists the netdevice from net->dev_by_index
using unlist_netdevice(), and isotp_release() runs immediately after this b=
ut
before the NETDEV_UNREGISTER notifier is dispatched:

isotp_release() {
    ...
    list_del(&so->notifier);
    ...
    dev =3D dev_get_by_index(net, so->ifindex);
    if (dev) {
        ...
    }
}

Since the device is unlisted, this returns NULL, causing isotp_release() to
silently skip unregistering the CAN RX filters.

When the NETDEV_UNREGISTER notifier eventually runs in isotp_notifier(), it
misses the socket because it was already unlinked from isotp_notifier_list.

Could this permanently leak the CAN filters with a dangling pointer to the
freed socket, leading to a use-after-free? Can this be triggered by an
unprivileged user in a user namespace with CAP_NET_ADMIN by repeatedly
creating and destroying vcan interfaces while simultaneously creating and
closing ISOTP sockets?

> -				synchronize_rcu();
>  			}
>  		}
>  	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260710-isotp-fixe=
s-v2-0-bc57e26594b2@hartkopp.net?part=3D1

