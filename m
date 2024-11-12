Return-Path: <linux-can+bounces-1999-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95D019C5DBC
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 17:53:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D69281969
	for <lists+linux-can@lfdr.de>; Tue, 12 Nov 2024 16:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 378952123F6;
	Tue, 12 Nov 2024 16:51:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E03B20F5B6;
	Tue, 12 Nov 2024 16:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731430303; cv=none; b=Wyr/tkRFnHmKuI3tBl426rB3u+Ij45yg7ktnO0ZS2Cmofif9beLeNU7LkqB6d+QLSm1c7LpIGO30yvBfsXH8a+OYWM0k5K3HnozCFh2ihl5UNQmQvHAMaifyfC2IxUA3eGH5U21rmTh0vlsXUERJU75Sx+cXN1DROs8jVGyHdcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731430303; c=relaxed/simple;
	bh=62tUL9F6Iovdc0MpnIKxgF5dqpMMuTJqfFJva2MAtm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HHiOs2TOiG0+RCTX52mgzyoMKJ9TbnMZ4jBGYBWTag7jF4UWL/gwN3fTdgHUHyevI0ea6v+Bgeuwjvi78SDS3vhTuVrVPDi6xOCLD34+QuSqSEf9J25L6vaECQx43yllFfpxx+C2wKP4tAslN8aJqEwGuLhxt5m5w+mntg+0DO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-71e681bc315so4218527b3a.0;
        Tue, 12 Nov 2024 08:51:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731430300; x=1732035100;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2u2R57gucY0eeJxp9CbTUBcRMCpAHmk0Uy7XQgHtLFs=;
        b=nw2qPzGolg4ncT3fkLRZYJ849BHleAUvmRm7Vi/q+TSrLUh2lh0dAbR74aSQv6R8Gl
         Oz8faQZYexyG8xDbLmv+J3BBetH1Z3/0nfFVHVt6WGl4dO5O7be9B85vyH3+e2iBnGkc
         uh5bnHMsHHqtAMTUMZUR/2yu+xOxURIcRrQA2Uol3cH+0AWiAueeYxEn+J8LPVF+J80I
         yO/Uy/8Np1gw3NF7oQMoNkeZcymTz6TPCJBh9vzfrFlEU2bQt8vqocX+I6NMWBcfe6sO
         48ZzlB6pj8sSeVDzPI8gi3lm2h5RDtNRdTmIEE/+1Pmo8dFRTy+/ofU+FqXdnqPwIgIF
         SSVg==
X-Forwarded-Encrypted: i=1; AJvYcCUdapDuZABQmGicfnwvle/oXi8PjU4OT4AzkGlkN1tX7l6Z3U2tFRsUP4KKxdNeKu9mPYTL9bIuceMz8Bc=@vger.kernel.org, AJvYcCVPehyQ/ieKIRIyZOM5Y0DVbXoEgx/t9bhTcDi47rTi//Nrm4NlDtDJX6Cy8NI+NIe4+rQTdv+Q@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+yTlA80R35RjlwXc2rK3GJfgDDJIehaM9m615dor33OLlpgL8
	MH4VUaw/gKL9ywsp8PAnOE2S6QsxT08jQpRd1oOLeX//3H3AvNKeh2xlTw==
X-Google-Smtp-Source: AGHT+IF0BoPoM/KmidRbvxpduKxV1w5dI8w45nmjZo7vnGy/9ppO3jMyRW9l6wInX/vHZEjoXdTHnQ==
X-Received: by 2002:a05:6a00:2185:b0:71e:74f6:f83a with SMTP id d2e1a72fcca58-724121c7bd1mr31923109b3a.3.1731430300547;
        Tue, 12 Nov 2024 08:51:40 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72407860aa5sm11271260b3a.32.2024.11.12.08.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 08:51:40 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [PATCH v1 4/5] can: bittiming: rename can_tdc_is_enabled() into can_fd_tdc_is_enabled()
Date: Wed, 13 Nov 2024 01:50:19 +0900
Message-ID: <20241112165118.586613-11-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
References: <20241112165118.586613-7-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3569; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=62tUL9F6Iovdc0MpnIKxgF5dqpMMuTJqfFJva2MAtm4=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOnG7e3Oqp/nL8qfE1bzqPp5bVzy19USt1rOL1zAf/7j3 IOxlye/7yhlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRP68ZGa5eYLv+8FJGxP0J tluiHh62a1seUjrhUo2otsVy5VPsCrWMDN/mTHjA98OlIzs48oVJi7jbZN4pp12PBa94kX6SZ6f 0Tk4A
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
 drivers/net/can/xilinx_can.c              | 2 +-
 include/linux/can/dev.h                   | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

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
index d924b053677b..6476add1c105 100644
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
diff --git a/drivers/net/can/xilinx_can.c b/drivers/net/can/xilinx_can.c
index 3f2e378199ab..81baec8eb1e5 100644
--- a/drivers/net/can/xilinx_can.c
+++ b/drivers/net/can/xilinx_can.c
@@ -515,7 +515,7 @@ static int xcan_set_bittiming(struct net_device *ndev)
 	    priv->devtype.cantype == XAXI_CANFD_2_0) {
 		/* Setting Baud Rate prescaler value in F_BRPR Register */
 		btr0 = dbt->brp - 1;
-		if (can_tdc_is_enabled(&priv->can)) {
+		if (can_fd_tdc_is_enabled(&priv->can)) {
 			if (priv->devtype.cantype == XAXI_CANFD)
 				btr0 |= FIELD_PREP(XCAN_BRPR_TDCO_MASK, priv->can.fd.tdc.tdco) |
 					XCAN_BRPR_TDC_ENABLE;
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


