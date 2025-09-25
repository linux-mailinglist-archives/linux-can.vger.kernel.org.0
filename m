Return-Path: <linux-can+bounces-5014-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 70AFBB9F219
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 14:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 14D103263AD
	for <lists+linux-can@lfdr.de>; Thu, 25 Sep 2025 12:14:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 822F530274A;
	Thu, 25 Sep 2025 12:14:08 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0DCF3002C9
	for <linux-can@vger.kernel.org>; Thu, 25 Sep 2025 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758802447; cv=none; b=uJ340TtSui3YpJjW7xmh/+X2g7QOfS+8CVTF+Ki7Redw8X6olyZoJigaRh4HZhwZ6+AZvwdXPAI08wpvMPxvreH941L1KonVCWKOhdUCkzYACBCsMBlmK7NJPW04vOBjirM6Vo33543BLZw0ALnVmAbJUTbCA+QejIM1Y6X15Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758802447; c=relaxed/simple;
	bh=ufAB8RsL7GnbYV8hEwh8am0wgYyRKz5q9d9U4oB6K3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lFT6EWf00TMJnrjJdNERqTJaJZo06sS6K1DRiR/sZoZOLa0NJ9EwHVKazb3Soc4rInTqAWahmTiDG4k3vhp6df8j4kk/xiFr4v7fRBQRPpbVmiTvzTzCFJKpLTztH0tR+6O7ooD+hSe40pa40Gy9+lnMOqcFhkotLcw5XfT+qUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqv-0000Wb-Em; Thu, 25 Sep 2025 14:13:37 +0200
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1v1kqu-000Pw3-1f;
	Thu, 25 Sep 2025 14:13:36 +0200
Received: from blackshift.org (p54b152ce.dip0.t-ipconnect.de [84.177.82.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 3B925479982;
	Thu, 25 Sep 2025 12:13:36 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Vincent Mailhol <mailhol@kernel.org>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 22/48] can: raw: reorder struct uniqframe's members to optimise packing
Date: Thu, 25 Sep 2025 14:07:59 +0200
Message-ID: <20250925121332.848157-23-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250925121332.848157-1-mkl@pengutronix.de>
References: <20250925121332.848157-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Vincent Mailhol <mailhol@kernel.org>

struct uniqframe has one hole. Reorder the fields to save 8 bytes.

Statistics before:

  $ pahole --class_name=uniqframe net/can/raw.o
  struct uniqframe {
  	int                        skbcnt;               /*     0     4 */

  	/* XXX 4 bytes hole, try to pack */

  	const struct sk_buff  *    skb;                  /*     8     8 */
  	unsigned int               join_rx_count;        /*    16     4 */

  	/* size: 24, cachelines: 1, members: 3 */
  	/* sum members: 16, holes: 1, sum holes: 4 */
  	/* padding: 4 */
  	/* last cacheline: 24 bytes */
  };

...and after:

  $ pahole --class_name=uniqframe net/can/raw.o
  struct uniqframe {
  	const struct sk_buff  *    skb;                  /*     0     8 */
  	int                        skbcnt;               /*     8     4 */
  	unsigned int               join_rx_count;        /*    12     4 */

  	/* size: 16, cachelines: 1, members: 3 */
  	/* last cacheline: 16 bytes */
  };

Acked-by: Oliver Hartkopp <socketcan@hartkopp.net>
Signed-off-by: Vincent Mailhol <mailhol@kernel.org>
Link: https://patch.msgid.link/20250917-can-raw-repack-v2-1-395e8b3a4437@kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/raw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 76b867d21def..db21d8a8c54d 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -75,8 +75,8 @@ MODULE_ALIAS("can-proto-1");
  */
 
 struct uniqframe {
-	int skbcnt;
 	const struct sk_buff *skb;
+	int skbcnt;
 	unsigned int join_rx_count;
 };
 
-- 
2.51.0


