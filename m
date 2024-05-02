Return-Path: <linux-can+bounces-523-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AA68B95D6
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 09:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D32F41C20A7A
	for <lists+linux-can@lfdr.de>; Thu,  2 May 2024 07:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A209047F7F;
	Thu,  2 May 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b="wo9Tg0nd"
X-Original-To: linux-can@vger.kernel.org
Received: from fritzc.com (mail.fritzc.com [213.160.72.247])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0826A42071;
	Thu,  2 May 2024 07:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.72.247
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714636611; cv=none; b=IqFVmc8Y1dDPHDBdqpYHBBf08oNHTTDEtNNnO1UrVr+dKpuswdtUzKnHYjm2z+hd0bFIQ72ticwfL8PQ53Q3/pdeb14mD0A5FyaMoIIM/CE9+08AZxyfu1k/IYzQpyiqLwG7DE23Oya2RCWBhAwWKTGw1OetwfCzHNMU60HBV0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714636611; c=relaxed/simple;
	bh=AaIXybvh0Qdg2fe21y2T3UM1+G6/Z3jU1KBSAcy/czo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tW2kzkI3x3xiM2XJ0ZE48U8g3yV3WLIUnAXtWCf8QXkWRedDiNy3WNZMw1PEcG9EXaKtgeqXXL5OS3ozS7l2BMLYvKRHWwoaIlwT+W9T7Lr10e7xDGzm76Em7rku8tqZCRTJAh0+nbNPOd1d7UaBPJanr2fb5soVCMCO7sVWHys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de; spf=pass smtp.mailfrom=hexdev.de; dkim=pass (1024-bit key) header.d=fritzc.com header.i=@fritzc.com header.b=wo9Tg0nd; arc=none smtp.client-ip=213.160.72.247
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hexdev.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hexdev.de
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fritzc.com;
	s=dkim; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=M8Jz2oA9KeaIgZDfV7MrQ+GmqetbV9IhG4DXAmmuPXQ=; b=wo9Tg0ndWiLo8PrD6NBggezdTH
	nf+T+iUc5dwDPSJ3XEFeaTeJlhME+mIS4FFopCqPrzR4UTAjwuvMoamVZ1VK7ElhAN+aM3ZMB+BBa
	9vX1nGhrdwLbbpoy3PChsk8FQ62Yzf+YlFtARqk+uBOgTIKGXgPVP72SEIcZC+WpnmE8=;
Received: from 127.0.0.1
	by fritzc.com with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim latest)
	(envelope-from <christoph.fritz@hexdev.de>)
	id 1s2RJ3-001Yg7-1Y;
	Thu, 02 May 2024 09:56:41 +0200
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
Subject: [PATCH v2 08/12] can: lin: Add special frame id for rx offload config
Date: Thu,  2 May 2024 09:55:30 +0200
Message-Id: <20240502075534.882628-9-christoph.fritz@hexdev.de>
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

A LIN bus supports up to 64 identifiers in one byte. This commit adds a
special frame ID, beyond the actual LIN identifiers, for signaling RX
offload configuration requests. This ID will be utilized in future LIN
enhancements to the CAN broadcast manager.

Signed-off-by: Christoph Fritz <christoph.fritz@hexdev.de>
---
 include/net/lin.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/net/lin.h b/include/net/lin.h
index 944e775c40e79..e7c7c820a6e18 100644
--- a/include/net/lin.h
+++ b/include/net/lin.h
@@ -19,6 +19,7 @@
 
 #define LIN_ID_MASK		GENMASK(5, 0)
 /* special ID descriptions for LIN */
+#define LIN_RXOFFLOAD_DATA_FLAG	0x00000200U
 #define LIN_ENHANCED_CKSUM_FLAG	0x00000100U
 
 extern u8 lin_get_id_parity(u8 id);
-- 
2.39.2


