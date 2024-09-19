Return-Path: <linux-can+bounces-1517-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EFC97CD54
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 19:50:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0E672847AA
	for <lists+linux-can@lfdr.de>; Thu, 19 Sep 2024 17:50:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54B901A01BC;
	Thu, 19 Sep 2024 17:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b="m1ubmm9T"
X-Original-To: linux-can@vger.kernel.org
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4598319E7F7
	for <linux-can@vger.kernel.org>; Thu, 19 Sep 2024 17:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.67.36.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726768244; cv=none; b=MVga7KYqkV9VK3ElYW5A9K1TPaVepJ4zejAInLNeqL91tOUVHxD69Itr5w2zSWa4tWt5SwW+2i4jvaNTUo/o91B95KQ9jwMesMm+P3z0Qobag7ygzQpSCsLLPxP0kMNNoKaf0H40+xxW6uv1GwmIAyT6rgRC++oAwoCocZkmfgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726768244; c=relaxed/simple;
	bh=50Bj59pXTs5VQHV233hN/gAu0RApi30dZ/I5YmC3kII=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uWhZlnhnBKyhfExKpuocv3v8Oyj/1zajRvvzvshYxNnNVIF/DM85ZiF7JY4gJTPO1gGXE1oxFCU2bt2/k3w+wFW5Ofhxazyexc+8vR+nXPl4+pPdg2F/MQnzB20w14gw2wjYdOOwmZOC3xZT2UYQ7zaZ9tJcuZM2wtZBTP7neM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net; spf=pass smtp.mailfrom=posteo.net; dkim=pass (2048-bit key) header.d=posteo.net header.i=@posteo.net header.b=m1ubmm9T; arc=none smtp.client-ip=185.67.36.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=posteo.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=posteo.net
Received: from submission (posteo.de [185.67.36.169]) 
	by mout02.posteo.de (Postfix) with ESMTPS id 8F8EC240101
	for <linux-can@vger.kernel.org>; Thu, 19 Sep 2024 19:42:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
	t=1726767768; bh=50Bj59pXTs5VQHV233hN/gAu0RApi30dZ/I5YmC3kII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:From;
	b=m1ubmm9TZnhfMiPrcMNY1K4Z/bYpAcDNt6PsKncyhNTblm2GAibGaC2T+UCdB44zH
	 0iuXsSbsrpSJdWxV9a7uTqLKPPpEQpJHiYefDEKl+WA2jLdccx8p0WJRaTE0TYvFUW
	 UttSI6eXSS8tGN0O9A3EJL47+2lhp4LM+MuvW3c+fO2dDKjSy3jruw3iJrWvOLZfLa
	 J/TxZ2bo62BAIbv8eSrL1jW8Mg//UaRyJIgZB1IN6BQpj2RJRkThdv3Y3KX9oCfCvp
	 imvLNPqazcpQ2zOE52YEIsJhvZBf0UqvKi7M/4SY0Rp83o+C4m1s99MYMqS7CjSByN
	 gIN/B7DhvwyzA==
Received: from customer (localhost [127.0.0.1])
	by submission (posteo.de) with ESMTPSA id 4X8jXR5BV8z9rxB;
	Thu, 19 Sep 2024 19:42:47 +0200 (CEST)
From: =?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
To: linux-can@vger.kernel.org
Cc: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol.vincent@wanadoo.fr>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	=?UTF-8?q?Thomas=20M=C3=BChlbacher?= <tmuehlbacher@posteo.net>
Subject: [PATCH 1/1] can: {cc770,sja1000}_isa: allow building on x86_64
Date: Thu, 19 Sep 2024 17:35:22 +0000
Message-ID: <20240919174151.15473-2-tmuehlbacher@posteo.net>
In-Reply-To: <20240919174151.15473-1-tmuehlbacher@posteo.net>
References: <20240919174151.15473-1-tmuehlbacher@posteo.net>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The ISA variable is only defined if X86_32 is also defined. However,
these drivers are still useful and in use on at least some modern 64-bit
x86 industrial systems as well. With the correct module parameters, they
work as long as IO port communication is possible, despite their name
having ISA in them.

Fixes: a29689e60ed3 ("net: handle HAS_IOPORT dependencies")
Signed-off-by: Thomas Mühlbacher <tmuehlbacher@posteo.net>
---
 drivers/net/can/cc770/Kconfig   | 2 +-
 drivers/net/can/sja1000/Kconfig | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/can/cc770/Kconfig b/drivers/net/can/cc770/Kconfig
index 467ef19de1c1..aae25c2f849e 100644
--- a/drivers/net/can/cc770/Kconfig
+++ b/drivers/net/can/cc770/Kconfig
@@ -7,7 +7,7 @@ if CAN_CC770
 
 config CAN_CC770_ISA
 	tristate "ISA Bus based legacy CC770 driver"
-	depends on ISA
+	depends on HAS_IOPORT
 	help
 	  This driver adds legacy support for CC770 and AN82527 chips
 	  connected to the ISA bus using I/O port, memory mapped or
diff --git a/drivers/net/can/sja1000/Kconfig b/drivers/net/can/sja1000/Kconfig
index 01168db4c106..2f516cc6d22c 100644
--- a/drivers/net/can/sja1000/Kconfig
+++ b/drivers/net/can/sja1000/Kconfig
@@ -87,7 +87,7 @@ config CAN_PLX_PCI
 
 config CAN_SJA1000_ISA
 	tristate "ISA Bus based legacy SJA1000 driver"
-	depends on ISA
+	depends on HAS_IOPORT
 	help
 	  This driver adds legacy support for SJA1000 chips connected to
 	  the ISA bus using I/O port, memory mapped or indirect access.
-- 
2.46.0


