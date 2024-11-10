Return-Path: <linux-can+bounces-1928-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FA19C33AA
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67E7E1F20ACB
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 703914CDEC;
	Sun, 10 Nov 2024 15:59:44 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9727F22619
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254384; cv=none; b=ZfCc/SjoGO7LFQKIt245La8nGOWZrDsjkQmDLUg7wcW19MxMw40t6kUxxAYaGSdP+AHN3J/Qmm6T8Y9snGoGbiQu7ps2lG/nilDv28Wv0UmNYl69n25NpEZBPLljQGqiZ7Wj2b72bdK4MFUnbJGqcJKaR3JBjm6QTxsuA5/IE9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254384; c=relaxed/simple;
	bh=y8r2o6HQIQVVWDZvQGrTzWyN13FIQ63giiXVow9VSng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=haJs5ng8083gouHxBFd8uvXbaqygnXXLMeLYR1ve69nbM8fHwV+4gUDILL/FbaatpJzANk/HTh+yEljDKLK13N1dI5NKPp7i8iUtREWwhKXrrzrmeBJPgodCoUTTP+kpHSXlRjvo/e+SclALGLeB8OrC52kZOEBf5JadMEp+A6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-71e4e481692so3708662b3a.1
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254382; x=1731859182;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oYdZTyY2EvS3TYlCPll5cyrllVZKueBtiEldHG/1zss=;
        b=FWl4wO9+9uoyUX0O62zaAv8Vbpl4e3ER8dwF1UswCQ8fVCJcQ3IAeqnscEn6JLD/Ut
         hksAha6euBH786CyaKLQvSEhs3qu1VU3gM0qgbEfTOydRufEgkdVRcN+2i1T1LcBN180
         FxlGpejyQneJcwIc4P85BsUGmFgT4pRP6MlMy9cehLsZoUiLh4ur8d/WVrtE0k5SLSAc
         m+ExA96DH1UyCCUl+6LtEul3SjvZpHyM/oiCp+DIcJ0CmtD7Pjwho6bhi5pJp6+5/2gt
         kVOOmccvrkuXzTuQ9NRCfPGFctkys7xKNoqn3gWnv0shGH/bFUUtBOuau+/LmGY6S1ue
         xRBQ==
X-Gm-Message-State: AOJu0Yw529HybZ2P8gj/FSYPjyqzCgefGfxCtgjZcJwkbhwHDtQI6VI1
	d+FU0VBt+ZqGFBLe31JLY5IQK+x9Cvh9QVu8PXPp8pLBUQZfKowMMyL8yQ==
X-Google-Smtp-Source: AGHT+IFe/yOqwjcw0+ed/IzP2JT8J+NYDxlHQMRQr5tDbKKbNqnKZXmC/xITj8Nhxb54qIyYSaZPWA==
X-Received: by 2002:a05:6a00:3d55:b0:71e:695:41ee with SMTP id d2e1a72fcca58-72413278a86mr13214355b3a.5.1731254381703;
        Sun, 10 Nov 2024 07:59:41 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:41 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 07/14] can: netlink: add can_dtb_changelink()
Date: Mon, 11 Nov 2024 00:55:56 +0900
Message-ID: <20241110155902.72807-23-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5836; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=y8r2o6HQIQVVWDZvQGrTzWyN13FIQ63giiXVow9VSng=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNwLXr3+faFjRlsI6e3XBzl2pa/9wONibTqt8kmMZu fHPqqrvHaUsDGJcDLJiiizLyjm5FToKvcMO/bWEmcPKBDKEgYtTACZySY/hn8WO+62GrKtyHdp1 3z+VDM98zbjvz71DfvNaLks+9HVSLmH4K2WgyLCrVDwz9tl3n9z4RYtru6aL3V0rZ8xz9kmucrE YBwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Factorize the dattabittiming parsing out of can_changelink() and move
it in the new can_dtb_changelink() function. This is a preparation
patch for the introduction of CAN XL because the databittiming
changelink logic will be reused later on.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
I am not fully happy that can_dbt_changelink() requires 8 parameters.
I will probably revisit this later on. But for the moment, I think
this is acceptable for an RFC.
---
 drivers/net/can/dev/netlink.c | 139 +++++++++++++++++++---------------
 1 file changed, 78 insertions(+), 61 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 50c1658f17a4..354846e3a0d0 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -185,6 +185,77 @@ static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
 	return 0;
 }
 
+static int can_dbt_changelink(struct net_device *dev,
+			      struct nlattr *data_databittiming,
+			      struct data_bittiming_params *dbt_params,
+			      struct nlattr *data_tdc, bool tdc_flags_provided,
+			      bool tdc_is_enabled, u32 tdc_mask,
+			      struct netlink_ext_ack *extack)
+{
+	struct can_priv *priv = netdev_priv(dev);
+	struct can_bittiming dbt;
+	int err;
+
+	if (!data_databittiming)
+		return 0;
+
+	/* Do not allow changing bittiming while running */
+	if (dev->flags & IFF_UP)
+		return -EBUSY;
+
+	/* Calculate bittiming parameters based on data_bittiming_const
+	 * if set, otherwise pass bitrate directly via do_set_bitrate().
+	 * Bail out if neither is given.
+	 */
+	if (!dbt_params->data_bittiming_const && !dbt_params->do_set_data_bittiming &&
+	    !dbt_params->data_bitrate_const)
+		return -EOPNOTSUPP;
+
+	memcpy(&dbt, nla_data(data_databittiming), sizeof(dbt));
+	err = can_get_bittiming(dev, &dbt, dbt_params->data_bittiming_const,
+				dbt_params->data_bitrate_const,
+				dbt_params->data_bitrate_const_cnt, extack);
+	if (err)
+		return err;
+
+	if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
+		NL_SET_ERR_MSG_FMT(extack,
+				   "CAN data bitrate %u bps surpasses transceiver capabilities of %u bps",
+				   dbt.bitrate, priv->bitrate_max);
+		return -EINVAL;
+	}
+
+	memset(&dbt_params->tdc, 0, sizeof(dbt_params->tdc));
+	if (data_tdc) {
+		/* TDC parameters are provided: use them */
+		err = can_tdc_changelink(dbt_params, tdc_is_enabled, data_tdc,
+					 extack);
+		if (err) {
+			priv->ctrlmode &= ~tdc_mask;
+			return err;
+		}
+	} else if (!tdc_flags_provided) {
+		/* Neither of TDC parameters nor TDC flags are provided:
+		 * do calculation
+		 */
+		can_calc_tdco(&dbt_params->tdc, dbt_params->tdc_const, &dbt,
+			      &priv->ctrlmode, priv->ctrlmode_supported);
+	} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
+	   * turned off. TDC is disabled: do nothing
+	   */
+
+	memcpy(&dbt_params->data_bittiming, &dbt, sizeof(dbt));
+
+	if (dbt_params->do_set_data_bittiming) {
+		/* Finally, set the bit-timing registers */
+		err = dbt_params->do_set_data_bittiming(dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct nlattr *data[],
 			  struct netlink_ext_ack *extack)
@@ -301,67 +372,13 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			return err;
 	}
 
-	if (data[IFLA_CAN_DATA_BITTIMING]) {
-		struct can_bittiming dbt;
-
-		/* Do not allow changing bittiming while running */
-		if (dev->flags & IFF_UP)
-			return -EBUSY;
-
-		/* Calculate bittiming parameters based on
-		 * data_bittiming_const if set, otherwise pass bitrate
-		 * directly via do_set_bitrate(). Bail out if neither
-		 * is given.
-		 */
-		if (!priv->fd.data_bittiming_const && !priv->fd.do_set_data_bittiming &&
-		    !priv->fd.data_bitrate_const)
-			return -EOPNOTSUPP;
-
-		memcpy(&dbt, nla_data(data[IFLA_CAN_DATA_BITTIMING]),
-		       sizeof(dbt));
-		err = can_get_bittiming(dev, &dbt,
-					priv->fd.data_bittiming_const,
-					priv->fd.data_bitrate_const,
-					priv->fd.data_bitrate_const_cnt,
-					extack);
-		if (err)
-			return err;
-
-		if (priv->bitrate_max && dbt.bitrate > priv->bitrate_max) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "CANFD data bitrate %u bps surpasses transceiver capabilities of %u bps",
-					   dbt.bitrate, priv->bitrate_max);
-			return -EINVAL;
-		}
-
-		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
-		if (data[IFLA_CAN_TDC]) {
-			/* TDC parameters are provided: use them */
-			err = can_tdc_changelink(&priv->fd, can_fd_tdc_is_enabled(priv),
-						 data[IFLA_CAN_TDC], extack);
-			if (err) {
-				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
-				return err;
-			}
-		} else if (!fd_tdc_flag_provided) {
-			/* Neither of TDC parameters nor TDC flags are
-			 * provided: do calculation
-			 */
-			can_calc_tdco(&priv->fd.tdc, priv->fd.tdc_const, &dbt,
-				      &priv->ctrlmode, priv->ctrlmode_supported);
-		} /* else: both CAN_CTRLMODE_TDC_{AUTO,MANUAL} are explicitly
-		   * turned off. TDC is disabled: do nothing
-		   */
-
-		memcpy(&priv->fd.data_bittiming, &dbt, sizeof(dbt));
-
-		if (priv->fd.do_set_data_bittiming) {
-			/* Finally, set the bit-timing registers */
-			err = priv->fd.do_set_data_bittiming(dev);
-			if (err)
-				return err;
-		}
-	}
+	/* CAN FD */
+	err = can_dbt_changelink(dev, data[IFLA_CAN_DATA_BITTIMING], &priv->fd,
+				 data[IFLA_CAN_TDC], fd_tdc_flag_provided,
+				 can_fd_tdc_is_enabled(priv),
+				 CAN_CTRLMODE_FD_TDC_MASK, extack);
+	if (err)
+		return err;
 
 	if (data[IFLA_CAN_TERMINATION]) {
 		const u16 termval = nla_get_u16(data[IFLA_CAN_TERMINATION]);
-- 
2.45.2


