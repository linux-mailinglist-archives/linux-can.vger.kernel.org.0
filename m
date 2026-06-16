Return-Path: <linux-can+bounces-7843-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id W4bJJXr0MGruZQUAu9opvQ
	(envelope-from <linux-can+bounces-7843-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 09:00:10 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 324D068CB1A
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 09:00:10 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=ENQZDQmA;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7843-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7843-lists+linux-can=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2E8E301603E
	for <lists+linux-can@lfdr.de>; Tue, 16 Jun 2026 07:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BF534A3C4;
	Tue, 16 Jun 2026 07:00:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9E730CDA2
	for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 07:00:07 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781593208; cv=none; b=QaGomRZndXeAb9zsADAAZPokIrC2XcA4m0uxlNWuTkMBmPt1aMN713rq0bNeFd5AncpkHv4aIICkqECVtYYkW98mz3GyySYHqVW+Q03Ayy2t4n9ZTZ9hBurfDrUqNfOLJdd7RbtB2UlwPnTV4yHbatJDZBppPgsqVfBqgRzz9fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781593208; c=relaxed/simple;
	bh=OZMt6Ts9zT/hcDRIiIWK9dRgogrEeeyNRF/MHqjYDjc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=krDXTzhsYupA6Pdl2EdamI+cUWOTcSqdJ44ELzP+8ZmbOfODjVnY2u2s+e7DptHCvSmxK25G0lMrFpS1DecHU+CxuiDIcjlX4diiodIOEdJCqAoPpx8WX+ujnFUUYLgboteZcZq0MIo0Xn+HBLhC3/n4Dp84yKWrnGpWeVogd5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ENQZDQmA; arc=none smtp.client-ip=209.85.214.170
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2bf30d530bdso41539415ad.3
        for <linux-can@vger.kernel.org>; Tue, 16 Jun 2026 00:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781593206; x=1782198006; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zRDuHfS0GYQQ7L7RU0l6AuS4sLuHII8a850qbxuqYr8=;
        b=ENQZDQmAYcm6mvd3ndMLRlaDzT+MdifQhKI3PF8nbzwehL0pEHZYapO90ep9PYTi+M
         kmMltzIdItKH41lo5aNZg+kf8rsbU+cT17iIVMmfkJ5ticXos1rolqeeaMb5Y9PQMa8o
         A9SAlP3lpOSiaV69uAvH9v77Qymt6SUm4sqK34i4Ekwd+o3geFV9LRtpV37+GTyg71cH
         XsgBXF2SIh0YErgc0U3kZJGjOfjO2+pLCcnBZkPY+/ikTuBsnv4uaoty2FS547nc2OaI
         e2WY8+jZfkKDrXHKtg+HNzqXMuYMubqIaUEU3+el0feU+eeGMwzgsxMF5ELWEPYPn/tS
         fECA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781593206; x=1782198006;
        h=mime-version:content-transfer-encoding:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRDuHfS0GYQQ7L7RU0l6AuS4sLuHII8a850qbxuqYr8=;
        b=QYLEVcrv69+i46zgT74LO2Lrh9FkliEONniMsYivEPUGidNdxNRw8Vd98PeGPrgwJx
         cwONQ8JEu/I3dh+8psOLb0anTagLhqfESpKDoLgXX+wvD8nwZ6eNNid84QgQi46BshJa
         mpyvbddtBNpxI/K1HR+OfKkqJ2SSvk5r4JG7ooDHkaqTUMvF3bxyVGOb+149aHtxyHlt
         K/YotChpBBPlxL6ZJwZV1u8TbiBRMXEf5D8glMc6bPbMFh6gFJWoI1FxQOrZIFRejGv9
         X/MGKsAiaUWRpyZe/U5+2Df0s2RI52rYnomBCMhofjLwOOevWe6fWv2D01R/db7wveRT
         6udA==
X-Forwarded-Encrypted: i=1; AFNElJ9wvvVCCQ40zf7qF7MEQsvZQeZPhOzYoV2X9nHQuhy0+73b6qDW0F+oEzZucTimIr2tqRAklWQkbh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXPopMOPa/yir5Hk8UZeInsGLI2flhqIuPcSPm2PxnwBTFNvTR
	RRMbwP6CZa69+MuYmt9NiYmqPd+1PDvR8f89vyLeq7UX/JCegvwa0hdD
X-Gm-Gg: Acq92OGvQFP/qaCsukPg4G4US4WCJRrbcU954BPD6gEsnneoLK8tddXqsMAuThuqYOe
	11J9ZllkbBb5jRbcCKtBAMascnbCX6kLZqQb80497El9lIzLsJxbmb4Z1TgFWqUKrVwRHywkaJE
	HRVXacBHFmIJ3lCrpUT5sMxuadUcOPtPNXYpE0rghN6a0XFBWypchh4VEGBpbzyZONPIQKgaua9
	IHVC9SONsNUldL4r1lvlRrMqHipDU62Rg1lwqTT+Rct9r4yyU7DebnXviBVgFMdeWGkL+oxes6a
	pIMywY7bJE0n7vUHGJw6kmtMfivXHT1vKo5GxIA8xYNRElTcxz+IIoOEvZD6RVbczJMqFeAXmLK
	AqgLnAst7v7MUhaz99g+FryONidI/fpX/MeDZXszwfe16TGQPtAWnejVFTLeRGNw6Dgpb9gUWZZ
	38nKNvuKpJcqqAU8tq06sPKRyQBsAPzFKm+us9ujI8epQsTSX4
X-Received: by 2002:a17:902:ce82:b0:2bf:379b:53d2 with SMTP id d9443c01a7336-2c6641bb17amr149611625ad.15.1781593206381;
        Tue, 16 Jun 2026 00:00:06 -0700 (PDT)
Received: from csl-conti-dell7858.ntu.edu.sg ([155.69.195.57])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5411sm119032145ad.32.2026.06.16.00.00.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 00:00:05 -0700 (PDT)
From: Maoyi Xie <maoyixie.tju@gmail.com>
To:
 Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol <mailhol@kernel.org>
Cc: =?utf-8?q?St=C3=A9phane?= Grosjean <stephane.grosjean@hms-networks.com>,
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 peak_usb_start(): double free of RX buffer when usb_submit_urb() fails
Date: Tue, 16 Jun 2026 15:00:02 +0800
Message-ID: <178159320216.2154888.16953451793788581739@maoyixie.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7843-lists,linux-can=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:mkl@pengutronix.de,m:mailhol@kernel.org,m:stephane.grosjean@hms-networks.com,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[maoyixietju@gmail.com,linux-can@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maoyixietju@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 324D068CB1A

Hi all,

I was going over the USB CAN drivers that use URB_FREE_BUFFER after the lan78=
xx
double-free fix, and I think peak_usb_start() in
drivers/net/can/usb/peak_usb/pcan_usb_core.c can free an RX transfer buffer
twice on the usb_submit_urb() error path. I am not totally sure, so I would
appreciate it if you could let me know whether you see this as a real problem.

This is the relevant part of the RX URB loop in 7.1-rc7.

	buf =3D kmalloc(dev->adapter->rx_buffer_size, GFP_KERNEL);
	...
	usb_fill_bulk_urb(urb, dev->udev,
		usb_rcvbulkpipe(dev->udev, dev->ep_msg_in),
		buf, dev->adapter->rx_buffer_size,
		peak_usb_read_bulk_callback, dev);

	/* ask last usb_free_urb() to also kfree() transfer_buffer */
	urb->transfer_flags |=3D URB_FREE_BUFFER;
	usb_anchor_urb(urb, &dev->rx_submitted);

	err =3D usb_submit_urb(urb, GFP_KERNEL);
	if (err) {
		if (err =3D=3D -ENODEV)
			netif_device_detach(dev->netdev);

		usb_unanchor_urb(urb);
		kfree(buf);
		usb_free_urb(urb);
		break;
	}

URB_FREE_BUFFER is set on the URB before submit, so buf belongs to the URB. W=
hen
the URB is finally destroyed, urb_destroy() frees that buffer for us with

	if (urb->transfer_flags & URB_FREE_BUFFER)
		kfree(urb->transfer_buffer);

So in the error path kfree(buf) frees the buffer once, and then usb_free_urb(=
urb)
frees the same buffer a second time through urb_destroy(). That looks like a
double free of the kmalloc'd RX buffer.

The error path is taken when usb_submit_urb() returns non-zero, e.g. -ENODEV =
if
the device is removed while the CAN interface is being brought up (ip link set
canX up), or -ENOMEM / endpoint errors. A device that disconnects at the wrong
moment, or otherwise makes the submit fail, would hit it.

I do not have a PCAN-USB adapter, so I reproduced just the buffer handling on
7.1-rc7 under KASAN. A small harness replays the exact sequence above
(URB_FREE_BUFFER set, then kfree(buf), then usb_free_urb(urb)), and KASAN rep=
orts
the second free.

  BUG: KASAN: double-free in usb_free_urb.part.0+0x91/0xb0
  Free of addr ffff8881069ccb80 by task trigger.sh/285
   kfree+0x113/0x3c0
   usb_free_urb.part.0+0x91/0xb0          <- second free, via urb_destroy()
  ...
  Freed by task 285:
   kfree+0x137/0x3c0                       <- first free, the explicit kfree(=
buf)
  ...
  The buggy address belongs to the object at ffff8881069ccb80
   which belongs to the cache kmalloc-64 of size 64

(The harness allocates a 64-byte buffer, which is why KASAN shows kmalloc-64,
while the real driver allocates dev->adapter->rx_buffer_size.) The first free=
 is
the explicit kfree(buf), and the second is usb_free_urb() going through
urb_destroy() and freeing urb->transfer_buffer because URB_FREE_BUFFER is set.

The smallest fix I could see is to drop the redundant kfree(buf), since
usb_free_urb() already releases the buffer. This is what commit 03819abbeb11
("net: usb: lan78xx: Fix double free issue with interrupt buffer allocation")
did for the same pattern.

	 		usb_unanchor_urb(urb);
	-		kfree(buf);
	 		usb_free_urb(urb);
	 		break;

With that one-line change the same harness frees the buffer exactly once and =
the
KASAN report is gone.

It looks like this has been there since the driver was first merged
(bb4785551f64), so if it is a real bug it would be a stable candidate.

I would appreciate it if you could let me know whether you agree this is a re=
al
double free and whether dropping the kfree(buf) is the right fix. I am happy =
to
send a proper patch with the reproducer once you confirm.

Thanks,
Maoyi
https://maoyixie.com/

