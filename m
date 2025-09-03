Return-Path: <linux-can+bounces-4428-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 094E9B41929
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 10:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42BB668268E
	for <lists+linux-can@lfdr.de>; Wed,  3 Sep 2025 08:52:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29322EDD5E;
	Wed,  3 Sep 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eExnSCPS"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AEFF2ED872;
	Wed,  3 Sep 2025 08:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756889524; cv=none; b=H08PNv/NrC+eGemXAqmy/GsWB2q2na3crR2AI76mxkm4uwN+YyW+KXeCQzXD07dN8YbDZ0+c2Hwc7MygS4/Y8K0Rve/LjfWOA01c6lOn6O6106FWqQEY/HAFOpwD06sDr1rcM7nViSP4RnMBt6S3b5uOi7tgpfIhgDyb+PTWLTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756889524; c=relaxed/simple;
	bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=k1HeTRonQFYBE8qfDZWJ3r+Zf1+DVflc9u2/APTViftECoBhuK+lKZp1yTLL0W8VV4r7DEBrCRfU6R4Y/iHZA+c/2zqfSrlYj1O7k3D/oA99NMaWQ9YhwTc+TVHLdtdyAQmQ6VgaQ+Ehuh9sZ+8P9QZPJuT+hbt4ASBCkFPgjJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eExnSCPS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAFF9C4CEF7;
	Wed,  3 Sep 2025 08:52:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756889524;
	bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=eExnSCPS8E7604a8VyaZRFqnxeBnFkum0U3zluEyMBdUAcXIXxkHDoIPyzzjiPlUV
	 NkoRKZv7s7VlrCSRMrCgdiM9Scx8J3HU7mYEIuzGzSN8IntrAUXV9zXzGhtE7UxjMZ
	 QBxGu+QY5aay14czh3Qk6i8kbdTV/ChwpbK5HVJJH3AduyNcQxQTQKsPVLe3pJ3Ypc
	 kR9oRaTSMDLcZVJykGxzW/Aj/zyycOwQWNdgsEOs2YScf+Oe2Zq8GhBbP5xLPK9O3v
	 YAfrl2yejPCyQA2HUXwc6XV/QjYurMG17aczEgzgU9NSYyhSl2PW1jQm2JeTGRQlcR
	 Il+EiZZPed7Gw==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Wed, 03 Sep 2025 17:50:02 +0900
Subject: [PATCH 03/21] can: netlink: document which symbols are FD specific
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250903-canxl-netlink-prep-v1-3-904bd6037cd9@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2346; i=mailhol@kernel.org;
 h=from:subject:message-id; bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBk7GCvjV2s6Xnj96GDskbRYnmWiclJeVqeEMmrvx5xvu
 N9w879yRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInMWsnIMPHSlVundgmyneNZ
 5KC25/STOafb9r1ZF7L0iZ5lbf3PiE2MDLuFVyYU2SvW/nW7UWyWOUfQ+u6Wf6Gtj2L0JjC3eyT
 8YwAA
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


