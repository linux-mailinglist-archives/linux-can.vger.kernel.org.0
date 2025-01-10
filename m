Return-Path: <linux-can+bounces-2572-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F21DCA08F35
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9189188D3E7
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:27:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D1E207A33;
	Fri, 10 Jan 2025 11:27:20 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3861020B210
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508440; cv=none; b=XMq1e6pvJkl1xDEjD1NZjFj/moTn/b0sRc1+pX72cno6ojFc+aThRY0CrOC2NC36y072BXHz60w7wMSiD+tb1fQfiMd9GEx109WrFDWRrXL/CcTb2ZWEJ7cBKRz4x+Df33Ipw/QTpJLf/oZUe7BDsMSWfGM6/LHji3CcEf2G0jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508440; c=relaxed/simple;
	bh=jiTiW0nSrpAHq6BrXtk8PZYDJxaG5pTxiBe3d/gpsbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MBtvI1xGVmAVYZ1pCrXU/oHjcITqSqaTZ/rN8ZUriS9RqncI+BrTkos9c7wPoIeSwJwAsqhRHsHL+pmlCdcLgeS5r8/1AdunD5J9JcI09A93wHfKio0msVtH4r3zN0Mn5IfYqzLmT43NMXxfpOMy3prpM+ihv2Xv0E9E6+POjQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAb-0004wF-Aq
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:17 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAa-0009dE-1Z
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:16 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 292F93A45BF
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:16 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 5C2693A458C;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 1d3ef886;
	Fri, 10 Jan 2025 11:27:13 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/18] dt-bindings: can: mpfs: add PIC64GX CAN compatibility
Date: Fri, 10 Jan 2025 12:04:09 +0100
Message-ID: <20250110112712.3214173-2-mkl@pengutronix.de>
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

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX CAN is compatible with the MPFS CAN, only add a fallback

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Link: https://patch.msgid.link/20240930095449.1813195-2-pierre-henry.moussay@microchip.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/microchip,mpfs-can.yaml     | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
index 01e4d4a54df6..1219c5cb601f 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mpfs-can.yaml
@@ -15,7 +15,11 @@ allOf:
 
 properties:
   compatible:
-    const: microchip,mpfs-can
+    oneOf:
+      - items:
+          - const: microchip,pic64gx-can
+          - const: microchip,mpfs-can
+      - const: microchip,mpfs-can
 
   reg:
     maxItems: 1

base-commit: 65ae975e97d5aab3ee9dc5ec701b12090572ed43
-- 
2.45.2



