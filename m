Return-Path: <linux-can+bounces-1924-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BC59C33A7
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C7FED28164C
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B28D183CC7;
	Sun, 10 Nov 2024 15:59:36 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA2E4CDEC
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254376; cv=none; b=RDWc/JRfiGs6lizqCH020bQkewGplxlRZoG6slXFKZ2jPISPRpEBZks2RHLHJpGyhcNPV7kOXCS12tk/hUFK0nFeggoFFiRXj/Qq4I2giXDNp1iWLzVNQLCzw7uxo8RUYkTPPSZLs5gAjNjCf8DgU0DBMesUt3wX1fO4q0xD4vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254376; c=relaxed/simple;
	bh=rGQlHT/m68C3UfrBE/ikk7wol7f4uQPoJ3LHcF4oN6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNhDAC4H25bGXTIPNC7Vwlyg4duS4Nnb2tgXJKNlLxzUH7ZMi7T2T07GtTN/Gy/87BNgWjbQk/qOvTrOmrcc2A0Z343XbFRJqZgDy47Dv/R8UFZ/hA4UnkZFMcacQP7LRyzDLShor8PtGIKQLYJKIPd0L3l5YxETT/x8iPGn9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7240d93fffdso2924860b3a.2
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254374; x=1731859174;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+RqkB1sUMX6vJyOuUWxOILOufOiaTgQEU1WBlalnbE=;
        b=TF7LZdeiLR0mRAk2QK+FdRn6xQD6CjeKusVwZ0ZCIaitPsU6OwiwnIRTWcM9Qm15BL
         c8dSFximmR0vjsktNaFTupATgy2Pux8pAZD8cNUyHhfHwjQxLZPFEq/fM+L+5yOtcz6z
         h0N7zQeG5dTAnKLUfRNAkmvGWOqDyqznC+TQ984cBCfQkewP0hz5WmXPe39eU83UOXKI
         8Sm0MEIsG9fakbKWJdi9OZarQte2qaaCouXjo0bFhpnXUGKH0vDBkPDkkuB7p9w7zKe8
         mCbUKrgSfsL16St7bEgWC/2WQ7LqtJEmXc/GtiRWYykcjgM9rp4ITEczOpOZG5z9PCCc
         1wCw==
X-Gm-Message-State: AOJu0YyWBBkURNmfoMSXj0OrJvEYgVWv/OKcu+oINVxGcG8WO7EXsGBY
	C/JtmO1zAprTeQWwoTt7fPr+e3eoZJZ2BuQ80DAH3Se+P8w40NceFldaVQ==
X-Google-Smtp-Source: AGHT+IFV+1ZU5BywHCzHpqNv/oMf6gY47kZ4zdN4AyEnvdKQRJY7uarP9Y5tLXJyElJCCPNgthAVJg==
X-Received: by 2002:a05:6a00:84c:b0:71e:3b8:666b with SMTP id d2e1a72fcca58-724132c0dd7mr13590563b3a.15.1731254374028;
        Sun, 10 Nov 2024 07:59:34 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:33 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 03/14] can: bittiming: rename CAN_CTRLMODE_TDC_MASK into CAN_CTRLMODE_FD_TDC_MASK
Date: Mon, 11 Nov 2024 00:55:52 +0900
Message-ID: <20241110155902.72807-19-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3947; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=rGQlHT/m68C3UfrBE/ikk7wol7f4uQPoJ3LHcF4oN6o=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNwLu7Z/H83fNEoaa0A3/BH1DebkamQ1eVtlvK826/ uHI/TulHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZiI8HIcI3T/+ylT5M8VN5b r5i55UjF5RxrUW+HUKdH+mxLomXtgxj+u/t6+M5ubskUehgWr/j0xZx5VgJa/RNKzTrlj5rE8+s zAQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

With the introduction of CAN XL, a new CAN_CTRLMODE_XL_TDC_MASK will
be introduced later on. Because CAN_CTRLMODE_TDC_MASK is not part of
the uapi, rename it to CAN_CTRLMODE_FD_TDC_MASK to make it more
explicit that this mask is meant for CAN FD.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/calc_bittiming.c |  2 +-
 drivers/net/can/dev/netlink.c        | 12 ++++++------
 include/linux/can/bittiming.h        |  2 +-
 include/linux/can/dev.h              |  2 +-
 4 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/net/can/dev/calc_bittiming.c b/drivers/net/can/dev/calc_bittiming.c
index 3809c148fb88..a94bd67c670c 100644
--- a/drivers/net/can/dev/calc_bittiming.c
+++ b/drivers/net/can/dev/calc_bittiming.c
@@ -179,7 +179,7 @@ void can_calc_tdco(struct can_tdc *tdc, const struct can_tdc_const *tdc_const,
 	if (!tdc_const || !(ctrlmode_supported & CAN_CTRLMODE_TDC_AUTO))
 		return;
 
-	*ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
+	*ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 
 	/* As specified in ISO 11898-1 section 11.3.3 "Transmitter
 	 * delay compensation" (TDC) is only applicable if data BRP is
diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index df8b7ba68b6e..72a60e8186aa 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -67,12 +67,12 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		u32 tdc_flags = cm->flags & CAN_CTRLMODE_TDC_MASK;
+		u32 tdc_flags = cm->flags & CAN_CTRLMODE_FD_TDC_MASK;
 
 		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
 
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
-		if (tdc_flags == CAN_CTRLMODE_TDC_MASK)
+		if (tdc_flags == CAN_CTRLMODE_FD_TDC_MASK)
 			return -EOPNOTSUPP;
 		/* If one of the CAN_CTRLMODE_TDC_* flag is set then
 		 * TDC must be set and vice-versa
@@ -230,16 +230,16 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			dev->mtu = CAN_MTU;
 			memset(&priv->fd.data_bittiming, 0,
 			       sizeof(priv->fd.data_bittiming));
-			priv->ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
+			priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
-		tdc_mask = cm->mask & CAN_CTRLMODE_TDC_MASK;
+		tdc_mask = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
 		 */
 		if (tdc_mask)
-			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_TDC_MASK;
+			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
@@ -339,7 +339,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
 						 extack);
 			if (err) {
-				priv->ctrlmode &= ~CAN_CTRLMODE_TDC_MASK;
+				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;
 			}
 		} else if (!tdc_mask) {
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 9b8a9c39614b..5dfdbb63b1d5 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -14,7 +14,7 @@
 #define CAN_BITRATE_UNSET 0
 #define CAN_BITRATE_UNKNOWN (-1U)
 
-#define CAN_CTRLMODE_TDC_MASK					\
+#define CAN_CTRLMODE_FD_TDC_MASK				\
 	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
 
 /*
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 492d23bec7be..e492dfa8a472 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -93,7 +93,7 @@ struct can_priv {
 
 static inline bool can_tdc_is_enabled(const struct can_priv *priv)
 {
-	return !!(priv->ctrlmode & CAN_CTRLMODE_TDC_MASK);
+	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
 
 /*
-- 
2.45.2


