Return-Path: <linux-can+bounces-5966-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 284EFCE99A0
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 12:59:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B25A430378AE
	for <lists+linux-can@lfdr.de>; Tue, 30 Dec 2025 11:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6CF32EA47C;
	Tue, 30 Dec 2025 11:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U4VZTX3Y"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8652EAB8E
	for <linux-can@vger.kernel.org>; Tue, 30 Dec 2025 11:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767095902; cv=none; b=W6r94zYUbUnZPLHfPmT6NC1QYeiH2a+IikxcHYq/l/PVmwbwfKi4cX0KMWcG/nZQOT0FqISwbkOQiHd2HpCjUhfTm/ii/BKE3Uye6fZ3n0GqT8R2F2tKDeF5IrJevS+29e3MHAXkuI3OqJL0sfWui/2LnJAfLWUyELiHSpFMMiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767095902; c=relaxed/simple;
	bh=KjYWDyWnoHoWoOkGnse/jvkaJ5XxxESdlC+QGJlKdBk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=muXMzwlUoh1rEXLPga543L7UTzGVEIDsHAFSfqjDEMS/uBztDQk0cKJ1gBM633nrNmvR+cEZ0hB+doLmEVgvVyn+NcZmjzEPEb0Hu0zulUserQFeJLSqY+C9f8DT8U7kkNoppvKU/A5x/906PJh0Px4FwaqzOgOC16w/f04vyeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U4VZTX3Y; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fb03c3cf2so5017446f8f.1
        for <linux-can@vger.kernel.org>; Tue, 30 Dec 2025 03:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767095898; x=1767700698; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TH2FRCJfbh+ausD8rThQOzC7X3+nqUlsi8sfpxkEbNI=;
        b=U4VZTX3Y6HR8jERFeL8mj4yDUtKhZ005wyfej12wnpG+3w0ZtFYw0Aze5325naRyyL
         wMdyO8OdmbUZJav0ohisIOo6tDjvqsE3fENobyG2JjbkyrVHivIgrtxp5R1wNbGnVbZa
         He5YBsFukxKNvJ51Gc82XRRdhthIwjIeSH32QLm5dOFRShvNU5QQZxfd+2UDYq6woj34
         ioEAgKeg9eUThF+GcUiAuFGfK87TJrt0jQcVgU6hWn/KH9BaR+oU5C6LCOofvJofS9bu
         KzGrjddJlwkYGXBBaj/oTg8k2InrZl/Xnsds+i7uAjPA2IFVAa2HcoFV5XahrqLJkPRd
         I3XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767095898; x=1767700698;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TH2FRCJfbh+ausD8rThQOzC7X3+nqUlsi8sfpxkEbNI=;
        b=bJKkdj/upOYdZf1egPmSpn+31f/JNxzmW6IpnwXMYxKzTdkvW1gy0BJwI7mpXDFr7A
         zy92g7Z7bMLSHB4JG72es4aBDoy7ePFOJxEADHljAUxed8Vqjdx2KkdXXD+IObqm0cgB
         lHyIEHpIeAuQvOBJyRXgN/HZ+a9ciVXGp/fZvQQn7mauB/AQRyZXswQEqOFoht8fdYAt
         WZDSJA6b5U+34WMZ5KoJ+zAnmYgvL8FJLoCIwIHrrBUULnG5Vo1iV3QwDPMy/Qj0J85Q
         aIPBslkGxvq1MGlnxHeTXF6m0wKiJB0HT262G1xAzmPCgvfvm9femLBH+ykgGyGr14QV
         s60A==
X-Gm-Message-State: AOJu0YxeAvQdF72fTmv5Mzfu919TXQj75SRLqmPraiV1QFvnsinipqmj
	nqorb8IJuus64KuINDi9j7F9f1mOQ6sbEyiPsEHvOR7pVN09DnvagBhP
X-Gm-Gg: AY/fxX56Hvu7iPdtDQW7/FI5HBAh/azuKB1wwGMhYHiddIFgCSMZQeRimY+7cB673OQ
	osFkku3sdtYbVuSbi2ZQMZgv3budGfkwFTuYop3gN+dbNWkAgqkMK+97RilwgYGoZFhU0RgLqbQ
	ouWx3x70E4kzFyRMXqVZ/u2uzgLIQGP53meoWlFuKD7aSibwnbSs0yrCYc6PE/VXQZ3X4eVdgiB
	McVqHPTbnJYJzipTu5kZ6gVir7Cpid6JY0gYKwxZZq6GlQtALXA8kENFQkefcVbppena7wwGp88
	3YoXCJDmEiwyfAFL1qYieO/vj6GOhBro7kRzoQZ9chAMgkctqtN0VIqoVLDyXapefFEEez55/Co
	9UVP4ULl5vAFdLeMF3pa/izUTet5gAaY3Chi5e0mBW0KO701Z8Uu55g3DGy3rofPU3yNQiD/p8m
	xHgaAReApKSrz3yJsPxglYTNLaAX127UApbwcE/LXYmOhCwqDVV8jcRFEfcv9fPqo7H5MWeTIh/
	sXsp5PhgDFNUjMMFUROrXZ3
X-Google-Smtp-Source: AGHT+IG8pw2WnLdLL2INIYYvES1i8SAlbuVSbxsplffVaBslb23j4XCBcHXODUtcw/FBn+d92ElZ7w==
X-Received: by 2002:a5d:52ce:0:b0:432:5c43:5f with SMTP id ffacd0b85a97d-4325c43025bmr23773087f8f.40.1767095898338;
        Tue, 30 Dec 2025 03:58:18 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:efaa:981e:926e:8957])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324eaa64cesm68337227f8f.35.2025.12.30.03.58.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 03:58:17 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>
Cc: linux-can@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 2/4] dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N SoCs
Date: Tue, 30 Dec 2025 11:58:12 +0000
Message-ID: <20251230115814.53536-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20251230115814.53536-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Document CANFD IP found on the Renesas RZ/V2H(P) (R9A09G057) and RZ/V2N
(R9A09G056) SoCs. The CANFD IP on these SoCs are identical to that found
on the RZ/G3E (R9A09G047) SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No changes made.
---
 .../devicetree/bindings/net/can/renesas,rcar-canfd.yaml     | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
index 9bfd4f44e4d4..fb709cfd26d7 100644
--- a/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
+++ b/Documentation/devicetree/bindings/net/can/renesas,rcar-canfd.yaml
@@ -44,6 +44,12 @@ properties:
 
       - const: renesas,r9a09g047-canfd     # RZ/G3E
 
+      - items:
+          - enum:
+              - renesas,r9a09g056-canfd     # RZ/V2N
+              - renesas,r9a09g057-canfd     # RZ/V2H(P)
+          - const: renesas,r9a09g047-canfd
+
   reg:
     maxItems: 1
 
-- 
2.52.0


