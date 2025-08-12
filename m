Return-Path: <linux-can+bounces-4213-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3660CB22F54
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 19:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E98D682252
	for <lists+linux-can@lfdr.de>; Tue, 12 Aug 2025 17:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AC1D2FF14F;
	Tue, 12 Aug 2025 17:37:27 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2BF72FDC4B
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020247; cv=none; b=K+J+13Ct/k3Frh5q1V/wzl1VctJpBMAxHUMx6eYah3NXXggn7DojfOxC2bGGv3+pNL2p8nGHwhKHKMem1SXFq6/72/s5aTnonb940/k4SuIYkf2NHappyzF1mBBfDthlYIrSJxx3kNKfeOC5MvHMpP4ISjDO7Oc0gnV3eYLSknI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020247; c=relaxed/simple;
	bh=4QosE3H82o+BIBanXec+XaasUKH495dBom5k4ZPKLLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oDPibzHn6ohQSSIZd6A3ZxnocmMdd2kRyrPYGB76dmpt27v6IOCWCFyPDwc+yuBZP4qYf08YJRU9kdLo0PbG7u3Pl9fTbyTNUBVLQwfKeVRde+tCbQHJxx95eExkjvqOqE/FPGNH5TvXKE3E+ARYix3mbqMrNoVMmJSDSW2T9Kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw7-0008OQ-Q6
	for linux-can@vger.kernel.org; Tue, 12 Aug 2025 19:37:23 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1ulsw7-00DEcg-0d
	for linux-can@vger.kernel.org;
	Tue, 12 Aug 2025 19:37:23 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D9CAA45625F
	for <linux-can@vger.kernel.org>; Tue, 12 Aug 2025 17:37:22 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 97DDE456202;
	Tue, 12 Aug 2025 17:37:17 +0000 (UTC)
Received: from hardanger.blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 3a13c453;
	Tue, 12 Aug 2025 17:37:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
Date: Tue, 12 Aug 2025 19:36:56 +0200
Subject: [PATCH 6/7] can: m_can: m_can_get_berr_counter(): don't wake up
 controller if interface is down
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-m_can-fix-state-handling-v1-6-b739e06c0a3b@pengutronix.de>
References: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
In-Reply-To: <20250812-m_can-fix-state-handling-v1-0-b739e06c0a3b@pengutronix.de>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 Patrik Flykt <patrik.flykt@linux.intel.com>, 
 Dong Aisheng <b29396@freescale.com>, Fengguang Wu <fengguang.wu@intel.com>, 
 Varka Bhadram <varkabhadram@gmail.com>, Wu Bo <wubo.oduw@gmail.com>, 
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-can@vger.kernel.org, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de, Marc Kleine-Budde <mkl@pengutronix.de>
X-Mailer: b4 0.15-dev-e44bb
X-Developer-Signature: v=1; a=openpgp-sha256; l=892; i=mkl@pengutronix.de;
 h=from:subject:message-id; bh=4QosE3H82o+BIBanXec+XaasUKH495dBom5k4ZPKLLY=;
 b=owEBbQGS/pANAwAKAQx0Zd/5kJGcAcsmYgBom3vIsM6EBlLJrHCJog96c4xbEju9IpTsI+k/T
 KbT31BdFXGJATMEAAEKAB0WIQSf+wzYr2eoX/wVbPMMdGXf+ZCRnAUCaJt7yAAKCRAMdGXf+ZCR
 nL4yCACSPOZ4Z1UT4XZ7ga6EYHPkwY54dQKAIz7O3DDYrDpzj+4LWAoVBiHjcWlERrPo3Tf4sMN
 GFqwemcryJT1jKaBDCrSgMdRY6bBhJYWdcCHaBNWo5z5D1cN541nJATqae0QEs1hG1tmDR8s2Ww
 5eI5Fd6pnivS5T7Gt9cj2dzygnIQkhXPtVajIRYKFOgi0CnLZ5dj9BQtMgRXLyeDl7hx9a4PTJR
 wXdhYZ3jfGa5dwaHfTANOMlox/gCx9xPV26M0njs0AjUR0v6LzYW6Y+ZvzS7SDVLKxvBsjKZe16
 1rem7Q7vwMCJXrRMG7IJkQDrCZHaKg6rljGcb5UesCxbFVfz
X-Developer-Key: i=mkl@pengutronix.de; a=openpgp;
 fpr=C1400BA0B3989E6FBC7D5B5C2B5EE211C58AEA54
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

If the interface is down, the CAN controller might be powered down,
the clock disabled, and/or it's external reset asserted.

Don't wake up the controller to read the CAN bus error counters, if
the interface is down.

Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/m_can.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/can/m_can/m_can.c b/drivers/net/can/m_can/m_can.c
index 149f3a8b5f7e..c24ea0e5599f 100644
--- a/drivers/net/can/m_can/m_can.c
+++ b/drivers/net/can/m_can/m_can.c
@@ -790,6 +790,10 @@ static int m_can_get_berr_counter(const struct net_device *dev,
 	struct m_can_classdev *cdev = netdev_priv(dev);
 	int err;
 
+	/* Avoid waking up the controller if the interface is down */
+	if (!(dev->flags & IFF_UP))
+		return 0;
+
 	err = m_can_clk_start(cdev);
 	if (err)
 		return err;

-- 
2.50.1



