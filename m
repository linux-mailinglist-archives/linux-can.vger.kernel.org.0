Return-Path: <linux-can+bounces-5907-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D3369CD90F4
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 12:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E60973021477
	for <lists+linux-can@lfdr.de>; Tue, 23 Dec 2025 11:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF0535295B;
	Tue, 23 Dec 2025 10:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWaN7fW6"
X-Original-To: linux-can@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7C60352931;
	Tue, 23 Dec 2025 10:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766484324; cv=none; b=aqsdDXyQ4C8px2UfF5MlBVZTrADr+V+Wvm0lyyVb0Jou90cRY8CPHje0ga033YyVro4DgTSeC+Entw+Fy2SLLzArC9bhYNXfBO9hlZY5+H1hxTxYlggSggURa/cUKVglbmfEFflc1Y8ChMVDxVRcjiLNcXaZab9Y+k8H6nrNvHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766484324; c=relaxed/simple;
	bh=QU3vKK3fAi+EkXtG1LRInpCrVPsy7c3PzEqqyr9a60o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IdA5SrtfkCxpHaa2QdK0WL+ezeYV6jyq85gDiAwkOeiUm7Le02L6YbnxAEFVEb9Ct5fo0jHeBtZ2M35m/HaSNBejmLOnPIxMYL1CMDHSTV7p745QAyoEZ9W5JX8zF/evHIa8plC1BbNabrwHTmA4TVzENjxWj0m3lkcB0UTEdN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWaN7fW6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E654C113D0;
	Tue, 23 Dec 2025 10:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766484324;
	bh=QU3vKK3fAi+EkXtG1LRInpCrVPsy7c3PzEqqyr9a60o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWaN7fW6DhGsHZ03v0aWutGIXIk0AnySLmLRRXy08kCQ5sLNxBbR8K7QccqCJgaHO
	 pnmnU/UChzLpi3ly3m1cTygs1eSeFC1u+33Av7XTYHwKxpzFAjQbIa67wVTo4Nk7LD
	 MbsfhwlUDIXUpVyOMKtAQwnh40FJ1KRsufMlUnPbv+2BBMnnvyznhSaUU0Urev364R
	 WH7K8wa5OwdqGmzLo88/Xyw4MvAeR4oPbzvqeM4Ydiyc0/jU0MappC8LwZdKavtp8v
	 WVXRlA6DiNYq7vTbW4wBpB0EDzWo8lZrnOtKPF7FZf/nuhpxwZk9smns9YgKl0TbJ0
	 IB5IydwAqIlKQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>,
	syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Marc Kleine-Budde <mkl@pengutronix.de>,
	Sasha Levin <sashal@kernel.org>,
	robin@protonic.nl,
	linux-can@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18-5.10] can: j1939: make j1939_session_activate() fail if device is no longer registered
Date: Tue, 23 Dec 2025 05:05:08 -0500
Message-ID: <20251223100518.2383364-4-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251223100518.2383364-1-sashal@kernel.org>
References: <20251223100518.2383364-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>

[ Upstream commit 5d5602236f5db19e8b337a2cd87a90ace5ea776d ]

syzbot is still reporting

  unregister_netdevice: waiting for vcan0 to become free. Usage count = 2

even after commit 93a27b5891b8 ("can: j1939: add missing calls in
NETDEV_UNREGISTER notification handler") was added. A debug printk() patch
found that j1939_session_activate() can succeed even after
j1939_cancel_active_session() from j1939_netdev_notify(NETDEV_UNREGISTER)
has completed.

Since j1939_cancel_active_session() is processed with the session list lock
held, checking ndev->reg_state in j1939_session_activate() with the session
list lock held can reliably close the race window.

Reported-by: syzbot <syzbot+881d65229ca4f9ae8c84@syzkaller.appspotmail.com>
Closes: https://syzkaller.appspot.com/bug?extid=881d65229ca4f9ae8c84
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Acked-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://patch.msgid.link/b9653191-d479-4c8b-8536-1326d028db5c@I-love.SAKURA.ne.jp
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

---

## FINAL ANALYSIS SUMMARY

### What the commit fixes:
A race condition in the CAN J1939 protocol driver where
`j1939_session_activate()` can succeed even after
`j1939_cancel_active_session()` from the NETDEV_UNREGISTER handler has
completed. This leaves orphaned sessions with references to devices
being unregistered, causing the "waiting for device to become free"
hang.

### Why it matters to stable users:
- **System hang**: The bug can cause network device unregistration to
  hang indefinitely
- **Syzbot reproducible**: The bug was found by automated fuzzing,
  meaning it's triggerable in practice
- **CAN J1939 users**: Affects automotive and industrial systems using
  the CAN J1939 protocol

### Stable kernel rule compliance:

| Criterion | Assessment |
|-----------|------------|
| Obviously correct | ✅ Yes - simple check using established kernel
pattern |
| Fixes real bug | ✅ Yes - syzbot-reported hang |
| Small and contained | ✅ Yes - 2 lines added, 1 file changed |
| No new features | ✅ Correct - only adds error path |
| Tested | ✅ Has Acked-by from maintainer |

### Risk assessment:
- **Very low risk**: The change only adds a conditional check before
  adding a session to the active list
- **Uses established pattern**: `dev->reg_state != NETREG_REGISTERED` is
  used throughout net/can/raw.c and other networking code
- **Cannot break existing functionality**: Adds a new error return path
  that's already properly handled (callers handle error returns)

### Dependencies:
- The fix is logically independent - it adds a safety check that works
  regardless of other commits
- The related commit 93a27b5891b8 is about a different part of the fix
  (adding missing calls in the unregister handler)
- Both commits are improvements to the same underlying issue but can be
  applied separately

### Conclusion:
This is a textbook example of a good stable backport candidate:
1. Fixes a real, user-visible bug (system hang)
2. Minimal change (2 lines)
3. Uses established kernel patterns
4. Has proper subsystem maintainer review
5. Low risk of regression

**YES**

 net/can/j1939/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index fbf5c8001c9d..613a911dda10 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1567,6 +1567,8 @@ int j1939_session_activate(struct j1939_session *session)
 	if (active) {
 		j1939_session_put(active);
 		ret = -EAGAIN;
+	} else if (priv->ndev->reg_state != NETREG_REGISTERED) {
+		ret = -ENODEV;
 	} else {
 		WARN_ON_ONCE(session->state != J1939_SESSION_NEW);
 		list_add_tail(&session->active_session_list_entry,
-- 
2.51.0


