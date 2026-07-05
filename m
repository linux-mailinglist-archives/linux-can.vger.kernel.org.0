Return-Path: <linux-can+bounces-7998-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uvZ8LaGsSWoY6AAAu9opvQ
	(envelope-from <linux-can+bounces-7998-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 05 Jul 2026 03:00:17 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 07447708BAC
	for <lists+linux-can@lfdr.de>; Sun, 05 Jul 2026 03:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=asu.edu header.s=google header.b=SvI9Ybfn;
	dmarc=pass (policy=none) header.from=asu.edu;
	spf=pass (mail.lfdr.de: domain of "linux-can+bounces-7998-lists+linux-can=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-can+bounces-7998-lists+linux-can=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AB7503010538
	for <lists+linux-can@lfdr.de>; Sun,  5 Jul 2026 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7EC1248F7C;
	Sun,  5 Jul 2026 01:00:14 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78D23156F45
	for <linux-can@vger.kernel.org>; Sun,  5 Jul 2026 01:00:13 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783213214; cv=none; b=Duo5aDs5cAcNJbqkNB5c201yBjsNDJorL2UGMaq0Kw0m+0mWJmpsz95XFHoL0EQ7VAd8NntPXMK/WMuWO+kKsJiMWqepXLoy6O2L6aw/Jg2QgSsJbHVPRwDG0xL6GbmgSpRFEgEpW6NfHnNsH2hi+ibsP1hT3LK77GTADRuQtt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783213214; c=relaxed/simple;
	bh=bRoUx8uvgmHPpou7BkbTeey9airBDwmCrEgNhuWihos=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bN+bAYsiqaYN14+OQ8A6GiD8gmcuCbcYR6VsLf1mu88BXoKbOzyqadmrfywnzZ2yAs3Tz6IARXdDSI2BTeZRk7NvQ3B7riXkUoeKU/RQYjNTohkP/GNvO8wSkl+HSbicA6oX2DqOw+kt7kw5VsDLNirWXCwloS/qyadyZ3NDFS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=SvI9Ybfn; arc=none smtp.client-ip=209.85.216.53
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-38125cebfdaso2371595a91.1
        for <linux-can@vger.kernel.org>; Sat, 04 Jul 2026 18:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1783213213; x=1783818013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=2YJE9MwGUIgRw/PQ+kRk/b+3w1sogxE5hANdxAI8L2k=;
        b=SvI9YbfnUeggRXQrODXoH7P8op5Ubw5rrlxdCXPIY87D2oPq+KVQAYHrDdQbH6PtQ9
         yUc4QDSVOA8pqit90Ct6fu//DCdz6SjxHudXpSYG9g+rCnjcB9qy4IIeGKCK//XUk5d8
         zUVg+sHpqI4mUFRuZ76QkNcpBcLagYnnNgu1WU7ovyH83WD7K+0LqtWCmXK+E4GE3wjd
         a0fdAb/GZ3D9PHz4vicEByDbiF9CJCxuJqDzZPumWSIFKDzp3VvX7dF1/Ug9ctcVj9fx
         4XiAruhsi6bVt6L0IX91OLNuKlMg/04KS7FEiR96vb45FI7bjxeuNTAZUKiAqVRHm6Jk
         9ltQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783213213; x=1783818013;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2YJE9MwGUIgRw/PQ+kRk/b+3w1sogxE5hANdxAI8L2k=;
        b=ebWaSEjDVVByk4skFnVgWwVCfJUwsA5IlfvJClyiWGoBcrM89WKvwPaUC1+yY2iH54
         g9MqIxyBG4fIKkqbBpYth7W03k5ZlmSVs35MPVxcTfXX+Zl6fSre5hqO6P6gfziPXfRo
         LBXsc/K05sEat3mmoZEGg4sWlaQbg0oVePwsjlG1XeWNy0iI/v9K/gwLH2JCSCNK8BrA
         70teHS1BwMlCdxZCjhpaps3lOyxmVLngtk0StxYd8Ie5nWus4mBs7qWztHglQb/fnm6z
         0/YEKlEG23kJvbdD3nIGXjL9spGWCT74RAiMtt7GbF0ZocAvwjVqWQEXcPv4ANqCAtTA
         q4ag==
X-Gm-Message-State: AOJu0YxnXNMBy6zlcSKeoNjcJZ7uRZKU5efpOc3izXwgtS3CzLzOXQ0x
	BkaoepNVXlkJiWYERazYk9BNraupnAlu1hHzSgEJzKgN+IpsNxrANYh7GDe0qBMLoA==
X-Gm-Gg: AfdE7ckjhUiCaUQlJ/w8xZcb0NcGwCbf6dT6O3LQTx7OT+xiCJ/wCMOJdO4wW3XLHbP
	trR+nIYsSl2+hWFM26e2+Aqe1EmtUfBRyLG9T23+/KgMYzj/GSTpmaW+88J8fG+FxrosVjN+ydA
	KWpzW0cwzrCxzvLqLKgMlanWHZa+TpsUl4qtyQ0TjGZ/KjDpXvMx3yXaD6DQdrNFROXSBfUvW8a
	o1H/NnLYDrw2FJm2X5Po0JJswl7B+MdX8iooF8VFt/K4vL9ffFNACJYC+1Yjor7k4vQXQXozmkY
	3XcMBz528LeX3bn3TGiMoV3WkjVhA/3afKVzxB4s8MZGy8d8IfBDVfH6mPVPJiNJmBjOfSgjgBa
	hzrN2NkU/mAW0ctDEtgii8thhrVSt2MhBpc7gK+9hhMj0dTUsT1MIB+93ZMDCro7V3tlZ9/qfxE
	o=
X-Received: by 2002:a17:90b:5102:b0:384:a641:3fe with SMTP id 98e67ed59e1d1-384a6410c94mr2095092a91.21.1783213212675;
        Sat, 04 Jul 2026 18:00:12 -0700 (PDT)
Received: from p1.. ([172.56.105.186])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38127c12792sm2837682a91.5.2026.07.04.18.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Jul 2026 18:00:11 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Frank Jungclaus <frank.jungclaus@esd.eu>,
	socketcan@esd.eu,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wolfgang Grandegger <wg@grandegger.com>,
	"David S . Miller" <davem@davemloft.net>,
	Weiming Shi <bestswngs@gmail.com>,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] can: esd_usb: free_candev() after unlink_all_urbs() in disconnect
Date: Sat,  4 Jul 2026 18:00:05 -0700
Message-ID: <20260705010005.1169943-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[asu.edu,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asu.edu:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7998-lists,linux-can=lfdr.de];
	FREEMAIL_CC(0.00)[vger.kernel.org,grandegger.com,davemloft.net,gmail.com,asu.edu];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_SENDER(0.00)[xmei5@asu.edu,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:frank.jungclaus@esd.eu,m:socketcan@esd.eu,m:mkl@pengutronix.de,m:mailhol@kernel.org,m:linux-can@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:wg@grandegger.com,m:davem@davemloft.net,m:bestswngs@gmail.com,m:xmei5@asu.edu,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[xmei5@asu.edu,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	DKIM_TRACE(0.00)[asu.edu:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asu.edu:from_mime,asu.edu:email,asu.edu:mid,asu.edu:dkim,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 07447708BAC

Each channel's esd_usb_net_priv is the netdev private area (netdev_priv()),
so it lives inside the net_device that free_candev() frees. Its TX URBs are
anchored in priv->tx_submitted, i.e. in that same allocation.

esd_usb_disconnect() frees the channels first and only then calls
unlink_all_urbs() to kill the URBs:

	for (i = 0; i < dev->net_count; i++) {
		if (dev->nets[i]) {
			...
			free_candev(netdev);		/* frees priv */
		}
	}
	unlink_all_urbs(dev);			/* reads priv again */

unlink_all_urbs() re-walks dev->nets[i] and does
usb_kill_anchored_urbs(&priv->tx_submitted) on each priv, but priv was just
freed by free_candev(), so this reads and writes through freed memory. KASAN
reports a slab-use-after-free write on the anchor lock, and the fault on the
corrupted list then panics the kernel.

The shared RX URBs (anchored in dev->rx_submitted) have the same problem: their
completion handler esd_usb_read_bulk_callback() dereferences
dev->nets[msg->rx.net], which must still be alive when they are killed.

Fix by killing the URBs before freeing the channels. unlink_all_urbs() only
touches dev, dev->udev, dev->rxbuf[] and the still-live dev->nets[i], so it is
safe to run first.

  BUG: KASAN: slab-use-after-free in _raw_spin_lock_irq (include/linux/instrumented.h:112 ...)
  Write of size 4 at addr ffff888010568ca0 by task kworker/1:0/26
  Call Trace:
   _raw_spin_lock_irq (include/linux/instrumented.h:112 ...)
   usb_kill_anchored_urbs (include/linux/spinlock.h:372 drivers/usb/core/urb.c:818)
   esd_usb_disconnect (drivers/net/can/usb/esd_usb.c:786 drivers/net/can/usb/esd_usb.c:1396)
   usb_unbind_interface (drivers/usb/core/driver.c:458)
   device_release_driver_internal (drivers/base/dd.c:1349 drivers/base/dd.c:1372)
   bus_remove_device (drivers/base/bus.c:664)
   device_del (drivers/base/core.c:3961)
   usb_disable_device (drivers/usb/core/message.c:1478)
   usb_disconnect (drivers/usb/core/hub.c:2345)
   hub_event (drivers/usb/core/hub.c:5407 ...)
   process_one_work (kernel/workqueue.c:3322)
   worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
   kthread (kernel/kthread.c:436)
   ret_from_fork (kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)

  BUG: unable to handle page fault for address: ffffffffffffffd8
  Oops: Oops: 0002 [#1] SMP KASAN NOPTI
  RIP: 0010:usb_get_urb.part.0 (./include/asm/atomic.h:93 ...)
  Call Trace:
   usb_kill_anchored_urbs (drivers/usb/core/urb.c:819 drivers/usb/core/urb.c:823)
   esd_usb_disconnect (drivers/net/can/usb/esd_usb.c:786 drivers/net/can/usb/esd_usb.c:1396)
   ...
   hub_event (drivers/usb/core/hub.c:5407 ...)
   process_one_work (kernel/workqueue.c:3322)
   worker_thread (kernel/workqueue.c:3405 kernel/workqueue.c:3486)
   kthread (kernel/kthread.c:436)
   ret_from_fork (kernel/process.c:158)
   ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
  Kernel panic - not syncing: Fatal exception

Fixes: 96d8e90382dc ("can: Add driver for esd CAN-USB/2 device")
Reported-by: Weiming Shi <bestswngs@gmail.com>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/can/usb/esd_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/esd_usb.c b/drivers/net/can/usb/esd_usb.c
index d257440fa01f..34c0ca187283 100644
--- a/drivers/net/can/usb/esd_usb.c
+++ b/drivers/net/can/usb/esd_usb.c
@@ -1385,6 +1385,7 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 
 	if (dev) {
 		dev->in_usb_disconnect = 1;
+		unlink_all_urbs(dev);
 		for (i = 0; i < dev->net_count; i++) {
 			if (dev->nets[i]) {
 				netdev = dev->nets[i]->netdev;
@@ -1393,7 +1394,6 @@ static void esd_usb_disconnect(struct usb_interface *intf)
 				free_candev(netdev);
 			}
 		}
-		unlink_all_urbs(dev);
 		kfree(dev);
 	}
 }
-- 
2.43.0


