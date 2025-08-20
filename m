Return-Path: <linux-can+bounces-4273-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED236B2DCD3
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 14:43:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9B877B3EED
	for <lists+linux-can@lfdr.de>; Wed, 20 Aug 2025 12:41:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6031577B;
	Wed, 20 Aug 2025 12:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="w86SCndN"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46B1A08A3
	for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 12:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755693786; cv=none; b=HS9qIofzg+zMDGbbPWRh+esS+VQa8/ni+g68NM2AE8cxfWvZ1shlUSztxpKM4eM5QJoeDWzs7YOTIM8muNCN7N1vD7REKbhxd8ZeEQMubA9ojgmWbfjLPrz4Z8oZJwMA1EWJelzUwldtSTy85sS4eyMtsJSt95alrlXfZQC9xpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755693786; c=relaxed/simple;
	bh=51A7apjZ8IFVa0Yg300u5/+5kMrmxbdazMNe8d87/KY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=t2QU9o1lhHxno9Hd+eDh8fVtPh1S5WJKeqBoaSkBzgtWfRvqP3AOoUIcd4kqRFYWktdVeh7BTD/R148Vthhs6+i6ky/+RkzXjM+fF+8P14NPT/XluZ+dkdaxwBXSwk0CdQb/0TiMFKcBOp6NuuwktyiSIiC5x2NlOBLVMgF9Jx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=w86SCndN; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-afcb78c77ebso1038566566b.1
        for <linux-can@vger.kernel.org>; Wed, 20 Aug 2025 05:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1755693783; x=1756298583; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xwZuyqe06pEPgm8WrxHlNtoUHhvQcJ+8KnDBnyp1UJ8=;
        b=w86SCndNnGmtUMUT0OX250cIf6Moep2rk1xpcBmRY93sCPo7VTnUxn8SsQmFcCP2Vs
         0ElgdQ1vROyZCq8USJJJ94DZUsNjuoMdKo6TnDF65Pgsr/ebvmSAa8rOwg1UBC31E5Y5
         xqjP2UqQz3UYPdvBs9V3Ye8+cer78JGYvhWseOcrhmNDR4SirMWlfT1WY0kClBEIBg5r
         cEepb7VPCbRVA/gm+cevR4v8h6LW4uD5BMap4Yi+UvMlXimQYKrKzNeQneRCI6VX0FMc
         Sqh2COiwjU7yJKWc45ZA2p64cUx8vvddd4XO3l2/weHtf46y37j0hVS5HNTRlLKTXV0u
         8c2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755693783; x=1756298583;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xwZuyqe06pEPgm8WrxHlNtoUHhvQcJ+8KnDBnyp1UJ8=;
        b=YXvJKay2jdKzxnlqvYHQXhGb3w3fkE/MOjJY7GRUap238ZH+gKntcHA3N8erb+lpOx
         xRLX2Vu/kSEYp5CdHHn3hikLvTtCW14B4jPShIYfJa8rJln44Q+tdISOiFx/TydGLdgO
         zOaUG8GiPPtcLweCK2tofQPD82KRS9wjGQua2IMS+q29Cr4v5+dMsRzUuEbc59X3q0+z
         EenXJvXE0oBXu/bgb1XoXXlhuR0cxPA+ghL6aQIfxChJUxUFSCeO40jrwXqrRQmdXqPa
         kNDMvOy7ie/Cp43D6HK9pzAzqXMCR34HEwWe1lhwBXxhsqJ1aMcy8+4HxuKlJbtNKoOL
         kYfg==
X-Forwarded-Encrypted: i=1; AJvYcCVImRssQ8bcEAuS5Ggi2jh8OH/1gxHezm97pLFkBIqMHE0rBf4dyNzOnJwFSjDLBx+62CmhCwL21jQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNVrSvqQodKBQjmvKwYUMRrY66W9o9JQnTKpGKCkU5goYelij2
	JbvU4TPeHiwv40SvdEV5fQeSCcQxLysJ3Uk/abEewIbUwfsMixq8zr5MAOEY3ubsIYU=
X-Gm-Gg: ASbGncvEOiOCduD7f9j9aYRnLbsA8RDsHl76JAoPpNGVt+YjGbuaAnFks/FV0oJk9Hi
	eP6J5s6ILaljCBuCcdRNcmMJtOLIT+2eACoQEz77ge/AnOqJl8lAvRm7yAVjzlrQ2mEdmIILxOy
	qklN31cLJ5LfLxVRhMkl/AXU0uqsnBsRQGkW/y9qraUEBeiScWBR/1HqIc0/tQJtoXlzmPN1OY+
	UEilGlLUyGjpt8rWtlkZFWeq3BtLAKzP2kDEnBc7rVruj+tfR4wXmdHIX7CNzKXrCHu6yk8P3CF
	rtrV1IylNCxRiirMas+akqPIqegpQ1h7ZLl3JGddC7YxCCPuiS3Nu6mJ6qSPKABQOQE3SGppIl2
	RORSgO6ROZBjZRozD/g==
X-Google-Smtp-Source: AGHT+IHVxY9C2B9taD88Cxqvj6obkaYcfXI9ph7iwjcVzwEn033IZvRkXZCjUiNo9LHBqDddmiHmgw==
X-Received: by 2002:a17:906:c141:b0:af9:8cbf:6053 with SMTP id a640c23a62f3a-afdf0049eeamr202227366b.6.1755693782774;
        Wed, 20 Aug 2025 05:43:02 -0700 (PDT)
Received: from localhost ([2001:4090:a245:849b:bc8d:b969:7631:815])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-afded539d39sm169436366b.110.2025.08.20.05.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 05:43:02 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Wed, 20 Aug 2025 14:42:25 +0200
Subject: [PATCH v9 1/4] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-topic-mcan-wakeup-source-v6-12-v9-1-0ac13f2ddd67@baylibre.com>
References: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
In-Reply-To: <20250820-topic-mcan-wakeup-source-v6-12-v9-0-0ac13f2ddd67@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, 
 Vincent MAILHOL <mailhol.vincent@wanadoo.fr>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2000; i=msp@baylibre.com;
 h=from:subject:message-id; bh=51A7apjZ8IFVa0Yg300u5/+5kMrmxbdazMNe8d87/KY=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoylh/ZKzOsTPc8b8uxn84xzGfvzYm7N2zsp8edhjvUCG
 cnBW52MOkpZGMS4GGTFFFk6E0PT/svvPJa8aNlmmDmsTCBDGLg4BWAiVtKMDH8Pby569cDFMmKt
 22Hbx/uDLP8ujXv4U+T0nv+Gz13nrDnO8E+bkclcS+jC286JkRFx+vM2t2/t+eJz6fN7x4qPHdN
 4t3ACAA==
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC from some system states. This configuration is
described in the wakeup pinctrl state while the default state describes
the default configuration. Also add the sleep state which is already in
use by some devicetrees.

Also m_can can be a wakeup-source if capable of wakeup.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..0e00be18a8be681634f25378bb2cdef034dc4e6b 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -106,6 +106,26 @@ properties:
         maximum: 32
     minItems: 1
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Can be Sleep or Wakeup pinctrl state
+
+  pinctrl-2:
+    description: Can be Sleep or Wakeup pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. Other states are "sleep" which describes the pinstate when
+      sleeping and "wakeup" describing the pins if wakeup is enabled.
+    minItems: 1
+    items:
+      - const: default
+      - const: sleep
+      - const: wakeup
+
   power-domains:
     description:
       Power domain provider node and an args specifier containing
@@ -122,6 +142,11 @@ properties:
     minItems: 1
     maxItems: 2
 
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of phandles to system idle states in which mcan can wakeup the system.
+
 required:
   - compatible
   - reg

-- 
2.50.1


