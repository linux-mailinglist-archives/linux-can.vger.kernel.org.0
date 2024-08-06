Return-Path: <linux-can+bounces-1131-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 416C3948A6D
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 09:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DED091F25325
	for <lists+linux-can@lfdr.de>; Tue,  6 Aug 2024 07:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FFD01BD00C;
	Tue,  6 Aug 2024 07:47:47 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F7731BA895
	for <linux-can@vger.kernel.org>; Tue,  6 Aug 2024 07:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722930466; cv=none; b=Mkvf+gcmGfun2jWq+0CePHHLwuwYqR33JlYt77Qa6UpVyVgvzE3VYU49CQs6LVqmrihns80DQBmblxgVHLxI6hYhsdzfFlHkG/VVW9A6rTdKPejVzJqe0H/JAI1AZI4MNZY6JjxFXbg7CpgVXdhjRvMz1t9W4VgY1ChZRwoqt5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722930466; c=relaxed/simple;
	bh=h/9hIEHIKrxey86A0dFWcUfr+38201w2cema3doQP+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NtG+/TnsZC8K/MyvWEgyWM9Z5QqOkzIxSAqN7fVec1TrE1zfCIjUObrod24e71K1iFwkEKCX17oqncuYsPEj+lTZYGgMI3PdeWTkvFkmE8iYxH3gf4xl0YJ4NPbM8n509HJnj3o7W+X9OsNX9gsTDSDBMWtufL2X15nUhXgyS98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEuu-00043C-Kl
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:36 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sbEut-004tpa-Lv
	for linux-can@vger.kernel.org; Tue, 06 Aug 2024 09:47:35 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 545D63179A1
	for <linux-can@vger.kernel.org>; Tue, 06 Aug 2024 07:47:35 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id 95C2831796C;
	Tue, 06 Aug 2024 07:47:33 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 62b77d5e;
	Tue, 6 Aug 2024 07:47:32 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Frank Li <Frank.Li@nxp.com>,
	Rob Herring <robh@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 01/20] dt-bindings: can: fsl,flexcan: add common 'can-transceiver' for fsl,flexcan
Date: Tue,  6 Aug 2024 09:41:52 +0200
Message-ID: <20240806074731.1905378-2-mkl@pengutronix.de>
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

From: Frank Li <Frank.Li@nxp.com>

Add common 'can-transceiver' children node for fsl,flexcan.

Fix below warning:
arch/arm64/boot/dts/freescale/fsl-ls1028a-rdb.dtb: can@2180000: 'can-transceiver' does not match any of the regexes: 'pinctrl-[0-9]+'
        from schema $id: http://devicetree.org/schemas/net/can/fsl,flexcan.yaml#

Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Link: https://lore.kernel.org/all/20240629021754.3583641-1-Frank.Li@nxp.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
index f197d9b516bb..a4261a201fdb 100644
--- a/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
+++ b/Documentation/devicetree/bindings/net/can/fsl,flexcan.yaml
@@ -80,6 +80,10 @@ properties:
       node then controller is assumed to be little endian. If this property is
       present then controller is assumed to be big endian.
 
+  can-transceiver:
+    $ref: can-transceiver.yaml#
+    unevaluatedProperties: false
+
   fsl,stop-mode:
     description: |
       Register bits of stop mode control.

base-commit: 3608d6aca5e793958462e6e01a8cdb6c6e8088d0
-- 
2.43.0



