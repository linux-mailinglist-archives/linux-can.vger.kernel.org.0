Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 524EC74FC85
	for <lists+linux-can@lfdr.de>; Wed, 12 Jul 2023 03:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjGLBQ2 (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 11 Jul 2023 21:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjGLBQ2 (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 11 Jul 2023 21:16:28 -0400
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com [209.85.210.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8DA1717
        for <linux-can@vger.kernel.org>; Tue, 11 Jul 2023 18:16:26 -0700 (PDT)
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-6b8c415fdd3so478723a34.1
        for <linux-can@vger.kernel.org>; Tue, 11 Jul 2023 18:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689124586; x=1691716586;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HVCDywhHpMOGTFqG/gDYk0S45lUTl1W6WhYjBIpoNpw=;
        b=XtBY8TRHtiNHK22Wpt60OTQ03x4/PR9p3UyDdooqBhnhWQMyK8H8ykKBUQS6/+jOo4
         0hqPUlhlGTfD7sRRljvrlhLfGPyFRpIo63javCxcOKxdaQJa+WaumNBI4oDucKrndF/X
         wTIoDeTlMwjjPPoKQoMrmuXMSxLjQ10TqAa8ICCIDIR+pLYQW8mDxaIXs0ULbeEN+oVy
         GUNOmVtHAOcS71uV9LT5ogNqgJCgEaB9eyN4TIZ1rnWpEOeKYBqhVuDMAl0gnSR7k6AI
         Zbm9h6Jc2ZYtqroVQUXsVb79GoAHC0WgKD1McP2NC2RsEUsfv+X1Iq7gBlitTxXnxiVs
         pWKg==
X-Gm-Message-State: ABy/qLZenoUUfLzoki/FGQ3wfO8nv7kcTVxv/QPf0dKKlF7j8xCnUbMP
        nNLfuHZ8qDIcmNrevyM4RjXxa564IFLJHxxZm6LmI0Ww6NSq
X-Google-Smtp-Source: APBJJlEfdPeTrhOct9RIcxFE/RE/xuq9yIIGgVNHdByqdXJPK44xyvBuBojGYPkI1HcFu3nt3m+tr7yZqNEffrD+pg4iJnyU9rQU
MIME-Version: 1.0
X-Received: by 2002:a05:6830:4524:b0:6b8:70f3:fd36 with SMTP id
 i36-20020a056830452400b006b870f3fd36mr712756otv.2.1689124586175; Tue, 11 Jul
 2023 18:16:26 -0700 (PDT)
Date:   Tue, 11 Jul 2023 18:16:26 -0700
In-Reply-To: <20230712004750.2476-1-astrajoan@yahoo.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f0c50706003ff6f3@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_sk_errqueue (2)
From:   syzbot <syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com>
To:     astrajoan@yahoo.com, davem@davemloft.net, dvyukov@google.com,
        edumazet@google.com, ivan.orlov0322@gmail.com,
        kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org,
        o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl,
        skhan@linuxfoundation.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, syzkaller@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+1591462f226d9cbf0564@syzkaller.appspotmail.com

Tested on:

commit:         3f01e9fe Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
console output: https://syzkaller.appspot.com/x/log.txt?x=130a98a2a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4c2acb092ca90577
dashboard link: https://syzkaller.appspot.com/bug?extid=1591462f226d9cbf0564
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1380a782a80000

Note: testing is done by a robot and is best-effort only.
