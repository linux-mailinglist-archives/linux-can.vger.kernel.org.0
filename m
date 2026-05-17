Return-Path: <linux-can+bounces-7645-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IEukBDLkCWo6twQAu9opvQ
	(envelope-from <linux-can+bounces-7645-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 17:52:18 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 698BC562281
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 17:52:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 340523038A67
	for <lists+linux-can@lfdr.de>; Sun, 17 May 2026 15:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAB2823183C;
	Sun, 17 May 2026 15:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ts9wYLug"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6970D33ADA8
	for <linux-can@vger.kernel.org>; Sun, 17 May 2026 15:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779032710; cv=none; b=sXHPeL2iNtEUkpMGjgyDpueWSgvq20eBTcbkjx685ucz3DcKvUXot7/ZPeKY6QTq5vp4MrG4o1bAQDXJKx0nCgbc/+NNOLHueUP2KdKhDeXpnLhWrZznm/rfEbte58d0hXkzVSaTfj3OlR0kgoXJVpTOUALEHzABKwQ8Fh6PZBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779032710; c=relaxed/simple;
	bh=92hjnILRYs105q3oN09+wTsnRhexNGzFiSGKoLJ+vwI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BQEA8L5dMHjHvlCYFvujHGRl94YopvyuG8J1NVfCSMeEn3XyzqHM1mfbhZdU++Dnbae9loYxDHQAPZtmdibEXhF0DYGjBf8UOTSSoEtw/6eiceUFd9ieZ12qVmDTje/4mpJpZ4GYq9yYDoCt4/oXQHWvKZLStSyn+dnd5d54O1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ts9wYLug; arc=none smtp.client-ip=74.125.82.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-135200bc7d2so3582743c88.0
        for <linux-can@vger.kernel.org>; Sun, 17 May 2026 08:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779032708; x=1779637508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kp5LSWAuNxzfazrqqQhlmJHYeJpUQHJGYVuj8ZJV+PY=;
        b=Ts9wYLugE43E7dhlQ/X5p4XkUagpcRMdUmT51FbpOOguc36tiCX0modCkpdThFNTa+
         MI/uUjJDkeTdnb0QywhKXaqXog+n8bXf8HI1xYdnKvEdjJpw30oYj4JXa85jUBysYoDK
         DKdqk6prqABIv0gNMpYEw4187Dk/CgoGpbZYJ/JbmO5e1q2PmPclNQJckX523ih7L39D
         LweK5Gsb3ZmgwZwoJekZSkurDNuiQcBqlTBVK+khhfhBSi/KArCTF9krUZ3j6toU2eo0
         +U0dHbwjpRebon+O8qRCUk2ZMrm/UpNbe2LRRSqFh0h8MTldhyw7APbTOALQsB/q+xjb
         TYSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779032708; x=1779637508;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kp5LSWAuNxzfazrqqQhlmJHYeJpUQHJGYVuj8ZJV+PY=;
        b=e6ZA2vD2DkihDw6pcjkMKShkLjNNMi0e5f1ZS9BElvHd9pPpTmBokbA5RLkOVnFnPP
         d61VUAqovjxzuvky9g048s8B1/P7dz2vTCWpUWgnx8GGB1DiwBTKcSO+jTnQXf2OWizD
         UbEoxTkfF6fmx1BXIE6OkIdSB0W1ZQUMnc64hAIl1IuLjUTmxL7D5cHFOW9YLjzPafX5
         lTHlp5Ep9aRbhCQUJHENJomgloyR8QCou44hGkpvlyHVNuciqCvlke7a6vS0q+2CPAEl
         XGkitbebcCg380mcj1eu3b0As37P5eZdcDl0tKN+j1i74iOGrX76GXY8LKeHeDf/2d5B
         Tc0A==
X-Forwarded-Encrypted: i=1; AFNElJ+XonIIanru20G6cr6LaVSmX8/V5yej7HE6lqFYk/cYamvqZlvvW3K0VKBbilHw8e4xhZ0kJSvPiII=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDVPGIVIqMZkAeXnV4cmgG2eKeb9NRWxoCn5l+dq5ce+MlPtmB
	7AUsfb+8rqSpid7XZXqZnCXMJF4kd56+50e+vpQOd23qHbYpAwR0NLJh
X-Gm-Gg: Acq92OEynH4LxlAfHxT1GRc78ZROHWohPvK8EiHtIu1wpWceAV67yGqyihCV7Vyp2ST
	UFZNpUiBASLxZf0eFY6BXttAsqW7yL88iZ4/svmSGnw4CgrjkZc9rxQPgKwtH6xI+kb5t5kFKWJ
	0lMVjdSa3CE1kNt3Wt0CGyQ5f5Ylw43dWtAZajJoVn27exL7ixP3us6dYzCqsoeGwRdig89tKdM
	I0OYtsTtVVnhMkeZKM1c/ZcLYNuea3ArE+4okNMoSk5TiAEyq9kQYVeMjonecSCcHvQZxQTTvva
	10Plj45BEroC+bQFD+J/VR3HDkQYwi7DvHdGe0Z2D/SPQIxjedUb8ZqM8yqVscgq1FKC3pfUxOH
	ox/ISFIlAvJ3EMZDIhor1QEmOWymwRP2CgT65rUcXicfa6mQSsILemGEuZj9DJuCJl1Zcr7LCq4
	0xg2v61xEECANJ+QAHwGImNfGkbyEwB+DNW1lX/+g4FpA+CZnQMFhNV8TxbY7AF5gtB7AveO+MO
	AOe51pBUw==
X-Received: by 2002:a05:7022:6890:b0:12d:de3e:cc01 with SMTP id a92af1059eb24-13504a4e7c1mr5571363c88.40.1779032708271;
        Sun, 17 May 2026 08:45:08 -0700 (PDT)
Received: from efaec68ba852.tailc0aff1.ts.net ([206.206.192.132])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-134cb5b3c20sm17621524c88.0.2026.05.17.08.45.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 08:45:07 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: Bastian Stender <bst@pengutronix.de>,
	Maxime Jayat <maxime.jayat@mobile-devices.fr>,
	linux-can@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>
Subject: [PATCH] can: j1939: fix NULL pointer dereference in j1939_session_completed()
Date: Sun, 17 May 2026 08:44:27 -0700
Message-ID: <20260517154426.4046979-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 698BC562281
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[pengutronix.de,mobile-devices.fr,vger.kernel.org,asu.edu,gmail.com];
	TAGGED_FROM(0.00)[bounces-7645-lists,linux-can=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bestswngs@gmail.com,linux-can@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-can];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

j1939_xtp_rx_dpo_one() accepts an attacker-controlled DPO value
without bounds checking. When DPO >= session->pkt.total, the
subsequent j1939_session_skb_get() returns NULL, and
j1939_session_completed() passes it to j1939_sk_recv() which
dereferences oskb->sk, causing a kernel panic.

 Oops: general protection fault, 0000 [#1] SMP KASAN NOPTI
 KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
 RIP: 0010:j1939_sk_recv (socket.c:318 socket.c:363)
 Call Trace:
  <IRQ>
  j1939_xtp_rx_eoma (transport.c:1235 transport.c:1412)
  j1939_tp_recv (transport.c:2141 transport.c:2189)
  j1939_can_recv (main.c:108)

Validate DPO against session->pkt.total in j1939_xtp_rx_dpo_one()
and abort the session if out of bounds. Also add a NULL guard in
j1939_session_completed() as defense in depth.

Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Reported-by: Xiang Mei <xmei5@asu.edu>
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/can/j1939/transport.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..9b0d67c8a9a0 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1231,9 +1231,11 @@ static void j1939_session_completed(struct j1939_session *session)
 
 	if (!session->transmission) {
 		se_skb = j1939_session_skb_get(session);
-		/* distribute among j1939 receivers */
-		j1939_sk_recv(session->priv, se_skb);
-		consume_skb(se_skb);
+		if (se_skb) {
+			/* distribute among j1939 receivers */
+			j1939_sk_recv(session->priv, se_skb);
+			consume_skb(se_skb);
+		}
 	}
 
 	j1939_session_deactivate_activate_next(session);
@@ -1818,6 +1820,11 @@ static void j1939_xtp_rx_dpo_one(struct j1939_session *session,
 
 	/* transmitted without problems */
 	session->pkt.dpo = j1939_etp_ctl_to_packet(skb->data);
+	if (session->pkt.dpo >= session->pkt.total) {
+		j1939_session_timers_cancel(session);
+		j1939_session_cancel(session, J1939_XTP_ABORT_FAULT);
+		return;
+	}
 	session->last_cmd = dat[0];
 	j1939_tp_set_rxtimeout(session, 750);
 
-- 
2.43.0


