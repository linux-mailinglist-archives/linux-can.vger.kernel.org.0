Return-Path: <linux-can+bounces-1807-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95B859B37D0
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 18:40:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55D9D28297F
	for <lists+linux-can@lfdr.de>; Mon, 28 Oct 2024 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB1BA1DF74D;
	Mon, 28 Oct 2024 17:40:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="GxHuZaU2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF6D1DF729
	for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730137223; cv=none; b=NWf10rvJhX1ruU8ZYboyE4o2moa9MNWoomXchhEIfFytyzMJFBbFUebzZHGX92UkTYo1iH5BKjj9CP2jzEq76KenkzWLHGSEpMzb9jqeS3jskGrUmUHV9Q673Ve0hnRo8mNfi381vWZnObROVFFyCoN5WQQ5t4JRONpUbWOUb/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730137223; c=relaxed/simple;
	bh=Jw+WdBzdeJ1ejN6JFooZdebJTss0hVEiqW0IkRTOyf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UVVJPxtBTWMqQ3j7lmSQYjrZwn9jaKIGO8QqLa2eLCmV0EjLS5SMiAIB80ci0Xc8TSzvmaWOKsmB3h4ML9EUvVkpMnDn+0SFzycGAfUJzZgzS5hXqYDB8EHZnPG9cuCGYsx4+YtPMaCeVTN7l9rljhLY+iIbnET8ZPnRpsu3WEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=GxHuZaU2; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4315c1c7392so46652825e9.1
        for <linux-can@vger.kernel.org>; Mon, 28 Oct 2024 10:40:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1730137220; x=1730742020; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BosgQ+kD0H5BJCs43wOOr0oQ/yjsIN/cdckDvbryFCI=;
        b=GxHuZaU2jzuUPTxk2k87mXbUTN5lLd0KmzQRNQDiHY81WMFCX0qbJ1+expdGXkfOR0
         cZP9L2xcMfcvg10abztgEFvAINc3FQuA82EWhJh4DpWZfhv7bIO0KHmiLOPeHR/ZHsZS
         wgAvYdzx7fY/ORRydg849VZ2PXoQ57Qhme+O8VxNC9N/cbHm8ZrSnx7v6LoIQ4e2PUS4
         ujz1FSiT8fJzND3YvF86GM9ksLcwkgM6h84SUS75z3anDkDm/uEK0o8tcxkGlXVPxXnq
         YAZD204ic4xup7Ri3wDbrOQlCw60UcE0EOMzN+vrmqSc5y/WtshF+7vcQLcgpxkBG5cF
         JCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730137220; x=1730742020;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BosgQ+kD0H5BJCs43wOOr0oQ/yjsIN/cdckDvbryFCI=;
        b=qT4+80l/NUrSgqvLmBbwd5CDKGZL5G7EmQ00N99bCafmSw/dNp4EW0zgUao0XH0C92
         9Id8NWqe5JYiZg3i9jUewsrJSo0McIqrRV31Xv9oreY23j8yotc3CVjB7pbxOoBuO4ZO
         EaN+83PO78O+wADEuo28xK6BNN1DpRhAPPi2UlGLWRoSUhmRQ1Pfm7dMaZkEV0kQk3Fd
         fkAMStylksEEkY/QQQtS2X8wKkFoRQe+2ANd5RExVa5d9CV9qTslLjW5cG/RcOFCaVce
         keA4bRZZO5RfZmznpOCHwQvjPurMmZ8XDr5TvET3jA9bxbQspfsU48oWD5G+jT/mJgpo
         HUDA==
X-Gm-Message-State: AOJu0Ywt0u7pbFZMcHaESiSSbMy+d/ONFHhljpvn8YvkbgcZ+3NLOaLF
	GI2RTSClUOts1Q/+NtKXZOuQdXXHAxem7/ZhjShar5wcIxtmePg1dBo+fFqeBHc=
X-Google-Smtp-Source: AGHT+IEqqisyDCHRMO2yXr3fzu1rVySxQSqDU1ltOdB1gBn9xls9XzEdxtAs+MNmhWUihFO/tSzfJQ==
X-Received: by 2002:a05:600c:4ecb:b0:42d:a024:d6bb with SMTP id 5b1f17b1804b1-4319acb8145mr62323225e9.20.1730137220010;
        Mon, 28 Oct 2024 10:40:20 -0700 (PDT)
Received: from localhost ([2001:4091:a245:81f4:340d:1a9d:1fa6:531f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5431c9sm147417555e9.0.2024.10.28.10.40.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Oct 2024 10:40:19 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 28 Oct 2024 18:38:07 +0100
Subject: [PATCH v5 1/9] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241028-topic-mcan-wakeup-source-v6-12-v5-1-33edc0aba629@baylibre.com>
References: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
In-Reply-To: <20241028-topic-mcan-wakeup-source-v6-12-v5-0-33edc0aba629@baylibre.com>
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
 Markus Schneider-Pargmann <msp@baylibre.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1874; i=msp@baylibre.com;
 h=from:subject:message-id; bh=Jw+WdBzdeJ1ejN6JFooZdebJTss0hVEiqW0IkRTOyf4=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNLlzwSUGSpPS0vrUKo/MalQaG9c6eXD7a217xauk64xV
 vQ8/XFnRykLgxgHg6yYIsvdDwvf1cldXxCx7pEjzBxWJpAhDFycAjCRkxGMDPtK5r8O7H7EI3f9
 tZXC1OXX9n22mT9R+OvnC/Pbwmd+WxXLyHA8SLDz636BllYXl6eGgh6izRv5wh6Un0/dE2Pd9P/
 gOkYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

m_can can be a wakeup source on some devices. Especially on some of the
am62* SoCs pins, connected to m_can in the mcu, can be used to wakeup
the SoC.

The wakeup-source property defines on which devices m_can can be used
for wakeup.

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC. This configuration is described in the wakeup
pinctrl state while the default state describes the default
configuration.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml       | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..0c1f9fa7371897d45539ead49c9d290fb4966f30 100644
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
@@ -122,6 +138,8 @@ properties:
     minItems: 1
     maxItems: 2
 
+  wakeup-source: true
+
 required:
   - compatible
   - reg

-- 
2.45.2


