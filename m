Return-Path: <linux-can+bounces-3078-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55128A61280
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 14:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C2916E04F
	for <lists+linux-can@lfdr.de>; Fri, 14 Mar 2025 13:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1737B1FF7D3;
	Fri, 14 Mar 2025 13:23:35 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5714E1FF7DC
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741958614; cv=none; b=kRMdB6f+sEItXw/RUaHmenskbGNY6O6nWmwq5oEqHzOPvWMZpuQzyYz2BO4afymTNAb2xjtrBZJd1Gnr1yA/oQVtDmr9eslAFSNpOR+ZN0ZP1N/dzkEPLm/fqoCkbAhV3wZjk0cyRvBgx1r12N8PD3tvlfoVP5ZqD7Fv4V+CniQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741958614; c=relaxed/simple;
	bh=dT0c0u+wfawVH0nlpWMHU+yE6c1Gd2Ir4z21PVqyRwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O45Mant8Xe9nY27XsWwDKcW6Tnts124wa7tGooWciylQBR1z20DWFxCJbbRtcpefaK88DmG4ztwlo0P31j3+dO1+vIyGgSuZWWJfo3PZkcrhBkI6MG/0AHCLDM0H+RXNdZC7QR+/OqI3+JhoTmEX+IulDMMQydCYOVoGJxIqUss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50d-0001iu-Ox
	for linux-can@vger.kernel.org; Fri, 14 Mar 2025 14:23:31 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tt50d-005i5j-1F
	for linux-can@vger.kernel.org;
	Fri, 14 Mar 2025 14:23:31 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 0ED3E3DBC09
	for <linux-can@vger.kernel.org>; Fri, 14 Mar 2025 13:23:31 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5FDBC3DBBEA;
	Fri, 14 Mar 2025 13:23:29 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 5e0fd1b2;
	Fri, 14 Mar 2025 13:23:28 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Frank Li <Frank.Li@nxp.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 3/4] dt-bindings: can: fsl,flexcan: add i.MX94 support
Date: Fri, 14 Mar 2025 14:19:17 +0100
Message-ID: <20250314132327.2905693-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250314132327.2905693-1-mkl@pengutronix.de>
References: <20250314132327.2905693-1-mkl@pengutronix.de>
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

From: Frank Li <Frank.Li@nxp.com>

Add compatible string "fsl,imx94-flexcan" for the i.MX94 chip, which
is backward compatible with i.MX95. Set it to fall back to
"fsl,imx95-flexcan".

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20250307190816.2971810-1-Frank.Li@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index 37e3e4f48762..f81d56f7c12a 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -45,6 +45,10 @@ properties:
           - enum:
               - nxp,s32g3-flexcan
           - const: nxp,s32g2-flexcan
+      - items:
+          - enum:
+              - fsl,imx94-flexcan
+          - const: fsl,imx95-flexcan
 
   reg:
     maxItems: 1
-- 
2.47.2



