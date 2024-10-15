Return-Path: <linux-can+bounces-1698-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F1699F6F2
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 21:17:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1B4F282400
	for <lists+linux-can@lfdr.de>; Tue, 15 Oct 2024 19:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 428391C4A3A;
	Tue, 15 Oct 2024 19:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="yQaNsijE"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297491F80CD
	for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 19:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729019834; cv=none; b=GDf6ND3zZeNoZjGu9TuOCw4Hb+kM4dIFVW+mqdqkIO41HTMQtkR8kAiwVlScltTEBayq7WIscP2cn24qW85zxQCHyHBhD804xk4fsXREe1tJZq+H7D6NpWlcF5DjQArPiZZPXZnHHUzYqWwhupFz6RyWaKC2PHzcolIC2G29K+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729019834; c=relaxed/simple;
	bh=Jw+WdBzdeJ1ejN6JFooZdebJTss0hVEiqW0IkRTOyf4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=php6s+cCn1kHiYBB3n+MVCz+QOYc9DuQF2eDrRHF9Fy8aw45VcPPklWN5+/kANfrqviYsleapMkp8RuALZ8kQkECMBa0nO5ERZzlPAhKCv4J2rw+11ZDUHq7plubcUW4GsbcmawebCmZzqabXAce2AoGLkufO0iQRi3vLvDIZUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=yQaNsijE; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a86e9db75b9so835208566b.1
        for <linux-can@vger.kernel.org>; Tue, 15 Oct 2024 12:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1729019830; x=1729624630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BosgQ+kD0H5BJCs43wOOr0oQ/yjsIN/cdckDvbryFCI=;
        b=yQaNsijE1PZ/e4b4fOvo0oEiUo84DNtinRmfG84VSrHQAcu+zmXyojK0n7raycgRmw
         VwU1Dh8Vny3PizuUu2v7JHoQGjE8lkNZUzby6T8vYVek3mvaW6kLLILpQCQWkAQ/HsXE
         TquicYi7uOTBLkFbU9w6j8eoNDyQGFCsVPCkn9GAkHq/Ad0ieZiQZUFYhqrli09UpoBk
         asAvC9i8lT1KI0SU1/99uAK8HjMTMXBHYypK3210cd1YgKNtScDmorYuEtcfdAj9l/8x
         yczlG8oNFcQPktg3vr/qKaomsn3fCLQfw890LalN5iw3nelaCuBQj8/aaBlKoX2xbQmN
         7/iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729019830; x=1729624630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BosgQ+kD0H5BJCs43wOOr0oQ/yjsIN/cdckDvbryFCI=;
        b=prW/dM3HNsT6uacFWpweDqR8YcCrUVXJhNY0THKj7gsr3Q+InmnDb5dATudshXFsvq
         tcYu1VQPXM2FXW7jtxXF8dtUr90xD80StrreczwqijZpK6GfqqkQ/EgRsQseKk+u2e4g
         jUCCOz//D9RWzvlLPqjYtfQ4i/lA/p/i+ziQ1AKMeOHdeLE8HyjDJuE7673nFP/dc9+D
         KuPJHCjfB/mfFQZNpKPaqZlLKdRuTuEzUMaf4twxETEqPE7mGdcLY/gdlbf/85vHw/Xd
         RiBPTEXkKIR4fyY6TX+QxebtZfGqi15IYORSeGIO1/bVIe8Ue2RerqZUmVs5MJJWAOW3
         3vFw==
X-Gm-Message-State: AOJu0Yw8Bb1iCUl65Rp/Acc3cBHH0HrmSgvPlq+EHPpE3yfH4W/7p23w
	Tjg2lPF2Gms2z2BCWwxKAip0rb+Y8ucUvTiIcfhlSkISFBKbs+bSwsjhTFx5SXk=
X-Google-Smtp-Source: AGHT+IFsYtA77wAuh9nis+Oc6a+Lfq19dmpQld1Bd4sJ531FzQwGqpJkoSD0d+dwGzwE0A/GIUGxDg==
X-Received: by 2002:a17:907:7291:b0:a99:f4eb:b7ee with SMTP id a640c23a62f3a-a99f4ebba87mr1017022866b.11.1729019830501;
        Tue, 15 Oct 2024 12:17:10 -0700 (PDT)
Received: from localhost ([2001:4090:a244:83ae:2517:2666:43c9:d0d3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9a2971a51esm101941966b.37.2024.10.15.12.17.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Oct 2024 12:17:10 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Tue, 15 Oct 2024 21:15:55 +0200
Subject: [PATCH v4 1/9] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241015-topic-mcan-wakeup-source-v6-12-v4-1-fdac1d1e7aa6@baylibre.com>
References: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
In-Reply-To: <20241015-topic-mcan-wakeup-source-v6-12-v4-0-fdac1d1e7aa6@baylibre.com>
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
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNL59rcHTtJ/VpO3mLlHjY0r6UKy1A873eMXXD+4bivaV
 Ki43HxfRykLgxgHg6yYIsvdDwvf1cldXxCx7pEjzBxWJpAhDFycAjCRr8YM/2uytik0z7co6z+5
 f/NiuZi2pwwypzN/bHXdcr3Nb0XR61uMDP3xIbNWWVbbZBsf/XOsQtx5goxrOr+e+ryluV37PbJ
 OswAA
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


