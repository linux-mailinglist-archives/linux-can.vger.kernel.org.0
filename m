Return-Path: <linux-can+bounces-458-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B21168AC4F6
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 09:14:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 520A01F22225
	for <lists+linux-can@lfdr.de>; Mon, 22 Apr 2024 07:14:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A279F502A2;
	Mon, 22 Apr 2024 07:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="i4Gumx5G"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4A54A99C;
	Mon, 22 Apr 2024 07:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713769936; cv=none; b=rCqnQmzwAaIRV48/CkV6GYZCHcw38NeY1npcvXeYoybT5oJoaKGRIl6GETG9VypJJ9YvTu3lUjdO7/ykZVWqpbg5exMUfcC1PBYNeRRKLAhWWeloIo4IgC7F5Pm5OHQGqTCDUUY77cvcasKrVeh7LNrtXwTE5JA+FF1n0uPo5Mo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713769936; c=relaxed/simple;
	bh=q9T1A6DKZWu+cEV4Ja19PHnmKkDeTZKLtPYNFzWJaPI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=mWSN8apbZrmUT/5k0uo2Ki9dWA7hpozn3YtPNYKLmJoBDZQ+C6bsfK/pv3d5ADXOZw2vQLOqAAbzNRgszxp5iAdl/p9v+BTpgdJhvTtJH03srAZ/4L2hI71s3LHCcU8vm8vfHBhp6TPlag6vgTznntBMGJsncyjJC6HTVm8HO+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=i4Gumx5G; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=2eb78AFe5PYDmdbUW5Vdqx7jRBou5taMNU0tTn49tb4=; b=i4Gumx5G5Dp1JbdyRKxtGMbFYV
	fJmeCpfc1pjT4vtPRRDonfbM5kWUPJVci8qlZbXlWRju1/LupUFudRzzXRa7ic/pGGCj7iFl3v+87
	u32m4NnBRd9STH5IeEcHUHS3XwYpJinYd/oRcH5YEvkubWwGJp2oHSuXVNuhcI5lj/pU=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1rynWl-001JRH-0F;
	Mon, 22 Apr 2024 08:51:47 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
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
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH 05/11] dt-bindings: net: can: Add serdev LIN bus dt bindings
Date: Mon, 22 Apr 2024 08:51:08 +0200
Message-Id: <20240422065114.3185505-6-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
References: <20240422065114.3185505-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation of device tree bindings for serdev UART LIN-Bus
devices equipped with LIN transceivers.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 .../bindings/net/can/linux,lin-serdev.yaml    | 29 +++++++++++++++++++
 1 file changed, 29 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml

diff --git a/Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml b/Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml
new file mode 100644
index 0000000000000..cb4e932ff249c
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/can/linux,lin-serdev.yaml
@@ -0,0 +1,29 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/can/linux,lin-serdev.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Linux serdev LIN-Bus Support
+
+description: |
+  LIN-Bus support for UART devices equipped with LIN transceivers,
+  utilizing the Serial Device Bus (serdev) interface.
+
+  For more details on an adapter, visit: https://hexdev.de/hexlin#tty
+
+properties:
+  compatible:
+    const: linux,lin-serdev
+
+required:
+  - compatible
+
+examples:
+  - |
+    &uart2 {
+      status = "okay";
+      linbus {
+        compatible = "linux,lin-serdev";
+      };
+    };
-- 
2.39.2


