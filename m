Return-Path: <linux-can+bounces-3592-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3ABAABD2F6
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 11:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE9527A388F
	for <lists+linux-can@lfdr.de>; Tue, 20 May 2025 09:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 111972676DC;
	Tue, 20 May 2025 09:14:34 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1C425486A
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 09:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747732474; cv=none; b=N5DTbnkeSY6W9LgAokGaZepimRw+wckqFbBTEajgMz9X/17+fl7Z/0fH0JfaZnZ50LzNokexKettF6Ji+tH6AS3/l+VXu2veD3QvC6CqqG/WS+q+2UOyppQz2vAgD7RFADHEszS+Y0A3VTSzpHjSdLEqknYgYLlbHZ04FZq2aVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747732474; c=relaxed/simple;
	bh=Zk2Q0HBVqnOOMWfARYxxUIR4OxQJr5XY03zurPT7vfo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IRO2gtenCJCsHf0p9mUdCmwlISQGFHba/77SkuaCXGdnpEmddyyBE1pIQT0Vn1muPYHVYrUMtpsZRpQDkutVx12kuBGITxVTwNQy53kimUuaeK1ZicLDdQv5hi8JceCiEP7nhtbixTwORxlf3Ex5JuvTbZ0wFFYWkhmtOhBUkIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHJ3O-0007na-I9
	for linux-can@vger.kernel.org; Tue, 20 May 2025 11:14:30 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1uHJ3O-000O5k-0m
	for linux-can@vger.kernel.org;
	Tue, 20 May 2025 11:14:30 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E09B2415A37
	for <linux-can@vger.kernel.org>; Tue, 20 May 2025 09:14:29 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id BE300415A23;
	Tue, 20 May 2025 09:14:27 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id 95ee9b4b;
	Tue, 20 May 2025 09:14:26 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	"Rob Herring (Arm)" <robh@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 1/3] dt-bindings: can: microchip,mcp2510: Fix $id path
Date: Tue, 20 May 2025 11:11:01 +0200
Message-ID: <20250520091424.142121-2-mkl@pengutronix.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250520091424.142121-1-mkl@pengutronix.de>
References: <20250520091424.142121-1-mkl@pengutronix.de>
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

From: "Rob Herring (Arm)" <robh@kernel.org>

The "$id" value must match the relative path under bindings/ and is
missing the "net" sub-directory.

Fixes: 09328600c2f9 ("dt-bindings: can: convert microchip,mcp251x.txt to yaml")
Signed-off-by: "Rob Herring (Arm)" <robh@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Link: https://patch.msgid.link/20250507154201.1589542-1-robh@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .../devicetree/bindings/net/can/microchip,mcp2510.yaml          | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
index e0ec53bc10c6..1525a50ded47 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp2510.yaml
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
 %YAML 1.2
 ---
-$id: http://devicetree.org/schemas/can/microchip,mcp2510.yaml#
+$id: http://devicetree.org/schemas/net/can/microchip,mcp2510.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
 title: Microchip MCP251X stand-alone CAN controller

base-commit: 239af1970bcb039a1551d2c438d113df0010c149
-- 
2.47.2



