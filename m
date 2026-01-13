Return-Path: <linux-can+bounces-6118-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 07456D168CF
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 04:47:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3749A30169BD
	for <lists+linux-can@lfdr.de>; Tue, 13 Jan 2026 03:46:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99C122F1FDA;
	Tue, 13 Jan 2026 03:46:56 +0000 (UTC)
X-Original-To: linux-can@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C9F2F0C62;
	Tue, 13 Jan 2026 03:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768276016; cv=none; b=VlOLWKRGPqxLyfPRqtNdFystpvdcDUUjG268ABdVPiCuIPb5NsFl5pVmzXI+uesQttkCCGckfOu0X4dtelcUSd5Ca9rI2LOiJnqQYT5LoQ5NPnSlDxE7ttOEzccti7Cv9FMtRjdJ1zT83m+KWY20wacGrMM+UeJXEZ7Qq3OICdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768276016; c=relaxed/simple;
	bh=VmNIpfC1AQ4hFEMJRZCZ6rIbB8XApUfA7pL8k0q9cMo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=rpWa7STn6YPG6+wncTkq01Svv74c+U/dBcJi24UfBMaEC9t+uow6HB68NntSHNXg9HDF3U/SAywaTRlsz+LgpWMn/Z9/KDa3TMWwgOAnyphLMQE0F//SGG/rJZSGFGcaTfB5hNRNAn4ODuz8wwJEPlPcikwoJ68anEfp+jAWB58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 60D3kVoG026732;
	Tue, 13 Jan 2026 12:46:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.10] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 60D3kVdI026729
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 13 Jan 2026 12:46:31 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <4b1fbe9d-5ca2-41e9-b252-1304cc7c215a@I-love.SAKURA.ne.jp>
Date: Tue, 13 Jan 2026 12:46:30 +0900
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: Re: can: j1939: unregister_netdevice: waiting for vcan0 to become
 free.
To: Robin van der Gracht <robin@protonic.nl>,
        Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        Oliver Hartkopp <socketcan@hartkopp.net>,
        Marc Kleine-Budde <mkl@pengutronix.de>, linux-can@vger.kernel.org
Cc: Network Development <netdev@vger.kernel.org>
References: <faee3f3c-b03d-4937-9202-97ec5920d699@I-love.SAKURA.ne.jp>
Content-Language: en-US
In-Reply-To: <faee3f3c-b03d-4937-9202-97ec5920d699@I-love.SAKURA.ne.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Anti-Virus-Server: fsav304.rs.sakura.ne.jp
X-Virus-Status: clean

Currently, the (session->last_cmd != 0) path in j1939_xtp_rx_rts_session_active() is
preventing the (session->state == J1939_SESSION_WAITING_ABORT) path in j1939_tp_rxtimer()
 from being called. This results in two j1939_priv refcounts leak (which in turn results in
one net_device refcount leak) due to j1939_session_deactivate_activate_next() being not called.

This problem goes away if I do either

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1689,16 +1692,18 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,

        if (session->last_cmd != 0) {
                /* we received a second rts on the same connection */
-               netdev_alert(priv->ndev, "%s: 0x%p: connection exists (%02x %02x). last cmd: %x\n",
+               netdev_alert(priv->ndev, "%s (modified): 0x%p: connection exists (%02x %02x). last cmd: %x\n",
                             __func__, session, skcb->addr.sa, skcb->addr.da,
                             session->last_cmd);

+               /*
                j1939_session_timers_cancel(session);
                j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
                if (session->transmission)
                        j1939_session_deactivate_activate_next(session);

                return -EBUSY;
+               */
        }

        if (session->skcb.addr.sa != skcb->addr.sa ||

or

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1697,6 +1700,11 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
                j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
                if (session->transmission)
                        j1939_session_deactivate_activate_next(session);
+               else if (session->state == J1939_SESSION_WAITING_ABORT) {
+                       netdev_alert(priv->ndev, "%s (modified): 0x%p: abort rx timeout. Force session deactivation\n",
+                                    __func__, session);
+                       j1939_session_deactivate_activate_next(session);
+               }

                return -EBUSY;
        }

. But what is the correct approach?


