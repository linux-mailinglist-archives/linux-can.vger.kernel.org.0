Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63E545D675
	for <lists+linux-can@lfdr.de>; Thu, 25 Nov 2021 09:49:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350939AbhKYIwU (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 25 Nov 2021 03:52:20 -0500
Received: from mail.zju.edu.cn ([61.164.42.155]:16260 "EHLO zju.edu.cn"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1353318AbhKYIuT (ORCPT <rfc822;linux-can@vger.kernel.org>);
        Thu, 25 Nov 2021 03:50:19 -0500
Received: from localhost.localdomain (unknown [222.205.2.245])
        by mail-app3 (Coremail) with SMTP id cC_KCgCXD1ODTZ9hJoLRCA--.33875S4;
        Thu, 25 Nov 2021 16:46:59 +0800 (CST)
From:   Lin Ma <linma@zju.edu.cn>
To:     linux-can@vger.kernel.org
Cc:     socketcan@hartkopp.net, mkl@pengutronix.de, davem@davemloft.net,
        kuba@kernel.org, Lin Ma <linma@zju.edu.cn>
Subject: [PATCH v0] can: raw: supplement the check to prevent the NPD
Date:   Thu, 25 Nov 2021 16:46:55 +0800
Message-Id: <20211125084655.16974-1-linma@zju.edu.cn>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cC_KCgCXD1ODTZ9hJoLRCA--.33875S4
X-Coremail-Antispam: 1UD129KBjvJXoW7KF1rWFWUZrWUJryrWry3urg_yoW8GFW8pr
        Waka1UJr4kGa47KanrGr40kay3tFyDArs09F9IgFyfXwn8CFy5Ga9aka429wnxCrnxJrWY
        qr1jga4UZ3WDJaDanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUvj1xkIjI8I6I8E6xAIw20EY4v20xvaj40_Wr0E3s1l1IIY67AE
        w4v_Jr0_Jr4l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2
        IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW0oVCq3wA2z4x0Y4vEx4A2
        jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
        x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUJVWU
        GwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI4
        8JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY02Avz4vE14v_GFyl42xK82IYc2Ij64vIr41l
        42xK82IY6x8ErcxFaVAv8VW8uw4UJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
        8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWU
        twCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
        0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
        Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUeH
        UDDUUUU
X-CM-SenderInfo: qtrwiiyqvtljo62m3hxhgxhubq/
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

The CAN_RAW_FILTER command allows the user to pass optlen as value 0. It
is expected to clear out the filer

static int raw_setsockopt(...) {
  struct can_filter *filter = NULL;
  ...
  // count = 0 if optlen = 0
  count = optlen / sizeof(struct can_filter);
  ...
  ro->filter = filter;
  ro->count  = count;
  ...
}

However, if this sock is bound to a device, bad thing happens as the
current check is failed to prevent the NULL Pointer Dereference.

static int raw_setsockopt(...) {
  ...
  if (ro->bound) {
    /* (try to) register the new filters */
    if (count == 1)
      err = raw_enable_filters(sock_net(sk), dev, sk,
                               &sfilter, 1);
    else
      // count = 0 can enter here while filter = NULL
      // which is unexpected
      err = raw_enable_filters(sock_net(sk), dev, sk,
                               filter, count);
  ...
}

This patch supplements the comparison with additional check.

Fixes: commit c18ce101f2e4 ("[CAN]: Add raw protocol")
Signed-off-by: Lin Ma <linma@zju.edu.cn>
---
 net/can/raw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/can/raw.c b/net/can/raw.c
index 7105fa4824e4..590df2da081c 100644
--- a/net/can/raw.c
+++ b/net/can/raw.c
@@ -564,7 +564,7 @@ static int raw_setsockopt(struct socket *sock, int level, int optname,
 			if (count == 1)
 				err = raw_enable_filters(sock_net(sk), dev, sk,
 							 &sfilter, 1);
-			else
+			else if (count > 1)
 				err = raw_enable_filters(sock_net(sk), dev, sk,
 							 filter, count);
 			if (err) {
-- 
2.33.1

