Return-Path: <linux-can+bounces-1998-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D74B9C5DBA
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A1E9C1F220AC
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 16:52:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B9420E332;
	Tue, 12 Nov 2024 16:51:41 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BC02209664;
	Tue, 12 Nov 2024 16:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430301; cv=none; b=GA5rVqY8tg8+vlN3G+s5Bj5W3oDaS8l1uPqGSeyYgSZR0T294mY6CbjS7iOFfY42jIuiZhN0Gz5OPmufT7NFJP93CFMfYdP5RoQmpssRoQmOsO7kP9HumiQZO3gASlA48s6hTijaH1/9a3V9XqVd3XvFHGqfFp+HVW2f0j4xhYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430301; c=relaxed/simple;
	bh=rGQlHT/m68C3UfrBE/ikk7wol7f4uQPoJ3LHcF4oN6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M+sRbUKuxAR9Vggi/OapUcaTU2UhjqEc+s+WKvaQ9rtQGphGWd8+nLaLJgbpSHBeCxz7nqhcFVMYgQmcp89XA88l5F8bNNyhuq12joQ3Pld/RpWBJkc0dlOzEPFxSTal5DWPDGQ8wPoVmVgpZ7rPWGtzcXDRy0nDBBEeKD8oPQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-71e4244fdc6so5041803b3a.0;
        Tue, 12 Nov 2024 08:51:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430298; x=1732035098;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+RqkB1sUMX6vJyOuUWxOILOufOiaTgQEU1WBlalnbE=;
        b=PH9OLIMeAY7NByrpjMSa0bVVQP600DkKfy5JyaQniFu8Dc+8xQOy+FU15ALLhjVmFK
         gKBV/pUJQW8mw7msgXwzdkYh5T1/XP8oo89KBCsQhgbhsz56X26ZtZKaFkkKlv9QUWQ2
         VMDc2ocXehmhLy4b2KUFJ89BppxjBFoZDeUMi4+NHiit5VGo9pGAZ2VMHBWj3KG5X3Fc
         ERN7byoVQE8UPKa/J6BkY5UZ7O8xsDwOhgfORuBJQ0gd+XcZdJmgQlt9omEL6qEDQWZe
         xTvz06dWggMllfdJg5SpDC0SghZJ7gs70IqhGJzAyjA5hQQYIbtOfSgKu0qjutyYPN0x
         teGQ==
X-Forwarded-Encrypted: i=1; AJvYcCVQETihquCq6llqTkx0/it/BaALq9zCsm9zmBNL2nCHc67FoGsOjsnDfuVQAKQNwmERhfuRx4tvhumXIos=@vger.kernel.org, AJvYcCWUwmWr6OGtP9x0HYxTcgF/+pBN5q6xEQVM2iG3X5GIwizReQEt1zFaySUhJT7qHswgAU0dQ6g6@vger.kernel.org
X-Gm-Message-State: AOJu0YxS+EIcgdfzdTHAVYxJ07/wte4uIzl1sj1Q1pUEFYmC4YzBqcOA
	YJspYGXyJd/y6SMWpNmDcsIT5SSFHUdPzIoKkHkyNkEXuwcTITHSVY5AbA==
X-Google-Smtp-Source: AGHT+IH0J8mWVdPBRmVltBM0FeHS71+xPiF6UIyxUy38j3OimBvgS2dE9R2Hy3KkDttDrC912zSToA==
X-Received: by 2002:a05:6a00:c90:b0:71d:fe5b:5eb9 with SMTP id d2e1a72fcca58-724132a6513mr22787735b3a.10.1731430298297;
        Tue, 12 Nov 2024 08:51:38 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860aa5sm11271260b3a.32.2024.11.12.08.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:51:37 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 3/5] can: bittiming: rename CAN_CTRLMODE_TDC_MASK into CAN_CTRLMODE_FD_TDC_MASK
Date: Wed, 13 Nov 2024 01:50:18 +0900
Message-ID: <20241112165118.586613-10-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
References: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3947; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=rGQlHT/m68C3UfrBE/ikk7wol7f4uQPoJ3LHcF4oN6o=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnG7e339s/j+btmCUNN6IZ/gr6hvFyNzAYvq+y3lWZd/ 3Dk/p3SjlIWBjEuBlkxRZZl5ZzcCh2F3mGH/lrCzGFlAhnCwMUpABP5z8zwv948TNtqRX3JT6l/ PPK3X/X6Pc5bMn39s+ZlTK2GR+c5MzIyvOm+m7rqXccJSdU7DzbmvlBb0vCUocl3fqJCwIkso0Q 1JgA=
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


