Return-Path: <linux-can+bounces-4864-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC049B94A34
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 09:00:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5410F3A8F2B
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:00:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 100DB3101DF;
	Tue, 23 Sep 2025 06:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M4v5Qts+"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCB073101D2;
	Tue, 23 Sep 2025 06:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758610791; cv=none; b=rxnJPnfwJc6HIJiEyOOdph0Wj8Dbdpfmed5yKeqEG0pDuajBVsCP9kwl4o4SblZLBJquAOxKHK4hr1zIkilfRpJ7cgYuWqA54ZKoJlqBHw+As7BuqAP7vTgLhKVTFnjfo7GF7kbip3+u0eXWqn/ETm0swTmzHDT772t/khvTAdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758610791; c=relaxed/simple;
	bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UvhQ9iwVyY8WEl9xy0EcQtER5mItAEWgLB4ZBQD5QueR4doRVeBXN/oeJ2JzY7AtHRsqMfuDnMRmoaPYHgxNy3SLulKdQelA/IG4vm86KlxZZYO9HuXQMRgvZEwG/jKdVgBNopBSqUC2RzsTAyQgTjUlCb0jWtIKCzb611mh3+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M4v5Qts+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 390ADC4CEF5;
	Tue, 23 Sep 2025 06:59:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758610790;
	bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=M4v5Qts+s363PcvgMAoFtqu4lZiz4L6AUSXSQtUY/FVGfBuDcL9qTXf9SgMkYviCX
	 1maNSST3sVkPrQDR2qTjRkOGzrKBIkyombNEgUnQhPzApNvj1GeCbk2EftZ4xXJ4qq
	 /MumC3QWbdHeyZS9rnlzG/nQBHY6WIQGarizoIzx67sGPq0qvJ58aXPbJS7kX5gaJL
	 88wcRYIXRXgRvsG3BwexvqbkR8GLGkOlYbVJFszxjBSwwJInIICIiVNVv6QJRA8a5D
	 x14JUEg/gKqOSdXx2TQCt5trJ73GVgQj6USfCzT9Ppu939r/u279D1IWMco1FjLrDa
	 vHywonEQuDZtQ==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 15:58:28 +0900
Subject: [PATCH v4 03/20] can: netlink: document which symbols are FD
 specific
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v4-3-e720d28f66fe@kernel.org>
References: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v4-0-e720d28f66fe@kernel.org>
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
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXXLUfd3OnWbNaM7xfPfW2VeQN4w6nzUfFlA35Dlc08
 0l3CxR1lLIwiHExyIopsiwr5+RW6Cj0Djv01xJmDisTyBAGLk4BmMjuh4wM7yrZre++Mf+/Z2vl
 t9B7OXsNPpu5JuxmeDPJYtnKA4sORzH8d5lieU++JG/i9VMbRc5/tpw9+/P+pfcyDpzQ0Ds5izl
 gEj8A
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


