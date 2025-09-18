Return-Path: <linux-can+bounces-4738-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0683BB83A9A
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 11:02:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AADF71C06A1E
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 09:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6256301000;
	Thu, 18 Sep 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GxoH68x7"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8683002C4;
	Thu, 18 Sep 2025 09:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186117; cv=none; b=ZD6FHIGPyncvDfugzh9bnHvzJkWRZzqS3KIyz9Cwf2mqPyeDC1o36ly9FEQhlcUsxB07vn0fhS6AYopAkNhVdGJ0GdJTadfG267MBvAjBmjvDxuhV/RtqZcPcI3lxvwOiC+SIeG41hC/buKq+fQ72yaHCGy17uwKTY8MG+blmB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186117; c=relaxed/simple;
	bh=jwRTUoN54HeyKKOV4Dj4gsSdmsvGsDnd8DlVRGDSbDU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=unOPKE0FOUs3O1KRHCha4ReKxS2JJUcoxN+VpplYQwcthrQMYvPzW/59gJdDrjaWh9d84gkvcudS7sk99ZaqekI0P+VnWVYYSB1xDJz7fBTLQ5WRhmcZh3FKbGMOITOPs5eZnSeyUI6BI47GkpSz5PO0FZ8bKu164Hz2vkjYfZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GxoH68x7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D35ECC4CEF0;
	Thu, 18 Sep 2025 09:01:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758186117;
	bh=jwRTUoN54HeyKKOV4Dj4gsSdmsvGsDnd8DlVRGDSbDU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=GxoH68x7hQHtLVtLVFaUYb+D7yUzMQAZLIcgN2NuzCvOueygHkFoCIZpYVskFiuxX
	 y1TATBou4FNIrB9zORxwf1WlGgQDx1qcA8PYE7mHvTFGHzVCicFJUwRQ+a2yCVmcvO
	 rM8g62VcDBWqaVYPddsMgb5LImWZa41OdSK5Y0rqFxnQ4DbfrQBkXJyQikO8/kUFEp
	 J9nM5mVxOGfBgnoghgHUUQdEXBs7MIiePFYyp53CuZVYCSEiXXaGD3RoP+Ki8t2Psg
	 bX/+R5//IRXVQRwAD9i/v2Uu9b2i7Usb6raiG+75yt5mpXFkU/ye8HASukUJ+zEtDf
	 RPELvjxDeOA6g==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Sep 2025 18:00:27 +0900
Subject: [PATCH 4/4] can: mcba_usb: populate ndo_change_mtu() to prevent
 buffer overflow
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-can-fix-mtu-v1-4-0d1cada9393b@kernel.org>
References: <20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org>
In-Reply-To: <20250918-can-fix-mtu-v1-0-0d1cada9393b@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Arunachalam Santhanam <arunachalam.santhanam@in.bosch.com>, 
 Akshay Bhat <akshay.bhat@timesys.com>, 
 Wolfgang Grandegger <wg@grandegger.com>, Chen-Yu Tsai <wens@csie.org>, 
 Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>, 
 Gerhard Bertelsmann <info@gerhard-bertelsmann.de>, 
 Yasushi SHOJI <yashi@spacecubics.com>, 
 =?utf-8?q?Remigiusz_Ko=C5=82=C5=82=C4=85taj?= <remigiusz.kollataj@mobica.com>, 
 linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2629; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=jwRTUoN54HeyKKOV4Dj4gsSdmsvGsDnd8DlVRGDSbDU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmnT5Wa/3W9fdJ1Pmfsm6Utj1ZGxk9zsm+6r7lgB+Pcm
 5eDojZs7ChlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjAR0WaG/wW/Ql+G9f/64zBv
 YUxp32L9bP/UrZ+OrlxjbPWX05p91n1Ghmdnr4fNte61cj9dc6HiXP0mz5MHYxaub63d7v08Qvr
 yE0YA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Sending an PF_PACKET allows to bypass the CAN framework logic and to
directly reach the xmit() function of a CAN driver. The only check
which is performed by the PF_PACKET framework is to make sure that
skb->len fits the interface's MTU.

Unfortunately, because the mcba_usb driver does not populate its
net_device_ops->ndo_change_mtu(), it is possible for an attacker to
configure an invalid MTU by doing, for example:

  $ ip link set can0 mtu 9999

After doing so, the attacker could open a PF_PACKET socket using the
ETH_P_CANXL protocol:

	socket(PF_PACKET, SOCK_RAW, htons(ETH_P_CANXL))

to inject a malicious CAN XL frames. For example:

	struct canxl_frame frame = {
		.flags = 0xff,
		.len = 2048,
	};

The CAN drivers' xmit() function are calling can_dev_dropped_skb() to
check that the skb is valid, unfortunately under above conditions, the
malicious packet is able to go through can_dev_dropped_skb() checks:

  1. the skb->protocol is set to ETH_P_CANXL which is valid (the
     function does not check the actual device capabilities).

  2. the length is a valid CAN XL length.

And so, mcba_usb_start_xmit() receives a CAN XL frame which it is not
able to correctly handle and will thus misinterpret it as a CAN frame.

This can result in a buffer overflow. The driver will consume cf->len
as-is with no further checks on these lines:

	usb_msg.dlc = cf->len;

	memcpy(usb_msg.data, cf->data, usb_msg.dlc);

Here, cf->len corresponds to the flags field of the CAN XL frame. In
our previous example, we set canxl_frame->flags to 0xff. Because the
maximum expected length is 8, a buffer overflow of 247 bytes occurs!

Populate net_device_ops->ndo_change_mtu() to ensure that the
interface's MTU can not be set to anything bigger than CAN_MTU. By
fixing the root cause, this prevents the buffer overflow.

Fixes: 51f3baad7de9 ("can: mcba_usb: Add support for Microchip CAN BUS Analyzer")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/usb/mcba_usb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/usb/mcba_usb.c b/drivers/net/can/usb/mcba_usb.c
index 41c0a1c399bf36104fbf8991b537acdb01e7e950..1f9b915094e64de875adff35026e9cd3beb0410d 100644
--- a/drivers/net/can/usb/mcba_usb.c
+++ b/drivers/net/can/usb/mcba_usb.c
@@ -761,6 +761,7 @@ static const struct net_device_ops mcba_netdev_ops = {
 	.ndo_open = mcba_usb_open,
 	.ndo_stop = mcba_usb_close,
 	.ndo_start_xmit = mcba_usb_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops mcba_ethtool_ops = {

-- 
2.49.1


