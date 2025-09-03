Return-Path: <linux-can+bounces-4442-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9526B4194A
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 55005188B791
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FAC62FA0DE;
	Wed,  3 Sep 2025 08:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="haaylu/V"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 360D42FA0DB;
	Wed,  3 Sep 2025 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889547; cv=none; b=mqO6TCdTDQOZYjGMHoG/CzGsBZtpOLIqPeb+LeeWO8U855HkYMO0dbsVaN45+zkQOyARdUod3F1QgXw8CkHaWS4qGO9i7oLarGZ/y2Nct+l6L0BXZt46xmps9dKeR+Ql/3viRJZf0pXKlbBrmKEORBt+FwLAbZOB83NgYhQZlco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889547; c=relaxed/simple;
	bh=WbFhdmHGiJMxSSdaa/G3rt+vK4xfLAmAV1f3xXUfhOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f2SpXPFtfQtktrGyEqsNt0vCzfutGgLf2lZm/212m8fpApD3x3vfEkJseNS0men5nzEjHYGPvp/QO3ZdzIdBu7+9auAex05C338FoQcl9tRsxBx7D3mfM80kdoSRaZHz1l2yOLYVGcBwwUv/Xri4Ba8gtzClqoq1pevRjl3DNGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=haaylu/V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1CB9EC4CEF1;
	Wed,  3 Sep 2025 08:52:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889546;
	bh=WbFhdmHGiJMxSSdaa/G3rt+vK4xfLAmAV1f3xXUfhOs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=haaylu/VU28sD/QWdBQfc9/mWNZmEtdL8XdTK2e/upmqS8q0C4JdDhxpUeBGXvLEc
	 +Rzo7PT2ZrtdDnDWag4TQx2yLGBacMSJb+WhTu6UcB2Hn7waTjRp/hvhnEGSl6CyBa
	 Yd9shlOvTLeGIbRiT0V3GVxOPPVtNhekhui4koCJfVW2AJ6gmj/xoZSLjPULd/bCT2
	 MnkAGQeBdgHSGA6maFrPaxClUp5qMf2tAY/AaswCk2DCokxitZf8caZ5+U8bTn4805
	 K1uH6mRT15Zj1xyOR5NST+6e/fGKmdJhCscUVG10FXtcAsJZqHU7roBOHEDKvXWXaC
	 tji2LPeU9ZXeA==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:16 +0900
Subject: [PATCH 17/21] can: netlink: add can_bitrate_const_fill_info()
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-17-904bd6037cd9@kernel.org>
References: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
In-Reply-To: <20250903-canxl-netlink-prep-v1-0-904bd6037cd9@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2111; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=WbFhdmHGiJMxSSdaa/G3rt+vK4xfLAmAV1f3xXUfhOs=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GBeI/PogrLfp/Pzfd//PZypqOnHV7WONicnbD39mO
 WTk3ThX31HKwiDGxSArpsiyrJyTW6Gj0Dvs0F9LmDmsTCBDGLg4BWAiR2YwMnydsnRptmkVq07H
 hKodkuekHaofqcUW7zojG1Ry86vIbHFGhvMXAhbvejTLyNp86oxA2cDS2eZb4rKi9+z167LjPpP
 cyA4A
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

Add can_bitrate_const_fill_info() to factorise the logic when filling
the bitrate constant information for Classical CAN and CAN FD. This
function will be reused later on for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 drivers/net/can/dev/netlink.c | 25 +++++++++++++++----------
 1 file changed, 15 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index cf9bf8eb1ae8e5c6b7910d8c9935cad73b78ef40..092031693ce9f55f2c396fc7de8336932f6f5516 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -569,6 +569,15 @@ static int can_bittiming_const_fill_info(struct sk_buff *skb,
 			sizeof(*bittiming_const), bittiming_const);
 }
 
+static int can_bitrate_const_fill_info(struct sk_buff *skb,
+				       int ifla_can_bitrate_const,
+				       const u32 *bitrate_const, unsigned int cnt)
+{
+	return bitrate_const &&
+		nla_put(skb, ifla_can_bitrate_const,
+			sizeof(*bitrate_const) * cnt, bitrate_const);
+}
+
 static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 {
 	struct nlattr *nest;
@@ -679,17 +688,13 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		      priv->termination_const_cnt,
 		      priv->termination_const))) ||
 
-	    (priv->bitrate_const &&
-	     nla_put(skb, IFLA_CAN_BITRATE_CONST,
-		     sizeof(*priv->bitrate_const) *
-		     priv->bitrate_const_cnt,
-		     priv->bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_BITRATE_CONST,
+					priv->bitrate_const,
+					priv->bitrate_const_cnt) ||
 
-	    (priv->fd.data_bitrate_const &&
-	     nla_put(skb, IFLA_CAN_DATA_BITRATE_CONST,
-		     sizeof(*priv->fd.data_bitrate_const) *
-		     priv->fd.data_bitrate_const_cnt,
-		     priv->fd.data_bitrate_const)) ||
+	    can_bitrate_const_fill_info(skb, IFLA_CAN_DATA_BITRATE_CONST,
+					priv->fd.data_bitrate_const,
+					priv->fd.data_bitrate_const_cnt) ||
 
 	    (nla_put(skb, IFLA_CAN_BITRATE_MAX,
 		     sizeof(priv->bitrate_max),

-- 
2.49.1


