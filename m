Return-Path: <linux-can+bounces-4013-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 968C8B0B990
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 02:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8C8E7A69DD
	for <lists+linux-can@lfdr.de>; Mon, 21 Jul 2025 00:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDEDA6DCE1;
	Mon, 21 Jul 2025 00:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="0jMgH5A4"
X-Original-To: linux-can@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B33439ACC;
	Mon, 21 Jul 2025 00:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753057710; cv=none; b=Ky9Ln96OonWITo+V03kR/Jb9lJP5p6HkNfXw9zh+xE2fx6skKgx0+56W4l9sXVJaKObPa64qZiV3ULMzbBkt3rIgsUiOx3TRcSQHFwjFF5xvU/EeH7UB3afJvsDFw348LUbtZZ+D+JCCkhiFkR3RVPn+S/1MhHFK1Pbxkb58LNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753057710; c=relaxed/simple;
	bh=7Kd51o6k1umbr4n0ph28myP06Rt8DtYIA2utamP1OEk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OezVy6VM4g62s4K1DOWsQ9CbFsIdgT1d4diY1pun0GdqOmRNKjVB6uj5umNIT0Kljl2q9B/ogM0fQ5Ua1Mj9kT4zdoQwa7Y1u+2auGdWIT7s6DqV1RKPa1EUL4jgl9YnM6sxBp1dQ2+lUzMEyS8onPzIDFYBqEjaE4MmeCF6UFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=0jMgH5A4; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
	Content-ID:Content-Description:In-Reply-To:References;
	bh=v0zTumylF7NIXq2YP49hGb5aJyiZ1Yk/J9XUzX2Z1tQ=; b=0jMgH5A4jPtcD2vuEhjKCzYmC1
	KwHNdV4yKPMyd3eHDjJy9tcDsWPkT4yRtRywXkuWgBc/0v9OruiCdY6+Fh9B385AjVSzFFHFQr4VF
	qK2W4pmLSSCaogYLrHYcXnmu3EwOH0cAhxKUmcXwFfVgaf1F8H0GuLUjP1y6nkurrLX+yWQTfoNql
	sBrNgg2KnsfZKNl/ijwlOIDwSFxj5QiBUqo9B4pBiu4ffOkREeP6iLyd0WuweKTNzFThiPpWx6C1I
	vc3sHB+T8kOl5xv2NxPXjKaE3iDKjTGt9i3B6uvchFC7ydAGcRS4F0L8xn5g24jMNevaD2MD1hu5H
	aN+0m0cA==;
Received: from [50.53.25.54] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udeOF-0000000FsLp-46YY;
	Mon, 21 Jul 2025 00:28:24 +0000
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
Subject: [PATCH v2] can: tscan1: CAN_TSCAN1 can depend on PC104
Date: Sun, 20 Jul 2025 17:28:23 -0700
Message-ID: <20250721002823.3548945-1-rdunlap@infradead.org>
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

Add COMPILE_TEST as a possibility for more complete build coverage.
I tested this build config on x86_64 5 times without problems.

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
v2: add "|| COMPILE_TEST" for build coverage (Vincent)

 drivers/net/can/sja1000/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20250718.orig/drivers/net/can/sja1000/Kconfig
+++ linux-next-20250718/drivers/net/can/sja1000/Kconfig
@@ -105,7 +105,7 @@ config CAN_SJA1000_PLATFORM
 
 config CAN_TSCAN1
 	tristate "TS-CAN1 PC104 boards"
-	depends on ISA
+	depends on (ISA && PC104) || COMPILE_TEST
 	help
 	  This driver is for Technologic Systems' TSCAN-1 PC104 boards.
 	  https://www.embeddedts.com/products/TS-CAN1

