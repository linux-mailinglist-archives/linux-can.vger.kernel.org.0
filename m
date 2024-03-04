Return-Path: <linux-can+bounces-350-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D738286FB0F
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 08:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F3E2B210F9
	for <lists+linux-can@lfdr.de>; Mon,  4 Mar 2024 07:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1A514A93;
	Mon,  4 Mar 2024 07:45:12 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F2A168DF
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 07:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538312; cv=none; b=gguHdF4sSMLwp8FBKcIhRs2tqv2xtNfNdfEOg6VLQW4T5FD6uYhjTw3l0cGshTokJP9cpKbOGgJqaUPscXXm4+GV0DvpnR+Gl0hQ8e9koBfLvqdXHmP66KMi7MaDxKimG9vL7Kt4h3JoeLK1R2aWloLuJgvghHAy8GEHTVha0Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538312; c=relaxed/simple;
	bh=kbyz4B5Lsk6DSbmtuWM7QgTXQiebPs1g1aWop77MUOs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hDI2soy9Gf2ubkV19jK4yCO81K1U+XoQ67APnLVHS56WvIlYSLzd+pBFOG9a3C1KPhoNtUFYhAAMND2vMHhhOZ4Z2PQBTvQHDMSdDpLnuPUuSsOW+LIWUYfLvOQR4+rSgttm1jwylX75fx1lGyWIXQefiXP6wEpFlFqVxs2eFPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh30V-0002Gi-QS
	for linux-can@vger.kernel.org; Mon, 04 Mar 2024 08:45:07 +0100
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1rh30V-004J4m-DZ
	for linux-can@vger.kernel.org; Mon, 04 Mar 2024 08:45:07 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1EB8E29C9AD
	for <linux-can@vger.kernel.org>; Mon,  4 Mar 2024 07:45:07 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 6705E29C9AA;
	Mon,  4 Mar 2024 07:45:06 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 19ac0df9;
	Mon, 4 Mar 2024 07:45:06 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: linux-can@vger.kernel.org
Cc: kernel@pengutronix.de,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH can-next] can: mcp251xfd: __mcp251xfd_get_berr_counter(): use CAN_BUS_OFF_THRESHOLD instead of open coding it
Date: Mon,  4 Mar 2024 08:44:50 +0100
Message-ID: <20240304074503.3584662-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Since 3f9c26210cf8 ("can: error: add definitions for the different CAN
error thresholds") we have proper defines for the various CAN error
thresholds. So make use of it and replace 256 by
CAN_BUS_OFF_THRESHOLD.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
index eebf967f4711..1d9057dc44f2 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-core.c
@@ -837,7 +837,7 @@ static int __mcp251xfd_get_berr_counter(const struct net_device *ndev,
 		return err;
 
 	if (trec & MCP251XFD_REG_TREC_TXBO)
-		bec->txerr = 256;
+		bec->txerr = CAN_BUS_OFF_THRESHOLD;
 	else
 		bec->txerr = FIELD_GET(MCP251XFD_REG_TREC_TEC_MASK, trec);
 	bec->rxerr = FIELD_GET(MCP251XFD_REG_TREC_REC_MASK, trec);
-- 
2.43.0



