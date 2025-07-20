Return-Path: <linux-can+bounces-4007-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E3B1B0B2E1
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 02:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF3051AA0442
	for <lists+linux-can@lfdr.de>; Sun, 20 Jul 2025 00:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39DFF1487C3;
	Sun, 20 Jul 2025 00:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="kbslBJWI"
X-Original-To: linux-can@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6839D7E110;
	Sun, 20 Jul 2025 00:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752969738; cv=none; b=a3azm0KXVn5pH/Fovgrn+YbelQIBuk9C7pQzobKhFaqr/BoHeitfi4ovMJGpJKuQvRNh9VOpg2UEkH0CNn4Ao3b4zhml1yzGe23X77+GHCt9NDa3ReFC5Wfp0r/AbvdUirGyHFG7vzFW/9YI8HJ9x3Eno9WghdLWwomnZ3ZH9uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752969738; c=relaxed/simple;
	bh=zlyJkcyPx+QqnGxt75+emm+zjMLSFKeChOckA3Xba54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QobN6K+Gthb0XlzVuS+xD/0jv/dNVOg3UfqUZjHsV/+Cvh3xcliepVRwgFgPsBVhYObgF2E45jes2CQLpyVMKfiSSO66PHe9XjWNj6C7DeTWUR5fHBtHj0VptR8PKKnPlvul+nkfpZyksE1P7pLE8JzlS/rJu1lBNzZPHHDC1qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=kbslBJWI; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=+gndcKUK+fXS/lReEEHvsa3zmUksOF29DdwtGn9N5gk=; b=kbslBJWIZbyIplwhgMiqFlAKxh
	+V0B5PqSBAkiO726nWk5x4Rxkl2oUWt7YLMyTGqCE12Qxs7dAyy74KW4uYM/jNPjwQtivm/h5FTLt
	Z02w6AP6FeBIBmCij7a6BM8gcXDa3lDX4uMkQphG48/YyZqH72pAU1OyD63aa7oui3vglxeOZ20jt
	bHGQx7Mq/+NG/9p9+jhfndUFh4NSjQ2TB2xi+2NXVcPX+3AGQSKZIYTKL5lbfhRv2ni5oHZ+wkfep
	LM+YoPftfZofx1p/VsVU1pdz6vjoFZ76uN8zpfPi333qD/l30Zrl8amxSOZ4RE1tSDJB0NaW8uOoI
	0FxdUSyA==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udHVN-0000000EkPP-3snN;
	Sun, 20 Jul 2025 00:02:13 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: netdev@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	"Andre B. Oliveira" <anbadeol@gmail.com>,
	linux-can@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH] can: tscan1: CAN_TSCAN1 can depend on PC104
Date: Sat, 19 Jul 2025 17:02:13 -0700
Message-ID: <20250720000213.2934416-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a dependency on PC104 to limit (restrict) this driver kconfig
prompt to kernel configs that have PC104 set.

Fixes: 2d3359f8b9e6 ("can: tscan1: add driver for TS-CAN1 boards")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Andre B. Oliveira <anbadeol@gmail.com>
Cc: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
---
 drivers/net/can/sja1000/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20250718.orig/drivers/net/can/sja1000/Kconfig
+++ linux-next-20250718/drivers/net/can/sja1000/Kconfig
@@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
-	depends on ISA
+	depends on ISA && PC104
 	help
 	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
 	  https://www.embeddedts.com/products/TS-CAN1

