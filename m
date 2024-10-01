Return-Path: <linux-can+bounces-1588-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D15EE98C132
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 17:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8B01C23B10
	for <lists+linux-can@lfdr.de>; Tue,  1 Oct 2024 15:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18CF1CB534;
	Tue,  1 Oct 2024 15:07:07 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847F11C9DD2
	for <linux-can@vger.kernel.org>; Tue,  1 Oct 2024 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727795227; cv=none; b=PDND+gcmdo1OR050KJ0253x6C8P5qkwYSnAB1vNLVBqGFP28wEjagJ1JuKP2zQ5e9+JZWjYk3TddOpU++OYCMw2W8kpsBc2+Vr/3glWOd3NCf0K+SvwxqhX3A/mlh1nF5LwJN7jGICBho96tHoZnXHWBqoD+Cso1YvJhfTRXMew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727795227; c=relaxed/simple;
	bh=L0zMbpgks/KY6ypYC/SM/wZ4pvaefGA2PCVTsCwzW0Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=kbRTT2pEDWAaYTxmEETCSUcqw1IDOikxX3cpn4ATXCdNr97f2oRVb6MztWnebu8E86opnoSkpDO+oXlCW3qArnl774Mu4CpZjq4lc6xy+XAGtEOplGCat+aW/XkeDgU+i40NntwWy2ybKvfKtU8//f33a/w0VtBCCs/6bbjIpGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sveSt-0005UN-QR
	for linux-can@vger.kernel.org; Tue, 01 Oct 2024 17:07:03 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sveSt-002u22-Cs
	for linux-can@vger.kernel.org; Tue, 01 Oct 2024 17:07:03 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1B505347C60
	for <linux-can@vger.kernel.org>; Tue, 01 Oct 2024 15:07:03 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B2EF1347C5A;
	Tue, 01 Oct 2024 15:07:01 +0000 (UTC)
Received: from [172.20.34.65] (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id edacce11;
	Tue, 1 Oct 2024 15:07:01 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 01 Oct 2024 17:06:58 +0200
Subject: [PATCH RFC can] can: mcp251xfd: mcp251xfd_get_tef_len(): fix
 length calculation
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241001-mcp251xfd-fix-length-calculation-v1-1-598b46508d61@pengutronix.de>
X-B4-Tracking: v=1; b=H4sIABEQ/GYC/x2NQQrCMBBFrxJm7cBMqIJuBQ/gtrhIp9N2IMaS1
 FIovbvB5YP//tuhaDYtcHM7ZF2t2CdV4JMDmUIaFa2vDJ58w0SMb5n9mbehx8E2jJrGZUIJUb4
 xLFVGunYXEaagHUG9mbPW5T/RwvNxdxISvI7jB/SFbZZ7AAAA
X-Change-ID: 20241001-mcp251xfd-fix-length-calculation-09b6cc10aeb0
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-can@vger.kernel.org, kernel@pengutronix.de, 
 Sven Schuchmann <schuchmann@schleissheimer.de>, 
 Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-dedf8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1865; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=L0zMbpgks/KY6ypYC/SM/wZ4pvaefGA2PCVTsCwzW0Q=;
 b=owEBbQGS/pANAwAKASg4oj56LbxvAcsmYgBm/BAS6U1BrA5QYCKj6fCJ/mfJK5dzfqVeWr/G5
 I5JYP7xgYKJATMEAAEKAB0WIQRQQLqG4LYE3Sm8Pl8oOKI+ei28bwUCZvwQEgAKCRAoOKI+ei28
 b48vB/0ZGQcUlNlUmqQYg7QexL9Kcoc1b1XgsTae1oY52VW0qR/n5oQ/0ZC3KEahiO9VjuD06Kb
 Xq/c43Cr3W8JJeqSbIosOXxdW34oFD7G3yUBl78L28WVXM9VKrrT2FVjJAjXBl9OoTacP8I4Of9
 dSE/g3cRgqGV4CwiMo8UE0XkQtUCr7yH8sJYZ/PcO3iOlwMf4b4nRZlpKmziP37vRGEoUzMgjAe
 lCUPBNaYITi/48GvCLAMF4QDAXq4IVbfv4gBrEj9e4fcffuY/VEgFkgHSGAR+p12A331UPGVFmT
 y22h9HPAG27RS8SnA3QL43shfekTmyBvOhwVxOV4fvjeU941
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

I think the length calculation is wrong. Can you try this compile
tested only patch. I'll add a proper patch description later.

Marc
---
 drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
index f732556d233a7be3b43f6f08e0b8f25732190104..e40a6d4134c29b32baeda7ad3dbaf4de27b54ba3 100644
--- a/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
+++ b/drivers/net/can/spi/mcp251xfd/mcp251xfd-tef.c
@@ -16,9 +16,9 @@
 
 #include "mcp251xfd.h"
 
-static inline bool mcp251xfd_tx_fifo_sta_full(u32 fifo_sta)
+static inline bool mcp251xfd_tx_fifo_sta_empty(u32 fifo_sta)
 {
-	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFNRFNIF);
+	return !(fifo_sta & MCP251XFD_REG_FIFOSTA_TFERFFIF);
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
base-commit: d505d3593b52b6c43507f119572409087416ba28
change-id: 20241001-mcp251xfd-fix-length-calculation-09b6cc10aeb0

Best regards,
-- 
Marc Kleine-Budde <mkl@pengutronix.de>



