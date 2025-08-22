Return-Path: <linux-can+bounces-4299-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D51B312CF
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 11:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D02DA1CE607B
	for <lists+linux-can@lfdr.de>; Fri, 22 Aug 2025 09:20:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDC0E2ECD37;
	Fri, 22 Aug 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="otG/bHA4"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9DE2E8B6C;
	Fri, 22 Aug 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755854409; cv=none; b=PjTutylG4XvuPnIPwj86AtoX+ox6yi9fN9Zpcp2imWVaiAKBnptjXtARxUcIiFpjbsi7pPqRopm0Q2YnidCZT334ji5yW4Lkxom3Rg3IkCMGQ46oIFlcvoW6GDMzpif75BkJMCvZbSCOuqnWXs2OBIjeLTBMnvD+THS74CB1iu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755854409; c=relaxed/simple;
	bh=lYXRPEF5xCv3IMvDjVWMR2FFCr2yw+pFku4jVaMdDP4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eIbhcERLjz8SEAmAtmD+I0r6U7yWiRy0Gcc+uViMwFwjPFNHExa/66PU/fU6ShEcOmhX9hLUZgykH9V9KzPVG9hz/oEZn14OshN9kWx/Fa5Da4v9dSmSck1egI3p2Mmhl34beZZ6XH4hZd/2GYrTgY767Q4XGf5XL607RrodfG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=otG/bHA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1C35BC113D0;
	Fri, 22 Aug 2025 09:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755854409;
	bh=lYXRPEF5xCv3IMvDjVWMR2FFCr2yw+pFku4jVaMdDP4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=otG/bHA4jnzSNnTzI7gaK7VxUVOmCTXiFN0jC6puFqoXmqQSZIaEkh1NH/upAuDv9
	 UM3blY6wVB/jAWT+VU51ViJJW509qNb0yaM4pls74pUjqCuMx0pJ1o+hyUGouWLbA9
	 RKtXuobt0M7bx2a3fuCwA/0gAyhdZMIL5FiGWbre1WLcoudtuFbBOJ4cypOMnXM6iD
	 IPtpTxFZxkzDpaHYUW9GHvTX+lwf2lKN5jxTgP0yZhL5blEmHmuz29Kv5n2T3ISRcu
	 GfFy3q+Cqetow8jkTicqvCI2UspG29T3Ke9JdRNOfiC+1Kg3hAGRSaF1sH/dALiBtV
	 akvzhyzwF03HA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B04DCA0EED;
	Fri, 22 Aug 2025 09:20:09 +0000 (UTC)
From: Maud Spierings via B4 Relay <devnull+maudspierings.gocontroll.com@kernel.org>
Date: Fri, 22 Aug 2025 11:20:05 +0200
Subject: [PATCH 1/2] dt-bindings: phy: ti,tcan104x-can: Document TI
 TCAN1051
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250822-can_phy3-v1-1-73b3ba1690ee@gocontroll.com>
References: <20250822-can_phy3-v1-0-73b3ba1690ee@gocontroll.com>
In-Reply-To: <20250822-can_phy3-v1-0-73b3ba1690ee@gocontroll.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, Vinod Koul <vkoul@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Aswath Govindraju <a-govindraju@ti.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>
Cc: linux-can@vger.kernel.org, linux-phy@lists.infradead.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 Maud Spierings <maudspierings@gocontroll.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1755854408; l=925;
 i=maudspierings@gocontroll.com; s=20250214; h=from:subject:message-id;
 bh=h5ZKsrw8gOWNFZ+LrIS6NAt/AwRMIdyfhSIwneUGyVY=;
 b=yNhf/uwZ57jylj44lykbtsjIChzfx1egEmURElSzgQTHDMOtYe+40rbVS0HDW6jz5lQuk9Wrv
 aW/WV+pyMbFDLZRhO0NC1y+NAc6wlOQ1EioJZsPHTHhDBYxzbBDgxh/
X-Developer-Key: i=maudspierings@gocontroll.com; a=ed25519;
 pk=7chUb8XpaTQDvWhzTdHC0YPMkTDloELEC7q94tOUyPg=
X-Endpoint-Received: by B4 Relay for maudspierings@gocontroll.com/20250214
 with auth_id=341
X-Original-From: Maud Spierings <maudspierings@gocontroll.com>
Reply-To: maudspierings@gocontroll.com

From: Maud Spierings <maudspierings@gocontroll.com>

TCAN1051-Q1 Automotive Fault Protected CAN Transceiver with CAN FD

It is pretty much identical to the TCAN1042, add the compatible with
fallback on the TCAN1042.

Signed-off-by: Maud Spierings <maudspierings@gocontroll.com>
---
 Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 4a8c3829d85d3c4a4963750d03567c1c345beb91..138923ffedfeeb6a0b391cae863723ec70bf2c88 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -18,6 +18,7 @@ properties:
       - items:
           - enum:
               - microchip,ata6561
+              - ti,tcan1051
           - const: ti,tcan1042
       - enum:
           - ti,tcan1042

-- 
2.50.1



