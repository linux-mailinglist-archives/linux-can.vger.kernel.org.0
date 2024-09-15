Return-Path: <linux-can+bounces-1508-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCD6B97970F
	for <lists+linux-can@lfdr.de>; Sun, 15 Sep 2024 16:18:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 501C91F21B0E
	for <lists+linux-can@lfdr.de>; Sun, 15 Sep 2024 14:18:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95D0F1C6F4A;
	Sun, 15 Sep 2024 14:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eEMZ8YD2"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F421C68A2;
	Sun, 15 Sep 2024 14:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726409924; cv=none; b=BTYJdx011rIJxvH+88K45/yjneGrlWcOz0lalv7QFamlZas8QbDmnk0/8rgrk3xeQa980geTT47xvrCLteyrmkqHsV69CGmUAwrb8QjYx4DWO3aqL/rMtyd9IoYN5XLtYrKfKugOa1w6v8ZIrR3ns1IipvmAP8OnTkwz1bclELE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726409924; c=relaxed/simple;
	bh=sPXpD92T+hvJ3Xq4Y2miBjvbDMl5XcT1vqRWKRi48uw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=h5NT9S5QCk7H5w0Td4cHmeirq+L9CNSzr+W8b9pJ2DTMkR9DhOXAXs9463PROv5kSXxoyZ5VG6qC8BPMFOzCGq4VTPndwwq4CXPQPm5CP00qjou1+k3Nl3PpWIPLBcWuDgE0O5bg+5n4Ve6P1Swrz2IzqXIrr5lCuEuAut4OOPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eEMZ8YD2; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-535694d67eeso3562712e87.0;
        Sun, 15 Sep 2024 07:18:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726409921; x=1727014721; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=731RcZeHTEALfaVb7fhfHI1er4oVn7kj9vmasIgzTaE=;
        b=eEMZ8YD24GI+nBw+SAV+wdTWPIOQOk8AQyWh9qxHnWR+BbxM+AZ3uFjD5drMoh/wLB
         SlGxZt+k6khIF3NvLMUXUU1vlFlf0V7zDS8Io54kk++7182tADKtaYeFpOeEn3cqVhNl
         TQ+4ZpBpTLcLLg6Shw13EmLxCXNccJevRqWwDli/7vkAxYXTPjgpkx5/LvgnmRECKPnS
         bPYX6DeRlF48yVpPraBCtuEMWlfbDH6Sb/j2713iS71XkYjkP3moYY9XcEUF6fzxStKb
         1VpJEXKflmh8sifdP3bpfvT2JvxdOXhGkU+43MT1leBM4rs5DBpkp4CcZHgU8gTyuymi
         fYvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726409921; x=1727014721;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=731RcZeHTEALfaVb7fhfHI1er4oVn7kj9vmasIgzTaE=;
        b=jO0pZyQ4CEBuvu36bRykMobe9VOBNX78q/7lQKniR5if/paXN56sFnsmXxKxR+6JHz
         XVvvqkEDwIFzjemMpzFZk0H1P1lGWlWroBWRtUNKaPJjUUuVPrCfiZPIVRCnqvZ+G8H8
         BXkyOjfc9ekEWZ+0BAaZPCW3v/YfwG62RqeZt3EjYgHnMHvPTfXsA43y5oKYgVjvylA5
         5E+dCOCtrjA5n7GtkYI5gcJlLPrBX7dSj+CnkxCWACgcTbat+ybjfXnDLIWC7lqkiqWc
         7B/6rEw/si90u7vu78AWZodiABe6lu/OMeVJ3LvX22qInJeCp1vIrekhEmoapXFNvpqp
         EXCQ==
X-Forwarded-Encrypted: i=1; AJvYcCXHC3QiMY43yRPIaWoWIlTTaqLj23Gyi+ek7hdQOgCT6VSoTyd4bqlsp0BBBn2ed1rtMC98gDrsy4NG@vger.kernel.org
X-Gm-Message-State: AOJu0YzTJ2jmVhIWltSlRD7EU353htHJin32X4Rd6jhcWLKiNus9TN3B
	L4R+BKhl9wedlaPEH7wJZpz+HDMIIchZAvRBeJ2VwbVIEYzRMgBF
X-Google-Smtp-Source: AGHT+IEdGMoIq8Cu8zXTnL+7jCZhukUPP4pANNbdKP+4SVXTL6PZrH6oArytismgN7UkEcJAe5MgPA==
X-Received: by 2002:a05:6512:3095:b0:533:4322:d03e with SMTP id 2adb3069b0e04-5366bb48a87mr6996850e87.25.1726409920722;
        Sun, 15 Sep 2024 07:18:40 -0700 (PDT)
Received: from ilordash-vm.mshome.net (broadband-5-228-117-203.ip.moscow.rt.ru. [5.228.117.203])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-536870968c6sm568967e87.125.2024.09.15.07.18.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Sep 2024 07:18:40 -0700 (PDT)
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
Subject: [RESEND PATCH v4 1/1] dt-bindings: phy: ti,tcan104x-can: Document Microchip ATA6561
Date: Sun, 15 Sep 2024 17:18:31 +0300
Message-Id: <20240915141831.2809208-2-ilordash02@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240915141831.2809208-1-ilordash02@gmail.com>
References: <20240915141831.2809208-1-ilordash02@gmail.com>
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


