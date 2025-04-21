Return-Path: <linux-can+bounces-3443-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FDE0A94DB3
	for <lists+linux-can@lfdr.de>; Mon, 21 Apr 2025 10:11:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF5A916FA75
	for <lists+linux-can@lfdr.de>; Mon, 21 Apr 2025 08:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C9C20C460;
	Mon, 21 Apr 2025 08:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="eZiA2ggq"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB220C00B
	for <linux-can@vger.kernel.org>; Mon, 21 Apr 2025 08:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745223071; cv=none; b=uFW2r/bByLwkdDC+mSSnFqdJNEuVsGA5KatRSxWnljzHk/ppKc2sVry5J499JK7f1+gDH5/n740O1V7ijTGDLL8hOlISDk3mnppmtgP62p+wS9JSKMXSRl8zSwQoxtjppRwb75H9uZ4HRhGoEa6rqUxcMoGgVI6snF/W17NxjRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745223071; c=relaxed/simple;
	bh=8cnbqnEIT2SapONFBAoVoxc2fqVmncyHVScTK2PoKRo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jMLch8WSoG6Q/G/3RrMvWQ+nLuUYGepIObIIOcHPFfagJi/js9S9E4pZ+rO0AHqMkY6GY3Ag4Ik/s62fp/NzMORPuDuqYzEandtiQgsYMX2lc9PZca9tk4F83Ra34DTY+ncEiJwe6Vs7zS4JvRvs5BXpqEmYqfRx4i1Di8sPmjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=eZiA2ggq; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-ac25d2b2354so548640266b.1
        for <linux-can@vger.kernel.org>; Mon, 21 Apr 2025 01:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1745223067; x=1745827867; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xXgQQbKgfnh8/TwrQq0CXBZDridfnrlUyigTFtKkpUk=;
        b=eZiA2ggqNIM6uoGrV/3/+E6nv64g+gGn4PxAuujLludy356xZMUFTDn6oELoRziZ8j
         dDk9QSuPBgf5HaY6S6DaAUswjUQr26VLdTeF66fg1Zjs4O9bKvvB17KfnRDuzI+5zkrr
         xlLgz9fujv4uGfm8Ad26pYIRSfcVCXmSCH/NDHk53aCFtJ8h/Ab5laGPcy8Aj4XBhc6m
         qy6lNydz6js+7QLMy4WPKCpqpcpQYidOSINv5D9nMXrU5lL1c6Yzh0XHcHV8sLpQxYBr
         IhM0zx7BtVJXHHzEM2T5yAGfBpXzRu3/pZ9HUSAknNGiWgPM6yzMnN2A0uImMFWwsHDJ
         lkxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745223067; x=1745827867;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXgQQbKgfnh8/TwrQq0CXBZDridfnrlUyigTFtKkpUk=;
        b=HBgfROUc67uhDzk0wH84xZyjPTD7T3tKzlEGQOYC07XETR5cV/XhDkM7mwBiaVqWqq
         iU68A4xcNGFTK4uDuS6uNEl+pJ/piS/1qc4080XU0HpyNXA4SJIzRvmHt/+QC98NrtTR
         pxiE5Vp0KNyjT8iDvIEjgCgBo6bphVgjG8fe0KAn/4EVVWBWrmtTDd7+5AKhmWY30rIQ
         JnpoDXK7nJma4AXrrmzuWKGmr53W9U9bHMK5z1nbF0hkr0TesUfwQNza1Z6fTyU/4Brx
         PAVpO+AjoTsO6tGudxodSIT4ZUa6MsgIWtc+Q33oI5NoR0hPSsBwhPUHD8LhKHBZ30KL
         XRgA==
X-Forwarded-Encrypted: i=1; AJvYcCUAi+e616cjLu4aEgKRT/4arp23ygLQHTMp4xOmn/wnqe2ijPIkddvoFvRhjy4VAmyQINwoAkUO68I=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw+gIxtRedS9uqIG5ZlPOtMr97bUjjRr+RXs63WDsrgYkkO6po
	wqWGnNF6TstD9xoplD391fldwFGWegqduIcq1NrIo2Mdbn2pDtAz+6P5euSR3/M=
X-Gm-Gg: ASbGncvJ2ivXSVYdSxbEHIRNwyPUXAhUGXQ+qestCR9XP71vnbzuTLkr5m5VAbOXvUg
	XwMWam5LqVcjQd3Slm1ic9BLjS3eTyue1HEg9OVnCm4afUi5S3wJG+GaCNG5Vpu69fFXlCXTPID
	kTUJ2eMKL1IkTOqvDqONMOMbF8RjGKlRijcp4eZy5XzNHbA81q0T5Rjou1e1k2kMajyHJFlG/b3
	UC0VJBSqKLSE1gXGwdFcBSjjORhGMYLQ+lI8Oeh2UM82GnlciHhmDqEyJTbeyq8i+dWFXqm8ipJ
	jjLMj2LXLeckKUl6IOPV4QgK0VR8A7a+sLs=
X-Google-Smtp-Source: AGHT+IFm/Skz537wfTeoh2KozrNOOTUDzhipX6Al/MEzRYRXMbJwDdJHpyUOgxUlClgZmtUma/F09A==
X-Received: by 2002:a17:907:7288:b0:aca:a383:b0c9 with SMTP id a640c23a62f3a-acb74afba44mr971434066b.13.1745223067279;
        Mon, 21 Apr 2025 01:11:07 -0700 (PDT)
Received: from localhost ([2001:4091:a245:826e:c0c:4cef:7dd:26bd])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-acb6ec0b389sm475749866b.20.2025.04.21.01.11.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Apr 2025 01:11:06 -0700 (PDT)
From: Markus Schneider-Pargmann <msp@baylibre.com>
Date: Mon, 21 Apr 2025 10:10:37 +0200
Subject: [PATCH v7 1/4] dt-bindings: can: m_can: Add wakeup properties
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250421-topic-mcan-wakeup-source-v6-12-v7-1-1b7b916c9832@baylibre.com>
References: <20250421-topic-mcan-wakeup-source-v6-12-v7-0-1b7b916c9832@baylibre.com>
In-Reply-To: <20250421-topic-mcan-wakeup-source-v6-12-v7-0-1b7b916c9832@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1809; i=msp@baylibre.com;
 h=from:subject:message-id; bh=8cnbqnEIT2SapONFBAoVoxc2fqVmncyHVScTK2PoKRo=;
 b=owGbwMvMwCXWejAsc4KoVzDjabUkhgzWvy17Oeq+FiudfrvfStt+jk7OAqn0iEtnJDZY7Fpj+
 aZYaF1xRykLgxgXg6yYIktnYmjaf/mdx5IXLdsMM4eVCWQIAxenAEzkUh3D/4A/8Wf3Ls5cuNSN
 +U+ejch+9V2mvRM6C/tExV0UHL//VWX4X61XbtC8ccPa36Xr2330dz/fKPW6iqVtfs7zgKeXWL5
 NZQUA
X-Developer-Key: i=msp@baylibre.com; a=openpgp;
 fpr=BADD88DB889FDC3E8A3D5FE612FA6A01E0A45B41

The pins associated with m_can have to have a special configuration to
be able to wakeup the SoC from some system states. This configuration is
described in the wakeup pinctrl state while the default state describes
the default configuration.

Also m_can can be a wakeup-source if capable of wakeup.

Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
---
 .../devicetree/bindings/net/can/bosch,m_can.yaml   | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
index c4887522e8fe97c3947357b4dbd4ecf20ee8100a..ecba8783198fc1658fcc236d8aa3c89d8c90abbd 100644
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
@@ -122,6 +138,12 @@ properties:
     minItems: 1
     maxItems: 2
 
+  wakeup-source:
+    $ref: /schemas/types.yaml#/definitions/phandle-array
+    description:
+      List of phandles to system idle states in which mcan can wakeup the system.
+
+
 required:
   - compatible
   - reg

-- 
2.49.0


