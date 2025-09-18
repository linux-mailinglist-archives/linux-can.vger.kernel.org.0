Return-Path: <linux-can+bounces-4737-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0E7B83A97
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 11:02:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B93DF466EE7
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 09:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F4133002A2;
	Thu, 18 Sep 2025 09:01:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LykDXyf9"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86FD2FFFB8;
	Thu, 18 Sep 2025 09:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186115; cv=none; b=I6T0PHN4avfqjvqeLAx0+qpKfSolLThJCrzk705timqAQ5N4ebeUA2EwQNYPH2X65sQYQVMICHnkJKo9q9lGOtP2bS9UC8cQwRJOo9WcS2SkHicAxWXZ+hdF76qCv9uYhB53pIHriEsXor9TxROyUQBapAcgOTdeti2Z9GaTyL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186115; c=relaxed/simple;
	bh=mGSWa58npvsbMCZz/6vmp8p/XePk3TJBfYof7NGs8oU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uJYvb5huZkMXsN5QLA/tEdVR2dc52L6wIXxfvMOeFwoLco5q7PqNTwa3dXMV+LYZ/3a+xVURwOajMU34tIFHl72z+0h85SVA4fWaUa+Qvc4n07dUf/cUL1K6pSQrYMUCxu2hLei2CvexMZUcKq+o6eeCnPo3ih99HeJutpI3oNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LykDXyf9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F37C4CEE7;
	Thu, 18 Sep 2025 09:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758186114;
	bh=mGSWa58npvsbMCZz/6vmp8p/XePk3TJBfYof7NGs8oU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=LykDXyf9viuasSfBsno2kiu+GBRZ9k02IgoUx32ATpI36+DMYYge8IsVktJ9Y0hCh
	 itVkhBj/FxyvYIGA/ZC66LiXHhEY+BCGEcLOG6DriQ7pntaLTQzj4mT9MFxuXrdZWR
	 WTlQZ+3uh7vQZJciFKtbeaQAWg2Fj5Z3CKaHH9DV5J7ZDeO0BOJgzGqIQYA6AZVHbu
	 KWkWpLNsRJtCOKlUzhICLsYmMJPHWa2AvjT1JqQAK0x8A3ZI5V0GAdmzBzy5aAuZnR
	 Ms3juopOsxXJRCs9uV5hU1+6dquREhGtGXFRjkpIAe/5CmUGaA6xiBdTsK6cje+hEh
	 6JCP5JTck0aAw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Sep 2025 18:00:26 +0900
Subject: [PATCH 3/4] can: sun4i_can: populate ndo_change_mtu() to prevent
 buffer overflow
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-can-fix-mtu-v1-3-0d1cada9393b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2683; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=mGSWa58npvsbMCZz/6vmp8p/XePk3TJBfYof7NGs8oU=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmnTxWZTgw4VM999eMKhiW/mgPzTVdd92X5/OeGtJvF4
 gvHcjqud5SyMIhxMciKKbIsK+fkVugo9A479NcSZg4rE8gQBi5OAZjIfQZGhv9126JX8G42aY3J
 mbiI+0nZJbvFB699Tqvivdr3J7Ca8z8jwwTdeWUXmvIuqQQHsiS6Km2sXf3IRa/fUMf80IctX55
 PZwEA
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Sending an PF_PACKET allows to bypass the CAN framework logic and to
directly reach the xmit() function of a CAN driver. The only check
which is performed by the PF_PACKET framework is to make sure that
skb->len fits the interface's MTU.

Unfortunately, because the sun4i_can driver does not populate its
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

And so, sun4ican_start_xmit() receives a CAN XL frame which it is not
able to correctly handle and will thus misinterpret it as a CAN frame.

This can result in a buffer overflow. The driver will consume cf->len
as-is with no further checks on this line:

	dlc = cf->len;

Here, cf->len corresponds to the flags field of the CAN XL frame. In
our previous example, we set canxl_frame->flags to 0xff. Because the
maximum expected length is 8, a buffer overflow of 247 bytes occurs a
couple line below when doing:

	for (i = 0; i < dlc; i++)
		writel(cf->data[i], priv->base + (dreg + i * 4));

Populate net_device_ops->ndo_change_mtu() to ensure that the
interface's MTU can not be set to anything bigger than CAN_MTU. By
fixing the root cause, this prevents the buffer overflow.

Fixes: 0738eff14d81 ("can: Allwinner A10/A20 CAN Controller support - Kernel module")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/sun4i_can.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/sun4i_can.c b/drivers/net/can/sun4i_can.c
index 6fcb301ef611d0c8bdb8720aaa77dc78950123d6..53bfd873de9bdecaf6923049007f9efd71289dd3 100644
--- a/drivers/net/can/sun4i_can.c
+++ b/drivers/net/can/sun4i_can.c
@@ -768,6 +768,7 @@ static const struct net_device_ops sun4ican_netdev_ops = {
 	.ndo_open = sun4ican_open,
 	.ndo_stop = sun4ican_close,
 	.ndo_start_xmit = sun4ican_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops sun4ican_ethtool_ops = {

-- 
2.49.1


