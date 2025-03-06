Return-Path: <linux-can+bounces-2990-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B4EEA548ED
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 12:17:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E8087A7D63
	for <lists+linux-can@lfdr.de>; Thu,  6 Mar 2025 11:15:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD3FD20B1F1;
	Thu,  6 Mar 2025 11:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="d0VGyZD/"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E20204F75
	for <linux-can@vger.kernel.org>; Thu,  6 Mar 2025 11:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741259764; cv=none; b=s54BtjQrzACQVliKUfw6xBV2qxoFeCSlg/6L0AkZgOi+eU7/DmLKaNBH6kGgM5xrSp1PaHhmqEjak+VvX9EWTvh3379boB5puZlr3zKAJFzHrE5TOgyartzEAuETH+TFzzt1QDr7QCv1MShBUzgvgpSLc5QsyuK32FHbjAjBMcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741259764; c=relaxed/simple;
	bh=MfFZLvNgPjqf41DYixOzP+LujWeubVPB6G1Uw3Qe6a8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TTeHYqQlR8MJELsl0QiQhibYpjUxftf63o62VRbR5ZKC6Z0KAkUwx/HWFW34zzQyb/kKSUocLwvcrdqquYIR9DOtViCR+gBOCe/Y10xplSa+LmEB5ziX045ZzH5zAUGq7NSqZFzu/xXqXbDd0CgJCUY5xFT67nT5HgwfwZYnpIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=d0VGyZD/; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-38f403edb4eso300043f8f.3
        for <linux-can@vger.kernel.org>; Thu, 06 Mar 2025 03:16:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1741259760; x=1741864560; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AuN0/pwTHZ9vhnZKyENKczH8fXv0gjKVeEKQIoqI9qs=;
        b=d0VGyZD/057WUi6gaRce86qcybsT27VRbrOowak8eNrEB/IZczycDZ3xfBPGD+58gL
         n8H/NAvRQRSgRpzIkPUEU4p8E7Hd8jhlnsmbthgDkIh8IOC8bToavm/gZdGoCXNRRdYD
         7jDvsoceBs70N2w44HAjPbbND/EEZWSQ5mmCZf2dRTYiRaCdesH0DgxjVGoax6VB8XZN
         BI3Hiae4TGAQe7/FxzjeA5CWQl0yjaKZGTu7CmOsoNzhowf2FA0vuTw++Cz29jRYMyX8
         jAJlQpcjTxTRrgZTU9mRmCVqlQBFb7lE5fXFgDfdmk9IIZAcwYMluKFT0YLTP6ZRasFd
         U6NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741259760; x=1741864560;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AuN0/pwTHZ9vhnZKyENKczH8fXv0gjKVeEKQIoqI9qs=;
        b=r2FgW386xrwUq5KfVjEqna+3lHaG1PSYG69csQpVHahop5k9A+0SQrkROjCrE4SpXr
         pkH12tQRlcZkAZ8tnBWDa0EApcRuHSQiFckShVYKhCnbRuh+96oNm1lO8Yx1dhiJBsi7
         kXgn2oz7SIqDFt1iiSvae13iYY0y1M2ExQElnnuW6ifysrXpemRGrPBuWIaa5lcbgXcb
         hyH7xwLW3h2A/8POQvuuf/UHeah3dOvo6yt+MQQAPJ5BIAvcguyU7MOhNErjZUh9lvbI
         d6WPPDutBEtmOYUK8ck8cyfmpBUNG05RQqfqLgRWgXOVQ/1G9DA76TcCwAmL04hClxio
         DsUg==
X-Forwarded-Encrypted: i=1; AJvYcCWGuoTvQTxhW9iVsXdgG7XZIiCHmRGXtT0+GdkITt/IpFE2L6kUv2uvSFZGAX1x1WOXp1ltCzwAsHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE2EMfsm2VhUk84pKa5mppMB4vI8b2GD/MRAQQ07liCST5YEEr
	v/zEak0rbO/7Ms6qQxesvfcZy+sLQbRGWPrMvzd4fD0H9R4hufv/+ksfY2lK4eQ=
X-Gm-Gg: ASbGncsA8LVAcadrLgVWmjYDrc3plBE7/syLd+O3pbctvaafi+GwyOQfURk3ai/J4rq
	yh6K/r9w4NaeSSV9Pg2n12eona2YOteKbV3d9B128u+zKRLzp5r6CoSPj/X2ytxyIqhE1EH6bUN
	Vj22h86toPPtfyec1Z9MvgE7SWLXrNAWR6//9KRkH20h2C3XBKegZbO18gjy2UOzvhfS6+MSH1m
	87MYkbxfwV/GFqWDFNNDwFmT9WCN6AFmrw/d+jJSQgc2n+nkIKlUDJL5OIQ2EwyyaBVdUL3Iyji
	QoJ8R81gQ16H+/qhrpxyAfefRx2lu1czeiIEkvJG4g==
X-Google-Smtp-Source: AGHT+IEfL0NWZoLLWRUTFCp+4DpyOhfP6ZpCXD8lXd7n6hvyRmuTOarjAISZof3JEfKOs/w46sjnwA==
X-Received: by 2002:a5d:6c6f:0:b0:391:2e7:6811 with SMTP id ffacd0b85a97d-3911f7404b0mr5947283f8f.14.1741259759759;
        Thu, 06 Mar 2025 03:15:59 -0800 (PST)
Received: from localhost ([2001:4091:a245:8327:80ad:8144:3b07:4679])
        by smtp.gmail.com with UTF8SMTPSA id 4fb4d7f45d1cf-5e5c768f213sm784211a12.74.2025.03.06.03.15.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Mar 2025 03:15:59 -0800 (PST)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Thu, 06 Mar 2025 12:14:41 +0100
Subject: [PATCH v5 03/13] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250306-topic-am62-partialio-v6-12-b4-v5-3-f9323d3744a2@baylibre.com>
References: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
In-Reply-To: <20250306-topic-am62-partialio-v6-12-b4-v5-0-f9323d3744a2@baylibre.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Anand Gadiyar <gadiyar@ti.com>, 
 Chandrasekar Ramakrishnan <rcsekar@samsung.com>, 
 Marc Kleine-Budde <mkl@pengutronix.de>, 
 Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Vishal Mahaveer <vishalm@ti.com>, 
 Kevin Hilman <khilman@baylibre.com>, Dhruva Gole <d-gole@ti.com>, 
 Akashdeep Kaur <a-kaur@ti.com>, Kendall Willis <k-willis@ti.com>, 
 linux-can@vger.kernel.org, Markus Schneider-Pargmann <msp@baylibre.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1648; i=msp@baylibre.com;
 h=from:subject:message-id; bh=MfFZLvNgPjqf41DYixOzP+LujWeubVPB6G1Uw3Qe6a8=;
 b=owGbwMvMwCGm0rPl0RXRdfaMp9WSGNJPNm9X+56w2K1+/c7Ce/Gfi6IMU0XDit/e/J73zXtzp
 W5s6zTmjlIWBjEOBlkxRZa7Hxa+q5O7viBi3SNHmDmsTCBDGLg4BWAi1SWMDJ/1uafnP3n+07y1
 66coo+WxvoOrREtrviwpnH+vqGLmqkZGhhNuT4pTtrVatqdxV/z9eJT7rnO1YN/Tkwsd4/VS7u/
 U4gYA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC from some system states. This configuration is
described in the wakeup pinctrl state while the default state describes
the default configuration.

Also m_can can be a wakeup-source if capable of wakeup.

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
2.47.2


