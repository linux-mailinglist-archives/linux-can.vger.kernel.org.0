Return-Path: <linux-can+bounces-1592-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 569D998F565
	for <lists+linux-can@lfdr.de>; Thu,  3 Oct 2024 19:37:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 08CC11F22640
	for <lists+linux-can@lfdr.de>; Thu,  3 Oct 2024 17:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CD41A265D;
	Thu,  3 Oct 2024 17:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="Mxf1cf3R"
X-Original-To: linux-can@vger.kernel.org
Received: from forward200d.mail.yandex.net (forward200d.mail.yandex.net [178.154.239.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D0F1A76D2
	for <linux-can@vger.kernel.org>; Thu,  3 Oct 2024 17:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727977031; cv=none; b=lU40zZECnhQoLhq5aZt04hZaDWPIsHQV2mtBmB8Z1sR1L2J59ZoEad875hQLQ+tuR8gGxcu2vqs5ThkOZVJoNoELoGUaX03qMAVcthknpD8I6qdJXVy5dl81lHg5GzBcCNReMJpLKSE5S0CPpvkg7bq/hC9Y58BF9hDbhQi3ENc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727977031; c=relaxed/simple;
	bh=lHoPSMSCTsEHdejRJct9HkhuZGCeJougElbiYipyRFo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=py9A8ZOsUi/hP5qzIbTqTABx1FkNfSXIZGzYEqhqDKLQ7ZaEkMun6X04fCt34V7jvXtP662qRPNMHW/qNHiAdhBYum+kNmiJuEkkKNABHr9xZlzwFTZX8tYJR+gYbRNXL7dkSLd0f7ggzQ5wCVzrKrISM9zJySe/mrQHaz2u11E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=Mxf1cf3R; arc=none smtp.client-ip=178.154.239.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from forward200a.mail.yandex.net (forward200a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d200])
	by forward200d.mail.yandex.net (Yandex) with ESMTPS id B087669F98
	for <linux-can@vger.kernel.org>; Thu,  3 Oct 2024 20:36:58 +0300 (MSK)
Received: from forward102a.mail.yandex.net (forward102a.mail.yandex.net [IPv6:2a02:6b8:c0e:500:1:45:d181:d102])
	by forward200a.mail.yandex.net (Yandex) with ESMTP id 9846D63143
	for <linux-can@vger.kernel.org>; Thu,  3 Oct 2024 20:36:58 +0300 (MSK)
Received: from mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:1eaf:0:640:53c2:0])
	by forward102a.mail.yandex.net (Yandex) with ESMTPS id 7430460AA1;
	Thu,  3 Oct 2024 20:36:51 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id nagYBL1o4Ko0-AsW2MjqH;
	Thu, 03 Oct 2024 20:36:50 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1727977010; bh=A8cAQfWEdLTwKiDeJh0h3RvQ0bXD5XK2qTrdOSYI8dU=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=Mxf1cf3RjrzLEH+j1AuASQ6GLl/Gnb1FOi22PeC/WHk2hvVwJnpbEKmfcp41Es0oc
	 x+N8tYKGsWLfatUoUvfVP/u5tdxb0G1rGaslPOb7M2VuQwfMNnfHpD6eYXEGlawYhQ
	 momJCr6rjzW6mB1sJ6BeGVcf/eyDEGSgUdAyN97E=
Authentication-Results: mail-nwsmtp-smtp-production-main-91.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: [PATCH] can: fix skb reference counting in j1939_session_new()
Date: Thu,  3 Oct 2024 20:36:12 +0300
Message-ID: <20241003173612.127822-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Yandex-Filter: 1

Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
new skb, I assume that the same should be done for an initial one
in 'j1939_session_new()' just to avoid refcount underflow.

Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 net/can/j1939/transport.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 319f47df3330..fecee36dbb70 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1505,7 +1505,8 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
-	skb_queue_tail(&session->skb_queue, skb);
+	/* Take an extra ref just like in j1939_session_skb_queue(). */
+	skb_queue_tail(&session->skb_queue, skb_get(skb));
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
-- 
2.46.2


