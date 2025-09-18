Return-Path: <linux-can+bounces-4736-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4D3AB83A94
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 11:02:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 601E7540C90
	for <lists+linux-can@lfdr.de>; Thu, 18 Sep 2025 09:02:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 858612FFDE9;
	Thu, 18 Sep 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vI+C1g/e"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E382FFDD7;
	Thu, 18 Sep 2025 09:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758186112; cv=none; b=BhyZ85cfQopH+2782+Kz6CFzfEwo/6Vx6sV+7dfgjTOy8JVELMUtwJhxoXJLpaej6PexfkobrarIe7F9Svu83m0UyfbtEnrEZWNgYrrM3UBUN53CyZsXhXYDuQ6VA6HLt+kJt5g5YBgjJWiav8hSAC3Whwm5GF9xeOZtDAz2lrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758186112; c=relaxed/simple;
	bh=2ojWim0st4lnA2XgT/Qg56HLdpsIlwLb6NH17RfD91E=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=IaoPJByFUtqKE4Rw4pI9uMfjIswQhIf8dg/ezn2TOJW5EQkrh/NoHmy3D+/IFa7kjfXxRVknIf2LCqrvPttM7Vw3z50PNpk4BdyQAKaM3b/qk8rxi9VKit6OpPyqZSytKOVu+LnOrmpvuirHHhOKHjf/iOGh/Ti52AkRnmm2O1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vI+C1g/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1676C4CEF7;
	Thu, 18 Sep 2025 09:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758186112;
	bh=2ojWim0st4lnA2XgT/Qg56HLdpsIlwLb6NH17RfD91E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=vI+C1g/e4EQ9UYWBlg8FNogeSAxF7IsqrjbIKlefff7UPE4VZhL7IunkvHKKmbL4S
	 fPZ4gxz+MnlsDX3NMkowkdB4msN+2IeSRVzSlagISr8bHzteyIYgqjsEfeJtc81fvA
	 SI8mQ9/i/kRAHEuO+3uZ/l8SxohvfpXrwG6iKi90Oi7JZKUCjkLfqOEaLeIHq9wDGJ
	 d9x4MABSIRXimIt0sATWTcMkox6L5RNZp1mPQvWXdivpdHpPlqFWbtp860oQJ2yyOV
	 r6zFw+Q/3glj/XBfJQfjUu2k7h+UOXfgtdFLw3qsLAh1LVc52g+k1YshRtpEfI83ru
	 W6Jky67iqsEDQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Thu, 18 Sep 2025 18:00:25 +0900
Subject: [PATCH 2/4] can: hi311x: populate ndo_change_mtu() to prevent
 buffer overflow
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250918-can-fix-mtu-v1-2-0d1cada9393b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2644; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=2ojWim0st4lnA2XgT/Qg56HLdpsIlwLb6NH17RfD91E=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmnTxW8SLihku7eY1d3/cZPkdrHCZ6R/1fwzJvSmexu0
 T49/hFHRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIlIejEyXFkuX7Ft50TvzoDn
 BmZ/K3dFFP1MU0+Vbj3zqUHWL2ZxMSPDF/FvzC/n8b1RMj+2Kvtmmopvff2kq3Ff16RX/z9iKyP
 EDQA=
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

And so, hi3110_hard_start_xmit() receives a CAN XL frame which it is
not able to correctly handle and will thus misinterpret it as a CAN
frame. The driver will consume frame->len as-is with no further
checks.

This can result in a buffer overflow later on in hi3110_hw_tx() on
this line:

	memcpy(buf + HI3110_FIFO_EXT_DATA_OFF,
	       frame->data, frame->len);

Here, frame->len corresponds to the flags field of the CAN XL frame.
In our previous example, we set canxl_frame->flags to 0xff. Because
the maximum expected length is 8, a buffer overflow of 247 bytes
occurs!

Populate net_device_ops->ndo_change_mtu() to ensure that the
interface's MTU can not be set to anything bigger than CAN_MTU. By
fixing the root cause, this prevents the buffer overflow.

Fixes: 57e83fb9b746 ("can: hi311x: Add Holt HI-311x CAN driver")
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/spi/hi311x.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/spi/hi311x.c b/drivers/net/can/spi/hi311x.c
index 09ae218315d73d49c2ec4280707911966fce1c31..6441ff3b4198718e8e662daa3022f06a2405f322 100644
--- a/drivers/net/can/spi/hi311x.c
+++ b/drivers/net/can/spi/hi311x.c
@@ -812,6 +812,7 @@ static const struct net_device_ops hi3110_netdev_ops = {
 	.ndo_open = hi3110_open,
 	.ndo_stop = hi3110_stop,
 	.ndo_start_xmit = hi3110_hard_start_xmit,
+	.ndo_change_mtu = can_change_mtu,
 };
 
 static const struct ethtool_ops hi3110_ethtool_ops = {

-- 
2.49.1


