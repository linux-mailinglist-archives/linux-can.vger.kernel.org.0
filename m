Return-Path: <linux-can+bounces-5496-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B343C69F03
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 15:26:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 361F2348AA9
	for <lists+linux-can@lfdr.de>; Tue, 18 Nov 2025 14:19:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4089F35C1BA;
	Tue, 18 Nov 2025 14:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TUPcV/+D"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CBA359F99
	for <linux-can@vger.kernel.org>; Tue, 18 Nov 2025 14:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763475527; cv=none; b=L4crOnDI+MyMhMangYeFaOlFQr+XW5GF17R4z6AzDyJeX/kuxMslWcuklMA0+X5/F+Lu2Sqsyrf6VRRGMdLdoETSmxwaXYh3Jg3boofvCiS7lufYMY3u/n4+dHKjaj3vyvrVWbFShPIdy6b2ouItTfjuQxn2Ie9UY2cONoodEU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763475527; c=relaxed/simple;
	bh=haSsgGLj2LFR4rRVPSrOVj0UFTthpfQ8j7ArNRNCmRc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PUGIeXxL22ObuuMV57Qaakk/H4NKR4zbSIsW01CUN0W0uD9SnKOcSTuzaXKclLIV93mCECftfYxKmht3cp7DL8DzYLcw/cIc+zxfqroJxQ/tecLBiGzsBIudMXiuGCEIdVjyTRat0/EiJJkwaDt025r/PgwCgHAk8xFNcvhQARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TUPcV/+D; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-42b32ff5d10so3897958f8f.1
        for <linux-can@vger.kernel.org>; Tue, 18 Nov 2025 06:18:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763475523; x=1764080323; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJmzG04+rJ9YMJz0FDJL+2PqD89ccz+qPnT5FslFWMY=;
        b=TUPcV/+DBsqRpDm0weqV/UA+OdNJQI/WjH/1YIb7qZBqStvbtcKffvs6smZOjDOhuD
         6yTDGoYJRkE6Hu8qfDPFqrlecYuoF1ShKmvpPwsq56izBfwBm918AC0PbOmOydnEaRJV
         ts7+2UoTJj/ySwgtpkTCZq5UpcBhmGakerFEROl8FLII+TD8x8K/vlnq4DS7xNmbxtTD
         cCqZvaiS/X/OnVOJPKbrmoDg3R7N+RjwwRZmvrOtP1FcLMjNvYPmrOG+IFxu0dvwKuta
         LV/Q721Gq0gZoRQ4G+cT3BfHU9dxvmWSg1JXiNG9hRvnIn007+ocHH4GPpzd93bYdvW8
         kTpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763475523; x=1764080323;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BJmzG04+rJ9YMJz0FDJL+2PqD89ccz+qPnT5FslFWMY=;
        b=RjbobZyzD74fKkO5JQbUvEiDcMM85hmmNu2rvLwhTfiLgxIVPu2zAOTaPme3IbgYLp
         tc2G9t0vGT+q8pPZeMvnKvbLZqIiSlS/9QHh99oQVrzdVmfUSAJXel92loK+B4TIJAos
         lK1lExKsddJESvm4Tpit1MTY+yWXoZzZrHJl555mGVFq9VssoCNOl9ye6pPlUzrIymEl
         20kCwj9U+v5t4Sqi2dPSFZxj649fBH3ZuHVisLby9gn+OI01phMUvrA5VVljGyF7Odij
         WU7uw/5qfERRPhwmM9nsBzXIlcD8ufcBKtW4K2dCOyIj9ae2s1bPW+vOKm08zC9BO/QS
         K3EQ==
X-Forwarded-Encrypted: i=1; AJvYcCUZEmKuw2e3NlkzOzxQXl1z4ORtxgEFu1/OC/B4QC68U6Ahvn308limMIP7dAXEG836oSwpprWmFMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YweiUxnEyJQk5jaZWRbKXwbiVpJzp9Vlp/fGBhZ1h/PMZg2U59W
	VZz+bosjT75g+QTooxJrRaDe2XSr1aQK6ZSIhRYT32tj4Wn9e5JRImVS
X-Gm-Gg: ASbGncsS0NESsIA6gz1whzlgc//HucKNKU2BkQKn6nJgzEoaf1S2u1VOwRTvdcjSCXS
	M4gB2Q/lSJzWGkqZW40GMukdkr1Y2F2vxJLIKQZ5flDw8GC3L8XtWtWXKGVFScDiMYnxXMx0Anf
	52Bh0m/LSc3JG5Wek7mJ7aF0cpZ0VIUw0mYpoKBHZG4KGM+4Uk/YXEpYuHERj76rVnc/vxdm3De
	Jp+4/wXPRrkzN0AV9mLZ6kolDXVXTt05z/iqTJeLmWvHjF5+4nd7XmpqyzGYXHFI2oZUydww/Gv
	wlNJueZ2zg9TEXcG5w6uOCm7Kw+x/FekVu4YAIiY5uMVB2L0BqE+zg1wfOdUTAGfHapKmRUkLzk
	yp2fkUGbynijU7cEQbKU/GGNj45M6jMPjx5BUexkofuLv2ko8V4UFHtgpJT+oSKAn/ForgnkY8b
	xLxtFv1hvVxlSg4Lej8nZ7mq0QBmKzDZI29hi2/5mKv2oGa2dS9H9jemM2wseOQSuOTY7rWi534
	5A9HaMurzIqAKsv
X-Google-Smtp-Source: AGHT+IGr0W3BKAE2tNSYntGdfGD0jqo7iYO08Mgwtq3xJYbhwCRI1m3FKOoJ2p5oqbRAo7p+OICvDg==
X-Received: by 2002:a05:6000:290a:b0:42b:3108:5671 with SMTP id ffacd0b85a97d-42ca8cd2c00mr3388172f8f.29.1763475523364;
        Tue, 18 Nov 2025 06:18:43 -0800 (PST)
Received: from localhost.localdomain (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53e85e6fsm32487590f8f.18.2025.11.18.06.18.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Nov 2025 06:18:43 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: can: renesas,rcar-canfd: Document renesas,fd-only property
Date: Tue, 18 Nov 2025 14:18:34 +0000
Message-ID: <20251118141840.267652-2-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251118141840.267652-1-biju.das.jz@bp.renesas.com>
References: <20251118141840.267652-1-biju.das.jz@bp.renesas.com>
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
renesas,no-can-fd property.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 .../bindings/net/can/renesas,rcar-canfd.yaml       | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index f4ac21c68427..bf9a7d5288d3 100644
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
-- 
2.43.0


