Return-Path: <linux-can+bounces-518-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED90C8B95C2
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 09:57:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E4181F2100C
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 07:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C551383A9;
	Thu,  2 May 2024 07:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="AmciRnk5"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF3A724205;
	Thu,  2 May 2024 07:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636609; cv=none; b=AVfW7Hy8cQ36mGMhD0FqVJAe+wUO91P8/EeX/mA0v9m2d598ildeT5CrGsO3B2Q3vH0w/OHNmBtO/c4D2dBNCyKMfZ2BUv57pyYkaEYx4zf3rXCL7Qn4sZjQJn0L4ijy4F6ghWQMo/5Mq2GG1rujmMh8f5Ll5NpjA25SqHr0xd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636609; c=relaxed/simple;
	bh=4mSUg0dh3ONONxNepx7MKYTY8kPRdKDrp/fIyordwS0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pQIB9D94ItRRVhazjKPsNZ4Jd6liuSAjqlEbgUhLmz4xvtMQe+Giv0O7Ee/Jgc8k0gO+g8dEQHT5hzrZ3bnO+0gvy8avzr0zUQqm8oy3lCN5TzoxuzireWMOe6kPn2qG7DGRugCzMjwYQ5onvFuMssut/1ARE0fAPJqufcXoAxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=AmciRnk5; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=npF0MqK5tZrCWaggeYcAXIs08pbdbMEnO4T8qneLQ34=; b=AmciRnk5Zz+I491GdwgS09SOQ3
	CZ+cUE1DeGmPOduchr04QHrRDZjT1SBsinayaXA0+JNDbABdvRPA/DnsqpPCGbvmgj7EH2bRprCHt
	D39ia6BJE24npR52tWHgb/y0vxCll2xb1IMP7tozGRYjuj1j3Vz6aDzDHexoHFO8Qn/8=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2RIz-001Yg7-1D;
	Thu, 02 May 2024 09:56:38 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>
Cc: Andreas Lauser <andreas.lauser@mercedes-benz.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Pavel Pisa <pisa@cmp.felk.cvut.cz>,
	linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-input@vger.kernel.org,
	linux-serial@vger.kernel.org
Subject: [PATCH v2 05/12] dt-bindings: vendor-prefixes: Add hexDEV
Date: Thu,  2 May 2024 09:55:27 +0200
Message-Id: <20240502075534.882628-6-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240502075534.882628-1-christoph.fritz@hexdev.de>
References: <20240502075534.882628-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for hexDEV GmbH. Website: https://hexdev.de

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index 08b241825f8b6..1a8cfc5c7350d 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -601,6 +601,8 @@ patternProperties:
     description: Hardkernel Co., Ltd
   "^hechuang,.*":
     description: Shenzhen Hechuang Intelligent Co.
+  "^hexdev,.*":
+    description: hexDEV GmbH
   "^hideep,.*":
     description: HiDeep Inc.
   "^himax,.*":
-- 
2.39.2


