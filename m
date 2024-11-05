Return-Path: <linux-can+bounces-1891-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD919BC98C
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 10:49:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 106C5B22A8B
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2024 09:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9AC31D0E26;
	Tue,  5 Nov 2024 09:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="PYGg32xH"
X-Original-To: linux-can@vger.kernel.org
Received: from forward102b.mail.yandex.net (forward102b.mail.yandex.net [178.154.239.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E8F1CF297;
	Tue,  5 Nov 2024 09:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730800130; cv=none; b=YpxChQXGyroE34GyD/lh7QtnLuhjIj4U9yhpzYllrapjbjuY7NYgTHff/En/B6p4juVt72sRz7PjLXtc+7+zoy4ZtjRuOfctIH/9k0TTmSRBt0Ol702ypeHVd2lmprsI6QQa2tsD4rMferQap7e1IF5krNwlVykBWRBY+7h8MII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730800130; c=relaxed/simple;
	bh=PLFNO/Za9IIH6WKNWm2K/r+dkLfoIRysDN4WXLR8wxo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bN8yP7ESGdze8SBRYCpjPXBev7AcbShwqBpw9Ph1mVBwhRJ6dinRvKPgpjDac5wUAwLiYfx3UFtT/ixs4v5xTKM65T4G+BI7zI2QS8X7KN4k8iyTOJC76u/7aTgNqlZDtt79ASPWTrLTm9guDZD7oKOHm1OfxL7SvA3Pca/biZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=PYGg32xH; arc=none smtp.client-ip=178.154.239.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net [IPv6:2a02:6b8:c10:2222:0:640:c513:0])
	by forward102b.mail.yandex.net (Yandex) with ESMTPS id 33B4660D54;
	Tue,  5 Nov 2024 12:48:38 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id amc52dYgCqM0-OqOWWHTQ;
	Tue, 05 Nov 2024 12:48:37 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1730800117; bh=yOcdpZoLLXYn95T8L/QYQw81yGB3Ut1F8CC0nSALDTQ=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=PYGg32xHYbnGXhLaI7IVQ5PoVJDTCcd/v1aWf2OGjoJZsqRZnpkIca9t4OLAtdOD1
	 2kjb9PysnnadhHh1mTTSdY28LoiXYC1n+RWDyuk6B3vshbyI3Hk7qxY+fkvu6L5jt7
	 W+NR/eOLobhsvNxAGRAQ2YHSXghhQ3IpsVVKvUng=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Robin van der Gracht <robin@protonic.nl>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Oliver Hartkopp <socketcan@hartkopp.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Cc: linux-can@vger.kernel.org,
	netdev@vger.kernel.org,
	lvc-project@linuxtesting.org,
	Dmitry Antipov <dmantipov@yandex.ru>,
	syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Subject: [PATCH v2] can: fix skb reference counting in j1939_session_new()
Date: Tue,  5 Nov 2024 12:48:23 +0300
Message-ID: <20241105094823.2403806-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since 'j1939_session_skb_queue()' do an extra 'skb_get()' for each
new skb, I assume that the same should be done for an initial one
in 'j1939_session_new()' just to avoid refcount underflow.

Reported-by: syzbot+d4e8dc385d9258220c31@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d4e8dc385d9258220c31
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
v2: resend after hitting skb refcount underflow once again when looking
around https://syzkaller.appspot.com/bug?extid=0e6ddb1ef80986bdfe64
---
 net/can/j1939/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 319f47df3330..95f7a7e65a73 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1505,7 +1505,7 @@ static struct j1939_session *j1939_session_new(struct j1939_priv *priv,
 	session->state = J1939_SESSION_NEW;
 
 	skb_queue_head_init(&session->skb_queue);
-	skb_queue_tail(&session->skb_queue, skb);
+	skb_queue_tail(&session->skb_queue, skb_get(skb));
 
 	skcb = j1939_skb_to_cb(skb);
 	memcpy(&session->skcb, skcb, sizeof(session->skcb));
-- 
2.47.0


