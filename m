Return-Path: <linux-can+bounces-1934-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE299C33B1
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 17:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E75F2281212
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2024 15:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6311254670;
	Sun, 10 Nov 2024 15:59:55 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 026EA4CDEC
	for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 15:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731254395; cv=none; b=ShfM8vyehTo9z3TXodwuKGw5ZxrYrRQn0leEuafVJqv4QtwEtXxij47e2NG3q9GnuLPC0K5trndolE5UmOpzB0W/A1Pgr6moEDV2BJCnBeRj3ukXk+oIQdwhFnQdwRsr7+zHbvumRE0AOSq+P5cgGcG0NmEowuhJxv7jrlKaWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731254395; c=relaxed/simple;
	bh=kU5ds4lkdPc6fQnlyi6Fr5Don+AeGG92qQETZ9gQa0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VX8L+yvgsGRJmPUDinDqT+rbiw7pD9DsOepXJxx2j0aVRRZ79W84Tk2rRxijieJ9t6wUmqsI5zKdFbKm2iAWy1gd8lazxs+BKS5ceBNVLnpRFLBxxwIMNGH78Q6yajrMRI0FM6YaMHZZLNxoGEvtZNUZPjsbaS43juI6dHsWBcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7206304f93aso3463444b3a.0
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2024 07:59:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731254393; x=1731859193;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vAikuunZHLYTv9EXmhiiKgpX5GddQJudHN+YLX0b3tw=;
        b=YHgvRD57UC2fBKTUH5i3rorDzQni0kGp+geqAwua0eA1j3HZbTCFIC0zOFg+LGPDNu
         /hyEOXjFCAzEGC5dkQ+8bmuIuReeigJEHNch/Ij6yfQnwH0jz3nMD7DY/JAnBbeF2NwL
         tX7QxnB6MiVcE8TOobg6LDuqHKjPVkRNbKk10ES8FBJU/sltuuMW52ONgMjez58jqWOz
         dcHIp2Qk7c4WHyPSS7JQ4z2t65i0mxo+MFcZ/vqXS6qPYekp+vzJd0UjbO7hWn4L4QQq
         geSA3pj1s1wInW0vnkz0TZB7tB+XP1oVVw9bhXShQYdAXejPx1ZFjC6iZbqzkHfXMtWf
         wFSA==
X-Gm-Message-State: AOJu0YxmSztb9qBtEd1oXRDVw0XE47irlSG9KtRr1Gem3bbbbvNHT4nC
	vT1gMzH9p7MaQOMohYFdB9z/VR7LoIuav7ImT+vR2ZPlgzc1a2yO0nS/zA==
X-Google-Smtp-Source: AGHT+IEU736vH04fL+pS7wXIN58ZHEG3zl27xMDepe+zG3f9uOxHZCj8Ftfu8VViJ64zy809b7gJhA==
X-Received: by 2002:a05:6a00:21ca:b0:71e:fb4:6c98 with SMTP id d2e1a72fcca58-724133a2455mr13266197b3a.23.1731254393080;
        Sun, 10 Nov 2024 07:59:53 -0800 (PST)
Received: from localhost.localdomain (124x33x176x97.ap124.ftth.ucom.ne.jp. [124.33.176.97])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724078609ddsm7490959b3a.22.2024.11.10.07.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Nov 2024 07:59:52 -0800 (PST)
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>
Cc: Robert Nawrath <mbro1689@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Subject: [RFC PATCH 13/14] can: netlink: add userland error messages
Date: Mon, 11 Nov 2024 00:56:02 +0900
Message-ID: <20241110155902.72807-29-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
References: <20241110155902.72807-16-mailhol.vincent@wanadoo.fr>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3404; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=kU5ds4lkdPc6fQnlyi6Fr5Don+AeGG92qQETZ9gQa0U=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOkGN4J1Gta/t2Z/FR/vzm5czL1V7dKmuD/TzY5VxceIc pizXHnaUcrCIMbFICumyLKsnJNboaPQO+zQX0uYOaxMIEMYuDgFYCLhaxj+6agtdg75ZW+vFhpT 6v6/6LT9Ba9eIavO8j+9gsqGd/2LGBmW1xzYLqIbs3bRzgnH3X5fvmL6vmHBydU151mOrxap+/C NGQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

Use NL_SET_ERR_MSG_FMT() to return meaningfull error messages to the
userland whenever the validation of the CAN netlink arguments fails.

Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
See this one as a WIP. I wrote this quickly. I will revisit and
rephrase when dropping the RFC tag of this series.

Also, do not try to imagine that I wrote this because I forgot how to
provide to can bittiming arguments to the ip tool. This patch is only
meant to help the newcommers, nothing else :D
---
 drivers/net/can/dev/netlink.c | 40 ++++++++++++++++++++++++++++-------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 3c89b304c5b8..0a6700194ab0 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -124,8 +124,11 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 				       cm->flags & CAN_CTRLMODE_TDC_AUTO,
 				       cm->flags & CAN_CTRLMODE_TDC_MANUAL,
 				       extack);
-		if (err)
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "TDC parameters are incorrect");
 			return err;
+		}
 	}
 
 	if (data[IFLA_CAN_BITTIMING]) {
@@ -133,26 +136,41 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 
 		memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));
 		err = can_validate_bittiming(&bt, extack);
-		if (err)
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Nominal bittiming parameters are incorrect");
 			return err;
+		}
 	}
 
 	if (is_can_fd) {
-		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING])
+		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_DATA_BITTIMING]) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Provide both nominal and FD data bittiming");
 			return -EOPNOTSUPP;
+		}
 	}
 	if (is_can_xl) {
-		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_XL_DATA_BITTIMING])
+		if (!data[IFLA_CAN_BITTIMING] || !data[IFLA_CAN_XL_DATA_BITTIMING]) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "Provide both nominal and XL data bittiming");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	if (data[IFLA_CAN_DATA_BITTIMING] || data[IFLA_CAN_TDC]) {
-		if (!is_can_fd)
+		if (!is_can_fd) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "CAN FD is required to use FD data bittiming or FD TDC");
 			return -EOPNOTSUPP;
+		}
 	}
 	if (data[IFLA_CAN_XL_DATA_BITTIMING] || data[IFLA_CAN_XL_TDC]) {
-		if (!is_can_xl)
+		if (!is_can_xl) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "CAN XL is required to use XL data bittiming or XL TDC");
 			return -EOPNOTSUPP;
+		}
 	}
 
 	if (data[IFLA_CAN_DATA_BITTIMING]) {
@@ -160,16 +178,22 @@ static int can_validate(struct nlattr *tb[], struct nlattr *data[],
 
 		memcpy(&bt, nla_data(data[IFLA_CAN_DATA_BITTIMING]), sizeof(bt));
 		err = can_validate_bittiming(&bt, extack);
-		if (err)
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "FD data bittiming parameters are incorrect");
 			return err;
+		}
 	}
 	if (data[IFLA_CAN_XL_DATA_BITTIMING]) {
 		struct can_bittiming bt;
 
 		memcpy(&bt, nla_data(data[IFLA_CAN_XL_DATA_BITTIMING]), sizeof(bt));
 		err = can_validate_bittiming(&bt, extack);
-		if (err)
+		if (err) {
+			NL_SET_ERR_MSG_FMT(extack,
+					   "FD data bittiming parameters are incorrect");
 			return err;
+		}
 	}
 
 	return 0;
-- 
2.45.2


