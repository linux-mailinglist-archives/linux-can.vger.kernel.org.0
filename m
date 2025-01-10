Return-Path: <linux-can+bounces-2576-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9F6A08F3E
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:28:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335B53A5454
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:27:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DA0B20B7E9;
	Fri, 10 Jan 2025 11:27:23 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B6020C46D
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508443; cv=none; b=sAJEo6j8ScgcsP99HhrfqccslEPcToSyubEXaSH8u3Jldm6iF8kXPUiAdabf3gAk2CJyRYOFxPtEKLCC2fC4JFI7STGLJoMYzHU/j7tVokU+OlcqOFcHWf94O5D9m+fksW5IhKV1fV96hTnJ14MbYusSnB7tb/rtBCpYoI2H8RU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508443; c=relaxed/simple;
	bh=jZOoArx5Qmm4yKv1HrwNliFc2jlah4YW0HrKIWnMJUY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBWtzGMc5J1tewDSncWS69RsGzEt6iJNdR+vsFOeNta3cz4F7hh60pbsw9gIJsa5p13ClZGctnwleoEHo50QbbC5XMi91jBuseN3j5UclUJ7B4HgFqVK9SAlOcgBSCNQkLomAmHUb+qWCSdEuEoHj7vDRWsAEYFTKb5DppD6ga8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAd-0004za-Kw
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:19 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAb-0009ek-1K
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:17 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 1B76A3A45DC
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id B1EC43A4595;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 89f2dae8;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Sean Nyekjaer <sean@geanix.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 06/18] can: tcan4x5x: get rid of false clock errors
Date: Fri, 10 Jan 2025 12:04:14 +0100
Message-ID: <20250110112712.3214173-7-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110112712.3214173-1-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
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

From: Sean Nyekjaer <sean@geanix.com>

tcan4x5x devices only requires the clock "cclk", so call
devm_clk_get() directly. This is done to avoid
m_can_class_get_clocks() that checks for both hclk and cclk and
results in this warning message:

| tcan4x5x spi0.0: no clock found

Signed-off-by: Sean Nyekjaer <sean@geanix.com>
Link: https://patch.msgid.link/20241128-mcancclk-v1-1-a93aac64dbae@geanix.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/m_can/tcan4x5x-core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/can/m_can/tcan4x5x-core.c b/drivers/net/can/m_can/tcan4x5x-core.c
index 84b914056b7d..4c9454176607 100644
--- a/drivers/net/can/m_can/tcan4x5x-core.c
+++ b/drivers/net/can/m_can/tcan4x5x-core.c
@@ -409,7 +409,7 @@ static int tcan4x5x_can_probe(struct spi_device *spi)
 		priv->power = NULL;
 	}
 
-	m_can_class_get_clocks(mcan_class);
+	mcan_class->cclk = devm_clk_get(mcan_class->dev, "cclk");
 	if (IS_ERR(mcan_class->cclk)) {
 		dev_err(&spi->dev, "no CAN clock source defined\n");
 		freq = TCAN4X5X_EXT_CLK_DEF;
-- 
2.45.2



