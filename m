Return-Path: <linux-can+bounces-1506-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CEAE979708
	for <lists+linux-can@lfdr.de>; Sun, 15 Sep 2024 16:15:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C46E91F21A5A
	for <lists+linux-can@lfdr.de>; Sun, 15 Sep 2024 14:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 731B51C6F41;
	Sun, 15 Sep 2024 14:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f6zQ7mwA"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D2845023;
	Sun, 15 Sep 2024 14:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409731; cv=none; b=msEtVVD6mxo+OySnu0e+Xys4ZI4wFnyVhg7xxKoVlNUasL72htiBG88kKLmnCwKMXJNT9YIWz7CJq2fvC/vTUo2ql4J+ZMsa+EnincvudDckXGxhuAhgcGO5VRO3lAoMq5SRN5m3vWqNc0/yCQu45DsXFGHiqttSNOQSRSR1gOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409731; c=relaxed/simple;
	bh=sPXpD92T+hvJ3Xq4Y2miBjvbDMl5XcT1vqRWKRi48uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Cbf7fP5wspWMvL4sISX48JcI+E+wOApvbsdgbQnQ1g0b2ADUIm/N7C8sAVlQTB7uhjA3HEStgS0TEJuNHnZPtR2CTpLlt7EgtF5bxOnVVietomKMiDH0r1aBJ9JYnCeCqEQsQIcTpvGIpmaZByudpDVP9eyV/k7MX7mXgdXpxLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6zQ7mwA; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5365cf5de24so4563818e87.1;
        Sun, 15 Sep 2024 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726409728; x=1727014528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=731RcZeHTEALfaVb7fhfHI1er4oVn7kj9vmasIgzTaE=;
        b=f6zQ7mwAQl7ceSUmfp3WcTc2pVbMc9fw/9bVwcHRRJKgwg4M9zBz5BuEmvOiBo3WNu
         qmjaJm+ZrLiFMRdo1AsICnmCK0nMrQXUMgovB08QNIVDAMZGKoA7GpubXfzUVao2juDH
         rsZ2fbi49ZMwq29C2N5+VstRSr6AipkHcyGP0OOhsVygbWRj9RHFc+5XdwR2i8OecIbT
         Tbqd7uco0kb2km4/wg9PxzW8KFD8LVHfiRc1P0lqvVfwwqTGTi9lDk9dZkVeV+xushL/
         Wy1yFVr+VcozpODgx4pcDou2Z4JIxuNHujQ4V/3mNI+8IOAEvYLjJRhrHqiWU9mKuV8U
         oc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409728; x=1727014528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=731RcZeHTEALfaVb7fhfHI1er4oVn7kj9vmasIgzTaE=;
        b=bx9iXOWL1M5/5L0yw9o9+pWT0JDk4U456XZo8TSKUuG4lSbdGL3HLNiiaHu71ylB6v
         mOizw6d8+d/sZ5LsxO52MgVx1mHpN1G0NbbJAjSQG0ByNm6NzNPMqv9P7oglz4sMeMol
         LlqrFbkajyVJyX5uTlCFrZPnrU5EHbySOAFVPhu04wQvomQhzwn9HPdEsp7YUJllnmXn
         Z71Gpngw7WU8WZgc8Lu8PCNzeJsgcIFbOyOA5Mz7VahVUd++f+v1S/3/O1lOBl0dxXNT
         pMTj83+OvA8eUNu6t741YJ1FyhAOM4o9Itgg6DMVVw96lW5jZCwfrV8Hyi4sDQOyKgNA
         oQ8w==
X-Forwarded-Encrypted: i=1; AJvYcCXaKZH1jloLyBrF2tW3q7ASydQvKm5NHavEbJ3P7G3N95uXVI6+YEY2rbE10X0zIYadQi5hYkFH2HvA@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8TJfuopyoxfh6r0BxbLSixDgCcW+3Wh0077+6c4Qy9Te4Ku4j
	sixqcBzD8C1BPBZgjHzkM9tPcXNpL0fJmIGJx8tzFMqIcR0ErI3SUmPVGA==
X-Google-Smtp-Source: AGHT+IE8xo9SxCSyrvC6lXR9rfYJXHpWHXpE3glLFShkHMRHBk3Qp4sURn+0LC/FptvpAai5P72XAA==
X-Received: by 2002:a05:6512:33cf:b0:52e:fd53:a251 with SMTP id 2adb3069b0e04-53678fec73amr7001780e87.59.1726409727438;
        Sun, 15 Sep 2024 07:15:27 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-5-228-117-203.ip.moscow.rt.ru. [5.228.117.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870968d1sm565255e87.175.2024.09.15.07.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 07:15:27 -0700 (PDT)
From: Ilya Orazov <ilordash02@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Vinod Koul <vkoul@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Aswath Govindraju <a-govindraju@ti.com>
Cc: linux-can@vger.kernel.org,
	linux-phy@lists.infradead.org,
	devicetree@vger.kernel.org,
	Ilya Orazov <ilordash02@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
Date: Sun, 15 Sep 2024 17:13:40 +0300
Message-Id: <20240915141340.2802953-2-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915141340.2802953-1-ilordash02@gmail.com>
References: <20240915141340.2802953-1-ilordash02@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Microchip ATA6561 is High-Speed CAN Transceiver with Standby Mode.
It is pin-compatible with TI TCAN1042 and has a compatible programming
model, therefore use ti,tcan1042 as fallback compatible.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Ilya Orazov <ilordash02@gmail.com>
---
 .../devicetree/bindings/phy/ti,tcan104x-can.yaml    | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
index 79dad3e89aa6..4a8c3829d85d 100644
--- a/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
+++ b/Documentation/devicetree/bindings/phy/ti,tcan104x-can.yaml
@@ -14,10 +14,15 @@ properties:
     pattern: "^can-phy"
 
   compatible:
-    enum:
-      - nxp,tjr1443
-      - ti,tcan1042
-      - ti,tcan1043
+    oneOf:
+      - items:
+          - enum:
+              - microchip,ata6561
+          - const: ti,tcan1042
+      - enum:
+          - ti,tcan1042
+          - ti,tcan1043
+          - nxp,tjr1443
 
   '#phy-cells':
     const: 0
-- 
2.34.1


