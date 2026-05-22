Return-Path: <linux-can+bounces-7687-lists+linux-can=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-can@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gGzYNZ6dEGpuawYAu9opvQ
	(envelope-from <linux-can+bounces-7687-lists+linux-can=lfdr.de@vger.kernel.org>)
	for <lists+linux-can@lfdr.de>; Fri, 22 May 2026 20:17:02 +0200
X-Original-To: lists+linux-can@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 532005B8EAC
	for <lists+linux-can@lfdr.de>; Fri, 22 May 2026 20:17:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB045302F0F7
	for <lists+linux-can@lfdr.de>; Fri, 22 May 2026 18:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C874366042;
	Fri, 22 May 2026 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="BPMqopYo";
	dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b="sbWXWjeU"
X-Original-To: linux-can@vger.kernel.org
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de [85.215.255.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56D2526ED25
	for <linux-can@vger.kernel.org>; Fri, 22 May 2026 18:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=85.215.255.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473306; cv=pass; b=funKeem/90j1JA7yMdEiKU74fyZcZ5GK/MIWGS6wzg4hV3UTQGU5HgZyRnPRdqy2t5hM9l2ice1yQJh7UluxLDPi1FEdE3linBBKEoqYKbxznGeLgGFWYgURgD0BY0dLInHQAqI1GdWwiILxEocs3oUIhzU4Fw4zU0R0mS8ZATs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473306; c=relaxed/simple;
	bh=aryVftEXV6zUwm4FQcK9C+aoxI9AbRH2wEThaC859MM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MAUCWSsBvg4mdJm3JPBw8E7Cj7THm0rkoyD1///rmZkVwISQsPQiuhz8/Ak3ymNIa/qfZWLgNHFMOz+0UnXV7IKUbCSKuuDKmeZWHvixC1Ugom8TzCfvs1QInMWOVu3rYnKAxfisLGijoOh3o9PQ9/3R/iwbTZ84HKahnBupA8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net; spf=fail smtp.mailfrom=hartkopp.net; dkim=pass (2048-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=BPMqopYo; dkim=permerror (0-bit key) header.d=hartkopp.net header.i=@hartkopp.net header.b=sbWXWjeU; arc=pass smtp.client-ip=85.215.255.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=hartkopp.net
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=hartkopp.net
ARC-Seal: i=1; a=rsa-sha256; t=1779473295; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=kHyMWd5Pc/dS2fVg6CTX6dj2U/Meap8g1yw0XmMsn6ShX2YRqmLpxHqzgY/caNTf3w
    IgANEn0a23ctWXwKmlJDbHNKRgTQ7Ma5rGiIxllx84IO8K6CLKxnlEeo7Fmi6gjApru8
    5VmdUW1Q/ejcXuLhAdTVapoTokvN6TVBQE64aXP15NHrRMmVM4FXRAvdbmtrOiS6q91q
    Vzbuwx9WLbMqI6QPd79hlORkwDPBKtPozGd1l/fxn5Nx0c+ybm1j9i1iNcGIYDCdSpJb
    PKi37QeDHA3JaLq4b0qPJVzXIY17odakqtDmAPHw0fW45gr0PQfr78D1rCtbSWywJ6mo
    58yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1779473295;
    s=strato-dkim-0002; d=strato.com;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=betYDFafZ+bYhVcjPhrToExGqoVosz3l9SGRbmrMBzo=;
    b=p1qkAVbv9dlnxW3wEf+7Z5fnKSAWMFaE5onr4bmVIRkjWfwRT3sTVe+BiKbVXzvTnt
    i/SBmqLZChTkkVpM2M14+mIEdPX5uD7xfZSCg7aIYQ9tk45Al4VvBAVMF79ThYQ3QMpK
    9kS0TOTGiVYtEraZQKYLOT1hEvTEXxhk3gbFY7laN7CcbLCpUFid0GNrTpSjoz2VcHgq
    P7c4E+v+yjqWyQKoLDCVytAPuYYSYsaA0Zlyrv4p5C+rvNoo9ac2m/EC1MFJ4oQVq9Dw
    Li4rV5GlZ6QiK23q7lSZ7B1mgJ+olzQIgG+b8VKu3ult9ueTRroajRzrrIu7b29a673u
    yQ9Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1779473295;
    s=strato-dkim-0002; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=betYDFafZ+bYhVcjPhrToExGqoVosz3l9SGRbmrMBzo=;
    b=BPMqopYo4XFjZlDPPeUZrA20hazKEVYJSPSgKpW2NpJ/SpTkJhCiNa/u4AtIEUxJM1
    7eGmOXX9XTK07E9VNFt4KPE4fSn4f9AQ/OQ8XeVQRxTVI1aQEaQ+1VNX3im0AGLvbKMz
    Tx/re1RcYAazQGyKdo3YzP/AgBGxeN+NNrCSZQk+6eiZnFed2BuxLNNZzYJARDBWpA0j
    Y4iXmjY6qquZ3mGTQgnSado50EnsGQAnDaNR4wd6dO2cjjza7EDS9cyJt3jY4RA4VqRz
    VnKvXVr3czWr+GV7lPBTWY33DGn1JoS4ItF0QttpmfWnKQsKzzYmVLoA3rMIlRltqJwF
    szpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1779473295;
    s=strato-dkim-0003; d=hartkopp.net;
    h=Message-ID:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=betYDFafZ+bYhVcjPhrToExGqoVosz3l9SGRbmrMBzo=;
    b=sbWXWjeU+MLukR0pnmExdLRgX76OLmkFfzdf9D+sAYVkHN7i6dqVL2ZlW58WqjWP8S
    AL6w4Kci/tS4WzB3izBw==
X-RZG-AUTH: ":P2MHfkW8eP4Mre39l357AZT/I7AY/7nT2yrDxb8mjH4JKvMdQv2tTUsMrZpkO3Mw3lZ/t54cFxeFQ7s0ZDT0tksFSR+Aix0esQJVIAlZEg=="
Received: from lenov17.lan
    by smtp.strato.de (RZmta 55.0.1 AUTH)
    with ESMTPSA id Kba96d24MI8FUgx
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Fri, 22 May 2026 20:08:15 +0200 (CEST)
From: Oliver Hartkopp <socketcan@hartkopp.net>
To: linux-can@vger.kernel.org
Cc: Oliver Hartkopp <socketcan@hartkopp.net>
Subject: [PATCH v2 0/2] Fix two KCSAN issues
Date: Fri, 22 May 2026 20:07:56 +0200
Message-ID: <20260522180758.51128-1-socketcan@hartkopp.net>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="us-ascii"
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[hartkopp.net,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[hartkopp.net:s=strato-dkim-0002,hartkopp.net:s=strato-dkim-0003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-7687-lists,linux-can=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[socketcan@hartkopp.net,linux-can@vger.kernel.org];
	DKIM_TRACE(0.00)[hartkopp.net:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-can];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,hartkopp.net:mid,hartkopp.net:dkim]
X-Rspamd-Queue-Id: 532005B8EAC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Patch 1 supersedes the "add locking when updating filter and timer values"
https://patchwork.kernel.org/project/linux-can/patch/20260219-bcm_spin_lock_init-v3-2-c61026740d7b@hartkopp.net/
where the readers in softirq/timer context have not been addressed
correctly and some comment was insufficient.

Patch 2 fixed an issue that has been detected by KCSAN when I was testing
patch 1 ;-)

V2: Changed the commit message of patch 1 as suggested by the AI review.
But the review result that "The syzbot report link could not be verified."
is obviously wrong. The URL works flawlessly:
https://lore.kernel.org/linux-can/6975d5cf.a00a0220.33ccc7.0022.GAE@google.com/

Oliver Hartkopp (2):
  can: bcm: add locking when updating filter and timer values
  can: bcm: use atomic access in receive statistics

 net/can/bcm.c | 88 ++++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 69 insertions(+), 19 deletions(-)

-- 
2.53.0


