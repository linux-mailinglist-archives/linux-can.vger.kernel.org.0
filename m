Return-Path: <linux-can+bounces-2119-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C39729D32EF
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 05:40:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764DF1F23294
	for <lists+linux-can@lfdr.de>; Wed, 20 Nov 2024 04:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553B214E2E6;
	Wed, 20 Nov 2024 04:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APsibEN7"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D251876;
	Wed, 20 Nov 2024 04:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732077640; cv=none; b=uyK16oyjeQsJlT2+xAjXpM4JWSS5Zfgo66PvbMHqb4gbQyX5VEb0lFOk/YNQfAjGSdaQTXvF+jRQnw1+Y9691L78Id1LWQCvDOoWtU1vR6sqOXnBNL7SkdQIyRvuXtWyzUZ2N9MHrM/P4DlEYejnG4zyszA7M923eDW47HDWP08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732077640; c=relaxed/simple;
	bh=lC6NOx3vRHlh1EYCGkFbCgWhXHAh3Gawi2cLr5+0xoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=abzuukzzJoUslc6fH9Gr1bvcPm0Xwq47DuAKlTVOcXmkcI1InCOwMiUXNdRsuKJENC+59EA8CKqPcVKX+NOILmEszDYbb26DTCWWkRogA2g0Ju9n6+4LBFidcDQ1wWaMSWg2mdTqdHFBh1wFxW+C6ebdflvsqqhZBm73fN6Ur+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APsibEN7; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-7f12ba78072so1387172a12.2;
        Tue, 19 Nov 2024 20:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732077638; x=1732682438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=+d99EwwK/DrK6S2sI097ir954K4jbTsFfiLQqAJGwak=;
        b=APsibEN7gFBXRQsuA2W4KHKi1YI/HN6Pt668UVepm5W8XMdFx4deJlrHk6pICS6crG
         muZ/m5XSUtvORJECnOTyN+qslzBkaqvxK5S5ODbzFRuWseN1ojTL2arE0lRQAsd6GHPW
         6R5/ou3+xhiRI3M3q5NNDTDKmITorAwkIvMghHYMNWVaPT5jh4k4B50vzu6IOO6Zisdi
         fVnxNhpR5Lm1r49QMxmTOOhQB/zbLuB8E3YFx2vY7hGKbPx42NcADUf8HCfphrxjw+S9
         0W7jYl8FRQz9pqlbeMVKaDc4FBVBEJ/cXgSOuYIPtG8cszkT+FiOYNKwL4umsELWaR0Z
         AEDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732077638; x=1732682438;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+d99EwwK/DrK6S2sI097ir954K4jbTsFfiLQqAJGwak=;
        b=L58Z4j5wq9kINDzuI5NIuaqgFGVkX6cR15s3rkJSDPjeS9nLHnXr6+FjIeyHDsX8Tl
         AOmiNjxH6vxaM9AQWUQ+Fr4NhFt7lTvifv35I3FH2pwIBgpWeFqVoD3taToiLN3XD6jS
         pk01QohU6HSPSylXYKHI56GNBf2TjSd+loFrfAi4fvyymX7QaYdZVoihz9KoE5gk0zLW
         zWIKxpCsvBN/mhwO8K3vPgansvS+ewZeRxye0DBN7Y0k3TJgvlbxbZvi13qi9vteW7VI
         wDVdRGbdN4hbyII5XiNZucnRAqaH9Sn2uRmoMBvYacaKrI8qNMJGtLpWhuq2Uo0DqMSC
         VdvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUAq8OWAuvOhEVhXM6q3CU+a54u9HxE+VFI9ZQ6izEZcsgYpA6VHdM52eX9/q6aV4NQkJvh2V/vizTu@vger.kernel.org, AJvYcCUMAdg4Hf/bQvOcprOxTC57TaFJwYcclZHqdyjlQH5bQLZrcNpegDRk8Y0W4Ws8Z9ssIaoC/YCfX1+3@vger.kernel.org, AJvYcCUdp5pWaCHnlA5g0DKrd/eC00DQ+r3XtckYG/73Cuk0QMz+j4AqKgDiQL4i00OFJUseSNbyGQhg@vger.kernel.org, AJvYcCVyz41GKX/e+ZRzIUXnzYKGx1IkZNfJre8mhvY03ecjoLr3uAVWp8wzut7GuZp7SGSc1Hwyimy/qRHmu7yM@vger.kernel.org
X-Gm-Message-State: AOJu0YxfduRAp7TsTUhiin4APy2LqiPsqBOTn2eD7l0u0+nwph9PkJji
	F6j/o7oWCga2BpQmz4mYuwDei9YVMJEzuO9/MEEgRn4jVQoOo/ZD
X-Google-Smtp-Source: AGHT+IHa2k7rAxOz6K3/LQWKcJZd6Hgf3AcLI9gXM9j4pODdHiRSYb5jshsvom4vFQyGWqtTm0yHGQ==
X-Received: by 2002:a05:6a21:3384:b0:1d9:8275:cd70 with SMTP id adf61e73a8af0-1ddb042e79bmr2047400637.40.1732077637938;
        Tue, 19 Nov 2024 20:40:37 -0800 (PST)
Received: from localhost.localdomain ([175.112.156.113])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724beeb8491sm592024b3a.19.2024.11.19.20.40.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 19 Nov 2024 20:40:37 -0800 (PST)
From: Ruffalo Lavoisier <ruffalolavoisier@gmail.com>
X-Google-Original-From: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Thomas Kopp <thomas.kopp@microchip.com>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Ruffalo Lavoisier <RuffaloLavoisier@gmail.com>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] docs: remove duplicate word
Date: Wed, 20 Nov 2024 13:40:13 +0900
Message-ID: <20241120044014.92375-1-RuffaloLavoisier@gmail.com>
X-Mailer: git-send-email 2.46.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

- Remove duplicate word, 'to'.
---
 .../devicetree/bindings/net/can/microchip,mcp251xfd.yaml        | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
index 2a98b26630cb..c155c9c6db39 100644
--- a/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/microchip,mcp251xfd.yaml
@@ -40,7 +40,7 @@ properties:
 
   microchip,rx-int-gpios:
     description:
-      GPIO phandle of GPIO connected to to INT1 pin of the MCP251XFD, which
+      GPIO phandle of GPIO connected to INT1 pin of the MCP251XFD, which
       signals a pending RX interrupt.
     maxItems: 1
 
-- 
2.46.1


