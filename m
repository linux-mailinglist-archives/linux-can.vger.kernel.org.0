Return-Path: <linux-can+bounces-8395-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dfxwAhoUVmp/ywAAu9opvQ
	(envelope-from <linux-can+bounces-8395-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:48:58 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7C0753908
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 12:48:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XPK5VGCz;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-8395-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-8395-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A0A030136A7
	for <lists+linux-can@lfdr.de>; Tue, 14 Jul 2026 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550501F0995;
	Tue, 14 Jul 2026 10:44:33 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34013363C60
	for <linux-can@vger.kernel.org>; Tue, 14 Jul 2026 10:44:31 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784025873; cv=none; b=SxVdrlyPBatgJSoMI1YJo8ZOb/KrryeUYb+wv8Y+6Qp/1r2hR/27SHpxhH/Mepsk2RCF85CQV7QEdOpx3U+mFurg81v0ARNDzvkm6yuVkuTcmL7TXz1lmu0jba0/9T7sgtUcqtVtCrboGo/GM7KSJ66m+TE0+rSFpfStiSzq8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784025873; c=relaxed/simple;
	bh=NN3OKzggappJDbMnDbGndDb7y/W3Yg+z6voMr2oWN+0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=diAAAy0KFivJ0j1d96HagumLvfUxvmiZwrib7pHwrXs/Gd9IvnZIoTV4si0S4higfC9Vd8nKFF8oqUTMQo1NFqrocoNnaG03iMp/Bo9dNvZK33DP3139cNHYgSjiwdEC2H7mk8AKxv5iwiyB3pgQ+iiN0iWB1qRaTaMlW6QeFtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XPK5VGCz; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65C751F000E9;
	Tue, 14 Jul 2026 10:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784025871;
	bh=6Cinaoutr2BaBRixXnDzp+jpH5uqQR7Q2fgmSCnn5CE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XPK5VGCzm+N3tjV+3USEMbC4/2vwJNcPLMW2ak82+3WPwoLGiM5GaM2degaDBCwTa
	 SLthf8jidQdBXdi3Al/FVLlJo0MXyvsRpkiKkZNJJ3d3vQV8EvgcYg0cuz6ljAaz9s
	 OXxiGJMV2aQV4qP1F/Lbx34fLdQsuCVuaQeBa5CCiHRCDW1OzIYk1wuWC+4WejZQZh
	 llvY9eMAUExeXmPM8eiesFBQXyM8xssaQunxlmtzJcHR4Z3TqW2hfc45X/okTYzlO2
	 8WGNdjOyvQ+plhVny/CsCCXM5AB72WaZDllA4icbFlhHH4tUGDEElhIUPb4LdAiaPI
	 mOkq172y2Y4EQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device
 removal
Reply-To: sashiko-reviews@lists.linux.dev
To: "Oliver Hartkopp" <socketcan@hartkopp.net>
Cc: "Marc Kleine-Budde" <mkl@pengutronix.de>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Oleksij
 Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org, "Vincent
 Mailhol" <mailhol@kernel.org>
In-Reply-To: <20260714-bcm_fixes-v13-9-fd667c61099a@hartkopp.net>
References: <20260714-bcm_fixes-v13-0-fd667c61099a@hartkopp.net>
 <20260714-bcm_fixes-v13-9-fd667c61099a@hartkopp.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 14 Jul 2026 10:44:30 +0000
Message-Id: <20260714104431.65C751F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8395-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[hartkopp.net:email,sashiko.dev:url,smtp.kernel.org:mid,lists.linux.dev:replyto,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,m:mailhol@kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5E7C0753908

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unprotected concurrent access to op->rx_stamp and op->rx_ifindex i=
n bcm_rx_handler causes data races and torn 64-bit reads on 32-bit architec=
tures.
--

--- Patch [9]: [PATCH v13 09/11] can: bcm: fix stale rx/tx ops after device=
 removal ---
commit 7ac0666664aa8f0bbda8367494a6678c948d2082
Author: Oliver Hartkopp <socketcan@hartkopp.net>

can: bcm: fix stale rx/tx ops after device removal

This commit fixes issues where an RX_SETUP update could silently skip
registering if a concurrent NETDEV_UNREGISTER occurred. It also ensures
that cyclic transmissions are stopped when a device is removed.

Link: https://lore.kernel.org/linux-can/20260708094536.DDF821F00A3A@smtp.ke=
rnel.org/
Link: https://lore.kernel.org/linux-can/20260708154039.347ED1F000E9@smtp.ke=
rnel.org/

> diff --git a/net/can/bcm.c b/net/can/bcm.c
> index 5660165cdf0eb..10dd99ecce70e 100644
> --- a/net/can/bcm.c
> +++ b/net/can/bcm.c
[ ... ]
> @@ -1483,18 +1495,32 @@ static int bcm_rx_setup(struct bcm_msg_head *msg_=
head, struct msghdr *msg,
>  				err =3D -ENODEV;
>  			}
> =20
> -		} else
> +		} else {
>  			err =3D can_rx_register(sock_net(sk), NULL, op->can_id,
>  					      REGMASK(op->can_id),
>  					      bcm_rx_handler, op, "bcm", sk);
> +		}

[Severity: High]
This is a pre-existing issue, but is there a data race when bcm_rx_handler()
accesses op->rx_stamp and op->rx_ifindex?

When a BCM socket is bound to ifindex 0 (all CAN devices), multiple CAN
frames arriving simultaneously on different CAN interfaces trigger
bcm_rx_handler() concurrently. The handler unconditionally writes to
op->rx_stamp and op->rx_ifindex outside of op->bcm_rx_update_lock:

net/can/bcm.c:bcm_rx_handler() {
    ...
	/* save rx timestamp */
	op->rx_stamp =3D skb->tstamp;
	/* save originator for recvfrom() */
	op->rx_ifindex =3D skb->dev->ifindex;
    ...
}

These fields are then read in bcm_send_to_user(), sometimes locklessly (e.g.
when called from bcm_rx_timeout_handler()):

net/can/bcm.c:bcm_send_to_user() {
    ...
		/* restore rx timestamp */
		skb->tstamp =3D op->rx_stamp;
    ...
	addr->can_ifindex =3D op->rx_ifindex;
    ...
}

Does this cause torn 64-bit reads of op->rx_stamp on 32-bit architectures,
and can the interface index be logically swapped with that of a concurrent
frame?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714-bcm_fixes-=
v13-0-fd667c61099a@hartkopp.net?part=3D9

