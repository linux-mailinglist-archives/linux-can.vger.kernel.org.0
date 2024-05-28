Return-Path: <linux-can+bounces-683-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D7E8D14E3
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2024 09:07:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3DAC41C215F2
	for <lists+linux-can@lfdr.de>; Tue, 28 May 2024 07:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576EB71748;
	Tue, 28 May 2024 07:07:00 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A918E61FE3
	for <linux-can@vger.kernel.org>; Tue, 28 May 2024 07:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716880020; cv=none; b=S2EBOjHcYRSHbBX6wWxp2V25Hq30rioD+91QNVpG+73iRt8fhCR5ZaWQKVvDW/ODmsk2djB730wZm7wUun/GV1UTq6a99/YeHiBJeG6CaOOqrEEph1ohem/mW9sGc6IGS9pw4DE3jWHI+W9OhBsHdTmDvhnDEnBv6Y4BrPZoRPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716880020; c=relaxed/simple;
	bh=m97IKiXWfUSy7H8C9KQwOOFyrfYjuNFZeQ3PSUGrWhc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=MeqCkDXNdOQnA+xC9HtVpYX0mRAAkCoDBLXbHaQF0BwGOe/0LDiX1kxnHOBhGKUyCWRKsy+rsnf8Z1kXG076d6IAUkZb8ADpVNGUrBm0RggVoS1L1RqkmPoKft4Ij7wqhSO6Awj3/hwyOEFX60IEBrw/TG8FBW2nW9A0HVRK6vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1sBqv5-0005M6-Ho; Tue, 28 May 2024 09:06:51 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1sBqv4-003I9E-Rm; Tue, 28 May 2024 09:06:50 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1sBqv4-008AYo-2Y;
	Tue, 28 May 2024 09:06:50 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Robin van der Gracht <robin@protonic.nl>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	kernel@pengutronix.de,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] j1939: recover socket queue on CAN bus error during BAM transmission
Date: Tue, 28 May 2024 09:06:48 +0200
Message-Id: <20240528070648.1947203-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-can@vger.kernel.org

Addresses an issue where a CAN bus error during a BAM transmission could
stall the socket queue, preventing further transmissions even after the
bus error is resolved. The fix activates the next queued session after
the error recovery, allowing communication to continue.

Fixes: 9d71dd0c70099 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
Tested-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 net/can/j1939/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fe3df23a25957..9805124d16763 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1681,6 +1681,8 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+		if (session->transmission)
+			j1939_session_deactivate_activate_next(session);
 
 		return -EBUSY;
 	}
-- 
2.39.2


