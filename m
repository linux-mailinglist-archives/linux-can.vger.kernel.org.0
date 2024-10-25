Return-Path: <linux-can+bounces-1774-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C6D9AFF21
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 11:58:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C0A12825AA
	for <lists+linux-can@lfdr.de>; Fri, 25 Oct 2024 09:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04FC11CBA1D;
	Fri, 25 Oct 2024 09:57:57 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF161BCA0C
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2024 09:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729850276; cv=none; b=G8JZhdl6OAqFIIOI2ODVE09xcYzPjnJOkhjpsTsc7CuEkoZm+ydOKMf6HRXHwXCjsiApTmHO0Fr/tiHja90kUvfB/jWHufb8U7NhHHpBMaPKK6NG/qZ1uXmAqyRCZjcDgrAkF/YM1VbFYZvasQ+Hl8BMzZc68H9GyITPF3raTvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729850276; c=relaxed/simple;
	bh=DIPs0Lxg5Q1OaB65aMkYsmUm8oW3dN9Mxm7wgnA4PzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cfAoou/9osulmrns8Qi0xScu0V4zzHwVIUEMX9mIMcXY204koa/5TpLIqlYKrcafRZp7dbM/7XCx9qQ1YT2TD3CWRJvMXqGZo6UTz+utgJ96LZB1ZkmMpgrEqADLd1/QIfERLdKj+cP39nFK5Ulp1fK9OYeUOPBJWKKcV4WsWHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4H4o-00088m-U3
	for linux-can@vger.kernel.org; Fri, 25 Oct 2024 11:57:50 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1t4H4o-000LLj-2M
	for linux-can@vger.kernel.org;
	Fri, 25 Oct 2024 11:57:50 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 666A235E90C
	for <linux-can@vger.kernel.org>; Fri, 25 Oct 2024 09:57:50 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id E7E5535E906;
	Fri, 25 Oct 2024 09:57:48 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8a3b4e8f;
	Fri, 25 Oct 2024 09:57:48 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Fri, 25 Oct 2024 11:57:43 +0200
Subject: [PATCH RFC can v2] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241025-mcp251xfd-fix-length-calculation-v2-1-ea5db778b950@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIAJdrG2cC/42NTQqDMBBGryKz7pRMUNGuCoUeoNviIiajBmyUJ
 IpFvHuDJ+jy8f28HQJ7ywFu2Q6eVxvs5BLISwZ6UK5ntCYxSCFzEoLwo2dZ0NYZ7OyGI7s+Dqj
 VqJdRxTRGUbel1iQUtwLSzew5NU/FG17PR6aVgyYFgw1x8t9TvdIZ/29ZCQmLumrzshCVKek+p
 9IS/eTsdjUMzXEcPwBHfnfeAAAA
X-Change-ID: 20241001-mcp251xfd-fix-length-calculation-09b6cc10aeb0
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Sven Schuchmann <schuchmann@schleissheimer.de>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1989; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=DIPs0Lxg5Q1OaB65aMkYsmUm8oW3dN9Mxm7wgnA4PzY=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBnG2uZfMsEAxrIpKzDXNVNYqfkOnPwd4AL9E9oU
 7fB3eCypaWJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZxtrmQAKCRAoOKI+ei28
 b3sQB/wNIOHe0x5YhCUo/3Icmrfdyk9z4N0xd4tPDlNkfsTlVOl2PzccW9oT36ZdoV0c95w/1i+
 0/wOqDDahjWLxJjYFuzVPwtIOT1kNhbBGXXMx2ikHSqefPsB4gHId14C7Qr+O+r6XMqGUzjXdlO
 OUmTSMVzSY6zOJ2tvi0sl5WebJMojPdjSvBtQ9sttKUliNeYJlLuOd/uaowH+ATP9qh6JVvbmzh
 3C7ahOSYm5MmZ9z6FJBxK6gXloUaYHwL1krYSOtHVM0+g3x/4c6sFm2bj9/lH42lUo4DSZ/wfxD
 6swBbjq1dS64oxQdLlqjqbxLgi/n9r6hjaJSISZQSrKJLCSO
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Reported-by: Sven Schuchmann <schuchmann@schleissheimer.de>
Closes: https://patch.msgid.link/FR3P281MB155216711EFF900AD9791B7ED9692@FR3P281MB1552.DEUP281.PROD.OUTLOOK.COM
Fixes: b8e0ddd36ce9 ("can: mcp251xfd: tef: prepare to workaround broken TEF FIFO tail index erratum")
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
Hello,

I got the empty check wrong and fixed it. Please test.

Marc
---
Changes in v2:
- mcp251xfd_tx_fifo_sta_empty(): fix check if TX-FIFO is empty
- Link to RFC: https://patch.msgid.link/20241001-mcp251xfd-fix-length-calculation-v1-1-598b46508d61@pengutronix.de
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index f732556d233a7be3b43f6f08e0b8f25732190104..d3ac865933fdf6c4ecdd80ad4d7accbff51eb0f8 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -16,9 +16,9 @@
 
 #include "mcp251xfd.h"
 
-static inline bool mcp251xfd_tx_fifo_sta_full(u32 fifo_sta)
+static inline bool mcp251xfd_tx_fifo_sta_empty(u32 fifo_sta)
 {
-	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+	return fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF;
 }
 
 static inline int
@@ -122,7 +122,11 @@ mcp251xfd_get_tef_len(struct mcp251xfd_priv *priv, u8 *len_p)
 	if (err)
 		return err;
 
-	if (mcp251xfd_tx_fifo_sta_full(fifo_sta)) {
+	/* If the chip says the TX-FIFO is empty, but there are no TX
+	 * buffers free in the ring, we assume all have been sent.
+	 */
+	if (mcp251xfd_tx_fifo_sta_empty(fifo_sta) &&
+	    mcp251xfd_get_tx_free(tx_ring) == 0) {
 		*len_p = tx_ring->obj_num;
 		return 0;
 	}

---
base-commit: 9efc44fb2dba6138b0575826319200049078679a
change-id: 20241001-mcp251xfd-fix-length-calculation-09b6cc10aeb0

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



