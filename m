Return-Path: <linux-can+bounces-1173-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E9894B37B
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 01:15:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1D561F222AA
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 23:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E955F153808;
	Wed,  7 Aug 2024 23:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="pDX7mK7a"
X-Original-To: linux-can@vger.kernel.org
Received: from out203-205-221-240.mail.qq.com (out203-205-221-240.mail.qq.com [203.205.221.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB34250EC;
	Wed,  7 Aug 2024 23:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072513; cv=none; b=sAgYZVHfcVeMc1cyjz6KjR245Ibv4aOdHhE5gEVwNUQ3/b8VznHAUFIaUHFtSiuzTwlapnRPq4Ge5Wn8dZIgYmLKKqJNDwMgVF7zgHFSNapUDgm81gzg/3qinhaWXM8lb5nCAkyJwZ6rucFtcljyXmBu5qcluScQLP696jwyTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072513; c=relaxed/simple;
	bh=sHhvml+mYSmDdgcMWP6jiNbju26OB7L8+gCQGhqWQvM=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Jum7QnRUd3Nl1XWAELa5x6iVoS7oo3ZL0iHF+JbTqZ299xvNraif9AHrq0ORuoNZhQvxLv6Y+5J+OB34BIN5eDEK2JZXmn4n3uyZZ23hAuLMM9T+Sffo3V5ziwtmuWLDqrekQbnlxxnVCwxOVX0PWWMkv/jeyVSd1kIp6AI8p5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=pDX7mK7a; arc=none smtp.client-ip=203.205.221.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723072508; bh=ld/aFBFO32VUAPp/57mNfqYKOGvt7MOQE+FG0HbCxC0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=pDX7mK7aO9uhDzvwcEJMuq5c3QpLUQj9kjZc9dta2Grmh/WmPiACxHiZ8f4SDKZIu
	 z2VGD55acHzj+YQc502Bo99eel44anwDm0y9zcqp3cpcUGmmiJx++cd6QoFxZkiEhw
	 kvz1FyfoOLUl48ukWbDgpforjnzHOTrMXtpwK89M=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id 2312EEAA; Thu, 08 Aug 2024 07:08:49 +0800
X-QQ-mid: xmsmtpt1723072129t5xidoyw0
Message-ID: <tencent_1F473700968236B84AEA74ED76FF67023C09@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTPOzuldNXnGeJ7s36h2U6hmp3yD4Ek7o1PE6XcYfGd+vnsxex9Q
	 n3r13Pr88qwieI7NVZ1HudXOvKJEnpIFUicyKUOi5tbvz4PiwZHkJGnWQreHJIxPg65isn0ceO78
	 lxku6wsjZZ6hMAvAf2MIC4xNYumSIubWYMJnlulXkJXEtx7X3HtkyGE4KPVtI3PC9/knpugv3Dy/
	 sNo5WJ6hEmsHk7KSKVSVpBxK7eT4KXC2z4FIoFFyJs/WxOVftmYVZzfCfwGVfNJOqOtyBIh3vLhW
	 S59vz0WSqdp5jc3avP+qfBz2jwAXwPOYpwYtYka3Owbvun6ax8uuh5JLPbLez433BT4RheechQRn
	 PTjC6MrFLZv06LxoZBpse2Lm818ORfeJXk9Th5D0pbtWB0L44NPASsg7hO5DQwg6U/LVwRjBl9n8
	 jx4q2HzCaQD8XLkHzRMb8ne7E8+YfYLLvWWti80+QA2Fs63Lptcd+BF3rF5TAj3WkTbHgDUO/a6d
	 1Bbovs/mykw1uVNIypV529y4F445C5BTChCS0ZcHBP6kDNooZti2pQ0U29shZLVKJNV5WqIpnnzj
	 a33hPlPRgVURReUFVammnPAzptiJN87tHrdcTireTFJ7L2Rx77x+ojGfuGklWg6r8GxAxb3eEiTd
	 Q8McnoGFJdTW1vtvB0Vvs8+jb9dKcCiO9t3DKJR4ZGcc+QSVEqXsQ/e6w90+pJ9iFA8og+K7m58A
	 R6jt4XxpK57mdX/ZA8FJzHGj/C927SvWHUdUeqGqUxa7rskXuf38PPKbB2bO3pjByvyBieCl8zP7
	 IdKwWIUTFwJxwSe8JYI5mqdRKImByCxdGJVpvlrcRMMFVc+WSDBcKux+P0ErL1S1U/gCfIEQ3MAW
	 MBrMEJkCm21bJpMkaB356/5Jh/LjfIGlyihAGKKC+zyG26DBHc0mtmflAqDQWx3Y2i5yGDuRBA8g
	 sSH99ARedaeVFJuQqkhT9bTT/AStzH
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: kuba@kernel.org
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kernel@pengutronix.de,
	leitao@debian.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	robin@protonic.nl,
	socketcan@hartkopp.net,
	syzbot+ad601904231505ad6617@syzkaller.appspotmail.com,
	syzkaller-bugs@googlegroups.com
Subject: [PATCH net-next V2] can: j1939: fix uaf warning in j1939_session_destroy
Date: Thu,  8 Aug 2024 07:08:49 +0800
X-OQ-MSGID: <20240807230848.594339-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240807071655.5b230108@kernel.org>
References: <20240807071655.5b230108@kernel.org>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The root cause of this problem is when both of the following conditions
are met simultaneously:
[1] Introduced commit c9c0ee5f20c5, There are following rules:
In debug builds (CONFIG_DEBUG_NET set), the reference count is always
decremented, even when it's 1.

[2] When executing sendmsg, the newly created session did not increase the
skb reference count, only added skb to the session's skb_queue.

The solution is:
When creating a new session, do not add the skb to the skb_queue.
Instead, when using skb, uniformly use j1939_session_skb_queue to add
the skb to the queue and increase the skb reference count through it.

Reported-and-tested-by: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ad601904231505ad6617
Signed-off-by: Edward Adam Davis <eadavis@qq.com>
---
 net/can/j1939/socket.c    | 7 ++++---
 net/can/j1939/transport.c | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/net/can/j1939/socket.c b/net/can/j1939/socket.c
index 305dd72c844c..ec78bee1bfa6 100644
--- a/net/can/j1939/socket.c
+++ b/net/can/j1939/socket.c
@@ -1170,10 +1170,11 @@ static int j1939_sk_send_loop(struct j1939_priv *priv,  struct sock *sk,
 					break;
 				}
 			}
-		} else {
-			skcb->offset = session->total_queued_size;
-			j1939_session_skb_queue(session, skb);
 		}
+		/* Session is ready, add it to skb queue and increase ref count.
+		 */
+		skcb->offset = session->total_queued_size;
+		j1939_session_skb_queue(session, skb);
 
 		todo_size -= segment_size;
 		session->total_queued_size += segment_size;
diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..dd503bc3adb5 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1505,7 +1505,6 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
-	skb_queue_tail(&session->skb_queue, skb);
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
@@ -1548,6 +1547,7 @@ j1939_session *j1939_session_fresh_new(struct j1939_priv *priv,
 		kfree_skb(skb);
 		return NULL;
 	}
+	j1939_session_skb_queue(session, skb);
 
 	/* alloc data area */
 	skb_put(skb, size);
-- 
2.43.0


