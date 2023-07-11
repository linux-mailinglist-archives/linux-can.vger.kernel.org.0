Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E58B674F0B8
	for <lists+linux-can@lfdr.de>; Tue, 11 Jul 2023 15:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbjGKNxh (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jul 2023 09:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjGKNxh (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jul 2023 09:53:37 -0400
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com [209.85.167.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A7A9CA
        for <linux-can@vger.kernel.org>; Tue, 11 Jul 2023 06:53:35 -0700 (PDT)
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-39cdf9f9d10so3877679b6e.3
        for <linux-can@vger.kernel.org>; Tue, 11 Jul 2023 06:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689083615; x=1691675615;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gCTVwmB5J6a5dx6XYxqF53hqOsGWkSYIyrPo76Icn50=;
        b=FMZDO6tLyttOzgRQ8WHVRnfKBwr89QMjb8TDCUwuSJsGMNGKRacNVwnmQNYHTUlye9
         Yyfs8zX7L34KA9Q6ZIpxQaTK0lPGN9GFrFsf3p0hn0aKDe3Y/QvRp9+ZuWPPhUfIbXnq
         qNv5GuyV2yckXo9JQHyDqcrtsPTD+T3+yPJWu/uSaeb0+3aqorxsOTqh+sVzfWF7wtay
         OP1SIUHuXEUPvltX9uTIojN9wqFmarGamwPLw534ywE+7n8odP1wCBXcryS3Nxzyq8vM
         v2CcnryhI3+Y5djBVqLaV2Iffxo3t9QXL8dHnCcypptqmZmH9vWH2ug3IJ4fZxLrnaPy
         daYg==
X-Gm-Message-State: ABy/qLbwtOQ5ds2gzbrinuMpgHwDIp8Ud939SUMsIq2ude8Ufi9d/8Mp
        TWC72cYxid11ViwDn4vDlkph3Ne6GHPHLca1QjQNSUBWLhTB
X-Google-Smtp-Source: APBJJlECruf66V+JyRtf/KQM/NOn3dy9C/Lb8k9+y2hASr80eBt7evZQjebFhxPNCMT+nnvVQAppHWH3WgcG/RDwIiq/YDiQySGh
MIME-Version: 1.0
X-Received: by 2002:aca:db54:0:b0:3a2:214d:3da9 with SMTP id
 s81-20020acadb54000000b003a2214d3da9mr1601278oig.10.1689083614942; Tue, 11
 Jul 2023 06:53:34 -0700 (PDT)
Date:   Tue, 11 Jul 2023 06:53:34 -0700
In-Reply-To: <000000000000de1eec059692c021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000dd5c040600366c6f@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Write in j1939_sock_pending_del
From:   syzbot <syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, dania@coconnect-ltd.com, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, nogikh@google.com, o.rempel@pengutronix.de,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
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
can: j1939: socket: rework socket locking for

But I can't find it in the tested trees[1] for more than 90 days.
Is it a correct commit? Please update it by replying:

#syz fix: exact-commit-title

Until then the bug is still considered open and new crashes with
the same signature are ignored.

Kernel: Linux
Dashboard link: https://syzkaller.appspot.com/bug?extid=07bb74aeafc88ba7d5b4

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
