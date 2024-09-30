Return-Path: <linux-can+bounces-1576-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD24989ECD
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 11:55:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1550A1F22B10
	for <lists+linux-can@lfdr.de>; Mon, 30 Sep 2024 09:55:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A60F818A6DD;
	Mon, 30 Sep 2024 09:55:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="owHRAHHC"
X-Original-To: linux-can@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520FD17CA03;
	Mon, 30 Sep 2024 09:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727690133; cv=none; b=q0Tt4fCk/88cabdVW3uBxNbPrfXoNssrEA7ukxAAg+a7dSRm7aIjmJZVu6VuOJHwbLqjAG/755Yfwoxc6HV90Eg2QdNTfG93DnUbOUWzsEAAalBAGYqi6wysQvLC8MxytacGDym11UuW+P2y8ycYZ5kQTLXELdKIeAscIh4rQj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727690133; c=relaxed/simple;
	bh=TpKt6MhMi2zuIrSRA+D1aGCZIk1dlQh2zU8a7MH4I+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IjJBjHgVvt2PMsgQ/0jmU+790WVrDXqPPEpKn3I47OFIuTB6uXyUTKA1+3833yjUqqg7bikTASbJh1xPn7RvTnoTwngGdHEGsJlIw7JR3IIujcYruXEL/BBvL88kA1CZYbYcRJ7aZPuTTXvflu0d8KlAc0XGNWr2MqJbokF+Dt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=owHRAHHC; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1727690131; x=1759226131;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TpKt6MhMi2zuIrSRA+D1aGCZIk1dlQh2zU8a7MH4I+0=;
  b=owHRAHHCjQHe9BNTqEI8/6nEdxxHK3fYqo8tycsOVSr9rGHZXD7ooM90
   nxaqPbQ4N0IeO2XEKUhoLao0+ZCfsbCBHG+U36coHw8ntDADEUEv/+j09
   D/BueQkfIj0t9tzDyzQAF4ws/2d8bJlyx03Y77uFk99JN0HHF/Sgu5jpm
   1alUDTG8k6aO0vtLVD3foB7rMmiL1ZY13QRbBTEr8IE1ZlT8FoPtd77Gu
   PhgLEYuH5JENDbEeM6xWoyGR+TwLLgl5OKLnKbLC05+3R7dOR0IWeFvHq
   GK8NUKxD6uw5vfwzm8sKg2+gqIqbgNl1Klw2YGP7gf9t4tOYo7utIgmcn
   w==;
X-CSE-ConnectionGUID: XiGZNwQLQnOpHGCFR5gKFQ==
X-CSE-MsgGUID: GvNnk9AqTkGOIs5Qegvh4Q==
X-IronPort-AV: E=Sophos;i="6.11,165,1725346800"; 
   d="scan'208";a="32248829"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Sep 2024 02:55:23 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 30 Sep 2024 02:54:59 -0700
Received: from ph-emdalo.microchip.com (10.10.85.11) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 30 Sep 2024 02:54:56 -0700
From: <pierre-henry.moussay@microchip.com>
To: <Linux4Microchip@microchip.com>, Conor Dooley
	<conor.dooley@microchip.com>, Daire McNamara <daire.mcnamara@microchip.com>,
	Marc Kleine-Budde <mkl@pengutronix.de>, Vincent Mailhol
	<mailhol.vincent@wanadoo.fr>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
	<krzk+dt@kernel.org>
CC: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>,
	<linux-riscv@lists.infradead.org>, <linux-can@vger.kernel.org>,
	<netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [linux][PATCH v2 01/20] dt-bindings: can: mpfs: add PIC64GX CAN compatibility
Date: Mon, 30 Sep 2024 10:54:30 +0100
Message-ID: <20240930095449.1813195-2-pierre-henry.moussay@microchip.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
References: <20240930095449.1813195-1-pierre-henry.moussay@microchip.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>

PIC64GX CAN is compatible with the MPFS CAN, only add a fallback

Signed-off-by: Pierre-Henry Moussay <pierre-henry.moussay@microchip.com>
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
-- 
2.30.2


