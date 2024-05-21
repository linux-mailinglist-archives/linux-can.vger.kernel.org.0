Return-Path: <linux-can+bounces-660-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E142D8CAEF4
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 15:07:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F0DE1C21A0E
	for <lists+linux-can@lfdr.de>; Tue, 21 May 2024 13:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 257537F7C7;
	Tue, 21 May 2024 13:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="hAuFPgbN";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Z/hUAcDu"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5EB7B3F3;
	Tue, 21 May 2024 13:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716296764; cv=none; b=aaEw/6d0V7MQiB4t5jVKjec6vyC68+kDlMK6+ZvMT02aagIDIbD366CLt3NUtcxRP0GgXDnpIr/ben1dEedr13bHRowg5dmaGW7/vHQxxtxvbHwIrf2aLHaYcuOnPvqZct9q4bXXqUOOubatpKB3AtHu0DZZe16KFkHjRL5aTmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716296764; c=relaxed/simple;
	bh=OdGZx35Xq/K2qo+2VemsbuBTb2vtHnLZgwqnHGj6dHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GILLvq71Ax03dbdu45AocppqC/GhNGARUw+5NuGS6f22qCs9hslsz704tR54m+wvitWpUW79tZ0hR/GJ+4G60RrDIyqyL3xJnErCavRB+/QMZDSOLdOjxnGelmtweKPKwEYplqhfTFff2z//wG9vUs4kMqr/UZZTW9/ay7V3lU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=hAuFPgbN; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Z/hUAcDu reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716296762; x=1747832762;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cyyRUEqHorrucwPwnV8fQCfXT5oEDfauIgMMG9jC7FM=;
  b=hAuFPgbNbE6YxOzCaxidKU48CLM6k5JBbdVfJhpDvaPW6oUSStJDcZe9
   IynwEwK1wKTW0cXqJuLGLaXXRe2oaxURPgzr7Y2XwzWf7UBGt0fJ2SYlj
   yLRSKFIdq2+hsBJ5/ebv+cfY7miT4xbRtfRTKPCsL5xmdU2G0Jnb4U19g
   4pV5ZTRWng4GvBpBoJG448x2xztwUG398VIaN8NPLu1FO6EvgZgNsOLyB
   c1dulWIB3umG8broKycb4eV2Yapn6L+HotIH1QZsochv2XsYyCENOEx3f
   lOfYyj5D0FuulxEHWMSn/wpdt/2+lEYJfp85qjqXkrDWEd/QJ+ZWeQnVw
   Q==;
X-CSE-ConnectionGUID: EzwhYIOMRsKrcBGmmEQETA==
X-CSE-MsgGUID: sLkcEvnaQ2e3HC/gI/hpXA==
X-IronPort-AV: E=Sophos;i="6.08,177,1712613600"; 
   d="scan'208";a="36993994"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 21 May 2024 15:06:00 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 4B2A9175C07;
	Tue, 21 May 2024 15:05:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716296756;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cyyRUEqHorrucwPwnV8fQCfXT5oEDfauIgMMG9jC7FM=;
	b=Z/hUAcDuc2Bbp1gD15KjQG8nmyP3JXEm7GkmbGTYEjj+OFm3AkjE/6QpHA4bAOkH5DxEok
	BJVar5t6BbetcJboOylCuUoTE+imBIi0tcW64Y7l3SWCx7mcG6/o8LvS745VdRjKcdcDZ3
	IKZWR/OX1bCeIqch1ykalhwPkq9k4kz2QVUmdzUvKs12gpbuLQQAc9DBrzcy1YhuLPumBS
	sk3+jsjDnQfORPKnLStCsa3TTk9+GaWTn2ia2b07c2GVthB/7C+cs6teJ4tTKE4aA8QSpe
	BMR1jQNTk1IHfhrYgNftyR00PLs18YeHMAuwpbhN8YzPVQy9E562qsomeCKNGQ==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Tue, 21 May 2024 15:04:58 +0200
Subject: [PATCH v3 8/8] dt-bindings: can: mcp251xfd: add gpio-controller
 property
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240521-mcp251xfd-gpio-feature-v3-8-7f829fefefc2@ew.tq-group.com>
References: <20240521-mcp251xfd-gpio-feature-v3-0-7f829fefefc2@ew.tq-group.com>
In-Reply-To: <20240521-mcp251xfd-gpio-feature-v3-0-7f829fefefc2@ew.tq-group.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Thomas Kopp <thomas.kopp@microchip.com>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716296697; l=932;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=OdGZx35Xq/K2qo+2VemsbuBTb2vtHnLZgwqnHGj6dHs=;
 b=3ius/kJSj1KX4cPP4zFqWQVMTg2McgvCYpq90oozVXbiamCIH9N9OBoo4+Ow7AkCmHxlBsdBS
 3RTlKrKcGoEAeovzC+nIf2LTBjDZz0oI+vDq9fhGFCyUntw+jS2MICX
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

The mcp251xfd has two pins that can be used as gpio. Add gpio-controller
property to binding description.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Gregor Herburger <gregor.herburger@ew.tq-group.com>
---
 Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index 2a98b26630cb..e9605a75c45b 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -49,6 +49,11 @@ properties:
       Must be half or less of "clocks" frequency.
     maximum: 20000000
 
+  gpio-controller: true
+
+  "#gpio-cells":
+    const: 2
+
 required:
   - compatible
   - reg

-- 
2.34.1


