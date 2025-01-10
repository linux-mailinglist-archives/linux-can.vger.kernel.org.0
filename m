Return-Path: <linux-can+bounces-2582-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC4F1A08F49
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 12:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1E303A47A9
	for <lists+linux-can@lfdr.de>; Fri, 10 Jan 2025 11:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFC9B20D4FB;
	Fri, 10 Jan 2025 11:27:26 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0123720CCCC
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736508446; cv=none; b=Azy+T14prFqKTuSdo2PegUvrgTJgnmngW0NlZX8xjnSWCTO9Q7q5EK5rXhi8KCOYFx+4x0Zv3RNveySS+wvFfjl1rkiKtoBPukjZIYnxdfAbenZyP5IGYMCNY0L6TpGkhwuERJWdNVT61CQzupVZ17xcxAmfCSji9+Wn7KeaG04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736508446; c=relaxed/simple;
	bh=eA4A+PZTJjAnKaR03apl1wEyblpDypb7x9Up2p+4yRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oAyiMPWVgnnSKxo+lXCFCHE5XiUUHzAHbRMTsjJtwKnzOo/zPeXh5e6z/+R58z9BJgO90x33mS8mQ/KqCLdk7nFTWhRLJkoTm4B/L0G/dz2ZkazhIds3nWNJMwnDePTocjCaiSYbfwQQN0RHL/DIV3mKVjv9DzeTdaLvDogTCos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAf-00051q-OW
	for linux-can@vger.kernel.org; Fri, 10 Jan 2025 12:27:21 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1tWDAc-0009gU-15
	for linux-can@vger.kernel.org;
	Fri, 10 Jan 2025 12:27:18 +0100
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id E9B4A3A4600
	for <linux-can@vger.kernel.org>; Fri, 10 Jan 2025 11:27:17 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id D36C93A4599;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e44e3629;
	Fri, 10 Jan 2025 11:27:14 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 08/18] mailmap: add an entry for Oliver Hartkopp
Date: Fri, 10 Jan 2025 12:04:16 +0100
Message-ID: <20250110112712.3214173-9-mkl@pengutronix.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250110112712.3214173-1-mkl@pengutronix.de>
References: <20250110112712.3214173-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

From: Oliver Hartkopp <socketcan@hartkopp.net>

Map my retired company address and an accidentally used personal
mail address within mailmap.

Signed-off-by: Oliver Hartkopp <socketcan@hartkopp.net>
Link: https://patch.msgid.link/20241130170911.2828-1-socketcan@hartkopp.net
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 .mailmap | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/.mailmap b/.mailmap
index 5ff0e5d681e7..37ecf2632be3 100644
--- a/.mailmap
+++ b/.mailmap
@@ -529,6 +529,8 @@ Oleksij Rempel <linux@rempel-privat.de> <external.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <linux@rempel-privat.de> <fixed-term.Oleksij.Rempel@de.bosch.com>
 Oleksij Rempel <o.rempel@pengutronix.de>
 Oleksij Rempel <o.rempel@pengutronix.de> <ore@pengutronix.de>
+Oliver Hartkopp <socketcan@hartkopp.net> <oliver.hartkopp@volkswagen.de>
+Oliver Hartkopp <socketcan@hartkopp.net> <oliver@hartkopp.net>
 Oliver Upton <oliver.upton@linux.dev> <oupton@google.com>
 Ondřej Jirman <megi@xff.cz> <megous@megous.com>
 Oza Pawandeep <quic_poza@quicinc.com> <poza@codeaurora.org>
-- 
2.45.2



