Return-Path: <linux-can+bounces-5108-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E85DBC668E
	for <lists+linux-can@lfdr.de>; Wed, 08 Oct 2025 21:08:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9CA6C4EDC78
	for <lists+linux-can@lfdr.de>; Wed,  8 Oct 2025 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B601B2C1595;
	Wed,  8 Oct 2025 19:08:10 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32512C0F81
	for <linux-can@vger.kernel.org>; Wed,  8 Oct 2025 19:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759950490; cv=none; b=IJzlFu4iF4arY4wvEDR13gsbD4xKSYMTtrwGDEEtOTMQLGTtFtOG8Hk+g/SsGB4tUTKszmBKOQphSADTlX4XW4rCA/efQIyt7Vvgi294OQgZa76MP20+CdNmmNyOrvpVL8EQavFggPc8vL5xJbrasrQWhqkKtLNsj33JEQkFj8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759950490; c=relaxed/simple;
	bh=RlNuKAoeu17R9ejquc+WYmEScR18yCzwYNcv7iVDAyg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pucF9AXZK4e9Zsd2UQYokEz6Jxgu64U8vmCumu3c0E4AR9Ni/Gj3OzcaKxWvKv0V1FslymKOAD03AcHcwGk1B3JXcZa3EfA4G1TqJTMdYFoloisDh+xAahawj8ej+Hq0ZLGF/6D7kzqqB+Jzo7WlvwFFUFOBzwfIfWkURo0hx5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW4-0003RR-3P; Wed, 08 Oct 2025 21:08:00 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v6ZW3-002cDM-1L;
	Wed, 08 Oct 2025 21:07:59 +0200
Received: from hardanger.blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 0F5164821FA;
	Wed, 08 Oct 2025 19:07:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Wed, 08 Oct 2025 21:07:41 +0200
Subject: [PATCH 6/7] can: m_can: m_can_tx_submit(): remove unneeded sanity
 checks
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-m_can-cleanups-v1-6-1784a18eaa84@pengutronix.de>
References: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
In-Reply-To: <20251008-m_can-cleanups-v1-0-1784a18eaa84@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol@kernel.org>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-92513
X-Developer-Signature: v=1; a=openpgp-sha256; l=773; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=RlNuKAoeu17R9ejquc+WYmEScR18yCzwYNcv7iVDAyg=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBo5raKLuCCiJLnkdusfwK/8PDZvqtR3TN671csa
 5IoIdRtUV6JATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaOa2igAKCRAMdGXf+ZCR
 nCDHB/9jYDnguJAFGqln3U6/2Bd0V1SwzZUWJ+ahZGXN1RcxrVT4kZwQEy74SjWZxYa+eYP50aQ
 03ttLkCGvwU62qc661dnSiB0Qi55YaenFJ1ZBke9Lv6rhB0J6CB8ze7g7aM9DE9kH12v7GjybjW
 wNrWDT2pHZgK5bjphGkNTOkwEoAL6ucX+Pe/eeFy/YqYKfE1gNkPTia6uWuy1E0UXhu7ugwy52E
 8n3XI4FuRN0ylL7BP+3VK7p1p2m4GskeBV/ckBYvD3y3WY8njszupxglF07Y4C4Q8lwTyyIuYVZ
 VId7k1M8BjIf3CWczYdJTctQWXZi5QnhCtbsxtzdtt13l1+5
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

m_can_tx_submit() is only called for peripheral devices. So remove the
sanity check.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 92a4feec4174..4451ea750b74 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -1960,11 +1960,6 @@ static netdev_tx_t m_can_tx_handler(struct m_can_classdev *cdev,
 
 static void m_can_tx_submit(struct m_can_classdev *cdev)
 {
-	if (cdev->version == 30)
-		return;
-	if (!cdev->is_peripheral)
-		return;
-
 	m_can_write(cdev, M_CAN_TXBAR, cdev->tx_peripheral_submit);
 	cdev->tx_peripheral_submit = 0;
 }

-- 
2.51.0


