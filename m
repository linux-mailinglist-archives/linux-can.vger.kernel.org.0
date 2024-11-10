Return-Path: <linux-can+bounces-1937-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4751C9C33BA
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C9651B20B88
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:04:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95003A8F7;
	Sun, 10 Nov 2024 16:04:29 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE274C3D0
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 16:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254669; cv=none; b=UuNtpidbjwHfADuNtTXkcbfnsIRFR30VAW6/q/LGU4C+44ZcNkebVzNGjimbMiy8bO0Ut8OLFD/JewVQcHfcq00rbr6mtEYmdYvlaw1G8bI6tnkWO9n65O576BtVH/gh+N0VuCsmv7IOMX+2RqiDsbkUyu4zgaCrJqW3ytjaO4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254669; c=relaxed/simple;
	bh=CqX8n0Owsum0Z1B7EszPVdIZX9NJI0hya+W5DpJXGW4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UvbmXt5aV0u49HzkzS+3vl8/FPCDlnR7WVdvbwDMRNsbNdGcyk6Uze14nxjSxJGl3X/Rd3qmhDiahzC3wddtgu4AYV+iMyGPsohcBXE2be1CTJzzFyynGIO2L1c8du57rGvg98ymi6vmfrxN8dxFg8Ancr3BRnUBh1vgHtG5CuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-71e592d7f6eso2797300b3a.3
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 08:04:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254667; x=1731859467;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YMmHsILc9wSuxIC3v3+L5VLMJNAlIR2dNPQT7/A1vY4=;
        b=SN0q/2N5YfBXmoJmVkHNWuAhX/vJrmI6TOU/B0zV9DRLXLhs3uAKzc6e90g5TACLU0
         irVaReDH1R5DD6mrVbEeJVyf/AQRObuj6RJKM/um789j04J0OSP50T0GxHO8KfmBYCYE
         dhM9okt9jrGa0SkuwcywKokQaHP6mo2BD2VdlswQ1UhX6pYHLdW7BvcVLi6TQGpDlOLL
         +oX+EQTP+170sUaO6Ep5Qwq4jZCQhe63bd+wyh1V5017EhQdh0nOjXPx3ATaH4jSbLcZ
         exivnKTv8sjREwEio6nu3k9Wnkk0DCS3nnLBO3HwwT0lhWhEtR8gRlTYXQcmLAZdWW4G
         Xpdw==
X-Gm-Message-State: AOJu0Yziqtm513bOFBK7gEckNY1jK41V1ImnkOaLtZVzRbHDk8U33kta
	C6lpl0oEAz4txiVjiqlqR9G5I+n3YB349PXQln/riHs+Y47o2qzxHYVzXg==
X-Google-Smtp-Source: AGHT+IGnKUcdoOwoZsA3MTl7YmAt4do4dZBwSs0KuviScrrD7ueEiK0BIJM2KdWPsV1k+Oj2/JeZgQ==
X-Received: by 2002:a05:6a20:7344:b0:1d2:eb91:c0c1 with SMTP id adf61e73a8af0-1dc22b38ac0mr13578089637.42.1731254667215;
        Sun, 10 Nov 2024 08:04:27 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078a48cbsm7383037b3a.45.2024.11.10.08.04.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 08:04:26 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 2/8] !!! DO NOT MERGE !!! can: netlink: update headers
Date: Mon, 11 Nov 2024 01:01:32 +0900
Message-ID: <20241110160406.73584-12-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
References: <20241110160406.73584-10-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2442; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=CqX8n0Owsum0Z1B7EszPVdIZX9NJI0hya+W5DpJXGW4=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN8uv/F5wxvWu7v+rNfGz13hOrlj2chH/a7OwJUaTT y+/er/JuaOUhUGMi0FWTJFlWTknt0JHoXfYob+WMHNYmUCGMHBxCsBEKnUYGbZN/pOh9crY1Prn 76h7T5sDPrUxzmm79nyjRsLSOP50nxsM/wz2Tn+62uYCR8+His/VrvX/L4n3bmm8uYQ7Z4f9IT2 9T6wA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Add the CAN XL definitions in the linux/can/netlink.h uapi
header. Normally those are pulled automatically from net-next. But
because the CAN XL series is still an RFC, this patch is added as a
convinience so that you do not have to do the copy yourself.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/uapi/linux/can/netlink.h | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 8ec98c21..8edbfa20 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -101,8 +101,11 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_PRESUME_ACK	0x40	/* Ignore missing CAN ACKs */
 #define CAN_CTRLMODE_FD_NON_ISO		0x80	/* CAN FD in non-ISO mode */
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
-#define CAN_CTRLMODE_TDC_AUTO		0x200	/* CAN transiver automatically calculates TDCV */
-#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* TDCV is manually set up by user */
+#define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
+#define CAN_CTRLMODE_XL_TDC_AUTO	0x200	/* XL transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_XL_TDC_MANUAL	0x400	/* XL TDCV is manually set up by user */
 
 /*
  * CAN device statistics
@@ -129,15 +132,19 @@ enum {
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
+	IFLA_CAN_XL_DATA_BITTIMING,
+	IFLA_CAN_XL_DATA_BITTIMING_CONST,
+	IFLA_CAN_XL_DATA_BITRATE_CONST,
+	IFLA_CAN_XL_TDC,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
@@ -145,7 +152,7 @@ enum {
 };
 
 /*
- * CAN FD Transmitter Delay Compensation (TDC)
+ * CAN FD/XL Transmitter Delay Compensation (TDC)
  *
  * Please refer to struct can_tdc_const and can_tdc in
  * include/linux/can/bittiming.h for further details.
-- 
2.45.2


