Return-Path: <linux-can+bounces-519-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4338B95C4
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 09:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6967E1F20D3A
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 07:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 915973D3BD;
	Thu,  2 May 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="xoBTEJjv"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF37D23775;
	Thu,  2 May 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636609; cv=none; b=D5UFQQ6d5PjdED2hCQIBUNl+vY7CHZ04O9ekbchhuLdQdRUAMuPPvRQsjNhceF7jqH6J2LEMRE2Y731aXowY4ee2Cxeao40z33T1AJKNSOgKeGWU5Eb1uyY077Cv4UFADPgqfawh6BRxmoD9GPOtpnd9/RPLF883VJud7FfkFJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636609; c=relaxed/simple;
	bh=KjK+ygnrZsuhjU+N9ZY0h772Kw/iSxchdX9Fp9lMvyU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Spu8M7IjLv4G8ta9nLkgt6GsW1ruGd6Oi/kx5BY0Nfy4iErTB76d7scSFCKvMaOiAtKmRJDYIHrof1xx4N/G8pzQFHvOyfnRQBBSM37wQnf4Yey8ge0RFWMo2MMdbtyr866oafMeA4aOJfLHNFRZm5E0VMzoG9NtAkL4JeH5vy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=xoBTEJjv; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=ETncEe944ZpMNYFBQ9viLt3yvbXCLqJ9t/iaLRcdEi4=; b=xoBTEJjvm0H0EV+kfYfdn/xdhF
	U/7CzF+rECZaVpwsYWBldA8DuZ9QxeC5+Wa6hfGySNRvbLZq2jNJExW2Tlkjhv/55dv0B0UYHYOep
	dXBrpkixvuHcC0QYdsebn6dGOT/Obz3COtizSbpKybABj2Brd/hVPFTCbFADuz94wQ/k=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2RJ0-001Yg7-2g;
	Thu, 02 May 2024 09:56:39 +0200
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
	Jiri Slaby <jirislaby@kernel.org>,
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
Subject: [PATCH v2 06/12] dt-bindings: net/can: Add serial (serdev) LIN adapter
Date: Thu,  2 May 2024 09:55:28 +0200
Message-Id: <20240502075534.882628-7-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502075534.882628-1-christoph.fritz@hexdev.de>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch adds dt-bindings for serial LIN bus adapters. These adapters are
basically just LIN transceivers that get hard-wired with serial devices.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 .../bindings/net/can/hexdev,lin-serdev.yaml   | 32 +++++++++++++++++++
 1 file changed, 32 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml

diff --git a/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml b/Documentation/devicetree/bindings/net/can/hexdev,lin-serdev.yaml
new file mode 100644
index 0000000000000..cbf9f63a2a49f
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
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        linbus {
+            compatible = "linux,lin-serdev";
+        };
+    };
-- 
2.39.2


