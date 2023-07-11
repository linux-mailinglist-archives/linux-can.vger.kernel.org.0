Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6403F74F0B1
	for <lists+linux-can@lfdr.de>; Tue, 11 Jul 2023 15:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231589AbjGKNwj (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jul 2023 09:52:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjGKNwg (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jul 2023 09:52:36 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AC6199
        for <linux-can@vger.kernel.org>; Tue, 11 Jul 2023 06:52:35 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3a1c2d69709so5064955b6e.1
        for <linux-can@vger.kernel.org>; Tue, 11 Jul 2023 06:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083555; x=1691675555;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=try7kLiqOvWBbDWNv3AsjzJNZ1pHNvllo2yNmM+PfCo=;
        b=BblO4TOAulmGSRCd5h6rsXWmLOG18wHqgPn37UfrIwKfYboDyoB9YePHP2SlIao9fR
         4Oa5k7gQ1zii4qZmQryBm1OzNPVDV63l8VuSRQZHOCUjhxVh+9+wdlXZfpZf4pvHlvb9
         XHA1JVroSiFErSzPo6LencPcFOKM6fIaMWsjaZouUVEt+V66DQjhF03yCsG/jpSuYrT7
         tjH7xM0pQVtp0Q6x5lMYi+TnnuGTVl/jJsYx5aD7nQBTLkuMyipRVH8JfuCpHF8t5/hm
         Q5DTiuwulIB7NKuzKTLf10da/Y8eRLyWQ+4L1C6fWaCi/hL8l/OiV0fI/FxWtVMpNUu4
         Dl+g==
X-Gm-Message-State: ABy/qLYj19yKDgbU32ltUCefh+uznLkwoArOVInq5U2Aii0Aun/n2nb1
        U977Wh/uKWTgdnDCrwzKigKFYlV+ugu6IpYruyNPhQW40hYH
X-Google-Smtp-Source: APBJJlGDsG+nOMkSJbLXJKRNGNJfHOn13Ov445zenjdwf+cSdHKoP10U8UttX2mqO6muw59vtWRMSKpRyJ6QOj+P2/CyrzrHnT/T
MIME-Version: 1.0
X-Received: by 2002:aca:bd03:0:b0:3a3:a8d1:1aa1 with SMTP id
 n3-20020acabd03000000b003a3a8d11aa1mr1493645oif.2.1689083554789; Tue, 11 Jul
 2023 06:52:34 -0700 (PDT)
Date:   Tue, 11 Jul 2023 06:52:34 -0700
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000477efc0600366975@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in j1939_session_get_by_addr
From:   syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To:     Jose.Abreu@synopsys.com, arvid.brodin@alten.se,
        davem@davemloft.net, dvyukov@google.com,
        ilias.apalodimas@linaro.org, joabreu@synopsys.com,
        jose.abreu@synopsys.com, kernel@pengutronix.de,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@rempel-privat.de, mkl@pengutronix.de, netdev@vger.kernel.org,
        nogikh@google.com, robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, tonymarislogistics@yandex.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8

---
[1] I expect the commit to be present in:

1. for-kernelci branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git

2. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf-next.git

3. master branch of
git://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git

4. main branch of
git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git

The full list of 9 trees can be found at
https://syzkaller.appspot.com/upstream/repos
