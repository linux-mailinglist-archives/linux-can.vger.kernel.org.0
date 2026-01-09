Return-Path: <linux-can+bounces-6072-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 76C7CD0A1AA
	for <lists+linux-can@lfdr.de>; Fri, 09 Jan 2026 13:59:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0E99430AA2D0
	for <lists+linux-can@lfdr.de>; Fri,  9 Jan 2026 12:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3C3635C19D;
	Fri,  9 Jan 2026 12:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sp0NA1+p"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com [209.85.221.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFA835B12B
	for <linux-can@vger.kernel.org>; Fri,  9 Jan 2026 12:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767963099; cv=none; b=eXtNA+P9fCtuNJ/1D3oOaDngIrG55iVjTYrGK7cZu2LnZjEoSr14bqS1NU0JywD5urz8fbbn1BhR0r8vWt6WIJRCdkP2Q8f0Se4ryYLjaKThuIzNyPgTLjOFIp41/CKlLvI8TyHZL3NVfptOg+hpEfHzQMxHl9uEL4qj2FM+Ctg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767963099; c=relaxed/simple;
	bh=JlkmrZA0IBEd5wIs54vPzpi+gQaKEecCIn8VD3Wq5v0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VI7riu12oQa0eiuVzCB4lcFshKUoNR/67OcOH2zWfsLuXGWfczdbkZq5IYf89nFhQsa6qJseVwtBNwz2NheQVvKYnnVmDvEOqvfwreGdsQxxaGvPCOF5PSNQiFVuIfA0wkSCUOqPN6+Bogh0GBy7jJLLiyecr6A5YAmxspsT7sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Sp0NA1+p; arc=none smtp.client-ip=209.85.221.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f68.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa9so1937384f8f.1
        for <linux-can@vger.kernel.org>; Fri, 09 Jan 2026 04:51:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767963094; x=1768567894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bbSAcKWTXGbb/5YHLZnLWC3PXJ+VGcy/cSnyBBzvWn0=;
        b=Sp0NA1+pVRIE6J/jorHpbs1/QUN3HFpTovRGFdHPQjzufCVqPZi1sly1X8WKrLLXfk
         mLCbsSp5V+kygezUi0qySZrSNRWe8h/WXoZTrE1LABsASeHS9Q4B/1h7eaIk1FPculvI
         QyGILEJWhZGyxz+V+tg/SUcIEkIju98VNGHdTHRlTPz6NSTan/yHQWNpcTsAAOqP59df
         KLnRvvwPK7dcTT5l39HIdbbdmCSpOfflTzzkkpRIGlLh48vIFPhofD8ASN7ld67DMm86
         LbgZQ6enhcDPPI+1MqNduj8Xs7ZqzdkE0mpbSVehyd5cHK0PAtc9fyPkPFpOTH8l7TaI
         FeZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767963094; x=1768567894;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bbSAcKWTXGbb/5YHLZnLWC3PXJ+VGcy/cSnyBBzvWn0=;
        b=wCRuk499Yi/HpGPJd+HLFQkZS8MtVIfhfD4+Q6vmPfAukl3YJZhgiObTWxV5SmbW8/
         qFtxnbFN4i4LstSoSacuVxXsP9mJXH1VH+vsQ39HuHCU+RUtsIVA53BHXak81UXostwi
         j5kYhRWc0oXhssV0LFIczD88Lif7ozq+NlsfOJuXfjqkGNzk4U3q9Fu5YwIIunO+SBaz
         QkIwL5MBe7c9opP85IEanQkYfWixRxhdKx3ImayRrymF8ieHNOoMEn/sGSfi3rx5zv3j
         V/5feQ2/sG0TYfrZvFgJnjdTvPpMJkRE9tCrCfxIfAEtoAsrGDcbtvwh7JjHNeWPfp4A
         N7PA==
X-Forwarded-Encrypted: i=1; AJvYcCUh/OuYaC8ge2lsmkx/HWXk9W/bWdw9fz4KAbSQ1o4QlgfK885Aey0iWON9OIpMFTJFCh4dPBMtyOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YznhNHy8amwl2c4HIuqPI7mKUgigXI2DmPmAH3nsi6gGolHgigW
	ktHgbg7S6x8Upt4pGAlX6yzySqobGZyjO3iZhLn12krrUo2chknOZCqOeKEFpCqK42yn9A==
X-Gm-Gg: AY/fxX5063sqAtfSI2jzCxZwbeMM2tddauTFynpzXhwMWqq935jbwzt3sWZHpadzJgb
	yXdjbZ3FdKXd4xCKdPD9z5eccfcUDredrc++LWlCcLVxxbDqZG9Ga4vaXugjdqzw6H9tIjFKdvu
	IvoJo0PfChxBzbzYlGW/C7lTGUigQ28xnQ1LXMc3/fdUGoWYyrXYuBjY+H2WbpFvoNEc6BVOfDY
	BDcuMchtmzI+yEwe/UwJLeD6XOo47Zph/7N5+jP+pHzvmXd+A/oTl87pvUGBiNM9i2Xh/H/x+H9
	VIbZQ3HOzgtmlOhgQVrgZEkbXWk3Hx+cFzHS16h4neJ+sO9ztKj9vXycY//NyrmXymkPkxWQr1e
	PwcPzjboMI/eogZrm1GsO6PMMVXb29O/qbuciFd4swu1ClrYE3XK/IjT7Rq4jYEFYu8A9xaxVR/
	XNH8bPQxVPvXmJjRomWmAistVPu/WmoCHk2iPW/Fk9EZxLRJCupPixAhdkpWDuREXKMuHrTcJlX
	uCtXTByxmUe9SgENfAcRUg=
X-Google-Smtp-Source: AGHT+IEmHgu1PwKX696JNHHMjQ+q4xOEiEji9gvLWaP1XYJ/xrxwuRwsGaEZvM6oRA5WdBX0mGm1NA==
X-Received: by 2002:a05:6000:1842:b0:42f:f627:3aa7 with SMTP id ffacd0b85a97d-432c3632b03mr10686383f8f.16.1767963093554;
        Fri, 09 Jan 2026 04:51:33 -0800 (PST)
Received: from iku.Home ([2a06:5906:61b:2d00:3d06:ce2:401e:8cb8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-432bd0dad8bsm22837291f8f.8.2026.01.09.04.51.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Jan 2026 04:51:32 -0800 (PST)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	linux-can@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar <prabhakar.csengg@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 2/4] dt-bindings: can: renesas,rcar-canfd: Document RZ/V2H(P) and RZ/V2N SoCs
Date: Fri,  9 Jan 2026 12:51:26 +0000
Message-ID: <20260109125128.2474156-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260109125128.2474156-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
v2->v3:
- Added Acked-by and Reviewed-by tags.

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


