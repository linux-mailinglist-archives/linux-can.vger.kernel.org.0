Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 991A97E26ED
	for <lists+linux-can@lfdr.de>; Mon,  6 Nov 2023 15:35:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230514AbjKFOfT (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 6 Nov 2023 09:35:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbjKFOfS (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 6 Nov 2023 09:35:18 -0500
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com [209.85.167.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6681BBD
        for <linux-can@vger.kernel.org>; Mon,  6 Nov 2023 06:35:14 -0800 (PST)
Received: by mail-oi1-f199.google.com with SMTP id 5614622812f47-3b3f5a58408so6376910b6e.1
        for <linux-can@vger.kernel.org>; Mon, 06 Nov 2023 06:35:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699281313; x=1699886113;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7LnU8RknCJWsPsqm7RXDpRlRmyk9PFdTymemdD1BB0=;
        b=UCBZayKzhC2kZ7l5z4apbeR5AngmWqi+EUsE/z4+luP2Wyrc+4POY/MV/OEPe8NLiY
         Uk76PtlHGlYEgNCYLfgxk2SzLUutkU1mwwt9Bg8KLIAsgUZX5U0sEuyqczVYAORvJnpe
         +uC8gR5Kmq0GR1KL6VuMsJ96JMne+Z0MLpowOrNkyll8MFJQbHJv14X+xxyy6bMs3kXh
         il5jKtDQIlziMR4nwYsCn1Ju0MZokZf+jiHvdFAaT0dYeGu58aiVsfjSlirh34u23gqa
         9pI5GLZBZGZvPvV07D7FXN5/aCGcaXxdr9v1zTIrDC7E8ePmW/y0t7+RopwgEuT+xupI
         UreA==
X-Gm-Message-State: AOJu0YzcXMJzOIHAfZm6I6JFyWOFIaNBsi0I1VbxQvGa+c3gPrUyZeGv
        KIBNNOB3UpARaHFWehwXAtEgv5LgBdNJc7nWlysc+x5ciEH2
X-Google-Smtp-Source: AGHT+IG/iI7FGWxO+tIpvDf57ygCjJyDFzHjpMxa+/pfuXhy/dTLktmDyG1XISzkLZn+1eHOTDmwVx+MQOuQC26hlSzHq7GEN+jT
MIME-Version: 1.0
X-Received: by 2002:a05:6808:23c1:b0:3a9:d030:5023 with SMTP id
 bq1-20020a05680823c100b003a9d0305023mr12427060oib.3.1699281313820; Mon, 06
 Nov 2023 06:35:13 -0800 (PST)
Date:   Mon, 06 Nov 2023 06:35:13 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001579a706097cc3c9@google.com>
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
X-Spam-Status: No, score=2.3 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        RCVD_IN_SORBS_WEB,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

This bug is marked as fixed by commit:
can: j1939: transport: make sure the aborted session will be deactivated only once

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
