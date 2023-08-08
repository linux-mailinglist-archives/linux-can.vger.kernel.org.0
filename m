Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F31C7773E8D
	for <lists+linux-can@lfdr.de>; Tue,  8 Aug 2023 18:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjHHQcS (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 8 Aug 2023 12:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232919AbjHHQbB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 8 Aug 2023 12:31:01 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C924413950
        for <linux-can@vger.kernel.org>; Tue,  8 Aug 2023 08:51:39 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6bb31e13a13so10350034a34.1
        for <linux-can@vger.kernel.org>; Tue, 08 Aug 2023 08:51:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691509861; x=1692114661;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=try7kLiqOvWBbDWNv3AsjzJNZ1pHNvllo2yNmM+PfCo=;
        b=fdadulK4vJRVRz9B6U67CZthbN9RzJ6ZCyYuHEeHsTsSnJHv6qERMbepPb54gQhQ5T
         +EESVqyyoGFaGl388k/iWIl3MLa1APlLqq3LP/CEQNlkggYA4He1d/OGDWdmMgRSLI7F
         e+2LJ6EvhpN1ZijexlsIGrg2rungfJlbJJMSz6F7kmNsBex51kF2SjzRSvKNNnAA4/cE
         zbSpovn2ecjvfEhe2+fZ4mX7gHDz9nXVKlr7czIfqSV1uqVG3CxcLfgp2kHLsLezbnD+
         gSSHEkTBxIo6rH71o1wNh1rkNA5Kg7isD6sw7ACpHuJnluAyOhvqEr8aPdSq7mG/ZYoD
         4XRw==
X-Gm-Message-State: AOJu0Yzs3htsPNV77pgiuFy4AoK1lrjaE1l271C1t9h5mizMAQm3bxLj
        LhqckE2Xa10kY3AL5DwgKMsEOXf4WQpEd1zSFHvgU7yXiHWX
X-Google-Smtp-Source: AGHT+IHVxzz7rv3Yc6Ex9nVZyfccRlIl4YuPHqh33kxidSRG2ZsY/cJC8dt7jVr/W6xkY4FX1aCJajbFNScBQQQ0cLLlU2M2U+jQ
MIME-Version: 1.0
X-Received: by 2002:a05:6870:c794:b0:1ba:7bf5:67cd with SMTP id
 dy20-20020a056870c79400b001ba7bf567cdmr16115130oab.11.1691502890465; Tue, 08
 Aug 2023 06:54:50 -0700 (PDT)
Date:   Tue, 08 Aug 2023 06:54:50 -0700
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ec3e1f060269b476@google.com>
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
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
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
