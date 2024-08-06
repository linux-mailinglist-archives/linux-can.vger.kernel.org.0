Return-Path: <linux-can+bounces-1140-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7859A948A81
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:49:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 239171F25A42
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:49:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7FD1BE23E;
	Tue,  6 Aug 2024 07:47:49 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64DEE1BCA14
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930469; cv=none; b=C+URjUKTBAGO/dHKT9S8U01EpsRwg6He0WktZsIzQYULvAcdiHEOGhRFbHJtXcbvBt5+v088vyLdn+aYUUh/bQz1VEAmSzFs+z3XRh7CLxmcQUssEEPaK+Ak2ew8vg4WKWENkkfokkC6ndVLG5Ic698hgB1B8QfSLQufwPZ/Bd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930469; c=relaxed/simple;
	bh=FGZdokbwYR21hsUPfsPlHeugTAmKjAroAoN0c2NRTeU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F8bAcovwIED3YuC9X2CWBMDhdUbeyUFjA5OaSNHbN/eQE1kRsFk6YVcD3zBCI6DLwQf0i/vWm6B4y/ILKdfG9XeOPd5sMKSZTKQiSsgtIKo6DANxZei6y9b82XoOtQZM0RlPhO7c68Mfmw+wk13Xbiyoh8rhBvDhuHmtQlqCldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuw-00043w-8m
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:38 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuu-004tqW-63
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:36 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id D64073179B0
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A2D6B31796D;
	Tue, 06 Aug 2024 07:47:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 81f9790b;
	Tue, 6 Aug 2024 07:47:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Haibo Chen <haibo.chen@nxp.com>,
	Han Xu <han.xu@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 02/20] dt-bindings: can: fsl,flexcan: move fsl,imx95-flexcan standalone
Date: Tue,  6 Aug 2024 09:41:53 +0200
Message-ID: <20240806074731.1905378-3-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240806074731.1905378-1-mkl@pengutronix.de>
References: <20240806074731.1905378-1-mkl@pengutronix.de>
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

From: Haibo Chen <haibo.chen@nxp.com>

The flexcan in iMX95 is not compatible with imx93 because wakeup method is
difference. Make fsl,imx95-flexcan not fallback to fsl,imx93-flexcan.

Reviewed-by: Han Xu <han.xu@nxp.com>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Acked-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20240731-flexcan-v4-1-82ece66e5a76@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index a4261a201fdb..97dd1a7c5ed2 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -17,6 +17,7 @@ properties:
   compatible:
     oneOf:
       - enum:
+          - fsl,imx95-flexcan
           - fsl,imx93-flexcan
           - fsl,imx8qm-flexcan
           - fsl,imx8mp-flexcan
@@ -38,9 +39,6 @@ properties:
               - fsl,imx6ul-flexcan
               - fsl,imx6sx-flexcan
           - const: fsl,imx6q-flexcan
-      - items:
-          - const: fsl,imx95-flexcan
-          - const: fsl,imx93-flexcan
       - items:
           - enum:
               - fsl,ls1028ar1-flexcan
-- 
2.43.0



