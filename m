Return-Path: <linux-can+bounces-1155-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 029C8949D6D
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 03:42:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 868BA1F242D7
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 01:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797D215B972;
	Wed,  7 Aug 2024 01:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NYO4au5E"
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-58-216.mail.qq.com (out162-62-58-216.mail.qq.com [162.62.58.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D7510E6;
	Wed,  7 Aug 2024 01:42:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.58.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722994972; cv=none; b=Oz3S2emWMPHLIamset5044EcUk/E6inBXi0No4CJXJIhHh6rBBAXuEoGEuvfbq4KL8xNjv/e4wEoFBWAzfGlCztXcvQeWQoQye9/rbLFxufWbRLiG5Ii9z/xH74R7v9tZbYHnAj7G0azpF7WRuUSYJ63vmi1bxrmaupXUvu/kiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722994972; c=relaxed/simple;
	bh=nJc/EA5aX6HYio1FRcTvW+nGYVDvgNrrwuK9u2kXc74=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=Zc5CkBZraaBQU0sVii+FRPh+qRLbsWD1p+xub6C3ROLku9oVcu1kkR/5Z/H7evxjJdrvOD8TSEBYcX48ZQiw5C1DXto7xuWBouO11gTfNe6t32EqKRLXPWpDuVD2j1JTHAN6XxanBLmTLrBjACGu6qYmuxHNLFrBfUQXPOW6p2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NYO4au5E; arc=none smtp.client-ip=162.62.58.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1722994964; bh=oEjPWbgLYa2owMiTzsj3wTp8GPNjpwQfhs8OU5kPAe4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NYO4au5ECSgeNojeTuCBXKVf5FeaPqixvh85Hi9jxgwnVqoDqDibRKM2+KYDIywCZ
	 hiPQ6JS5t6vqIWRbhbJQ2nco2YU/ffJA463V1u9B7lyceMOr3hdV3n+TS0qj9x8wuj
	 4vGjMlD4BmmBdQo5h5/l56x9nPcQC8bon84hR8HI=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-0.qq.com (NewEsmtp) with SMTP
	id AA802823; Wed, 07 Aug 2024 09:42:40 +0800
X-QQ-mid: xmsmtpt1722994960toihf7mun
Message-ID: <tencent_2878E872ED62CC507B1A6F702C096FD8960A@qq.com>
X-QQ-XMAILINFO: MmuCfgcSBfHxKKwxo/p8YL1xiGHNfKFtuBEW8I4yF+aKQOuLCtiS0xtdslArfI
	 h54xGnl3oJuktD7cSc1A3sGEw3GzfMcokw9AKTMN/Zn6ZPvOs5QKcp3uH8MvuTJQ5SdV6R5kUIU1
	 jQaEi5L6x7ytl+qRKXEnfG2IVFupe5JpZ4DqI24sR6Xrz9YQplc4C9cYTPIiR1czLO4FWC7C1ErX
	 jcQVp5jJkeFhXF8RsQcrrkMPdOrCNMa0lFES6x+XinI2dGefhoYfSEAhzoXrn8G/wb/NOnyEbyyh
	 eEdfP96Ncq++SW/9ZrwTXSWVsBoqORXbbM+GMTo1cB9uJ2+sClGKz2oDiXXypyhndyUKYi1SxyZu
	 1M49MTNMj1lAioJ8NdAAW6OwWwPlcii4KIMyx9K6K9Bsec1lgLC+9cYHgHrWldT4jjlf3lGU6ksb
	 2/r862Vh1YhOrQjvRAp2Y6U0g3IrngiRihqPFPqCRhOtptJv43SBYLx85Fcqp6uqo3w/7Dxh5SNy
	 apsUDQxebk7uwrBeBJxQPslVbt2r01Dk8Dk8CKSV2nP1LFRio8guIU9XCKkPHxQktmKJbab+tY73
	 XTxWZHxWbbnf4F2pkpr3Z3eWrHEu9+4SSHxxYlAfNf8yBgHfEqTFoPmNIaFw1j4FD9F8i+GxUYua
	 1j8TckjqaVkMOYOWnqhTsqIx/MIUS1jXb9PMvsiX1+22e/AWk98ayN5OX1SzJt2qDheDpgs0uW6+
	 VQhnbpqTu835+RsxSoR6WIptoIkmvCMaJVhzYaZLS+i0O++CEqMTca9f6JPrUDHQ4Wj8YZLPDv1g
	 FvX67ju/4cme5IE2+P6pheshN+kng4L31m+X1Wou60/tP0zx/0scTkhqsHMcqxIJHTtcsjH2VWPF
	 9aOAhpreyE38MeafAJ6a31OYKFmxzVi0ZGUtGw8ZdGQkGVFH7w956AdnIOGo3bmpEVGft5RfH8LP
	 tdqVi1dtmCXs/WPytsawuE3/I9/AaNhwkoT+/thb8=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+ad601904231505ad6617@syzkaller.appspotmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	kernel@pengutronix.de,
	kuba@kernel.org,
	leitao@debian.org,
	linux-can@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	mkl@pengutronix.de,
	netdev@vger.kernel.org,
	o.rempel@pengutronix.de,
	pabeni@redhat.com,
	robin@protonic.nl,
	socketcan@hartkopp.net,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Wed,  7 Aug 2024 09:42:40 +0800
X-OQ-MSGID: <20240807014239.3997268-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <000000000000af9991061ef63774@google.com>
References: <000000000000af9991061ef63774@google.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes: c9c0ee5f20c5 ("net: skbuff: Skip early return in skb_unref when debugging")

Root cause: In commit c9c0ee5f20c5, There are following rules:
In debug builds (CONFIG_DEBUG_NET set), the reference count is always  decremented, even when it's 1

This rule will cause the reference count to be 0 after calling skc_unref,
which will affect the release of skb.

The solution I have proposed is:
Before releasing the SKB during session destroy, check the CONFIG_DEBUG_NET
and skb_unref return values to avoid reference count errors caused by a 
reference count of 0 when releasing the SKB.

#syz test: net-next 743ff02152bc

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index 4be73de5033c..50d96015c125 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -278,7 +278,8 @@ static void j1939_session_destroy(struct j1939_session *session)
 
 	while ((skb = skb_dequeue(&session->skb_queue)) != NULL) {
 		/* drop ref taken in j1939_session_skb_queue() */
-		skb_unref(skb);
+		if (skb_unref(skb) && IS_ENABLED(CONFIG_DEBUG_NET))
+			skb_get(skb);
 		kfree_skb(skb);
 	}
 	__j1939_session_drop(session);


