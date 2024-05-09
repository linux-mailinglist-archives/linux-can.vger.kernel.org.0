Return-Path: <linux-can+bounces-614-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB9C8C13CB
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 19:20:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 317691F22955
	for <lists+linux-can@lfdr.de>; Thu,  9 May 2024 17:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 990C31118C;
	Thu,  9 May 2024 17:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="BD3uaxNR"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22640DDDF;
	Thu,  9 May 2024 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715275177; cv=none; b=q9VdNsMqwEj0gQXYtzBsgSranjz88a2bN+EUmHQc+ZOhRy1ABNLZj0Q5W3jJZL+sqHCJep6CTosmR3J5EqVlf4CPQou1LLW+9m/oN/Cxq5r+OrS5HbV7xIo342ufQwOtfE8Y/SODQ7KZF3rm39pjN9MnWJDmmIJaMgdey30Xopc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715275177; c=relaxed/simple;
	bh=J/YDqG3JJ56JQkE7HnsocBLjK7QbETG+mWtLbGFuH4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kkgkcnGxNzsihOWhzGOYcMaiAjqPpZLcRkcabFcRl8MvyHl9AlrSSYF99ueWK9SnEtKap5CaYqrecFIBHEZlMr7QN2dK/3U14eHHai+ZKwYmyHVb2OHIqnQLnSja1wCExFsi/2/57uJOjaPR6q0ewp7vNUVHgE0OlHisDP9Le1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=BD3uaxNR; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=EtoFUQGhrpk3k42+fGI1DKljyQYHapjFTzBrNVtgqXo=; b=BD3uaxNRmoGVfC3xRcKJsUEWg7
	w/ZxKKb9mWpBBNBFjtvnd2vG+eMTydVNG0a4+U1rXDYsKfow9yVdtgFY+A7a+GA4Rl5EDekvE4hqw
	UQZHewuN1E70fGWfdGDUV7IsgX6CEVBmkPuLytkzxi7fmQzU0iIMSM6WVM/RswgDt+Dk=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s57QC-001jf8-2i;
	Thu, 09 May 2024 19:19:17 +0200
From: Christoph Fritz <christoph.fritz@hexdev.de>
To: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Jiri Slaby <jirislaby@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
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
Subject: [PATCH v4 05/11] dt-bindings: vendor-prefixes: Add hexDEV
Date: Thu,  9 May 2024 19:17:30 +0200
Message-Id: <20240509171736.2048414-6-christoph.fritz@hexdev.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
References: <20240509171736.2048414-1-christoph.fritz@hexdev.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add vendor prefix for hexDEV GmbH. Website: https://hexdev.de

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index fbf47f0bacf1a..e59250e98ec8c 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -603,6 +603,8 @@ patternProperties:
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


