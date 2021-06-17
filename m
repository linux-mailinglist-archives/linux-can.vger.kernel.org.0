Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD6D93AA863
	for <lists+linux-can@lfdr.de>; Thu, 17 Jun 2021 03:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbhFQBGr (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 16 Jun 2021 21:06:47 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:7310 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbhFQBGq (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 16 Jun 2021 21:06:46 -0400
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4G53c642QYz1BMmV;
        Thu, 17 Jun 2021 08:59:34 +0800 (CST)
Received: from dggpemm500005.china.huawei.com (7.185.36.74) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:04:36 +0800
Received: from localhost.localdomain (10.69.192.56) by
 dggpemm500005.china.huawei.com (7.185.36.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.2; Thu, 17 Jun 2021 09:04:36 +0800
From:   Yunsheng Lin <linyunsheng@huawei.com>
To:     <davem@davemloft.net>, <kuba@kernel.org>
CC:     <olteanv@gmail.com>, <ast@kernel.org>, <daniel@iogearbox.net>,
        <andriin@fb.com>, <edumazet@google.com>, <weiwan@google.com>,
        <cong.wang@bytedance.com>, <ap420073@gmail.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linuxarm@openeuler.org>, <mkl@pengutronix.de>,
        <linux-can@vger.kernel.org>, <jhs@mojatatu.com>,
        <xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
        <andrii@kernel.org>, <kafai@fb.com>, <songliubraving@fb.com>,
        <yhs@fb.com>, <john.fastabend@gmail.com>, <kpsingh@kernel.org>,
        <bpf@vger.kernel.org>, <jonas.bonn@netrounds.com>,
        <pabeni@redhat.com>, <mzhivich@akamai.com>, <johunt@akamai.com>,
        <albcamus@gmail.com>, <kehuan.feng@gmail.com>,
        <a.fatoum@pengutronix.de>, <atenart@kernel.org>,
        <alexander.duyck@gmail.com>, <hdanton@sina.com>, <jgross@suse.com>,
        <JKosina@suse.com>, <mkubecek@suse.cz>, <bjorn@kernel.org>,
        <alobakin@pm.me>
Subject: [PATCH net v2] net: sched: add barrier to ensure correct ordering for lockless qdisc
Date:   Thu, 17 Jun 2021 09:04:14 +0800
Message-ID: <1623891854-57416-1-git-send-email-linyunsheng@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.56]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm500005.china.huawei.com (7.185.36.74)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The spin_trylock() was assumed to contain the implicit
barrier needed to ensure the correct ordering between
STATE_MISSED setting/clearing and STATE_MISSED checking
in commit a90c57f2cedd ("net: sched: fix packet stuck
problem for lockless qdisc").

But it turns out that spin_trylock() only has load-acquire
semantic, for strongly-ordered system(like x86), the compiler
barrier implicitly contained in spin_trylock() seems enough
to ensure the correct ordering. But for weakly-orderly system
(like arm64), the store-release semantic is needed to ensure
the correct ordering as clear_bit() and test_bit() is store
operation, see queued_spin_lock().

So add the explicit barrier to ensure the correct ordering
for the above case.

Fixes: a90c57f2cedd ("net: sched: fix packet stuck problem for lockless qdisc")
Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
---
V2: add the missing Fixes tag.

The above ordering issue can easily cause out of order packet
problem when testing lockless qdisc bypass patchset [1] with
two iperf threads and one netdev queue in arm64 system.

1. https://lkml.org/lkml/2021/6/2/1417
---
 include/net/sch_generic.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 1e62551..5771030 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -163,6 +163,12 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		if (spin_trylock(&qdisc->seqlock))
 			goto nolock_empty;
 
+		/* Paired with smp_mb__after_atomic() to make sure
+		 * STATE_MISSED checking is synchronized with clearing
+		 * in pfifo_fast_dequeue().
+		 */
+		smp_mb__before_atomic();
+
 		/* If the MISSED flag is set, it means other thread has
 		 * set the MISSED flag before second spin_trylock(), so
 		 * we can return false here to avoid multi cpus doing
@@ -180,6 +186,12 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 		 */
 		set_bit(__QDISC_STATE_MISSED, &qdisc->state);
 
+		/* spin_trylock() only has load-acquire semantic, so use
+		 * smp_mb__after_atomic() to ensure STATE_MISSED is set
+		 * before doing the second spin_trylock().
+		 */
+		smp_mb__after_atomic();
+
 		/* Retry again in case other CPU may not see the new flag
 		 * after it releases the lock at the end of qdisc_run_end().
 		 */
-- 
2.7.4

