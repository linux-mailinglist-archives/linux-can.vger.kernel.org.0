Return-Path: <linux-can+bounces-1925-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D65679C33A8
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FAF02815C6
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38D4C84D34;
	Sun, 10 Nov 2024 15:59:39 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AA094CDEC
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254379; cv=none; b=RdVF50ty9S4pXLJ7Qb/9Htlfd0SKmi0tAOuUKPaWbNKLi9Q9PNs5Ow2Fjs5oaAgKm/SD8KGPhxdOxj0WPDmouPZBVSZj1cmvBs3NLaDhHJcXLaG6ycJeFhC4Xlkr3ag2DZ/oSPxC0vO6ouJYjlwkLKbhU/FP+VFc8vvbfiXEc8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254379; c=relaxed/simple;
	bh=tbI75KkNyNIbbfjwHewL8MSQ61WwVXeb1xQf+kCn2QI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qiFcxIag65ZNaFqqKlG00bVruUe2jPtCL7e0kU2EQS4DDRDpveKTm+++k6iVD3qoG4Ho8a1kdCDK01WL5xe2gA+rBH56ZtptrUUpG6uecsbpG119LTiB0P5lC/wjZvMCxNTl2KPiftcQ8sU29SgUVK48OmbXgF2L9w6IBzA9hms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7240fa50694so2549161b3a.1
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254376; x=1731859176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eO6ueo4RouQPSqzYHibdq6GPcTIl2DWIa6kMtt2PGuM=;
        b=U40rPQtMJtPklgVJAuNHvmTo4H5GCP89epvvKQWsvxmxp22tlbeFO3M+46BbEf5smH
         NDv9e+uERRwYzLsojN+KIvrdC2bdGkCcoU3UEcoLh40Nk2DFuHrz+sUrvA13RwRegXya
         4jivWsX7JSfxvZ5CHJUayN2gmFCeFsm7WOHfD7/mTMLD4HUCzKRdDefsHQGwjPTm5utg
         rd0cQ7l6YX1xnsOLP0LitvWrNFhnhIE59E8BwhiLICmtqfM83HuetlmO+E050GEZfkbt
         UhCmjwG7wOBoTPjXl1knlAGcbAHt5VR/Q6MxTphbhx1ElE4lfiFY8p3x7hKdAE8fjtdE
         pqaQ==
X-Gm-Message-State: AOJu0Yw91GxYZ6eaTytUqxiin7bQkviZg0r2hFWI+F+jt32vctpxZ2Uk
	CFGM6smz9LQIJEMYIBzmeprPJFp/JuQy7RRgG/oaMaXxsULJlg6a+e3RUA==
X-Google-Smtp-Source: AGHT+IEbEAZUEDfAO9YtlbMdNM/ymqyIEf7mZsRM672vUC1Fy8cI10l9e2ptoSPMsy9ljouGND+t8g==
X-Received: by 2002:a05:6a20:2444:b0:1db:ddba:8795 with SMTP id adf61e73a8af0-1dc22b576aamr14729839637.36.1731254375922;
        Sun, 10 Nov 2024 07:59:35 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:35 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 04/14] can: bittiming: rename can_tdc_is_enabled() into can_fd_tdc_is_enabled()
Date: Mon, 11 Nov 2024 00:55:53 +0900
Message-ID: <20241110155902.72807-20-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2884; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=tbI75KkNyNIbbfjwHewL8MSQ61WwVXeb1xQf+kCn2QI=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNwIbi7ZlFhxb82eHm43LK50g/+2bP5beXjhPoHfqN MtFVVWNHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACaSt4bhv0f9oSTzJ9NCSlbK Lkpl6WEraNp0T0G0aJFg0MlcxrrV2gx/eGs69/MIsZ9lvHylNGrH7m1zNszy9t3QwlNzS4pXmWs LAwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

With the introduction of CAN XL, a new can_xl_tdc_is_enabled() helper
function will be introduced later on. Rename can_tdc_is_enabled() into
can_fd_tdc_is_enabled() to make it more explicit that this helper is
meant for CAN FD.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c             | 6 +++---
 drivers/net/can/usb/etas_es58x/es58x_fd.c | 2 +-
 include/linux/can/dev.h                   | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 72a60e8186aa..27168aa6db20 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -144,7 +144,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
 	int err;
 
-	if (!tdc_const || !can_tdc_is_enabled(priv))
+	if (!tdc_const || !can_fd_tdc_is_enabled(priv))
 		return -EOPNOTSUPP;
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,
@@ -409,7 +409,7 @@ static size_t can_tdc_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MAX */
 	}
 
-	if (can_tdc_is_enabled(priv)) {
+	if (can_fd_tdc_is_enabled(priv)) {
 		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL ||
 		    priv->fd.do_get_auto_tdcv)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
@@ -490,7 +490,7 @@ static int can_tdc_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	     nla_put_u32(skb, IFLA_CAN_TDC_TDCF_MAX, tdc_const->tdcf_max)))
 		goto err_cancel;
 
-	if (can_tdc_is_enabled(priv)) {
+	if (can_fd_tdc_is_enabled(priv)) {
 		u32 tdcv;
 		int err = -EINVAL;
 
diff --git a/drivers/net/can/usb/etas_es58x/es58x_fd.c b/drivers/net/can/usb/etas_es58x/es58x_fd.c
index ab67fe0508ec..f169d764a1aa 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_fd.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_fd.c
@@ -429,7 +429,7 @@ static int es58x_fd_enable_channel(struct es58x_priv *priv)
 		es58x_fd_convert_bittiming(&tx_conf_msg.data_bittiming,
 					   &priv->can.fd.data_bittiming);
 
-		if (can_tdc_is_enabled(&priv->can)) {
+		if (can_fd_tdc_is_enabled(&priv->can)) {
 			tx_conf_msg.tdc_enabled = 1;
 			tx_conf_msg.tdco = cpu_to_le16(priv->can.fd.tdc.tdco);
 			tx_conf_msg.tdcf = cpu_to_le16(priv->can.fd.tdc.tdcf);
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index e492dfa8a472..9a92cbe5b2cb 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -91,7 +91,7 @@ struct can_priv {
 				   struct can_berr_counter *bec);
 };
 
-static inline bool can_tdc_is_enabled(const struct can_priv *priv)
+static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
 {
 	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
-- 
2.45.2


