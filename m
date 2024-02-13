Return-Path: <linux-can+bounces-240-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0637852E39
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 11:44:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FC991F256A1
	for <lists+linux-can@lfdr.de>; Tue, 13 Feb 2024 10:44:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B51D424B54;
	Tue, 13 Feb 2024 10:43:58 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51CCA24B24
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 10:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707821038; cv=none; b=DbSRwX+j6gHGeaYwfyOj5KXsKg9bNJH02oiI/5F0TdEhwzZm9Fehm6jm1bmzqTScXCb23evfJ1D4lTNJVmJOHPozFjMStum9ghW6DdkzwRkicfLUdo+Y59W51zLDjyhmlaorKjtJc8mus2TZCB/wNFTdHPd3DCJ9zRGWnBSNGtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707821038; c=relaxed/simple;
	bh=uPlvIFVTH5FLj43h+COsvaOy0/XUpFnl9YLEoOGxarw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=mJJEkRy+BBD2lkjzZmq5+N/1LaFzOPW7UkGTdOMYtYkEshZ8iKjW+H8whcAWa4041siIp83o/8gtltUtUtqk8JvvY84KsmRB0jdW8Zp53gfDXNnl3E3qDB1iEIXOQxoll2f11cSJhSGpmTlJAcfQ2oxzoS2XQB34+kxJXzOqq0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZqGZ-0004ER-Rj
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 11:43:55 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rZqGZ-000SsW-EP
	for linux-can@vger.kernel.org; Tue, 13 Feb 2024 11:43:55 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0E04B28D59D
	for <linux-can@vger.kernel.org>; Tue, 13 Feb 2024 10:43:55 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A373828D59B;
	Tue, 13 Feb 2024 10:43:54 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id f05ffb33;
	Tue, 13 Feb 2024 10:43:54 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 13 Feb 2024 11:43:51 +0100
Subject: [PATCH] MAINTAINERS: can: xilinx_can: remove Naga Sureshkumar
 Relli
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240213-xilinx_can-v1-1-79820de803ea@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAOdHy2UC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDIKFbkZmTmVcRn5yYp5uUkpxoaZpokGJknKQE1FBQlJqWWQE2LDq2thY
 AhBraHVwAAAA=
To: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Cc: linux-kernel@vger.kernel.org, linux-can@vger.kernel.org, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.13-dev-f0463
X-Developer-Signature: v=1; a=openpgp-sha256; l=991; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=uPlvIFVTH5FLj43h+COsvaOy0/XUpFnl9YLEoOGxarw=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBly0foJIKpCN1FnDUSl2+GbEAv/oqDCwsUbQTqZ
 AqqZNJUgEKJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZctH6AAKCRAoOKI+ei28
 b3QwB/9G6ItdZOFAHRN4rAEH2IdEiDFF4HXrPoL2t3gzSkeyjiqifpEOtZsT3Ot71SDyYeq5gqt
 BMigh8M8OSvlR0/F/jQBEZBilCW63+znsfvIIXGOO3OLwAK3vvckxJNOZQ2boU3ajp347Ib2t4b
 0J4zPpT0LwvG+ZJirXCTMdBVKisQINd8/G1wsDUk+HVgSNoqtlgN7oZLNEzJ1c3jv55d0cfrGIV
 IVdwZrwhpeRKnvOYvJPlzSxARdDCH+ojKm7NwXxV+ddSWrSDdtBNm+4984GfPjTdsTCAK9hl3OK
 rnwA6Y8w4v07ponGhX/qAavUB2Vk5wPjPOLMMmrVsveQzgxk
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Mails to naga.sureshkumar.relli@xilinx.com are bouncing due to a mail
loop. Seems Naga Sureshkumar Relli has left the company.

Remove Naga Sureshkumar Relli from the xilinx_can driver.

Cc: Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 000ef0e46c70..3e03092593f3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24142,7 +24142,6 @@ F:	drivers/net/ethernet/xilinx/xilinx_axienet*
 
 XILINX CAN DRIVER
 M:	Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
-R:	Naga Sureshkumar Relli <naga.sureshkumar.relli@xilinx.com>
 L:	linux-can@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/net/can/xilinx,can.yaml

---
base-commit: a3522a2edb3faf8cb98d38c2a99f5967beef24e2
change-id: 20240202-xilinx_can-bdca95a0d23b

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



