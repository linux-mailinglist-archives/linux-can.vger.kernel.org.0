Return-Path: <linux-can+bounces-7365-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aIjiCfit3GnfVAkAu9opvQ
	(envelope-from <linux-can+bounces-7365-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Mon, 13 Apr 2026 10:48:56 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E6E3E951F
	for <lists+linux-can@lfdr.de>; Mon, 13 Apr 2026 10:48:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 371153010394
	for <lists+linux-can@lfdr.de>; Mon, 13 Apr 2026 08:45:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6CBE3A3E81;
	Mon, 13 Apr 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rWD1Zhw4"
X-Original-To: linux-can@vger.kernel.org
Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8344335A397
	for <linux-can@vger.kernel.org>; Mon, 13 Apr 2026 08:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776069956; cv=none; b=So6inQb6+wCO7mKkPniV27+MD54TblLpTXYRVmKK5QVVz6lVYJGpgegQI/uVuaIYOq2xRNIO6HrpmgcIBhgCAtujje/nlfFNpM0T0lW7kCghu2hWQQlJEARrOjK/anMhVrzI4xjIjzJcYTDGaHEfzkQx+v53k5lWeRm+wk6+uSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776069956; c=relaxed/simple;
	bh=w9JfzH1zslra+T5xxjofC1Q1lXiXC0fR+accB4/X4xU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PEc3Qj/qowkYrRzZ6Yjdz60MDwgzkii+/Ng93sw55iRBPFODXWvL7UwaTizbUa2EZFEV8ba53cV+r1GIeMI7k2GlMsVt0tuwdRinaMFiLvrkCiGD0xenNkFspuc+TJBfp4W/gJCczqKlzP+tRqzllhNr26RwGOMPmW+7OcAOikE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rWD1Zhw4; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c742b9b7727so1318365a12.0
        for <linux-can@vger.kernel.org>; Mon, 13 Apr 2026 01:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776069955; x=1776674755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dP4j0fBLDD6a/TfIbOTZM2AS6mcGEPiajTQtEr5oZdw=;
        b=rWD1Zhw4NEXmH9CqVh2Lk77eY7QFkP7mmiZSgoWeRzWTLsVzHbYrO8cWB6FPPXTfHh
         DZ7I9J45BWrqPAaJwpwW4chj91bjGyoU6QgvBMZR2eFfznXbrVLsGgKjn5vZ9BQxKswM
         ZigZLzlWEEAJtZByGzgEhcqwktaEja03/7PjaFoWYGmIZ2A6ENtfB7WSGLW2FUNMzs4B
         PjIpQ9CgDwUbH1I7OPPIZ7NkCzNDfl7ahJ7hkBZl03PiruOw5o9xSLavSs+H7sHGFRyM
         UkCc3m0E7LZvlahef0FSjKsXmcp4irHzPb4oVmYD2S++uN5L+N0q3Mk3tp1GvlKU3Toe
         b8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776069955; x=1776674755;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dP4j0fBLDD6a/TfIbOTZM2AS6mcGEPiajTQtEr5oZdw=;
        b=qHGISgR+iKMXfpSRFY7ndE1IoEsaiK90iDhZLCo2oP0QqP/SY0xIiY38f/U+68N0Zp
         pfu2iqf7+yRjufvWNdl4QdZh/YS/tR/w3MxdDHDeK1VT3RWY1oBlf/3AQ5dMxa65nfm7
         zWQ8xUlcBLoToxVWYj9XnZ0QxLWWDbtQay01NeW0gTS1HYZMSzgGryOWwiqABury8v7X
         6I1hDC0VjLFl/shkvxZoUbmhs5x/EFHcNDdotPJEDX/svSE6kp6lpjzsiO9nY25oVLJY
         a/yGJw2hVcCR/N6t9aA0NISMT0LV0oQG/Pg3+cIojiePhsSKx0icc1mf0osyUuzRM1dy
         IzYQ==
X-Gm-Message-State: AOJu0Yz/Ix4msBpqmJPGk9kQFp80Q24SIQptcn9Z9x3MC6LBao4AjVZR
	5ZQL9J996g7eaTFmk8E7k4Ug2yZVqCKoyD5wgvWAmDpsctIRCJfVmBh6qifhXw==
X-Gm-Gg: AeBDieuq676ot969ENbjPFX9x2sHBPAUm9qGIT7Jb73dyOYHNJCKxu8YCx1EiWvKyFg
	34ARG0+5D/RSRjA4jGy+Jbgkg/RIqQNKAPZDoAxtKQXiQghSx1i0JcGz4rKY74wonNwamjDz0MA
	yrv8dhE8mB0V69i/YKYPWYmJzqdkhN2f2OhZwhCjvQwX+k0YYkuQx/lwqgvcICXVpmx74EwIqNu
	fAvRfd9qf5OgA0bPEza14PwvEhelekoLBsgkomzD40ypQbLdMeaA9WNhQsE2kBBf3dPgOp7/jz9
	fpCghivJlvH840QZpKofmXVEYFNRV/w5YLihkSsVEqq+Fb9PBLF6QmqtKcjyODeEjtR8H972Q11
	tGS8D7PqpIoLCknXk/XId5wSDHsD38VldiVYtGL7+PBVKiErTUC7ZuTuY3Dqtjq5mSP5lKbjTGk
	l4a2wOQM6YOqFgRmwptpBvGJstxe2leBQPvZEjW/8uWPJxEVXCiDz9F8yz/SmO4889
X-Received: by 2002:a05:6a21:33a7:b0:398:8ea8:5f9f with SMTP id adf61e73a8af0-39fc937c237mr16145844637.16.1776069954571;
        Mon, 13 Apr 2026 01:45:54 -0700 (PDT)
Received: from gmail.com (69-172-89-235.static.imsbiz.com. [69.172.89.235])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c79218fc64csm9648912a12.11.2026.04.13.01.45.52
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 13 Apr 2026 01:45:53 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: linux-can@vger.kernel.org
Cc: robin@protonic.nl,
	o.rempel@pengutronix.de,
	Dudu Lu <phx0fer@gmail.com>
Subject: [PATCH] can: j1939: Use hrtimer_cancel in j1939_cancel_active_session
Date: Mon, 13 Apr 2026 16:45:48 +0800
Message-Id: <20260413084548.69294-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[protonic.nl,pengutronix.de,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7365-lists,linux-can=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[phx0fer@gmail.com,linux-can@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-can];
	NEURAL_HAM(-0.00)[-1.000];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 97E6E3E951F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

j1939_cancel_active_session() uses hrtimer_try_to_cancel() for both
txtimer and rxtimer. When hrtimer_try_to_cancel() returns -1, it means
the timer callback is currently executing. In this case, the function
neither cancels the timer nor drops the session reference via
j1939_session_put(). The session is then deactivated while the timer
callback may still be running, leading to a potential use-after-free if
the callback accesses the session after it has been cleaned up.

Replace hrtimer_try_to_cancel() with hrtimer_cancel() which will wait
for an in-progress callback to complete before returning, ensuring the
timer is fully stopped before the session is deactivated.

Note: This changes the function to potentially sleep (hrtimer_cancel
waits for the callback). The function is called with
active_session_list_lock held (a spinlock), so an alternative approach
would be to handle the -1 return from hrtimer_try_to_cancel() without
blocking. However, if the lock can be converted or the cancel moved
outside the lock, hrtimer_cancel() is the cleaner fix.

Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
 net/can/j1939/transport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index df93d57907da..996d4c2cbbb0 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -2230,9 +2230,9 @@ int j1939_cancel_active_session(struct j1939_priv *priv, struct sock *sk)
 				 &priv->active_session_list,
 				 active_session_list_entry) {
 		if (!sk || sk == session->sk) {
-			if (hrtimer_try_to_cancel(&session->txtimer) == 1)
+			if (hrtimer_cancel(&session->txtimer))
 				j1939_session_put(session);
-			if (hrtimer_try_to_cancel(&session->rxtimer) == 1)
+			if (hrtimer_cancel(&session->rxtimer))
 				j1939_session_put(session);
 
 			session->err = ESHUTDOWN;
-- 
2.39.3 (Apple Git-145)


