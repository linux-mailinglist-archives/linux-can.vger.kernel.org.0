Return-Path: <linux-can+bounces-5424-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E95FFC607DA
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 16:35:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 718AC4E13CD
	for <lists+linux-can@lfdr.de>; Sat, 15 Nov 2025 15:35:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71F8E1DBB3A;
	Sat, 15 Nov 2025 15:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="EsuJad+R"
X-Original-To: linux-can@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00A11286A9
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 15:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763220906; cv=none; b=FV9zjuhiyJNRyR32oJXo6is1VT02oqlEyJBgu2RQcofXdt+XfghXb8ft5Mfpo7OVCYlk/4siX9ebx47oq/bTpzAxrh1sGNWS0vXJ1k/GZU9RFmy4agmxTga9icFazWHxATcD+iSxyl0f1eRAa26N1qvcS2PGoAhU3uyAKQPqtaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763220906; c=relaxed/simple;
	bh=lWY3+k2Q+E3cYhZBJC0shhvIiYFmP2Li6xBhkCyLQvc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=c0d81UOr1qeB/9J/UsFTx9bceJ8XSQ2UohHtSpPyeP9OtihSA+ccAlJ2TXs0dxnpFiLSO7xl7XIftT1pGP0+5RkYZR2x9WfPfbDmghxGv09+z5fKs5G4HcQSdT0V+nt4Zyedjdxt/WAtIDswTDgh5RsTO30Pk4mbqSebS0Mt0AE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=EsuJad+R; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 533DA240101
	for <linux-can@vger.kernel.org>; Sat, 15 Nov 2025 16:34:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.net; s=2017;
	t=1763220896; bh=b/ha75gM5wiAr4oz8QQktbYWuG85XEdItL8PGc1tZ7g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=EsuJad+RA19j6WzobI+abOAlj2jGM1PX2ywmm9xbCJq9qeRnSMpLy3SMjX4oWXsi4
	 CGQh6ChEeuuggg7XtHZmt+6We0IaCqBSc7N/HHWlu/D5xRl0V1qgKMqjKldQnND98p
	 /Fj3B2QhCXBdTOdLbI8hRabEVzHkyOq2udrWWwXYqMLxrQbsqrgOF4+0TylivmIwe8
	 Ri+MJnd22Zbq1uxNfM1Ss9HgOaBawhvHJcXLWcy6gft5G65+KJ2BZWETanPJSBy0vY
	 JtrOl1jV2HnVdrGSQJoc+1wpgElXU0nH6vyYeT2aX2At5hG5/IFTrTzQQ6TQh0bfVM
	 r0fByeGCpFwJQ==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4d7yk74dKPz9rxB;
	Sat, 15 Nov 2025 16:34:55 +0100 (CET)
From: =?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
Subject: [PATCH] can: sja1000: fix max irq loop handling
Date: Sat, 15 Nov 2025 15:34:56 +0000
Message-ID: <20251115153437.11419-1-tmuehlbacher@posteo.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Reading the interrupt register `SJA1000_IR` causes all of its bits to be
reset. If we ever reach the condition of handling more than
`SJA1000_MAX_IRQ` IRQs, we will have read the register and reset all its
bits but without actually handling the interrupt inside of the loop
body.

This may, among other issues, cause us to never `netif_wake_queue()`
again after a transmission interrupt.

Fixes: 429da1cc841b ("can: Driver for the SJA1000 CAN controller")
Signed-off-by: Thomas Mühlbacher <tmuehlbacher@posteo.net>
---
 drivers/net/can/sja1000/sja1000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/sja1000/sja1000.c b/drivers/net/can/sja1000/sja1000.c
index 4d245857ef1c..83476af8adb5 100644
--- a/drivers/net/can/sja1000/sja1000.c
+++ b/drivers/net/can/sja1000/sja1000.c
@@ -548,8 +548,8 @@ irqreturn_t sja1000_interrupt(int irq, void *dev_id)
 	if (priv->read_reg(priv, SJA1000_IER) == IRQ_OFF)
 		goto out;
 
-	while ((isrc = priv->read_reg(priv, SJA1000_IR)) &&
-	       (n < SJA1000_MAX_IRQ)) {
+	while ((n < SJA1000_MAX_IRQ) &&
+	       (isrc = priv->read_reg(priv, SJA1000_IR))) {
 
 		status = priv->read_reg(priv, SJA1000_SR);
 		/* check for absent controller due to hw unplug */
-- 
2.51.2


