Return-Path: <linux-can+bounces-1926-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EDC9C33AB
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 16:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DFFF0B20C23
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 826A485956;
	Sun, 10 Nov 2024 15:59:40 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7F9F22097
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254380; cv=none; b=npcTRWEqjTdw3FyLxdqOXECYlMrNYfJF4jQ33wwT/StZ4hW2iBBgttmj+zKZwsaulBwVl2CsQ1ErZzP7k2NKE97bUr1e52Xnj8v0vxRE1z5NUxtB5uyX/FMv2dsKpPznbDdI5jnE9Wv/IyAf3TfPTMS1yCh21bEL/CQaAg0PXuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254380; c=relaxed/simple;
	bh=TGsZQkUAIjws0xAT9C/EhdBcOLf1sKWYO14fSrVJxTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U4PFXxn7yRN3FKmglsPCc+2N9k53TkPqGrmqSAEb91+tqMTkWkXyThahKZz7oaihTRk8yi8rKBJM+/1D9GgVa8akwBgbnJfSRgXIbIpw+2TB7W0kNbHS5SkIlJYon62GgWhvQOIlFLfhzp6whmPpPQrNvXE9z/C7OnG+4XpLktU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-720b2d8bcd3so2943444b3a.2
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254378; x=1731859178;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4uwmgASRQnIZqtiJIfT2RD5X8JJVQJLUhw9F/Yt1MRY=;
        b=NK1R3sMnnznHOvbTUW0lpizxTFUhdzV/+PVzbzfFefTYVYm3CDBPHpdC4yWTvXHNlG
         RGCeGgOf3JUunq4G0GVItZHXtIRgajWX18DHxRVLiRekFe+NBNf9OiwJlQv5l5NOlZJZ
         fWTt5fNq0/HJTmYvJRwNGAJETaqf6uKoVEdO3zdZasc21JUDhtghg8KLEIq2RiPLGZLW
         wZmNd3s4wt81cMgTMwMrusDtQ6plO2O3bX5coZnEItZJ+VJbgGw56P2ovsxMWAPlm9xW
         vUDZ8R17O+RkT4TuqE5xBwgEcVHlFFyEY3pihJBKvnpl/uwN8YIGmwrGfTmcqVafe7G1
         fwhw==
X-Gm-Message-State: AOJu0Ywfgi7s62Oa/+Pspu/+NKAnK0+1URW67WfuYwYhQPE+LFZycmPY
	/29cg91EdfS/m5i+pouR2B2o9Wvv7d2PuFEF1hq08exWXWTpCuQbqjxwUA==
X-Google-Smtp-Source: AGHT+IFGnH1N+/K0ebsvZ6QfYM7vpSIbZiIr27etngA+ZSJspjl7zs5GyP2b3CrwcA4Yi+SlTef3fQ==
X-Received: by 2002:a05:6a00:a09:b0:71e:7cb2:57e7 with SMTP id d2e1a72fcca58-7241328bcdcmr14171088b3a.10.1731254377841;
        Sun, 10 Nov 2024 07:59:37 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:37 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 05/14] can: netlink: can_changelink(): rename tdc_mask into fd_tdc_flag_provided
Date: Mon, 11 Nov 2024 00:55:54 +0900
Message-ID: <20241110155902.72807-21-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1933; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=TGsZQkUAIjws0xAT9C/EhdBcOLf1sKWYO14fSrVJxTk=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGNwLdlTzjJ++r+tvO467+J/fUAYvp38NkttY8SjA4E XzjSLVhRykLgxgXg6yYIsuyck5uhY5C77BDfy1h5rAygQxh4OIUgInIRDH8D2OpE/qis1U2edET DgY9iWPP4vtjZzvszmC+ZrWw2d73MsNfeYXM20xszxsuzDh7chcPY84hKYanTLOla58aWrwSLb7 MCQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The only purpose of the tdc_mask variable is to check whether or not
any tdc flags (CAN_CTRLMODE_TDC_{AUTO,MANUAL}) were provided. At this
point, the actual value of the flags do no matter anymore because
these can be deduced from some other information.

Rename the tdc_mask variable into fd_tdc_flag_provided to make this
more explicit. Note that the fd_ prefix is added in preparation of the
introduction of CAN XL.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/dev/netlink.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 27168aa6db20..f346b4208f1c 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -189,7 +189,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			  struct netlink_ext_ack *extack)
 {
 	struct can_priv *priv = netdev_priv(dev);
-	u32 tdc_mask = 0;
+	bool fd_tdc_flag_provided = false;
 	int err;
 
 	/* We need synchronization with dev->stop() */
@@ -234,11 +234,11 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 			memset(&priv->fd.tdc, 0, sizeof(priv->fd.tdc));
 		}
 
-		tdc_mask = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
+		fd_tdc_flag_provided = cm->mask & CAN_CTRLMODE_FD_TDC_MASK;
 		/* CAN_CTRLMODE_TDC_{AUTO,MANUAL} are mutually
 		 * exclusive: make sure to turn the other one off
 		 */
-		if (tdc_mask)
+		if (fd_tdc_flag_provided)
 			priv->ctrlmode &= cm->flags | ~CAN_CTRLMODE_FD_TDC_MASK;
 	}
 
@@ -342,7 +342,7 @@ static int can_changelink(struct net_device *dev, struct nlattr *tb[],
 				priv->ctrlmode &= ~CAN_CTRLMODE_FD_TDC_MASK;
 				return err;
 			}
-		} else if (!tdc_mask) {
+		} else if (!fd_tdc_flag_provided) {
 			/* Neither of TDC parameters nor TDC flags are
 			 * provided: do calculation
 			 */
-- 
2.45.2


