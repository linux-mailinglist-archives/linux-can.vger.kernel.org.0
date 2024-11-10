Return-Path: <linux-can+bounces-1933-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593629C33B0
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C3451C208F8
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D393322619;
	Sun, 10 Nov 2024 15:59:54 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 133AB54670
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254394; cv=none; b=cqW6IDIb0wlxHgk2d/2XujGeAwVuC/0RdINbwpbM/90riKldmMMDw6Nk8lInBB4saI2CPlnHt1V4NYpnSlSetP7VzWfiD883VEFDbKg9/Q9vHPwkQFlglRo9HYKrx/8vDpbKsx2uvueEfnLs5dYSRY4peuNWbHYwpd+LJPhLNEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254394; c=relaxed/simple;
	bh=l+iJceP/CX+ruWvvLTw4JSQiZ/tf6YiWmrGoipsul8k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTLyuEmwRgkd5ykY5NAQAg4/VdzvsgYij2ATJMdXKSglAJYbLfvsltKcGt9XxBk46qR/7PdDIaX3wwLEct+5Q/GWc0raY4bFKNcT3Ajp/uegs/r+oqiFpABWg+XpVrCJoxVsj/GQ786JVhp+XepgU2avX8ZWNrfUU8S7Dn+QTKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-71e52582cf8so2973370b3a.2
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254391; x=1731859191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2WfKK42MaddHSrrKAoTgI1+IL+w1me2UdjJwS4TcJuM=;
        b=dPLRR+SBjxUyklfUdbcHhUOStvI7bFho2rakH8POx0EBw4j5VZdRz4kGYAJIiPCQBB
         9ocHrl7ESiELt1wzCmpeRhjEHVgD4IDDeEWsXZzQIV9SZbGIuomz3A0Z3CUrc4riBr3S
         eAyYetflnJ5B1PnIbxSkP+NnsGzrnXMRvHipi2pGPfWqbFBysUnzTbxh3ubnYAwGASTJ
         7KZWIFk4lw5ZElPQtAhyDoZjjlJF562M0tABpPfpJKNRhwZJUu7jfTb1eru1iNxojwx1
         eVboPibD4r9aTvCIwmAAFtLYlr7vZtiWVbvLBYPP0d2AzN2moqmdKhNRhL5wANme1Bcd
         9GDA==
X-Gm-Message-State: AOJu0Ywv49I92nbeysOOHJlAmYXjG2a2rRV4j/zakxkOMa79J+Pm3fYR
	tyEIbLUloE4isdSshtuqOhAK5+YSmRzSsMMKco50jpogWD2O4IuD0JFzog==
X-Google-Smtp-Source: AGHT+IEdwNiVeiSiS81zle5qmTwjnPfZlcfTfZ0Jf80RvoFUEhFYAocVRBbofjkoCtSY9bRWsMxnzA==
X-Received: by 2002:a05:6a00:1816:b0:71d:f423:e6cc with SMTP id d2e1a72fcca58-724132a1a93mr13947633b3a.8.1731254391149;
        Sun, 10 Nov 2024 07:59:51 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:50 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 12/14] can: netlink: add CAN XL support
Date: Mon, 11 Nov 2024 00:56:01 +0900
Message-ID: <20241110155902.72807-28-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=10285; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=l+iJceP/CX+ruWvvLTw4JSQiZ/tf6YiWmrGoipsul8k=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN4I+O5fNWLfguZity+MfS2KTC5ROaCbn3j96/8dXg T23j6jv7yhlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRt9sZGRr+TV3+++qiT9Lb NpTJd2Xu+fJI+fb7s27/k11bZyX25Usw/BWpZCjViL253/sB+x+pYlllBxs3rVuLu2N+WLEeMN/ /kg8A
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Add the netlink interface for CAN XL.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c    | 78 +++++++++++++++++++++++++++++---
 include/linux/can/bittiming.h    |  2 +
 include/linux/can/dev.h          | 13 ++++--
 include/uapi/linux/can/netlink.h |  7 +++
 4 files changed, 90 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 6c3fa5aa22cf..3c89b304c5b8 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -22,6 +22,9 @@ static const struct nla_policy can_policy[IFLA_CAN_MAX + 1] = {
 	[IFLA_CAN_TERMINATION] = { .type = NLA_U16 },
 	[IFLA_CAN_TDC] = { .type = NLA_NESTED },
 	[IFLA_CAN_CTRLMODE_EXT] = { .type = NLA_NESTED },
+	[IFLA_CAN_XL_DATA_BITTIMING] = { .len = sizeof(struct can_bittiming) },
+	[IFLA_CAN_XL_DATA_BITTIMING_CONST] = { .len = sizeof(struct can_bittiming_const) },
+	[IFLA_CAN_XL_TDC] = { .type = NLA_NESTED },
 };
 
 static const struct nla_policy can_tdc_policy[IFLA_CAN_TDC_MAX + 1] = {
@@ -55,6 +58,10 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 {
 	int err;
 
+	/* TDC is optional */
+	if (!data_tdc)
+		return 0;
+
 	/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually exclusive */
 	if (tdc_auto == tdc_manual)
 		return -EOPNOTSUPP;
@@ -94,7 +101,7 @@ static int can_validate_tdc(struct nlattr *data_tdc,
 static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 			struct netlink_ext_ack *extack)
 {
-	bool is_can_fd = false;
+	bool is_can_fd = false, is_can_xl = false;
 	int err;
 
 	/* Make sure that valid CAN FD configurations always consist of
@@ -111,6 +118,7 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		struct can_ctrlmode *cm = nla_data(data[IFLA_CAN_CTRLMODE]);
 
 		is_can_fd = cm->flags & cm->mask & CAN_CTRLMODE_FD;
+		is_can_xl = cm->flags & cm->mask & CAN_CTRLMODE_XL;
 
 		err = can_validate_tdc(data[IFLA_CAN_TDC],
 				       cm->flags & CAN_CTRLMODE_TDC_AUTO,
@@ -133,11 +141,19 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
 			return -EOPNOTSUPP;
 	}
+	if (is_can_xl) {
+		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_XL_DATA_BITTIMING])
+			return -EOPNOTSUPP;
+	}
 
 	if (data[IFLA_CAN_DATA_BITTIMING] || data[IFLA_CAN_TDC]) {
 		if (!is_can_fd)
 			return -EOPNOTSUPP;
 	}
+	if (data[IFLA_CAN_XL_DATA_BITTIMING] || data[IFLA_CAN_XL_TDC]) {
+		if (!is_can_xl)
+			return -EOPNOTSUPP;
+	}
 
 	if (data[IFLA_CAN_DATA_BITTIMING]) {
 		struct can_bittiming bt;
@@ -147,6 +163,14 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 		if (err)
 			return err;
 	}
+	if (data[IFLA_CAN_XL_DATA_BITTIMING]) {
+		struct can_bittiming bt;
+
+		memcpy(&bt, nla_data(data[IFLA_CAN_XL_DATA_BITTIMING]), sizeof(bt));
+		err = can_validate_bittiming(&bt, extack);
+		if (err)
+			return err;
+	}
 
 	return 0;
 }
@@ -275,8 +299,8 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
 {
+	bool fd_tdc_flag_provided = false, xl_tdc_flag_provided = false;
 	struct can_priv *priv = netdev_priv(dev);
-	bool fd_tdc_flag_provided = false;
 	int err;
 
 	/* We need synchronization with dev->stop() */
@@ -310,8 +334,10 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		priv->ctrlmode &= ~cm->mask;
 		priv->ctrlmode |= maskedflags;
 
-		/* CAN_CTRLMODE_FD can only be set when driver supports FD */
-		if (priv->ctrlmode & CAN_CTRLMODE_FD) {
+		/* CAN_CTRLMODE_{FD,XL} can only be set when driver supports FD/XL */
+		if (priv->ctrlmode & CAN_CTRLMODE_XL) {
+			dev->mtu = CANXL_MAX_MTU;
+		} else if (priv->ctrlmode & CAN_CTRLMODE_FD) {
 			dev->mtu = CANFD_MTU;
 		} else {
 			dev->mtu = CAN_MTU;
@@ -322,11 +348,14 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		}
 
 		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
-		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
+		xl_tdc_flag_provided = cm->mask & CAN_CTRLMODE_XL_TDC_MASK;
+		/* CAN_CTRLMODE_(XL_)TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
 		 */
 		if (fd_tdc_flag_provided)
 			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
+		if (xl_tdc_flag_provided)
+			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_XL_TDC_MASK;
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
@@ -395,6 +424,15 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	/* CAN XL */
+	err = can_dbt_changelink(dev,
+				 data[IFLA_CAN_XL_DATA_BITTIMING], &priv->xl,
+				 data[IFLA_CAN_XL_TDC], xl_tdc_flag_provided,
+				 can_xl_tdc_is_enabled(priv),
+				 CAN_CTRLMODE_XL_TDC_MASK, extack);
+	if (err)
+		return err;
+
 	if (data[IFLA_CAN_TERMINATION]) {
 		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
 		const unsigned int num_term = priv->termination_const_cnt;
@@ -494,6 +532,16 @@ static size_t can_get_size(const struct net_device *dev)
 				 can_fd_tdc_is_enabled(priv),
 				 priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL);
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
+	if (priv->xl.data_bittiming.bitrate)			/* IFLA_CAN_XL_DATA_BITTIMING */
+		size += nla_total_size(sizeof(struct can_bittiming));
+	if (priv->xl.data_bittiming_const)			/* IFLA_CAN_XL_DATA_BITTIMING_CONST */
+		size += nla_total_size(sizeof(struct can_bittiming_const));
+	if (priv->xl.data_bitrate_const)			/* IFLA_CAN_DATA_BITRATE_CONST */
+		size += nla_total_size(sizeof(*priv->xl.data_bitrate_const) *
+				       priv->xl.data_bitrate_const_cnt);
+	size += can_tdc_get_size(&priv->xl,			/* IFLA_CAN_XL_TDC */
+				 can_xl_tdc_is_enabled(priv),
+				 priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL);
 
 	return size;
 }
@@ -634,7 +682,25 @@ static int can_fill_info(struct sk_buff *skb, const struct net_device *dev)
 	    can_tdc_fill_info(skb, dev, &priv->fd, can_fd_tdc_is_enabled(priv),
 			      priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL) ||
 
-	    can_ctrlmode_ext_fill_info(skb, priv)
+	    can_ctrlmode_ext_fill_info(skb, priv) ||
+
+	    (priv->xl.data_bittiming.bitrate &&
+	     nla_put(skb, IFLA_CAN_XL_DATA_BITTIMING,
+		     sizeof(priv->xl.data_bittiming), &priv->xl.data_bittiming)) ||
+
+	    (priv->xl.data_bittiming_const &&
+	     nla_put(skb, IFLA_CAN_XL_DATA_BITTIMING_CONST,
+		     sizeof(*priv->xl.data_bittiming_const),
+		     priv->xl.data_bittiming_const)) ||
+
+	    (priv->xl.data_bitrate_const &&
+	     nla_put(skb, IFLA_CAN_XL_DATA_BITRATE_CONST,
+		     sizeof(*priv->xl.data_bitrate_const) *
+		     priv->xl.data_bitrate_const_cnt,
+		     priv->xl.data_bitrate_const)) ||
+
+	    can_tdc_fill_info(skb, dev, &priv->xl, can_xl_tdc_is_enabled(priv),
+			      priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MANUAL)
 	    )
 
 		return -EMSGSIZE;
diff --git a/include/linux/can/bittiming.h b/include/linux/can/bittiming.h
index 5dfdbb63b1d5..2053b9dff0ad 100644
--- a/include/linux/can/bittiming.h
+++ b/include/linux/can/bittiming.h
@@ -16,6 +16,8 @@
 
 #define CAN_CTRLMODE_FD_TDC_MASK				\
 	(CAN_CTRLMODE_TDC_AUTO | CAN_CTRLMODE_TDC_MANUAL)
+#define CAN_CTRLMODE_XL_TDC_MASK				\
+	(CAN_CTRLMODE_XL_TDC_AUTO | CAN_CTRLMODE_XL_TDC_MANUAL)
 
 /*
  * struct can_tdc - CAN FD Transmission Delay Compensation parameters
diff --git a/include/linux/can/dev.h b/include/linux/can/dev.h
index 9a92cbe5b2cb..1ac98914f351 100644
--- a/include/linux/can/dev.h
+++ b/include/linux/can/dev.h
@@ -58,7 +58,7 @@ struct can_priv {
 
 	const struct can_bittiming_const *bittiming_const;
 	struct can_bittiming bittiming;
-	struct data_bittiming_params fd;
+	struct data_bittiming_params fd, xl;
 	unsigned int bitrate_const_cnt;
 	const u32 *bitrate_const;
 	u32 bitrate_max;
@@ -96,6 +96,11 @@ static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
 	return !!(priv->ctrlmode & CAN_CTRLMODE_FD_TDC_MASK);
 }
 
+static inline bool can_xl_tdc_is_enabled(const struct can_priv *priv)
+{
+	return !!(priv->ctrlmode & CAN_CTRLMODE_XL_TDC_MASK);
+}
+
 /*
  * can_get_relative_tdco() - TDCO relative to the sample point
  *
@@ -116,13 +121,13 @@ static inline bool can_fd_tdc_is_enabled(const struct can_priv *priv)
  *                           |                      |<->| relative TDCO
  *  |<------------- Secondary Sample Point ------------>|
  */
-static inline s32 can_get_relative_tdco(const struct can_priv *priv)
+static inline s32 can_get_relative_tdco(const struct data_bittiming_params *dbt_params)
 {
-	const struct can_bittiming *dbt = &priv->fd.data_bittiming;
+	const struct can_bittiming *dbt = &dbt_params->data_bittiming;
 	s32 sample_point_in_tc = (CAN_SYNC_SEG + dbt->prop_seg +
 				  dbt->phase_seg1) * dbt->brp;
 
-	return (s32)priv->fd.tdc.tdco - sample_point_in_tc;
+	return (s32)dbt_params->tdc.tdco - sample_point_in_tc;
 }
 
 /* helper to define static CAN controller features at device creation time */
diff --git a/include/uapi/linux/can/netlink.h b/include/uapi/linux/can/netlink.h
index ef62f56eaaef..c81fd153a07f 100644
--- a/include/uapi/linux/can/netlink.h
+++ b/include/uapi/linux/can/netlink.h
@@ -103,6 +103,9 @@ struct can_ctrlmode {
 #define CAN_CTRLMODE_CC_LEN8_DLC	0x100	/* Classic CAN DLC option */
 #define CAN_CTRLMODE_TDC_AUTO		0x200	/* FD transceiver automatically calculates TDCV */
 #define CAN_CTRLMODE_TDC_MANUAL		0x400	/* FD TDCV is manually set up by user */
+#define CAN_CTRLMODE_XL			0x800	/* CAN XL mode */
+#define CAN_CTRLMODE_XL_TDC_AUTO	0x200	/* XL transceiver automatically calculates TDCV */
+#define CAN_CTRLMODE_XL_TDC_MANUAL	0x400	/* XL TDCV is manually set up by user */
 
 /*
  * CAN device statistics
@@ -138,6 +141,10 @@ enum {
 	IFLA_CAN_BITRATE_MAX,
 	IFLA_CAN_TDC, /* FD */
 	IFLA_CAN_CTRLMODE_EXT,
+	IFLA_CAN_XL_DATA_BITTIMING,
+	IFLA_CAN_XL_DATA_BITTIMING_CONST,
+	IFLA_CAN_XL_DATA_BITRATE_CONST,
+	IFLA_CAN_XL_TDC,
 
 	/* add new constants above here */
 	__IFLA_CAN_MAX,
-- 
2.45.2


