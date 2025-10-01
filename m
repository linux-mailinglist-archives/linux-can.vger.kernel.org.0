Return-Path: <linux-can+bounces-5093-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 0501DBB0B3F
	for <lists+linux-can@lfdr.de>; Wed, 01 Oct 2025 16:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9E7654E1DB7
	for <lists+linux-can@lfdr.de>; Wed,  1 Oct 2025 14:31:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C67257841;
	Wed,  1 Oct 2025 14:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="LREd/2vq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A272550D4
	for <linux-can@vger.kernel.org>; Wed,  1 Oct 2025 14:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759329076; cv=none; b=Xj/h08b+RHi+qbirYEvneiVEk5SWvJ/lrpPKIjXbzgC9FkZ+69wz1GkMrzo1r4DXLh5T7sximYzYY0XbE7q1NJLEDnv00YTe3Z+8KGE7DCHFpk1YRZX2/1lUH8EKg1/SQAWcdbSMj4W/TSL7u7qLe0s+lunOu24+9tgGMF2oNV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759329076; c=relaxed/simple;
	bh=XWZPUaaF3htAs1jXMpQkvVgHfFhx17l90EvgzHPAih4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=brvxhawZtNpCiFJdY9gxZOk5KeMT/0EYE8ex3pzS1xa+/SiEKLJ6cW+nVr5nuE8OZr1wAovTovJ3kfyYHBsuKZNrEAV9yxrm3fM59Fc8uZUl+b3xWeyPCGGiEnI6HI8hk0ji6/BEr3FsUCurX86zca2eYNYKdxjohOIm6bwmaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=LREd/2vq; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6366d48d8ccso2203386a12.0
        for <linux-can@vger.kernel.org>; Wed, 01 Oct 2025 07:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1759329073; x=1759933873; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hm8p+oRUJotaddP1TSvfnFNBE3k3mXNPqR5Ais0Uds8=;
        b=LREd/2vq9Zl5L/W7CLQYyAd4EVHfcKh+/YsVy+8bHyp0yO5Q6BEjT3YgDUNylJo2JD
         QbUgqHxFo2GyyzOK9zaem5LTzxD6+h3YhrNh1bO1DKWPyJ66wDoRAxRR4t4Z8wJAl/Xk
         dC91hwP1T7Igm1eEgRG640dlKJPBrk+zR18BmYdFFlf7gcn5QKK6BU8eOnHbYJXtgaJ9
         VEf1pjkIUXILdN0PxX2Q1Z8A84awE1zPz6acfvWWA35Z64BzH6QJKZxoN7NSz5/xFXkh
         e78g2ESvVZiURDMpqg0m/FC3+BRb7zlU7Eml2ac0a0uOZgtkBYNbT1E1/hbdEyh6GNjU
         O31A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759329073; x=1759933873;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hm8p+oRUJotaddP1TSvfnFNBE3k3mXNPqR5Ais0Uds8=;
        b=aKo8rAgyk+jKqwMs+DVpH9PaP+ImcLURYFwnNghjFjvdLtEwcFdjmc9t83J28hZ+c9
         9P4ccCqgLjkqM3g1FvQWNk/dYCNxg59mxafbIjtSbwDxTi85pz6k8pFXSffCE5Zi3T1C
         eeTIPa3VfGbDTGO6zKv93CRsfmhI4tQWbcHRdaxaAsDJOnxmmZrwYe47uQQK7ZzcKzVa
         IE3rDxi3MvS2qQlwhgX3H7P3b0ujbEdGTZi8HCX6H4+iFSAyzqknZ3nQNY6vVEqfFzuJ
         12aAw0Z64euW4e02SqfPtpiYJe9cT+3FvQglM958Y5TM7wUTT0KtKOtsFedrnkKWL3oc
         U03A==
X-Forwarded-Encrypted: i=1; AJvYcCWuPJSUUtjtveDfQamjxf5lJlTLN/wGur2ZYx5yIRi24Jbpyq+b96fze8dHiTMkASOKT75xYsP/IFs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwZJfaXXLniWew+zbvWIZmb7wa4iJUxj/OLBsj/Ue9BmbfoGXWd
	xc8cPNGNcRdTd7M5F0XUSlWQVIDyabLnyEa5/2HkfjNvbJSW6auFr5GRLZvVcM2s0Xs=
X-Gm-Gg: ASbGncuU5fTHjfzYNtoeKxw/hCqtSF4XFKX5lYoQsFmgByuCd0loSv4/7S2BHS30zvV
	yxR9tvOqVt+l48k+fc74PMAid7D+cQBDJ2+zOHDj+xpW+8BelCRVTeGhmzdhzFaLRy6VCOEqqWr
	zhpqM8tmajvINBkj20fUzoeSuwZ6cjfz1HcV0Aqx0Up9Jzzqzc6vWnC4jov9TDszcOjo+Hn2pBp
	AC2Wq1z/Hg6uq6MSXuMeVxZciL5lqoDUclc3fx+TtKGDcj0GQ7VgXI9ME386gmh3QGGY+d9zzy5
	pG1PJRD/umYCYfiSkLjJjWaB+mnNZxwpSBTfgY/1JSFw0Unos8KvtVL4eNy6nBNxrrYSESiOxh8
	lrrNRJlnwrloMIBPgqMnomEGg9FplApmSt9geq2/A1ZYr
X-Google-Smtp-Source: AGHT+IHFmCw9M7RXCZRtcPimiE3xYGWmiFdckmISU5XdmOOsx8oWJtSKmAidkIoaUD91Rq4E5XkMwQ==
X-Received: by 2002:a17:907:3d42:b0:b3d:9c3c:9ab6 with SMTP id a640c23a62f3a-b46e6afd22fmr373738766b.29.1759329072722;
        Wed, 01 Oct 2025 07:31:12 -0700 (PDT)
Received: from localhost ([2001:4090:a245:8496:49da:2c07:5e9a:7fb9])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-b3fb818fb90sm607739266b.63.2025.10.01.07.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 07:31:12 -0700 (PDT)
From: "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>
Date: Wed, 01 Oct 2025 16:30:19 +0200
Subject: [PATCH v10 1/4] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-topic-mcan-wakeup-source-v6-12-v10-1-4ab508ac5d1e@baylibre.com>
References: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
In-Reply-To: <20251001-topic-mcan-wakeup-source-v6-12-v10-0-4ab508ac5d1e@baylibre.com>
To: Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vincent Mailhol <mailhol@kernel.org>
Cc: Vishal Mahaveer <vishalm@ti.com>, Kevin Hilman <khilman@baylibre.com>, 
 Dhruva Gole <d-gole@ti.com>, Sebin Francis <sebin.francis@ti.com>, 
 Kendall Willis <k-willis@ti.com>, Akashdeep Kaur <a-kaur@ti.com>, 
 Simon Horman <horms@kernel.org>, linux-can@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Markus Schneider-Pargmann (TI.com)" <msp@baylibre.com>, 
 Vincent Mailhol <mailhol@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2028; i=msp@baylibre.com;
 h=from:subject:message-id; bh=XWZPUaaF3htAs1jXMpQkvVgHfFhx17l90EvgzHPAih4=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhoy71sI/mqZEXFbZ5rHrr8krW/aez89esqRFKG92/HjN8
 kSkq314RykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzknDYjw0abY2oqP/J+sIfH
 rNbffP4Bg+cyCx9Xy+Ai5p/PS5/ufsHI8P/Li83dL9pSlytNdG22VxX9+IwrJVTlurDx1t9v/7x
 8zgQA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC from some system states. This configuration is
described in the wakeup pinctrl state while the default state describes
the default configuration. Also add the sleep state which is already in
use by some devicetrees.

Also m_can can be a wakeup-source if capable of wakeup.

Signed-off-by: Markus Schneider-Pargmann (TI.com) <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 25 ++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index 61ef60d8f1c78c40a6c8458ed30b940b1121d83f..2c9d37975bedd652b3060ab11ba75c37565edaad 100644
--- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
+++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
@@ -109,6 +109,26 @@ properties:
         maximum: 32
     minItems: 1
 
+  pinctrl-0:
+    description: Default pinctrl state
+
+  pinctrl-1:
+    description: Can be "sleep" or "wakeup" pinctrl state
+
+  pinctrl-2:
+    description: Can be "sleep" or "wakeup" pinctrl state
+
+  pinctrl-names:
+    description:
+      When present should contain at least "default" describing the default pin
+      states. Other states are "sleep" which describes the pinstate when
+      sleeping and "wakeup" describing the pins if wakeup is enabled.
+    minItems: 1
+    items:
+      - const: default
+      - enum: [ sleep, wakeup ]
+      - const: wakeup
+
   power-domains:
     description:
       Power domain provider node and an args specifier containing
@@ -125,6 +145,11 @@ properties:
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
2.51.0


