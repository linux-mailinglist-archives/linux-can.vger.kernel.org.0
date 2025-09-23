Return-Path: <linux-can+bounces-4837-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9ECB946FF
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 07:41:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A89FB4459FB
	for <lists+linux-can@lfdr.de>; Tue, 23 Sep 2025 05:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CB2530F550;
	Tue, 23 Sep 2025 05:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="anRqCqz3"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D3830DEAC;
	Tue, 23 Sep 2025 05:40:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758606052; cv=none; b=ayBJCb4qNMgIqzFnvyvlZ9LV7OYacCjGPbSIDI7nbi57KtCFgEt8mruO9n3+rZ4RWrN9/nRs3kpq4bD/lmY5HlzBCC9CNoKZPH4txxFD21rwM6yu77hYH7mUP/f4PWweCX2JgX+YkXg1vdmjlGulCVXZ8nfU5LIbeNTxqkCMWyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758606052; c=relaxed/simple;
	bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=azTjI+/fisjIh8Zj8PeFBENzK9RkMu+csyFIU6fYKd4YDOM73WGFUfGZO1hGPkxsICT4qoeeapJUeIfwbUWplCQpnRVG3u2gU6DuLH3rt0PWRpxkJP/+nWtM7C+NAcM05Nzt8pfcPOj0W6+RveZa7dEUSe+1jTdeGBS8eJtAty0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=anRqCqz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90F41C116D0;
	Tue, 23 Sep 2025 05:40:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758606051;
	bh=7GXiF2puI9MV0ynLrL3LnDqqLVjv4d6zMPfx4ftHtlY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=anRqCqz3ZJ2ewCRvBTJX1VFluKICSzMrNrTVtS2brmrZzoqLwpJajESY9YtQejWai
	 MXibgLwyAFBaVB3jm5vY84sxhi/2wxCaGLPJLt/peCBO9ONGtu6IEc3L/Gt363BXkt
	 mZ6mCmlDcKG6CBosyagdiB5KU7V+MvcMuse48ggGbT0RVIm7dEvWN9PrzLZppnDPUB
	 HpsZ2HIikU+CaANEunGKsINwAQ2dWyuG1NUUuknwZEb/A3d+4Mu+6jiWfIc5BkrrRh
	 J5yj9hGpiutCrTVe0H6cozd2rJp6kjIIpTldCZfQ4UFwwcmlXARFhiJEsLhN8kVjxR
	 AnS0cz2l/rdeg==
From: Vincent Mailhol <mailhol@kernel.org>
Date: Tue, 23 Sep 2025 14:39:38 +0900
Subject: [PATCH v3 03/20] can: netlink: document which symbols are FD
 specific
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250923-canxl-netlink-prep-v3-3-87a7684333f3@kernel.org>
References: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
In-Reply-To: <20250923-canxl-netlink-prep-v3-0-87a7684333f3@kernel.org>
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
 b=owGbwMvMwCV2McXO4Xp97WbG02pJDBmXjNYH/HftCbBzXsm7gLN7wev5UzhWc6T18j6q3MPRs
 uZ4jcStjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABORWs/wV2Qp+2UezYeaV6fc
 7XlRfP7gycw67oM2tbU8M8saDlbqSzH8U7JZ3uxx/kDrW5nZnVEN0Ts33Tx5ZFvae4NV/azyZjc
 v8gEA
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


