Return-Path: <linux-can+bounces-7999-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id tQeQB9uvSWqi6AAAu9opvQ
	(envelope-from <linux-can+bounces-7999-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 05 Jul 2026 03:14:03 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C263708C08
	for <lists+linux-can@lfdr.de>; Sun, 05 Jul 2026 03:14:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=eUTDXHVZ;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7999-lists+linux-can=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-can+bounces-7999-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8ADE300DDDB
	for <lists+linux-can@lfdr.de>; Sun,  5 Jul 2026 01:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E7071EB19B;
	Sun,  5 Jul 2026 01:14:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 197811DB95E
	for <linux-can@vger.kernel.org>; Sun,  5 Jul 2026 01:13:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783214040; cv=none; b=Vrf5RamZ8oV10PZyCATlruoTsa3IFpbV/WXwDkmC4iMuHkBKiI5hI9M7cWNz7qIzwgtku1v/2w0w2Jkjvs8FrT+05oq7w/WYUSb9pr5CigDoHOh5pEq3ASV5q85wr8Y7HyCORbCJsTilvV7cPrOWw9jHMtYWbrDZZYZiPGVaMyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783214040; c=relaxed/simple;
	bh=9zAdQfOmYR/DiUysF6hz3O6GKuGRSRTw/YDKH/nLTEI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZmrPB4mIeavxm+h/xA1dnTRljhid4/8pP3harsY1GdKBZ/Eyl1BR5Kle290qbxTUD+5lRTAeU13kQ7kqhc5UtaD9yrXgB6VzXu1uFyxgFfMpMp1/xlAw+FCFeLMMjg9haY0LFu5GfyG+kwjtpS2pxLN08VRRJYAQZ7zJqNkQQU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eUTDXHVZ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D2181F000E9;
	Sun,  5 Jul 2026 01:13:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783214038;
	bh=SZd+JZlCgkp6O1Ccyn5X1MmExBsJl3/o4bqW3zSs5A8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eUTDXHVZKJBN+wWvRyEiK5bFrRM1h+rj+5bxJ8odZCUqcrIBdTE/P1HSSYq5FJakc
	 c7XfpBEgII0CAuWfVZILVliplVJ7xLnX8Wfy7MImNeAioFxukSWWA5Iw9rlPNosq3X
	 A+YZ5eM/AA7eKyJd5ps8J/kH+MAdUZ18FF2fV3lBbPqO0a3BRnYScBRy6MKzpld9ne
	 ziFssY37JZvsjpekpRD+d6fP4Op7XhPGAxxLWXL3ztpZePDLMLSoLGa6PZZOchUeLC
	 t1+kOd0BmJgn7AKqEZ7+drM3dUdqw2xZytfj3mLB2ss47rZB2Nv/uclW8arG290zro
	 fQBD0rf9tdjrA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] can: esd_usb: free_candev() after unlink_all_urbs()
 in disconnect
Reply-To: sashiko-reviews@lists.linux.dev
To: "Xiang Mei" <xmei5@asu.edu>
Cc: "Vincent Mailhol" <mailhol@kernel.org>, "Oliver Hartkopp" <socketcan@hartkopp.net>, "Marc
 Kleine-Budde" <mkl@pengutronix.de>, "Oleksij Rempel" <o.rempel@pengutronix.de>, linux-can@vger.kernel.org
In-Reply-To: <20260705010005.1169943-1-xmei5@asu.edu>
References: <20260705010005.1169943-1-xmei5@asu.edu>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 05 Jul 2026 01:13:57 +0000
Message-Id: <20260705011358.6D2181F000E9@smtp.kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-7999-lists,linux-can=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	REPLYTO_DN_EQ_FROM_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,smtp.kernel.org:mid,lists.linux.dev:replyto];
	FORGED_SENDER(0.00)[sashiko-bot@kernel.org,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:xmei5@asu.edu,m:mailhol@kernel.org,m:socketcan@hartkopp.net,m:mkl@pengutronix.de,m:o.rempel@pengutronix.de,m:linux-can@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	HAS_REPLYTO(0.00)[sashiko-reviews@lists.linux.dev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5C263708C08

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Moving `unlink_all_urbs()` before `unregister_netdev()` introduc=
es a memory leak race with `esd_usb_open()` on the RX path.
--

commit f21a9588c02c39e2094757bcdada4fb7aca593c8
Author: Xiang Mei <xmei5@asu.edu>

can: esd_usb: free_candev() after unlink_all_urbs() in disconnect

This commit fixes a slab-use-after-free issue by killing URBs before freeing
the CAN devices.

> diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
> index d257440fa01ff..34c0ca1872839 100644
> --- a/drivers/net/can/usb/esd_usb.c
> +++ b/drivers/net/can/usb/esd_usb.c
> @@ -1385,6 +1385,7 @@ static void esd_usb_disconnect(struct usb_interface=
 *intf)
> =20
>  	if (dev) {
>  		dev->in_usb_disconnect =3D 1;
> +		unlink_all_urbs(dev);

[Severity: Medium]
Does moving unlink_all_urbs() before unregister_netdev() introduce a memory
leak regression by racing with esd_usb_open() on the RX path?

Previously, unregister_netdev() ran first, providing rtnl_lock=20
synchronization. Now that unlink_all_urbs() runs before unregister_netdev(),
esd_usb_open() could run concurrently if the interface is brought up at the
exact same time the device is disconnected.

If this race occurs, unlink_all_urbs() could scan the buffers while they are
still NULL:

drivers/net/can/usb/esd_usb.c:unlink_all_urbs() {
        ...
        for (i =3D 0; i < ESD_USB_MAX_RX_URBS; ++i)
                usb_free_coherent(dev->udev, ESD_USB_RX_BUFFER_SIZE,
                                  dev->rxbuf[i], dev->rxbuf_dma[i]);
        ...
}

And concurrently, esd_usb_setup_rx_urbs() could allocate them immediately
after the check:

drivers/net/can/usb/esd_usb.c:esd_usb_setup_rx_urbs() {
        ...
        dev->rxbuf[i] =3D buf;
        dev->rxbuf_dma[i] =3D buf_dma;
        ...
}

Could these newly allocated DMA buffers be permanently leaked since
unlink_all_urbs() has already completed its cleanup pass?

>  		for (i =3D 0; i < dev->net_count; i++) {
>  			if (dev->nets[i]) {
>  				netdev =3D dev->nets[i]->netdev;
>  				netdev_info(netdev, "unregister\n");
>  				unregister_netdev(netdev);
>  				free_candev(netdev);
>  			}
>  		}
> -		unlink_all_urbs(dev);
>  		kfree(dev);
>  	}
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705010005.1169=
943-1-xmei5@asu.edu?part=3D1

