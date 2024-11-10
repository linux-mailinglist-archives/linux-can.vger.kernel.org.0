Return-Path: <linux-can+bounces-1929-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1189C33AC
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F0231C20A23
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81FF54670;
	Sun, 10 Nov 2024 15:59:46 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A03922619
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254386; cv=none; b=aJr3dF4UGgCHJtMhVYVVUzd8UMXKfUfO5qyy+6tSEJAbwNMhgtVgYAxrVyQURkylquPqQdqmgBxT6ZnghKXTZsDwH1tTP9RRRhUnIsj4stzTEriYlSRivL136icVM8ha6+j/3cc9ymZzOKOaocs1g9/AwrOXQiGUNr5t2PhF+T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254386; c=relaxed/simple;
	bh=Z2LSUEF7QUvpdgh9KXWboGWvqem9+r9NrcJ05Votpzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ue7XBV87wDNEuYYnsxA2H7a40ODwiEwAZuyaDR2k0walIIptvNquIlNBvHkJrNwlEKXNhcR9AxRpnSCZ5FrTIT1vvhJ1dlsylwo5rr9zpfvmf/cyyQODgOaTg3qCkhMvmEs4wdUNDpg3R4f5XodukMpUVoda8rSyyAEnjUd9pNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e49ad46b1so3183748b3a.1
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254383; x=1731859183;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6lrW5YCsVBIoGlrAIqC+fAh3HUhAirgHCzkwrrOTNc=;
        b=NSlOJbWzOnnEDg/Zvuo8g19gMyhjww11gJi4jJSeTmJe3QXAUXt7oKpeiotJ+VVC1F
         6B8ZzUOBZNhmlO5uC/brKZ+K3+g1Gyi14xITUoSRHRCB7i8lOIWZPqd3GrNYPheZWULz
         JHWJtZsh/bvfZKizW4rrZwfxgett4CG4AFBZXpS2R9IFV8Iz2WMxHwzA8etgyBHjr2qE
         /YOdpGJak9VWeidLe65yNUwhbt9u4fgkqtPKCqMYap4U/DW0zHjW8ccUnUYWXyXdDh0j
         FOI25rdCcRvZ+IuqyplVmx7egbnIroVhXfOABm1Th5hiNvgmNXn3O+UB3V38VietBdE/
         hKzg==
X-Gm-Message-State: AOJu0YwSYQ29rQNn/DZvkO4iTW4ryv/6zfZtfuv/kDInMK079V49jgFc
	iGjNlo06dRzNdoJR6mobbdlHqY3udLGVM36aRclmWFR9s11M8+7p03q13w==
X-Google-Smtp-Source: AGHT+IH4tbB8AZO63UNMCrmkLfKNlIfFcQTVgp4mtV9koBD43bs7hUvBGZWKz4V6v4iAzjrZlpreRg==
X-Received: by 2002:a05:6a00:a09:b0:71e:7cb2:57e7 with SMTP id d2e1a72fcca58-7241328bcdcmr14171449b3a.10.1731254383584;
        Sun, 10 Nov 2024 07:59:43 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:43 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 08/14] can: netlink: add can_validate_tdc()
Date: Mon, 11 Nov 2024 00:55:57 +0900
Message-ID: <20241110155902.72807-24-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3397; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=Z2LSUEF7QUvpdgh9KXWboGWvqem9+r9NrcJ05Votpzc=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNwItr3UfyLmVIiIqsDI7PVHjX2qt1fJXSyfmb9iQe XLz0XUqHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACbirMbw3/FpXnv/K9apDb+f TNatWR6qxDTpyb7rdQn+i3x/n7DQeMfI8OxzrV74kbe5gSe2hWrmP/xwY8EzH4eUwy55f8QSWk9 EcgEA
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Factorize the TDC validation out of can_validate() and move it in the
new add can_validate_tdc() function. This is a preparation patch for
the introduction of CAN XL because this TDC validation will be reused
later on.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 81 +++++++++++++++++++++--------------
 1 file changed, 48 insertions(+), 33 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 354846e3a0d0..511f721f4c80 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -49,6 +49,48 @@ static int can_validate_bittiming(const struct can_bittiming *bt,
 	return 0;
 }
 
+static int can_validate_tdc(struct nlattr *data_tdc,
+			    bool tdc_auto, bool tdc_manual,
+			    struct netlink_ext_ack *extack)
+{
+	int err;
+
+	/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
+	if (tdc_auto == tdc_manual)
+		return -EOPNOTSUPP;
+
+	/* If one of the CAN_CTRLMODE_TDC_* flag is set then
+	 * TDC must be set and vice-versa
+	 */
+	if ((tdc_auto || tdc_manual) != !!data_tdc)
+		return -EOPNOTSUPP;
+
+	/* If providing TDC parameters, at least TDCO is needed. TDCV
+	 * is needed if and only if CAN_CTRLMODE_TDC_MANUAL is set
+	 */
+	if (!data_tdc) {
+		struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
+
+		err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX,
+				       data_tdc, can_tdc_policy, extack);
+		if (err)
+			return err;
+
+		if (tb_tdc[IFLA_CAN_TDC_TDCV]) {
+			if (tdc_auto)
+				return -EOPNOTSUPP;
+		} else {
+			if (tdc_manual)
+				return -EOPNOTSUPP;
+		}
+
+		if (!tb_tdc[IFLA_CAN_TDC_TDCO])
+			return -EOPNOTSUPP;
+	}
+
+	return 0;
+}
+
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
@@ -67,42 +109,15 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 
 	if (data[IFLA_CAN_CTRLMODE]) {
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
-		u32 tdc_flags = cm->flags & CAN_CTRLMODE_FD_TDC_MASK;
 
 		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
 
-		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
-		if (tdc_flags == CAN_CTRLMODE_FD_TDC_MASK)
-			return -EOPNOTSUPP;
-		/* If one of the CAN_CTRLMODE_TDC_* flag is set then
-		 * TDC must be set and vice-versa
-		 */
-		if (!!tdc_flags != !!data[IFLA_CAN_TDC])
-			return -EOPNOTSUPP;
-		/* If providing TDC parameters, at least TDCO is
-		 * needed. TDCV is needed if and only if
-		 * CAN_CTRLMODE_TDC_MANUAL is set
-		 */
-		if (data[IFLA_CAN_TDC]) {
-			struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
-
-			err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX,
-					       data[IFLA_CAN_TDC],
-					       can_tdc_policy, extack);
-			if (err)
-				return err;
-
-			if (tb_tdc[IFLA_CAN_TDC_TDCV]) {
-				if (tdc_flags & CAN_CTRLMODE_TDC_AUTO)
-					return -EOPNOTSUPP;
-			} else {
-				if (tdc_flags & CAN_CTRLMODE_TDC_MANUAL)
-					return -EOPNOTSUPP;
-			}
-
-			if (!tb_tdc[IFLA_CAN_TDC_TDCO])
-				return -EOPNOTSUPP;
-		}
+		err = can_validate_tdc(data[IFLA_CAN_TDC],
+				       cm->flags & CAN_CTRLMODE_TDC_AUTO,
+				       cm->flags & CAN_CTRLMODE_TDC_MANUAL,
+				       extack);
+		if (err)
+			return err;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
-- 
2.45.2


