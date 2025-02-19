Return-Path: <linux-can+bounces-2864-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B77FAA3BCEF
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 12:35:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9BC70173AAC
	for <lists+linux-can@lfdr.de>; Wed, 19 Feb 2025 11:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A62521DFE34;
	Wed, 19 Feb 2025 11:34:06 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03A81D8DE1
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739964846; cv=none; b=VB9U5cmAsaf0IufFxdTrLav4pFBkjO+gUo5qrDX5wXXYNp5iLLVfkCSc1sglyDE3rASEDqgbfXMYyJDPxlTu2pUpvj5w5/06YXFnW1YhOXsSa1ulJ+BhZeWcFxH2soeURVSrgwsBcKV/+O5aEuI+VSeRc5ak3S1m2lMGONkJNog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739964846; c=relaxed/simple;
	bh=0f0DtBoJCWC9xdHMwxnnzB3cTOOtfYdSqcZKe6PDN20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WjGs7aqA0sftjEZPeo+ePEKsK1hZWLqJPhoNgeY+l9LKyASJr7SKxw0WZkCrkH4aMNny8d7BUIcXqdMRwIRn1DD+/2l49UM4L7+PfrkzC3SsuhxBpxwtNB8pYWM8AhYG0uWJrr4GxO2LAYi+VvCZ57tdZNoRmQ/KW6Y4MR0kuxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL5-0001a7-0Q
	for linux-can@vger.kernel.org; Wed, 19 Feb 2025 12:34:03 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tkiL3-001l1q-06
	for linux-can@vger.kernel.org;
	Wed, 19 Feb 2025 12:34:01 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id A32563C6935
	for <linux-can@vger.kernel.org>; Wed, 19 Feb 2025 11:34:00 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id A8C133C68E5;
	Wed, 19 Feb 2025 11:33:57 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 8403235e;
	Wed, 19 Feb 2025 11:33:56 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Ruffalo Lavoisier <ruffalolavoisier@gmail.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/12] dt-binding: can: mcp251xfd: remove duplicate word
Date: Wed, 19 Feb 2025 12:21:13 +0100
Message-ID: <20250219113354.529611-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250219113354.529611-1-mkl@pengutronix.de>
References: <20250219113354.529611-1-mkl@pengutronix.de>
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

From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>

Remove duplicate word 'to' from microchip,rx-int-gpios description.

Signed-off-by: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
Acked-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Link: https://patch.msgid.link/20241120044014.92375-1-RuffaloLavoisier@gmail.com
[mkl: rephrase subject and patch description]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index 2a98b26630cb..c155c9c6db39 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -40,7 +40,7 @@ properties:
 
   microchip,rx-int-gpios:
     description:
-      GPIO phandle of GPIO connected to to INT1 pin of the MCP251XFD, which
+      GPIO phandle of GPIO connected to INT1 pin of the MCP251XFD, which
       signals a pending RX interrupt.
     maxItems: 1
 
-- 
2.47.2



