Return-Path: <linux-can+bounces-4735-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 06538B83A8B
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 11:02:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2C88623DFC
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 09:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E637C2F5495;
	Thu, 18 Sep 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kH+ibA9R"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3CB2F60DB;
	Thu, 18 Sep 2025 09:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186109; cv=none; b=qjp1h7sR+egoEbwz1MD4uTOo14U493OPyDExj76G8mEb/xRcckuocJ2cnArn+efMigrGhwXZCmcJ4y/w2p5hvZ7SAuSuQ5OUydSgmUCpIUPJZNCm+AjuREG5QrBQHBjNZIbS4swaeqxpYCm2kmH7AhK1eLN/GuF7FiwW8gxdV8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186109; c=relaxed/simple;
	bh=99bx0qqju2UEGVzQhTUbxA8T28JN+IzFGx/ISmPcSf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AYqO7DXrVnNYap4cc0EhfFX/YodLsBMBG+pxqpzEcWA3DG7ywJah1qQ2ox/qHgD3zhJU2aUduDya1RIGm89l82msm3y8TrkM0Xv7P4eUz8UeycIa1aWYVhd6TdQctm7m2hSmeO2/CDNqFl8YJHNJ8LrvzhxhCNpWY1J/KJN0kgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kH+ibA9R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25FDEC4CEFB;
	Thu, 18 Sep 2025 09:01:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758186109;
	bh=99bx0qqju2UEGVzQhTUbxA8T28JN+IzFGx/ISmPcSf4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=kH+ibA9RimkNjlWOzcnxzqAitYkbqRM5/CJfNWkcORvEWN9WrfPs8ShwdVZHY0ET3
	 DLo1QhJc6/oze4/74DjYNN8TRgrCK/l3COjFnV8n7+Cb0C76nbjjg5bLHij0GzSZ2h
	 3TzKGnZ4WY4B3caZ7HLMNfTyU7WWFBW+sgPjl4rbvLNu3hQ7JEyvZH3WeEu3UqQGUC
	 +lVV80yrpLw0iCThDxCePzELPZvmE9Qt7Qv1kzE1/HvHhjdShe+zyG+BCfqghLPFHg
	 kCnA4lxvwsVx2dBT2BfC2qB6iPC/ajxONhI0ZVxe0xS4pkQ+TxtzURGaqrSW9DlEEr
	 R0u3OoKCTs/pw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Sep 2025 18:00:24 +0900
Subject: [PATCH 1/4] can: etas_es58x: populate ndo_change_mtu() to prevent
 buffer overflow
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-can-fix-mtu-v1-1-0d1cada9393b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3267; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=99bx0qqju2UEGVzQhTUbxA8T28JN+IzFGx/ISmPcSf4=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmnT+U6it09XHjp1J2k1U/PXLpx2WKK4Pf+wt9vFizWt
 tKrNly6rKOUhUGMi0FWTJFlWTknt0JHoXfYob+WMHNYmUCGMHBxCsBEinsZ/keu99z6r3fH53Xz
 J7b6aCTJxvsI/W2Yd9en/DqfW7nGEWGG36xXD6w/bl9nMtfX9BXD1goJ7rAF0u+3Lwn/m6bGmn2
 cjQMA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Sending an PF_PACKET allows to bypass the CAN framework logic and to
directly reach the xmit() function of a CAN driver. The only check
which is performed by the PF_PACKET framework is to make sure that
skb->len fits the interface's MTU.

Unfortunately, because the etas_es58x driver does not populate its
net_device_ops->ndo_change_mtu(), it is possible for an attacker to
configure an invalid MTU by doing, for example:

  $ ip link set can0 mtu 9999

After doing so, the attacker could open a PF_PACKET socket using the
ETH_P_CANXL protocol:

	socket(PF_PACKET, SOCK_RAW, htons(ETH_P_CANXL));

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

And so, es58x_start_xmit() receives a CAN XL frame which it is not
able to correctly handle and will thus misinterpret it as a CAN(FD)
frame.

This can result in a buffer overflow. For example, using the es581.4
variant, the frame will be dispatched to es581_4_tx_can_msg(), go
through the last check at the beginning of this function:

	if (can_is_canfd_skb(skb))
		return -EMSGSIZE;

and reach this line:

	memcpy(tx_can_msg->data, cf->data, cf->len);

Here, cf->len corresponds to the flags field of the CAN XL frame. In
our previous example, we set canxl_frame->flags to 0xff. Because the
maximum expected length is 8, a buffer overflow of 247 bytes occurs!

Populate net_device_ops->ndo_change_mtu() to ensure that the
interface's MTU can not be set to anything bigger than CAN_MTU or
CANFD_MTU (depending on the device capabilities). By fixing the root
cause, this prevents the buffer overflow.

Fixes: 8537257874e9 ("can: etas_es58x: add core support for ETAS ES58X CAN USB interfaces")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/usb/etas_es58x/es58x_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_core.c b/drivers/net/can/usb/etas_es58x/es58x_core.c
index db1acf6d504cf37cec724d392c9f7fee2d1f6045..adc91873c083f968ff7571a5b0db5747988482c5 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_core.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_core.c
@@ -7,7 +7,7 @@
  *
  * Copyright (c) 2019 Robert Bosch Engineering and Business Solutions. All rights reserved.
  * Copyright (c) 2020 ETAS K.K.. All rights reserved.
- * Copyright (c) 2020-2022 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
+ * Copyright (c) 2020-2025 Vincent Mailhol <mailhol@kernel.org>
  */
 
 #include <linux/unaligned.h>
@@ -1977,6 +1977,7 @@ static const struct net_device_ops es58x_netdev_ops = {
 	.ndo_stop = es58x_stop,
 	.ndo_start_xmit = es58x_start_xmit,
 	.ndo_eth_ioctl = can_eth_ioctl_hwts,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops es58x_ethtool_ops = {

-- 
2.49.1


