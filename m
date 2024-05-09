Return-Path: <linux-can+bounces-618-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAD28C13E2
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:21:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB070282241
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:20:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41B854176D;
	Thu,  9 May 2024 17:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="VM4+3Zgh"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9447B38DFC;
	Thu,  9 May 2024 17:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275182; cv=none; b=RqWGAdYzzu27G25jIbHuzWVcQT4qTROh/EJ/Uuh4GiTjZjZEROUDK3izPI0LANN7AEWirQ828e9Q4nSOQj8j6EV//ugHgGF+98irxvBYmzZbw+J6DKfnQVMP7ctN/5kybpRdRGNedjyUNlgUQA337BhoJZbH51ksV/sj1ZBm7/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275182; c=relaxed/simple;
	bh=D8CRXW39vhFJcU1BkBHaw05EGHcEhOT2Kdm35iJrw3g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kTTAQ63wYhY6UW+l2nmwdRxsPaN7ekbNkkFfEwGBusdVCof5CkooNTyRYeJqQtOhTks+LRkOGnhfvrgi0oMwOQBt938UCutfeN3EiU9Uk6DLjD8GyLafjZb70t5QsKYaa76i4jgLJU9IEc5ScwwbKgVGl3q0AHJlQ8KkThM8MjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=VM4+3Zgh; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=rMlGkfZfrcUSgXceQUi74AsdzcOwprrtEB39XA8/TWU=; b=VM4+3ZghFGxUrfQ6TFYHPqZR5h
	/D85Z466xMjYeB8myqVNba9xD0XpWdMWZCGqrOHKg6yvoAniY5n10F1ElsH22XZON7jKHFCJM0OMk
	sBoXXPEPITHyumXR8zHroAGqVVeSXYQd3OgOiHnH1NR8iaYatOCnr3GaaXuBwfer8zpM=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57QM-001jf8-1n;
	Thu, 09 May 2024 19:19:19 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v4 06/11] dt-bindings: net/can: Add serial LIN adapter hexLINSER
Date: Thu,  9 May 2024 19:17:31 +0200
Message-Id: <20240509171736.2048414-7-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for hexDEV hexLINSER serial LIN adapters. These adapters
are basically just LIN transceivers that are mostly hard-wired to serial
devices.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 .../bindings/net/can/hexdev,hex-linser.yaml   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,hex-linser.yaml

diff --git a/Documentation/devicetree/bindings/net/can/hexdev,hex-linser.yaml b/Documentation/devicetree/bindings/net/can/hexdev,hex-linser.yaml
new file mode 100644
index 0000000000000..42dce3348f73c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/hexdev,hex-linser.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/hexdev,hex-linser.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: hexDEV hexLINSER serial LIN adapter
+
+description:
+  LIN transceiver, mostly hard-wired to a serial device, used for communication
+  on a LIN bus.
+  For more details on the adapter, visit <https://hexdev.de/hexlin#hexLINSER>.
+
+maintainers:
+  - Christoph Fritz <christoph.fritz@hexdev.de>
+
+properties:
+  compatible:
+    const: hexdev,hex-linser
+
+required:
+  - compatible
+
+additionalProperties: false
+
+examples:
+  - |
+    serial {
+        linbus {
+            compatible = "hexdev,hex-linser";
+        };
+    };
-- 
2.39.2


