Return-Path: <linux-can+bounces-573-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37C58BC754
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 08:02:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09091C20919
	for <lists+linux-can@lfdr.de>; Mon,  6 May 2024 06:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6BC1422C1;
	Mon,  6 May 2024 06:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b="WztB5EON";
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b="tN+vi0+5"
X-Original-To: linux-can@vger.kernel.org
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795971422A5;
	Mon,  6 May 2024 06:00:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.104.207.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714975226; cv=none; b=dq/B8XCuVMmh1L02JK22JpKVCSmxPts7rZbVK4yBg0CtYxEHqOJnuobX6ASDnH3DAT5ETU3jPsecPPjhT9K3Gt98EzO0GKZoWS7ahsa81icBXcKV2Z3/lU3iRSDzpD194FdWCKpoZszR+WmdPS8Tr8FBOl6JQObpj2sntgzcPHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714975226; c=relaxed/simple;
	bh=n7tWG1Z1TtD2JkeZjnmsbv83buLI5moDMRobi/fvv8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=u0UXgnaTpo+UFS1t7U3Q/QzqhA3FYuCjDXZhT9AGFaIw/Bm+LuA1d+znLo3MAziU3bPl1f8aco/8vIwOhK4wKUutrXwIldtcCwWbpCMvHE3nBe2WHcm18/SO67ySoWxekzU7jglMRv2cYDodu/pd7TTJIwAVpaZ4jE3+86209Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com; spf=pass smtp.mailfrom=ew.tq-group.com; dkim=pass (2048-bit key) header.d=tq-group.com header.i=@tq-group.com header.b=WztB5EON; dkim=fail (0-bit key) header.d=ew.tq-group.com header.i=@ew.tq-group.com header.b=tN+vi0+5 reason="key not found in DNS"; arc=none smtp.client-ip=93.104.207.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ew.tq-group.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ew.tq-group.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1714975224; x=1746511224;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=TuuhNbNaeBjZJdztCfrNpOfP6WkWLiHnIjQUOHBmfhU=;
  b=WztB5EONc3Da/02nW1M81zpf9x/xkGimf2BCcD4ky8Lhl5xkOqXCLJS+
   +eaJrfa/ssh0y4pb4a6VHJ9+QORowsIFIyGNLkQnOo5fLwTFJ2O3rAvw5
   buZpJzCNOr6iSlTyzQsyVzVgtecwyKzf/fpOxBVoDt5oe/SK2b8CUeNhO
   Rj2FWctPSiZeDt+WPeEVAEX/ydCLvYMn7vfh/ac9UTneNIEdO1CeRyWZo
   VR34Bk/cWf7eXwRp1s2lMLO101qk8BikR3PuOBjUSaT4xR5MBVsB06GGl
   6vVvXGRqtZmk4kCNi2JwZOdYPvtIQlCV0S/yxRdn3nDSTF2n+nDqv8sxe
   Q==;
X-CSE-ConnectionGUID: jymlU0qzThSQkwTrQANGVw==
X-CSE-MsgGUID: Opmh6Y8zRiqfQbQZkUjm4A==
X-IronPort-AV: E=Sophos;i="6.07,257,1708383600"; 
   d="scan'208";a="36751440"
Received: from vmailcow01.tq-net.de ([10.150.86.48])
  by mx1.tq-group.com with ESMTP; 06 May 2024 08:00:22 +0200
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D7D7E176045;
	Mon,  6 May 2024 08:00:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ew.tq-group.com;
	s=dkim; t=1714975218;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=TuuhNbNaeBjZJdztCfrNpOfP6WkWLiHnIjQUOHBmfhU=;
	b=tN+vi0+5spL8tPphYS2QIHsQij8hBxxKwXPJgIvlvjo126l0Wbayc2aa9acCvUJiRps7xU
	DOX+MyZmL4rrXiaUbqInKmL/jpHDKtIuoMLiRfMlbO24YJzvm+65QWjEfYJqvOQfCm6vsq
	PbbSkJjKSXLzQceXTz3JBIY0+TW79vJseUQyM1Isd7WQrOXpYf6daUMZlbbg18x68G0BzU
	5cH+ikx0Pi6ZPO92d3SW0tEu+d/MErx9gNVDEyWQ9tLZupBNlWrXkyfuPBevWms6QEVS5m
	u+waVzqt/nkYabiLt8urfbZfHP2xTwQ6zOjHLAZQKCntqrBVg/YSdmrXpSuXvg==
From: Gregor Herburger <gregor.herburger@ew.tq-group.com>
Date: Mon, 06 May 2024 07:59:48 +0200
Subject: [PATCH v2 6/6] dt-bindings: can: mcp251xfd: add gpio-controller
 property
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240506-mcp251xfd-gpio-feature-v2-6-615b16fa8789@ew.tq-group.com>
References: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
In-Reply-To: <20240506-mcp251xfd-gpio-feature-v2-0-615b16fa8789@ew.tq-group.com>
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
 linux@ew.tq-group.com, gregor.herburger@ew.tq-group.com
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714975188; l=868;
 i=gregor.herburger@ew.tq-group.com; s=20230829; h=from:subject:message-id;
 bh=n7tWG1Z1TtD2JkeZjnmsbv83buLI5moDMRobi/fvv8g=;
 b=dtcIIW/3/ZUobrP0XJ3wzYGoDatR8SHllfuJ7lfpO349HQBXJKFgwdWH5TGBleBeWLyImiclG
 Vcn8gRK/YuaCBQJM3TEIsxYGR4EwWkvfKnsYzKOAkXNpU0RnFdJkpf9
X-Developer-Key: i=gregor.herburger@ew.tq-group.com; a=ed25519;
 pk=+eRxwX7ikXwazcRjlOjj2/tbDmfVZdDLoW+xLZbQ4h4=
X-Last-TLS-Session-Version: TLSv1.3

The mcp251xfd has two pins that can be used as gpio. Add gpio-controller
property to binding description.

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


