Return-Path: <linux-can+bounces-5743-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CA18C8ACA8
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 17:00:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 161213B7189
	for <lists+linux-can@lfdr.de>; Wed, 26 Nov 2025 15:59:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D4B333C1BA;
	Wed, 26 Nov 2025 15:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="faU8sh3L"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 372E23043C6
	for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 15:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172758; cv=none; b=KyJE2pfrqlPImI2NY1LbZ7BNgRIKBO3dqCJxZlwFRcFTPwg+ZrDhINqgArcnqIvUjrPBWj6plLZvrytXfmd8VR205AcXoEQPgntki1Qvvzhy6im5lnKqn/V1B3Krd3ZllQZ6h0WARCfIvef00aqmO8ulOOzKc5DpWwW11r+y2hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172758; c=relaxed/simple;
	bh=sBUk2K+LyWxsZ50kZXqzevdzeTfhAWsRwpcwQmtD5xA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L9PxQcKj5RiXGCaEIVpBBZreaioFrsj/tx+VXOQx+lIWQI85GRkEjHVEDeknM7jd0b+VMGtX48fNhK8pKre1qBCEEb6qbe62I1x71AkGcTJDLwhxAkL8dfhFgNMR3vIo585kB+bDaLokxh6RV5umg2IuNj3b4EBv9OQdE29bxoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=faU8sh3L; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-42bb288c219so5848956f8f.1
        for <linux-can@vger.kernel.org>; Wed, 26 Nov 2025 07:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764172754; x=1764777554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fxqp4M5X4tgd8J3YZl7+OJdfIMx5GV6b0qSx7EidnZM=;
        b=faU8sh3LrH0MVhS5dDYQWjGIDqG4B7cZa3R/tAywZnuMbLIJc57FELzUgJNaEQv75o
         sz9tTghyeAtDy4qxjOjCq0uFIBdfg5A9k5skQCtz3pUt8NKzxZY7xFbO+iyv8AdryvXS
         gwC1WIr9h56rXzjq45oPZ+4+3QgFIBON24IbSs9yxMpqtbHH5YkHYhbtql1YxkBDZwIy
         4Bn51naBafwtY/FO2+ROHgCkrOqb+2VeEplV8rIG3UUIIQ43QcCDnflde+v86eqYV5Wj
         F2TfYSZ4cGL2s4trZKBDxz4flqq4mB/V3Cu88i/JhRPftIuOfYM/3gk8cZ7bL3L5yEVU
         UuRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764172754; x=1764777554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fxqp4M5X4tgd8J3YZl7+OJdfIMx5GV6b0qSx7EidnZM=;
        b=tDGFu01TH7WHgQrxBIVh5N5YFh56rwoiCpxdjluz7MyBA9bIqMsgfjBK8qSqDJifVy
         5IE/UgwmT6HMVfJYRi8Mb/qhgH8r8MEO3e8RSLWbCPu+8CgS7TAjBlucAZuUNK/JAquo
         YWwMmj9VWifCAp3GZu4Eu1Ip0NUQmxf0p2E0zyNxdwENtvB8IKBNUEpQF1Bs3m8eO5Ih
         3LILMECNdGTnHzgRQw8KwIRvzLIrUMcGGeWEkiZlUjiSAfjgaPqUquHrT6YwmZawTpzT
         j5Mh5sI4LaOBm0QVT43XCSa41Ae/gDRuYndzwwlyPzbIyoD+ZA7AfVy9j8zO+ifgewAq
         GYEg==
X-Forwarded-Encrypted: i=1; AJvYcCWK2GPp7cPrXGty2NuscP4Vxqt04Jw2Pm2NpLpava55+kO212bTC2VGLoVPA0KWw7W5rOvEI9KeBYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyVIHY1C5XHu11GbuaABRfMf3jXmUlVC5hFklpmwQNQwN2DVTd1
	zZC6GLhQwRxj8HYeuNCsLHeEkaAKtFdmY8na3+hqlyuMhVQ41rnkujY9
X-Gm-Gg: ASbGncudCmjVawjjF9hcBCkjXsS+8Ju0GYQd9oqLdv0e3DfUSTsnHf/Nsj11xZTaljL
	VIeUKfPJJ1/nQuW5eMWxO7zxJ3LXj3wAaMjf2l0NAzq5k9xb8Tc4M3L100osHIboX42dP4E8idz
	BvTOjcFacJUJKYN6R1S84ht+MtjbdB0CkMQWcaG0S+en3o2XszymCNPtnz9omV6jsd7wIbRNXVM
	WvukShinoIT0hJHpokN1y6Pp54C4odwXjrd7bl3kXRweDX6pafEP91Ik7tgPn00+zdSxjyy3+4N
	BaelHna7u0hCfqCRxWch3F2k7Cq4W/SiY+/IwJ63yCPx5JwyGLs8aMFUaqjAweql0m7g0SoEEum
	EtSbQCagT96iRwQyd3vM3FYlT6lY9W878IOs6IDpUY70WNbybaAxe+gOiRISkmpepkGeobBxGMv
	TSvmB7JKrRjJwnZbr9YqL1PtVtQyrTS0fpkBCBFnHHdShCV0u1kwbaRNS2JGpimylZtaW5Srw=
X-Google-Smtp-Source: AGHT+IGsHAyvJKxk7IgZs6cADiBilbwV9eEwOI5jq20QUYAnEsvLcBpBixq8p6RYLJIqdLmoTspabg==
X-Received: by 2002:a05:6000:2410:b0:42b:396e:2817 with SMTP id ffacd0b85a97d-42cc1d199cdmr20649023f8f.40.1764172754101;
        Wed, 26 Nov 2025 07:59:14 -0800 (PST)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cbd764dbesm38197188f8f.27.2025.11.26.07.59.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 07:59:13 -0800 (PST)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v4 1/2] dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
Date: Wed, 26 Nov 2025 15:59:06 +0000
Message-ID: <20251126155911.320563-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251126155911.320563-1-biju.das.jz@bp.renesas.com>
References: <20251126155911.320563-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The CANFD on RZ/{G2L,G3E} and R-Car Gen4 support 3 modes FD-Only mode,
Classical CAN mode and CAN-FD mode. In FD-Only mode, communication in
Classical CAN frame format is disabled. Document renesas,fd-only to handle
this mode. As these SoCs support 3 modes, update the description of
renesas,no-can-fd property and disallow it for R-Car Gen3.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
v3->v4:
 * Dropped the node added in example for just testing.
v2->v3:
 * Added check to disallow the usage of both fd-only and no-can-fd.
v1->v2:
 * Added conditional check to disallow fd-only mode for R-Car Gen3.
---
 .../bindings/net/can/renesas,rcar-canfd.yaml  | 38 +++++++++++++++++--
 1 file changed, 35 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f4ac21c68427..e129bdceef84 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -125,9 +125,17 @@ properties:
   renesas,no-can-fd:
     $ref: /schemas/types.yaml#/definitions/flag
     description:
-      The controller can operate in either CAN FD only mode (default) or
-      Classical CAN only mode.  The mode is global to all channels.
-      Specify this property to put the controller in Classical CAN only mode.
+      The controller can operate in either CAN-FD mode (default) or FD-Only
+      mode (RZ/{G2L,G3E} and R-Car Gen4) or Classical CAN mode. Specify this
+      property to put the controller in Classical CAN mode.
+
+  renesas,fd-only:
+    $ref: /schemas/types.yaml#/definitions/flag
+    description:
+      The CANFD on RZ/{G2L,G3E} and R-Car Gen4 SoCs support 3 modes FD-Only
+      mode, Classical CAN mode and CAN-FD mode (default). In FD-Only mode,
+      communication in Classical CAN frame format is disabled. Specify this
+      property to put the controller in FD-Only mode.
 
   assigned-clocks:
     description:
@@ -267,6 +275,30 @@ allOf:
       patternProperties:
         "^channel[6-7]$": false
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,rcar-gen3-canfd
+    then:
+      properties:
+        renesas,fd-only: false
+
+  - if:
+      required:
+        - renesas,no-can-fd
+    then:
+      properties:
+        renesas,fd-only: false
+
+  - if:
+      required:
+        - renesas,fd-only
+    then:
+      properties:
+        renesas,no-can-fd: false
+
 unevaluatedProperties: false
 
 examples:
-- 
2.43.0


