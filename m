Return-Path: <linux-can+bounces-1930-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D537D9C33AD
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CD631F211E7
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 424E74CDEC;
	Sun, 10 Nov 2024 15:59:48 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27465C603
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254388; cv=none; b=hFiSx6xbGEwX78GADyCuZYMggNN1s+r0WfxRWvS0b2VvZ90zTpD2pVMloKebcTPlpJ4fm+cP31sSgoezAn6x22TVmAtEayrffxiPajh7ysPoqvsYEPLcIlNQruz39vCj7sWhkL3NXDB2S1cc8yb42RK0Z1LejW3cOb45+OLANaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254388; c=relaxed/simple;
	bh=6AWkq8fVlplJ5Q9KjGdTsi26ntsXz+of8QKHsSxCrNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cl/9BRv1kGYOPhXcW22PDHWeQvhRreAsRVWufYAIpfWWtSm3uCvzmOYFz+JZnOZ2s/ly4SdFgVr8Lj+X8ohI++unQ0GIfsaHQDm25aM3pxujW/3Qb4K/Qt6Rk3o84EK8FE79/tH/6zD2BW6GDUnnq2PDY4fqpPvCNpIktb5U9Io=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so2943493b3a.2
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254385; x=1731859185;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpvNj0+lw+0YVjZ6uCLK3LzqmQn2rKmI8DZ2Ufv3MIE=;
        b=wYzyhXXztXsQvlFprkhQo9NUEdX2AENScQzESrwSPHhNiQxVxqVMTaFXnrUqPhsDQm
         2VLx1k9VQuMjRt+Tnb3x6IzGIBOljdyX00RidBD+No1gDsVQ20ZiHrsiCMvSYCCrVUOG
         O/G9TsUzSATXodXg7wMKfLYx+9aMc3BfAFJDWJ0rx9k+clzDJvf6Nlxi0w+BG+WumrFv
         Yen7P4/yN3r+0PWLUPwV2MHucnZ+irR7z723Xs5mGdZkUrQeiALCXPM+jjAN9V+jZpSb
         DOTSBUqdnJX6UX1crNSmg3tBihy1Y20ijDZNsPPb1T+FsgPqvVVIpxLXABvJvrhvS2Kl
         mMVg==
X-Gm-Message-State: AOJu0Yz+3FUFB4lQ32rirqeo8MzEZGkdSFi3I8QOyVfWMy8fxeQSvGv8
	EnX2cXAC5KTvtdsZZwpIbCBhJXJblDSsgCQAwbYGmA01CL3kLW4wsU7pLA==
X-Google-Smtp-Source: AGHT+IHtVRRJ65ryaR8bQy1Ht/5A/QLT642z83NO/Xd88CpRszwBvUe0952SQ+992pIv2YPYFnrosg==
X-Received: by 2002:a05:6a00:80c:b0:71e:4c18:8e3b with SMTP id d2e1a72fcca58-7241325eef3mr14117477b3a.2.1731254385468;
        Sun, 10 Nov 2024 07:59:45 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:45 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 09/14] can: netlink: make can_tdc_get_size() FD agnostic
Date: Mon, 11 Nov 2024 00:55:58 +0900
Message-ID: <20241110155902.72807-25-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2726; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=6AWkq8fVlplJ5Q9KjGdTsi26ntsXz+of8QKHsSxCrNw=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN4J8Xz13sX6m3jPX/HO0XVzJz19ZtcuCzCa68DebZ 08s8vTpKGVhEONikBVTZFlWzsmt0FHoHXboryXMHFYmkCEMXJwCMJF6DUaGxRtOK+gbfjp+98/S mu6CP7HuwX+vFOT331sjuvMNw70PnIwM/1c3KfbVzYz6yNmjbMS6VGC3vE3+DL68GXtmMrGvu7m FGwA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

This is a preparation patch for the introduction of CAN XL.

can_tdc_get_size() depends on some varibles which are specific to CAN
FD. Move these to the function parameters lest so that, later on, this
function can be reused for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 511f721f4c80..1809f5e53a75 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -422,32 +422,31 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 	return 0;
 }
 
-static size_t can_tdc_get_size(const struct net_device *dev)
+static size_t can_tdc_get_size(struct data_bittiming_params *dbt_params,
+			       bool tdc_is_enabled, bool tdc_manual)
 {
-	struct can_priv *priv = netdev_priv(dev);
 	size_t size;
 
-	if (!priv->fd.tdc_const)
+	if (!dbt_params->tdc_const)
 		return 0;
 
 	size = nla_total_size(0);			/* nest IFLA_CAN_TDC */
-	if (priv->ctrlmode_supported & CAN_CTRLMODE_TDC_MANUAL) {
+	if (tdc_manual) {
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MIN */
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV_MAX */
 	}
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MIN */
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO_MAX */
-	if (priv->fd.tdc_const->tdcf_max) {
+	if (dbt_params->tdc_const->tdcf_max) {
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MIN */
 		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF_MAX */
 	}
 
-	if (can_fd_tdc_is_enabled(priv)) {
-		if (priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL ||
-		    priv->fd.do_get_auto_tdcv)
+	if (tdc_is_enabled) {
+		if (tdc_manual || dbt_params->do_get_auto_tdcv)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCV */
 		size += nla_total_size(sizeof(u32));		/* IFLA_CAN_TDCO */
-		if (priv->fd.tdc_const->tdcf_max)
+		if (dbt_params->tdc_const->tdcf_max)
 			size += nla_total_size(sizeof(u32));	/* IFLA_CAN_TDCF */
 	}
 
@@ -491,7 +490,9 @@ static size_t can_get_size(const struct net_device *dev)
 		size += nla_total_size(sizeof(*priv->fd.data_bitrate_const) *
 				       priv->fd.data_bitrate_const_cnt);
 	size += sizeof(priv->bitrate_max);			/* IFLA_CAN_BITRATE_MAX */
-	size += can_tdc_get_size(dev);				/* IFLA_CAN_TDC */
+	size += can_tdc_get_size(&priv->fd,			/* IFLA_CAN_TDC */
+				 can_fd_tdc_is_enabled(priv),
+				 priv->ctrlmode & CAN_CTRLMODE_TDC_MANUAL);
 	size += can_ctrlmode_ext_get_size();			/* IFLA_CAN_CTRLMODE_EXT */
 
 	return size;
-- 
2.45.2


