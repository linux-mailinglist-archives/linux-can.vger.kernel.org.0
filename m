Return-Path: <linux-can+bounces-800-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8354F911DFB
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 10:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B45111C2123A
	for <lists+linux-can@lfdr.de>; Fri, 21 Jun 2024 08:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDCD170842;
	Fri, 21 Jun 2024 08:02:09 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6046E17083A
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956929; cv=none; b=kVLwIWp1a2RG0+T1RS6EZyHbYbz2iLdavMf0O4eGjxqwwbNSpgA8CafXdqprkN8oHmA7uxOfzoHvYv9fFlrxBaLRdyf27o37bgXOO9ReOUZK/8708bBfO/4++ezPgb129HqjHWzNmWMeYJ87iKKkafufgWSLbgtgrDbgyonjDoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956929; c=relaxed/simple;
	bh=uMXQlgxt9w5o+MPNf5v1GiEcZ1S2LtRtbsf7sKSbTWM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tjoh2nWvN4bTRaramflt2Wn+vXCsdgLy267eqqicnH2lbCWqftmF8zsLhb8u1cNYT454u4/XYS+uzymfcqVS7ZyGLOlquSpXGoMmyTji6c+lpasiR8YYlb0BeHDqrjnZ/W4cNvT9NbPepcxB0nht/gWUnn4htThVZavSK/27zmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDh-0003xL-Bx
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:05 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKZDg-003tGG-LQ
	for linux-can@vger.kernel.org; Fri, 21 Jun 2024 10:02:04 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 4D8C72EE3C0
	for <linux-can@vger.kernel.org>; Fri, 21 Jun 2024 08:02:04 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id DCF932EE391;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 59989aee;
	Fri, 21 Jun 2024 08:02:02 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Harini T <harini.t@amd.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 04/24] dt-bindings: can: xilinx_can: Modify the title to indicate CAN and CANFD controllers are supported
Date: Fri, 21 Jun 2024 09:48:24 +0200
Message-ID: <20240621080201.305471-5-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621080201.305471-1-mkl@pengutronix.de>
References: <20240621080201.305471-1-mkl@pengutronix.de>
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

From: Harini T <harini.t@amd.com>

Xilinx CAN binding documentation supports CAN and CANFD controllers.
Modify the title to indicate that both controllers are supported.

Signed-off-by: Harini T <harini.t@amd.com>
Link: https://lore.kernel.org/all/20240503060553.8520-2-harini.t@amd.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/xilinx,can.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
index 8d4e5af6fd6c..40835497050a 100644
--- a/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
+++ b/Documentation/devicetree/bindings/net/can/xilinx,can.yaml
@@ -5,7 +5,7 @@ $id: http://devicetree.org/schemas/net/can/xilinx,can.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title:
-  Xilinx Axi CAN/Zynq CANPS controller
+  Xilinx CAN and CANFD controller
 
 maintainers:
   - Appana Durga Kedareswara rao <appana.durga.rao@xilinx.com>
-- 
2.43.0



