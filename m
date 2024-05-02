Return-Path: <linux-can+bounces-546-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B00008BA06B
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 20:30:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B973281445
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 18:30:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2803A180A95;
	Thu,  2 May 2024 18:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="o5Vv90Uj"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BB617F385;
	Thu,  2 May 2024 18:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714674549; cv=none; b=DNjC4jfVVjPntOvOFjwJ2CCWW51XX0dI/jEX5TMB3mrB9ClbmwyK+/t6gFlpsFlv84Q5TlbRGHVuthuhhvZwPQJe2+eaagX+Lxv/8rmpMtRe1iTnOSrHSNl86P61WFXySTTscMiJQ0uaGUbvLyxUb8mKcImZixg8pCf3ZvcbaKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714674549; c=relaxed/simple;
	bh=BCLyRn6CAWrGWzuuim46rr9r7Y1EbKkSb3hW4oSGMKA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YHpGN+ZQ/i6zwnx/LdW5XVIO+kNbby+zLji+uuMYoulsR1tF1kh+efp/ZBaLJL70T+TEEH+3rfYD6ETznzoxfNsfA+d5/U+1J+GRXQ8OObbsxSkFMYpyDAMbvEtNmkg4z467eWbwjTNNci8vlT6hEJpM2KjEonlvEQ4UpIfya+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=o5Vv90Uj; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ovSYkpeke3/a3PG+6oPTsSVDfi0gMV1wcBnaCGOSfVs=; b=o5Vv90Uj8lJ9qhhk95/QxUXPCH
	qj5GiVbUKmeW9ZBp1i8ilqjucg4gdgJqaCXBOIVHcn/mO4qqwtR9/RqACvwH5ZJ0+nvvAkWgcGIEq
	08bS17Q5uTtSvGksbR9PQgYxeKt5Mx73qceoIxYExpXeDxTzaAmYtSNe4BDHnBmrQCuI=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2bAx-001ZbZ-1l;
	Thu, 02 May 2024 20:29:00 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Jiri Slaby <jirislaby@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
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
Subject: [PATCH v3 06/11] dt-bindings: net/can: Add serial (serdev) LIN adapter
Date: Thu,  2 May 2024 20:27:59 +0200
Message-Id: <20240502182804.145926-7-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502182804.145926-1-christoph.fritz@hexdev.de>
References: <20240502182804.145926-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for serial LIN bus adapters. These adapters are
basically just LIN transceivers that are hard-wired to serial devices.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 .../bindings/net/can/hexdev,lin-serdev.yaml   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml

diff --git a/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
new file mode 100644
index 0000000000000..c178eb9be1391
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
@@ -0,0 +1,32 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/hexdev,lin-serdev.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Serial LIN Adapter
+
+description:
+  LIN transceiver, mostly hard-wired to a serial device, used for communication
+  on a LIN bus.
+  For more details on an adapter, visit <https://hexdev.de/hexlin#tty>.
+
+maintainers:
+  - Christoph Fritz <christoph.fritz@hexdev.de>
+
+properties:
+  compatible:
+    const: hexdev,lin-serdev
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
+            compatible = "hexdev,lin-serdev";
+        };
+    };
-- 
2.39.2


