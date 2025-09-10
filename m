Return-Path: <linux-can+bounces-4602-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EB6D9B50DAC
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 08:05:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 205351892EC1
	for <lists+linux-can@lfdr.de>; Wed, 10 Sep 2025 06:05:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D3D306493;
	Wed, 10 Sep 2025 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gkTPQIDh"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 696FF3043DD;
	Wed, 10 Sep 2025 06:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757484291; cv=none; b=sQ1ICq6cRb4j/vaBYCT+69qzfZl9KF1zLa9aAx2Aoy7jsnbG2+ogxOdOvdzUYEEnJ+SGbQozpg0V80fPFsmk6ezvTbnZ6YZFqlUqg8SPNHNnFA8QAJCg9MO+hsIoFCXvFGG3EsJlw6va5w/vZw8udiwsTgqcWw7MlLWYOoN9mq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757484291; c=relaxed/simple;
	bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EeYEmZ7bMC/sNucV3lypoq4LSq1TBygxnu1W3N5QQjZug6CGB/4e1bjp/Oj8gw9c6XzUAyoVt73+uDNoOCqLHuCd1p+TVY4Iibwq7kDX4c4nTsbeRSKB9CdHmUXza+H6mAEYgTklpU+ZmQXdzwa+M4uGszVI2hKW6Pl6YUQgmYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gkTPQIDh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C510FC4CEF0;
	Wed, 10 Sep 2025 06:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757484291;
	bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=gkTPQIDh1QYX1IPJoBmisdwaDn3U+FtfwJrFeI0Ww/nVrkFJZdObH155gXHG9hb7f
	 MtqjsOd2z1Heo+b89Wl+DD5S+6s3XNPNPfbz51FHd5PF9XmYT2to+dbSPjwSswtR45
	 iwIwBbGv64VajOWc5AVwn6LSTkN4Gf+/4Lz+jSFtW0KQ/MjQjP8jVQhUNmwZbW3TqV
	 0gvVBfGBK/wxnbCVsPv/5d/dgBX+RwKyg8p5ldlTJewZgTMzJ9ySA+FBiNWM6lQ2pu
	 XmKO0kPnpimMUcRq6z3jkqNCfYIbDalndBflaq7Pq9j/rW8U7EgS3x6YdzdYCtmS1h
	 a0AsDiUa8cLxw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 10 Sep 2025 15:03:28 +0900
Subject: [PATCH v2 03/20] can: netlink: document which symbols are FD
 specific
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250910-canxl-netlink-prep-v2-3-f128d4083721@kernel.org>
References: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
In-Reply-To: <20250910-canxl-netlink-prep-v2-0-f128d4083721@kernel.org>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Vincent Mailhol <mailhol@kernel.org>, 
 =?utf-8?q?St=C3=A9phane_Grosjean?= <stephane.grosjean@hms-networks.com>, 
 Robert Nawrath <mbro1689@gmail.com>, Minh Le <minh.le.aj@renesas.com>, 
 Duy Nguyen <duy.nguyen.rh@renesas.com>, linux-can@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2346; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBkHRc4JxbioT3Y+ZFBfkGg5/Y8GX2pA3kJn9ebfnF93V
 5nLrr3aUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCK5+owMH63XbVzI41Fili/f
 c0fzeaJlHXNX8kSDnYd1V9YtyHZ4z8jwZvLtzF9H1q25kr9l2rrCwIW3fsUKe77htbz88Lb3lem
 7eAE=
X-Developer-Key: i=mailhol@kernel.org; a=openpgp;
 fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2

The CAN XL netlink interface will also have data bitrate and TDC
parameters. The current FD parameters do not have a prefix in their
names to differentiate them.

Because the netlink interface is part of the UAPI, it is unfortunately
not feasible to rename the existing symbols to add an FD_ prefix. The
best alternative is to add a comment for each of the symbols to notify
the reader of which parts are CAN FD specific.

While at it, fix a typo: transiver -> transceiver.

Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
---
 include/uapi/linux/can/netlink.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 02ec32d694742a32b3a51ff8c33616e109cef9f4..ef62f56eaaefda9f2fb39345776a483734682cd0 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -101,8 +101,8 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
-#define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
-#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
+#define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
 
 /*
  * CAN device statistics
@@ -129,14 +129,14 @@ enum {
 	IFLA_CAN_RESTART_MS,
 	IFLA_CAN_RESTART,
 	IFLA_CAN_BERR_COUNTER,
-	IFLA_CAN_DATA_BITTIMING,
-	IFLA_CAN_DATA_BITTIMING_CONST,
+	IFLA_CAN_DATA_BITTIMING, /* FD */
+	IFLA_CAN_DATA_BITTIMING_CONST, /* FD */
 	IFLA_CAN_TERMINATION,
 	IFLA_CAN_TERMINATION_CONST,
 	IFLA_CAN_BITRATE_CONST,
-	IFLA_CAN_DATA_BITRATE_CONST,
+	IFLA_CAN_DATA_BITRATE_CONST, /* FD */
 	IFLA_CAN_BITRATE_MAX,
-	IFLA_CAN_TDC,
+	IFLA_CAN_TDC, /* FD */
 	IFLA_CAN_CTRLMODE_EXT,
 
 	/* add new constants above here */
@@ -145,7 +145,7 @@ enum {
 };
 
 /*
- * CAN FD Transmitter Delay Compensation (TDC)
+ * CAN FD/XL Transmitter Delay Compensation (TDC)
  *
  * Please refer to struct can_tdc_const and can_tdc in
  * include/linux/can/bittiming.h for further details.

-- 
2.49.1


