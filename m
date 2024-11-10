Return-Path: <linux-can+bounces-1932-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 792219C33AF
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10A27B20A81
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986D722619;
	Sun, 10 Nov 2024 15:59:51 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 399044CDEC
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254391; cv=none; b=P9hqaWEPwdbXIJM0DnwLGVnfqacSJjoY/6lFb9LTSgSylS2mD6+aFLsxkE5UeRUYYBlAva5NjegfYDBA3EYOvlkMfrU/3q/zG7vp185LxJ++OD1UCsKz+Je/IvDjhuCpu5mtOgIQhgUyVeHY3unBRTBUBIoCiDhf6VxM3cFVenY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254391; c=relaxed/simple;
	bh=tTN74wsThEiZ8MDaA0tCqSgruy8bJA8SbII0rmFGB7A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FXjTYgGTIgHTd+1Tnn1DfqF0dwBp9xRf/GRojmiMNuaLWdKSlNstohMkd5voWG+hFEe+p8AKD7fGyteZfQKG6vL8u4Ya6SfW2xbxZsI1nt3tG+2AM+LbYY1BfrarOEifW2SgvEmiagDxpXl0DiwjxbZQ9IYU4KKwTGe9SeZu3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7205b6f51f3so2960868b3a.1
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254389; x=1731859189;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0mJXf+Gr/5+37UbY45YPnBQRii3iH0C16W5YHaUxwss=;
        b=ACcZHVaq+rnTIJO4RehvSwty2+rmUMrvzC3loS0UtumCQZMOpyhuF+hwzEc2/SYmBW
         Y378UEXcfe+CXWry2cInzG9m4Ebb7d6PZiK5ey9RwziqJ4GQjFXGjNc+amhybuZVNskq
         HwFS22Z0LbyTmIGwJdXIfUBKeArSIOMr6qfDgV/+PtTA/5iGT5GXe8HW8UfIoV2ENWzN
         5xqT/GQCL4VBZ5SC4vEJapN7K9EgqUpqgYHcCbV9p8LPTBPHH1cZXXEuEyYAYPnHt6Bk
         e9NtbGHPygukN6vFu5PxQlW0EGDNJQXsrqjTkyXutZXJYapFQkqZmFRjIiBXoZrZ9KDN
         hoLw==
X-Gm-Message-State: AOJu0Yy1sZBNEJ+CTcueCgs8fuqmgsokAabjB2S/3qk5jNgNchHA4wpe
	EkCOenwkyWviGqbVuKqQhEPH+doSHdKWmP79AsTw3Xmn+JwTOMfLfCVmmQ==
X-Google-Smtp-Source: AGHT+IE4uDPbRslYZ7Ynzagrg22nRwnvb+KJ5B/dx6db+Q91rRdyuuhNtEkP8E6qc8yPIouCoD+rCQ==
X-Received: by 2002:a05:6a00:845:b0:71e:98a:b6b4 with SMTP id d2e1a72fcca58-724132c26e7mr13115001b3a.11.1731254389265;
        Sun, 10 Nov 2024 07:59:49 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:48 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 11/14] can: netlink: document which symbols are FD specific
Date: Mon, 11 Nov 2024 00:56:00 +0900
Message-ID: <20241110155902.72807-27-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2296; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=tTN74wsThEiZ8MDaA0tCqSgruy8bJA8SbII0rmFGB7A=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN4JKdh89uy83Leh6wKtvwWUnFLtulQUxHqquY7PVe fo/lOFBRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgIms1GP4H9LQmbZCNPetZYuC pU2GqMbj2+Fmwgd+O1YIXXq9z0tMiOGveMXplUp7kldW2s57yxqmKitwd9HCn6/dWe77NXJ4n2f hBAA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The CAN XL netlink interface will also have data bitrate and TDC
parameters. The current FD parameters do not have a prefix in their
names to differentiate them.

Because the netlink interface is part of the UAPI, it is unfortunately
not feasible to rename the existing symbols to add an FD_ prefix. The
best alternative is to add a comment for each of the symbols to notify
the reader of which parts are CAN FD specific.

While at it, fix a typo: transiver -> transceiver.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 include/uapi/linux/can/netlink.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index 02ec32d69474..ef62f56eaaef 100644
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
2.45.2


