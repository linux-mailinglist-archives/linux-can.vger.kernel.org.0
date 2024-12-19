Return-Path: <linux-can+bounces-2462-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508ED9F8543
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 21:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC171894406
	for <lists+linux-can@lfdr.de>; Thu, 19 Dec 2024 20:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C75D1DC98A;
	Thu, 19 Dec 2024 19:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="2nj7UVeo"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 130EB1C07ED
	for <linux-can@vger.kernel.org>; Thu, 19 Dec 2024 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734638347; cv=none; b=JPqnAAeVybvd18dd7+xMlPlexvJRrYdaSzNc5MyMkykQvGl+1X6t1sLMvvBKhDpFpNP9SrHSJOVle5XJ8GbsJRX8LuJ3zMrp2Nzd1w0rw3TQUwLpG+czyGgXuZPUPY8hG5vpcV9r0FCnB3RRJwnmBNe/RspvBwAE1dhy2Qmu/wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734638347; c=relaxed/simple;
	bh=pbVz5i7bBpn8K6oPpV4EgG0QmN+pyuIY566qROm5zTA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=V2N5HJatbVUvzc/SCaDH2h8K9X6OiMQ/ThI6YLD788TLbFljuepNaEw25USOpwYMmJaW1c6OnGFk+KTtOqV332LQC4+zC4975FSULAcLoii8YAaZNg6y9d9Rd2jgxS/Gi9q+dtU21TN1PkSAbmYQLqL0nfpYZT9WiDFYmVm5fmU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=2nj7UVeo; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-aa6a92f863cso238033166b.1
        for <linux-can@vger.kernel.org>; Thu, 19 Dec 2024 11:59:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1734638343; x=1735243143; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PRShUSBjq5I6HKenuUGB0yK2sVXlFvGUz4LilaU4jRU=;
        b=2nj7UVeoMh9+4F+yHQihVV/sQZ0/JyVaGr5BTA5YP3bx4b9TlrsYmhCaFbZUGI/VtO
         t+YkBDlzyHl6WiKLpcwmgbfkFaDJqYRKCy6AlbiD91SehEEn6BlIOSRCMuvlPJGh5RkK
         9OISoIswIfLPImp1wWTwVonW3VxTO2CzgeGKuH+68m533qDmLzWCnz38bBoX31bdOoz3
         pi7dHsuH2jquAhAH5iinfsmAnsYJNdaoDnmlNUeIWLXjCGaRisHlggVpcyx5V69SDGqu
         NKJm2dEepca2DQXqHnx6d0tOWhclXQ3gucO5ezjwFuG/QjfO1KQVEywnng3dyPyEMjhc
         HXjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734638343; x=1735243143;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PRShUSBjq5I6HKenuUGB0yK2sVXlFvGUz4LilaU4jRU=;
        b=WvDpdKwgiXCXywNNn+0oQuHX2znAVP6aWRsJ9PVim3ihB82gTCdsLJY9ze6/uG7MTE
         TbG5F48z6F5OwFxonOCN5UCjye0WfTdNjm7XzvyiKzeTyiHTwg4HyE1WS2lPhemUABAD
         uq65E68JSxvKY1M9t//asQV1DgoBGUMfXNaoVmS/Lw9P7eHxuZKfhEx3XP3dLNNOxc56
         ubB8jXzGuoDRwXo5frPMNuOHzJVuxteFlOomExC1Y6+ZopAbGduMQP0eq0nNaTbIDIl0
         VuTx9sMNmEu1f/PxXdycefuGCXnhEKuf4qmWID0KMYKvM4zhgN7tagsaseLbKwEV5eR1
         atSA==
X-Gm-Message-State: AOJu0YxgkoEKnrF4e53A/SNGF7xVsIpQCoQDapzAKFjxCgWhnKM1zHOp
	CuNP0QPe1rp2lpQXLVHeVjHsp0XiRI7189XUuK4REZGOR1epPEv2x6AIhEEXHmo=
X-Gm-Gg: ASbGncsdUpp+cIbGqyKsy2qAfkxJXv8dGrYsEiG3Lu0ljzs8Fwd23nZziwtBhc2Rrrz
	BNjuwY9v+694AcFt4qr3GWsDzy0yoq+wtxwPIXBnzkjprvlND58n4FJCBqFGt8vVsf8tl3PmLSL
	cTnv+oxBWVV3gtKymTp3+26i0u/ov0c3NigQodpLlxP+dIRjQ32c4ZGF+D42vxtwPkUVrf93z5O
	itia70+gZoK11Y3uHZbuOE/2eZ8nUnE11qN9qE7I/uLmResSQ==
X-Google-Smtp-Source: AGHT+IFWWW5j/dWBpAa3jLvu/efCTMtDMJLR6V5NnS7zYJJvfEW3vIH7rRRkkbWVf34McH8wrBcmmw==
X-Received: by 2002:a17:907:9621:b0:aa6:6f92:74b1 with SMTP id a640c23a62f3a-aac2ad7fa01mr7034866b.13.1734638343290;
        Thu, 19 Dec 2024 11:59:03 -0800 (PST)
Received: from localhost ([2001:4090:a244:82f5:6854:cb:184:5d19])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0f015b3csm96559066b.161.2024.12.19.11.59.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 11:59:02 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 19 Dec 2024 20:57:52 +0100
Subject: [PATCH v6 1/7] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241219-topic-mcan-wakeup-source-v6-12-v6-1-1356c7f7cfda@baylibre.com>
References: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
In-Reply-To: <20241219-topic-mcan-wakeup-source-v6-12-v6-0-1356c7f7cfda@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>
Cc: linux-can@vger.kernel.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 Matthias Schiffer <matthias.schiffer@ew.tq-group.com>, 
 Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2145; i=msp@baylibre.com;
 h=from:subject:message-id; bh=pbVz5i7bBpn8K6oPpV4EgG0QmN+pyuIY566qROm5zTA=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJTqp6offH44/KPdSX7St1Yu4MBb2b7V4b+4yprywlpW
 bjh0NXfHaUsDGIcDLJiiix3Pyx8Vyd3fUHEukeOMHNYmUCGMHBxCsBETm9j+Kfnf+rjiws/Xwns
 rC5e8FZJWOSH/6XsOU5X9nTeO3/76stDDH94pxsYbfgbdG/acqct3KdkGd653z5re15dqvL45Uy
 t2mIuAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

m_can can be a wakeup source on some devices. Especially on some of the
am62* SoCs pins, connected to m_can in the mcu, can be used to wakeup
the SoC.

The wakeup-source property defines on which devices m_can can be used
for wakeup and in which power states.

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC. This configuration is described in the wakeup
pinctrl state while the default state describes the default
configuration.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..75963b11d31964c47679370664824ea111e70ca7 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -106,6 +106,22 @@ properties:
         maximum: 32
     minItems: 1
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. The second state called "wakeup" describes the pins in their
+      wakeup configuration required to exit sleep states.
+    minItems: 1
+    items:
+      - const: default
+      - const: wakeup
+
   power-domains:
     description:
       Power domain provider node and an args specifier containing
@@ -122,6 +138,17 @@ properties:
     minItems: 1
     maxItems: 2
 
+  wakeup-source:
+    oneOf:
+      - description: This device is capable of wakeup.
+        type: boolean
+      - description: This device is capable of wakeup from the defined power
+          states.
+        $ref: /schemas/types.yaml#/definitions/string-array
+        enum:
+          - suspend
+          - poweroff
+
 required:
   - compatible
   - reg

-- 
2.45.2


