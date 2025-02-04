Return-Path: <linux-can+bounces-2729-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52208A27674
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 16:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5809A3A228F
	for <lists+linux-can@lfdr.de>; Tue,  4 Feb 2025 15:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B202144DB;
	Tue,  4 Feb 2025 15:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="VMSNN1dq"
X-Original-To: linux-can@vger.kernel.org
Received: from out.smtpout.orange.fr (out-15.smtpout.orange.fr [193.252.22.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A4E2144BF;
	Tue,  4 Feb 2025 15:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738684245; cv=none; b=H/iUDSayZ+quY9nOCb7qLoOTV2PWLGuJzhcZLJqhhE3TRh5iYQgffTILklcMx4jBuD2pzzrad3P9SLZjKbIiyaMi4/+p6w+D4gfA3tt+WdNAUaLioCAo/nQFy7S3PfM1LI5Hhr4xlyT/zVLBYy51nggImXXTL/q5cslDb21uT9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738684245; c=relaxed/simple;
	bh=hgq6PLLzwquAwcoJjWjAeIA7AfelQlL9J3oyq/pQXnI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ELre4KlXIP2tZqC5aBhxycSQUzMntPtVrXUh0VZhOULWFwjuH9BqFlsZ56nZqLVO/BXEqSonoBNNsgYgaLZ39v2BBncOpsPyP0XxXtGcWk4OU36+LlQDtSeVxk88H8F9CBe061iLEgV/k+yPi1kxgfRuGHrqO60A+o4y84SClVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=VMSNN1dq; arc=none smtp.client-ip=193.252.22.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from localhost.localdomain ([124.33.176.97])
	by smtp.orange.fr with ESMTPA
	id fLAnt8hotUbA0fLAztNaVY; Tue, 04 Feb 2025 16:49:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1738684168;
	bh=rRDeSQnod8uSP7ynJ/SgjIL7urMg+AxKe9ansz1nwIE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=VMSNN1dqivivCcInaUqQJNk8/Y8NdOquRgHGcLjX9B8ONEXlpT5Y9sSMgqRaQTGVs
	 RKhLW2UNIMb1sVWBDzMDJ+xVt7tV+X6P55ISrYES7IaMDOT9x+Q9ZlvTadK6tBk8NE
	 5mGMLUwbVUtySHvjodL3BVjUdEjzIsTk1+7HWnDtX+16EJmN4y7ZbwI5TzOTyqeaty
	 FXSvXKc3lxgzIRSPnc+7zuMbVTME5ZuFGzDlP50/L+ZqFZ9WoKC4zaopLcNI2xYzlI
	 mTAUI/X2nZ+O6Lv/IiHSiG2lfmtFp+NOMquCA9aDz6/Dvl42rgVM5WFbW8Vope/sv0
	 qvrHe3oYFhvqQ==
X-ME-Helo: localhost.localdomain
X-ME-Auth: bWFpbGhvbC52aW5jZW50QHdhbmFkb28uZnI=
X-ME-Date: Tue, 04 Feb 2025 16:49:28 +0100
X-ME-IP: 124.33.176.97
From: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
To: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	yan kang <kangyan91@outlook.com>,
	yue sun <samsun1006219@gmail.com>
Subject: [PATCH] can: etas_es58x: fix potential NULL pointer dereference on udev->serial
Date: Wed,  5 Feb 2025 00:48:15 +0900
Message-ID: <20250204154859.9797-2-mailhol.vincent@wanadoo.fr>
X-Mailer: git-send-email 2.45.3
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1450; i=mailhol.vincent@wanadoo.fr; h=from:subject; bh=hgq6PLLzwquAwcoJjWjAeIA7AfelQlL9J3oyq/pQXnI=; b=owGbwMvMwCV2McXO4Xp97WbG02pJDOmLzF5/aHw6//C1FqfLW53faL4VC3Td8niG5X5Jpb0X4 4Xe3cyK7yhlYRDjYpAVU2RZVs7JrdBR6B126K8lzBxWJpAhDFycAjCRbjeG/y5b/zkt3r+4+HtO vAafBoP/5v7LPNy6Ppd+auhz8pqJpTD8sw39cVCmUoHPS9z7KBO3khJXq5qO8B9pk0szqyTXuJ9 jAQA=
X-Developer-Key: i=mailhol.vincent@wanadoo.fr; a=openpgp; fpr=ED8F700574E67F20E574E8E2AB5FEB886DBB99C2
Content-Transfer-Encoding: 8bit

The driver assumed that es58x_dev->udev->serial could never be NULL.
While this is true on commercially available devices, an attacker
could spoof the device identity providing a NULL USB serial number.
That would trigger a NULL pointer dereference.

Add a check on es58x_dev->udev->serial before accessing it.

Reported-by: yan kang <kangyan91@outlook.com>
Reported-by: yue sun <samsun1006219@gmail.com>
Closes: https://lore.kernel.org/linux-can/SY8P300MB0421E0013C0EBD2AA46BA709A1F42@SY8P300MB0421.AUSP300.PROD.OUTLOOK.COM/
Fixes: 9f06631c3f1f ("can: etas_es58x: export product information through devlink_ops::info_get()")
Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
---
 drivers/net/can/usb/etas_es58x/es58x_devlink.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/usb/etas_es58x/es58x_devlink.c b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
index eee20839d96f..0d155eb1b9e9 100644
--- a/drivers/net/can/usb/etas_es58x/es58x_devlink.c
+++ b/drivers/net/can/usb/etas_es58x/es58x_devlink.c
@@ -248,7 +248,11 @@ static int es58x_devlink_info_get(struct devlink *devlink,
 			return ret;
 	}
 
-	return devlink_info_serial_number_put(req, es58x_dev->udev->serial);
+	if (es58x_dev->udev->serial)
+		ret = devlink_info_serial_number_put(req,
+						     es58x_dev->udev->serial);
+
+	return ret;
 }
 
 const struct devlink_ops es58x_dl_ops = {
-- 
2.45.3


