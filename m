Return-Path: <linux-can+bounces-671-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14A478CC30D
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 16:19:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 573CEB21654
	for <lists+linux-can@lfdr.de>; Wed, 22 May 2024 14:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3491B147C7C;
	Wed, 22 May 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="OhtK3LO6";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="Xtvp2Z9F"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D2B1474B8;
	Wed, 22 May 2024 14:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716387403; cv=none; b=GL9AB7ZjqE1F8cV4Z5t4ZYkM8KWz1F7zBb22AAKBhOFImSubfVvq1FC8Rk2+M0IzPmvWP535gbZvFiuj/xnWO0saznXSqi3fvgSw7us3Hj6Kwe682SIuuTwGtvZVwAkiO1IWHfwnAjg/0hmMARQKPTzT+gpOLsRiKxp/6quR6Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716387403; c=relaxed/simple;
	bh=OdGZx35Xq/K2qo+2VemsbuBTb2vtHnLZgwqnHGj6dHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fSu7gLo86DopVopCeJyCkYgnqz8SsX/ZZwUBsNtc3ti/urA+9W9KOMVQxQTSeqjs8haB+YYbgYoqmZBD6Evm8d7TJLkU+yGHowfRggbHHBfbVB8EqIhgGY4Yhstjc/OCQc2G5edSltY7OMF30VeriA923LZWivye6IUsUAmmmFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=OhtK3LO6; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=Xtvp2Z9F reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1716387401; x=1747923401;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=cyyRUEqHorrucwPwnV8fQCfXT5oEDfauIgMMG9jC7FM=;
  b=OhtK3LO6mQK1CAu941DUpr0sFsYbPAPQ4uoLBWCfwPBL815os6fZIAfD
   +MOrWEFmyU3SSg2/18qGngy3b1am7PH7iVeGpULZlTBZQkKslpLAtSd8B
   +vBId8I3DPMvHnx2G/v29rjATRcVxq6zOTSZ4syWwHNDjJdsDMiOPm7BL
   rJvLnOD5CgngDcfgG2IRrq5Lntcj14FTFda/e6nHq6yvVQSfWAXMyNXND
   8yGSJrDiqNG5Qgs+b/r7YediSdiXfs/erCs1vuj6FzavUPx+CWX3VSKjZ
   /4skJkTiJG2Yh0Q3G9BpGZ890P6W6Gr31uC9qs3jQ87Pcfm61I2EXitqR
   g==;
X-CSE-ConnectionGUID: BDwKn6HkTBi+ipyCzc3sRA==
X-CSE-MsgGUID: 26cSOEZTSQS/O1T9RwEotA==
X-IronPort-AV: E=Sophos;i="6.08,179,1712613600"; 
   d="scan'208";a="37017683"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 22 May 2024 16:16:40 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id C163316EF06;
	Wed, 22 May 2024 16:16:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1716387395;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=cyyRUEqHorrucwPwnV8fQCfXT5oEDfauIgMMG9jC7FM=;
	b=Xtvp2Z9F7vtHnA4uHwqzd40sVd/Le0dBcX3UpZTVqoSUvxjJM1GJ/jCqtNkTAi69/lSCfe
	vEpoYeR2EQAD0vWJ/3BNCWqWsuR9cmL2Y5Kmmu/MUlg4ICc/L0pXPDzhdXxU4H4PB3FnEd
	H9Q0d2VSDH+SUjDq2B4v610Y04YjLOn6BusDF4b6iPJ9Ps9Kc4qhev2UY90bSHRjI9DO5l
	8Vse0Tvngqq4wNHWEtcRK3bs2uycKS1E2r2np8W2LL4IlG7V2UFNxYCz0eSjrFEkGAYzLh
	YDldi4w3XNcKVjIriev3PR2xjA8xzwpKNnAG/pmwD9PeStyjLLc7vBfK0/wMOg==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Wed, 22 May 2024 16:15:25 +0200
Subject: [PATCH RESEND v3 8/8] dt-bindings: can: mcp251xfd: add
 gpio-controller property
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240522-mcp251xfd-gpio-feature-v3-8-8829970269c5@ew.tq-group.com>
References: <20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com>
In-Reply-To: <20240522-mcp251xfd-gpio-feature-v3-0-8829970269c5@ew.tq-group.com>
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
 Linus Walleij <linus.walleij@linaro.org>, 
 Bartosz Golaszewski <brgl@bgdev.pl>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716387339; l=932;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=OdGZx35Xq/K2qo+2VemsbuBTb2vtHnLZgwqnHGj6dHs=;
 b=OHtY6KgFHG+iBUfU0YBi281KIdVWaWQqMvJEoo8s8rPb9hdJExEcAPRb2QmRbXMuZTf4sVFDy
 jVRGwKMAsJ5BCrxiESFhn31aXVnwvNGsvafRMVWsvi6jf3Rv++Lck6U
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


