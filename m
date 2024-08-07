Return-Path: <linux-can+bounces-1172-lists+linux-can=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F28F694B36A
	for <lists+linux-can@lfdr.de>; Thu,  8 Aug 2024 01:12:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B20F12828E8
	for <lists+linux-can@lfdr.de>; Wed,  7 Aug 2024 23:12:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44870155322;
	Wed,  7 Aug 2024 23:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="NQ+lNwEj"
X-Original-To: linux-can@vger.kernel.org
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D511509A5;
	Wed,  7 Aug 2024 23:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723072322; cv=none; b=RGkdYQrO3ENCBPvVnozbBqHMLnUGKvTo63jaCC7bWfuJ/zBw2EpwNNhnBRmrzVs2HMqF/1tJ3ZR2E4MH41WHziDPp7sgKyssDYEyOXwIbufVnQ/Sl1JXhMQ7ZsMQeJ1wIYYQje104ADr4GL1j6rhy3ZNwexWRiSFq+Z38EKZAV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723072322; c=relaxed/simple;
	bh=mmEQt4WLPvu1Q6AjOhQsDjmILJgncsyY4a/depz6Jr4=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=eoAbXoapUwdsBZ3Mpt9LPR9ifSjqNhy3wl57bOInLpmrN2lleV2qyWYTWve2yssijkIWs91f7PizAVHT/pFBorkLHzCJ4xWzM5B/4sCPTMTYStQ8VljX+bMw4bP3y7SvYcp6CKWZDzans358BUn09KInOhvARqClx2Up6MTBm3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=NQ+lNwEj; arc=none smtp.client-ip=162.62.57.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1723072013; bh=YfgS1SOKBc6BkxAyhWP7vMJVEPZCK6J/CiIBhINzIAY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NQ+lNwEjhe1CteIS4mqCIbYEycTE+5BxjIg9CZ0DPoj33aMSEllzt08Dg+G8FProv
	 51DTOF53ta1DkMduiEvuIOexb/h7OktTBOJwJCKCfY0mCl0Hxp1srg3LOL60e9zEjg
	 XWBjQtrjZ1HFm6p3ZtYcwVWmHVuvk36jArlAoiKU=
Received: from pek-lxu-l1.wrs.com ([111.198.225.4])
	by newxmesmtplogicsvrszb9-1.qq.com (NewEsmtp) with SMTP
	id 1B0B88A3; Thu, 08 Aug 2024 07:06:48 +0800
X-QQ-mid: xmsmtpt1723072008tza6m1i5m
Message-ID: <tencent_91A42CC56E749550E926ED26CE0C78A26F0A@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uizFEc16KZAMm3J790h8RsmN+sb/uxy8sVMn0nkMJMSs0TSg4CL
	 Efg1wOMGQJPEmEgoN6Wly+Qni0L43YHUre9MZKDXNBqK+dW/ufDYaO+t4bsL1id9OoErSbCwMjUQ
	 ORd/UdVVwQNLtlcqPAkcKXoswa2dn4XBIYaeirKfAZu17UzqpX78dhGJ94U96q+rF6SO7D/+h36X
	 Zld8fFQ2Mdk6dlv5FwoYuWSghOIsUOCuJ3ELXauwG7woMyhMjAZ3Hg4zXGDlTnFDsQZbXKaXU/lj
	 T/j2iq6NFFSrM9iy53Sw7mehKaoCP+wHq3YRQ7q9qazP93Rtp8DXB29sLNRFFR0qhsnSrzErBOfW
	 aeXv0MzxpGoMPlGlBzIRz6LifCh5fmhydqcPkdndzloqc7oKtZBXHLfxtFxZWhn2CmJrMaJOiMWM
	 TGf9rwBynp0xQPbz5QU2puaMD8Cd2ONIHHpQRSH4WQvSEjCaSFalyBzO/pIljCaQNqUFqkI19Ooq
	 h/YCJFIdybRHEiau1LDtVUF1Htuq9wZ06MWqX+yYYdTjZmIofold14YG4Q7QrVKjqhRGk8TTuqQr
	 hzG5wB5wIxNhjVWuKvUeXwgYuPvpHNdD006kaSgkQX4QOA7g5bWpeSPbCgmWeDxwha2YLRlXhVWc
	 L3QlQZjwsm72Adfxe3O1d4l/7w0LW4YBiDSftRmYGaW4/WQonwPE9H48lpUxgi9dqUIzgUD3Qw1F
	 mj7vu/girtvD4vg2pV/ULiuAjocVvGJ220tfgNrvUOsf1ZtbWVS/EgGGyfsQHPPDW9DFIO1q2hp8
	 QPFm0/hVVbuDhvGLNICXslFR5C+LizqMazRB/P0Dawb6B3LYGOjbbM7bi9MNxnGXNHAhgheLPv9J
	 5l7Pvv82wtvhE5+u9ZW40zCXp5hYo0PtAf4F3zv3epqh7qhZs/E4130pkv7NTb6ZGKBlz7YUNz/F
	 nfbe/S1Xl7GRGuWCW2C5H+rqkQWtXlhH6Te0BnHx8=
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
From: Edward Adam Davis <eadavis@qq.com>
To: leitao@debian.org
Cc: davem@davemloft.net,
	eadavis@qq.com,
	edumazet@google.com,
	kernel@pengutronix.de,
	kuba@kernel.org,
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
Subject: Re: [syzbot] [can?] WARNING: refcount bug in j1939_session_put
Date: Thu,  8 Aug 2024 07:06:48 +0800
X-OQ-MSGID: <20240807230647.592287-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZrMqFN4vE7WHRBjE@gmail.com>
References: <ZrMqFN4vE7WHRBjE@gmail.com>
Precedence: bulk
X-Mailing-List: linux-can@vger.kernel.org
List-Id: <linux-can.vger.kernel.org>
List-Subscribe: <mailto:linux-can+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-can+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 7 Aug 2024 01:02:28 -0700, Breno Leitao wrote:
> > Fixes: c9c0ee5f20c5 ("net: skbuff: Skip early return in skb_unref when debugging")
> >
> > Root cause: In commit c9c0ee5f20c5, There are following rules:
> > In debug builds (CONFIG_DEBUG_NET set), the reference count is always  decremented, even when it's 1
> 
> That is the goal, to pick problems like the one reported here. I.e, the
> reference shouldn't be negative. If that is the case, it means that
> there is a bug, and the skb is being unreferenced more than what it
> needs to.
Got it, I will remove the Fixes tag.
> 
> > This rule will cause the reference count to be 0 after calling skc_unref,
> > which will affect the release of skb.
> >
> > The solution I have proposed is:
> > Before releasing the SKB during session destroy, check the CONFIG_DEBUG_NET
> > and skb_unref return values to avoid reference count errors caused by a
> > reference count of 0 when releasing the SKB.
> 
> I am not sure this is the best approach. I would sugest finding where
> the skb is being unreferenced first, so, it doesn't need to be
> unreferenced again.
> 
> This suggestion is basically working around the findings.

BR,
--
Edward


