Return-Path: <linux-can+bounces-1927-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B93019C33A9
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C98728142E
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5330154670;
	Sun, 10 Nov 2024 15:59:43 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1A62126F0A
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254383; cv=none; b=YNV+z3K99xsF8PNnYDD9Ba62gcrnnR/s6mQP7s//R/oL/9k+Zkpjs4pi+6428FmjlZNsjfiZZ7LiAqHXtInobY7Gclp0B9hx/DVou1YfP5nFhKx3d2ZiBx1vNt13JCWVKFrGcLYenTh3eN6JQVqaCXY4T6K56BTan1TJok+B5Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254383; c=relaxed/simple;
	bh=JQ8FDOAwiuFLnx+vO4K9zypluoXMZVyGUgQF1kWXi5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JIfHBaqrKJ7tt0yNc276Y3u6DVIioSBS9ndirfcD+cnCfv3LswdvyRhO4RdfBg9DOhEoTlBOR1ylmq294/RBgoM6L672yisPAIGie8Tp5B6OOXGchFW8EYggwIw+sEmjG6FWfe6JkF2S5IcuDVcSbHKJQrY//3BjZx2BMkBjjo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7240d93fffdso2924901b3a.2
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254380; x=1731859180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i3cIId994HZbxz9ifKqKPC/N2VK9ed8/4XF3OnVbKUU=;
        b=JLItUTCeU9JS2SsZehn2VVbQtBkyfmy+FZfDLhDuo79AXaj900ssNLjUvCjV2qi3dt
         ocCW864zx+EuqOsM8MMy39fT+iwr1QMv+QB+IOyzCniES/+MjcWT+jodyVeztEZDGwv7
         B3Xy6zFuiB0kyXQy2rWt9YVbF/j1ZGsPMkGLU59sS3s5RfNO4IoiqEzEiOOKo/Js9kOh
         FBTEyBjl0XxcToFoWcbn874FblDA98ThJqr30FE1+DAPtqs+E4tgSnNlwwAFc3tYfCBe
         GYgTEnWxqLjgGQQq0nNtIHmxPCWUhnWcWXzjIC/hpqYoAbkndc4HFIO7mlnw5l5+EYUl
         lbvQ==
X-Gm-Message-State: AOJu0YzE6lmQzOlT3pJDDDeabYgSMpChvnV63p+QYMTMYadfEPLN8zRT
	qAqEJlUujN2fwSMqWn9MldbgVwqENbDRcV87gaa+Bd1IfB42lDZDYndX2Q==
X-Google-Smtp-Source: AGHT+IFpXaeqOQdhVwTOHS3KDHOy/g6SUMFj+a7dCyw9pQFY+3xgv7aO4Eo1mi9C30baaFi6+nOghg==
X-Received: by 2002:a05:6a00:2290:b0:71e:55e2:2c43 with SMTP id d2e1a72fcca58-724132c07ddmr14083212b3a.14.1731254379800;
        Sun, 10 Nov 2024 07:59:39 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:39 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 06/14] can: netlink: make can_tdc_changelink() FD agnostic
Date: Mon, 11 Nov 2024 00:55:55 +0900
Message-ID: <20241110155902.72807-22-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2082; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=JQ8FDOAwiuFLnx+vO4K9zypluoXMZVyGUgQF1kWXi5E=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNwI593idTnCRNDfhO341uzUqwOOkwiHD5oPlngmeq WskK1d1lLIwiHExyIopsiwr5+RW6Cj0Djv01xJmDisTyBAGLk4BmAjPRUaGjwWvT/5zbrhg++Tm BSV3+9QySwMRZQ33t0V7nKW9zn2WZWRYvSVpwub8prmxnK1X2TfOkmdhnsjy4IfR8XJXo9iz/tN 5AA==
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

This is a preparation patch for the introduction of CAN XL.

can_tdc_changelink() depends on some varibles which are specific to
CAN FD. Move these to the function parameters list so that, later on,
this function can be reused for the CAN XL TDC.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index f346b4208f1c..50c1658f17a4 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -136,15 +136,16 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 	return 0;
 }
 
-static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
+static int can_tdc_changelink(struct data_bittiming_params *dbt_params,
+			      bool tdc_is_enabled, const struct nlattr *nla,
 			      struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb_tdc[IFLA_CAN_TDC_MAX + 1];
 	struct can_tdc tdc = { 0 };
-	const struct can_tdc_const *tdc_const = priv->fd.tdc_const;
+	const struct can_tdc_const *tdc_const = dbt_params->tdc_const;
 	int err;
 
-	if (!tdc_const || !can_fd_tdc_is_enabled(priv))
+	if (!tdc_const || !tdc_is_enabled)
 		return -EOPNOTSUPP;
 
 	err = nla_parse_nested(tb_tdc, IFLA_CAN_TDC_MAX, nla,
@@ -179,7 +180,7 @@ static int can_tdc_changelink(struct can_priv *priv, const struct nlattr *nla,
 		tdc.tdcf = tdcf;
 	}
 
-	priv->fd.tdc = tdc;
+	dbt_params->tdc = tdc;
 
 	return 0;
 }
@@ -336,8 +337,8 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 		memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		if (data[IFLA_CAN_TDC]) {
 			/* TDC parameters are provided: use them */
-			err = can_tdc_changelink(priv, data[IFLA_CAN_TDC],
-						 extack);
+			err = can_tdc_changelink(&priv->fd, can_fd_tdc_is_enabled(priv),
+						 data[IFLA_CAN_TDC], extack);
 			if (err) {
 				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;
-- 
2.45.2


