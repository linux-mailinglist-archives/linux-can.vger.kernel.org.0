Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B8AC37772D
	for <lists+linux-can@lfdr.de>; Sun,  9 May 2021 17:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbhEIPRM (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 9 May 2021 11:17:12 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:42550 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229672AbhEIPRL (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 9 May 2021 11:17:11 -0400
Received: by mail-il1-f200.google.com with SMTP id d3-20020a9287430000b0290181f7671fa1so11697640ilm.9
        for <linux-can@vger.kernel.org>; Sun, 09 May 2021 08:16:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ptj/dJVyElDcDR4dlhXEYGbK7nkar7mLZG2Y7a4j/mk=;
        b=YxPkNG3sc2HY/ycF4dV8971sWhJSO68kF/pvxLQ05h+nzEc2menZxfDvgtOvpz07Cq
         CKGX9Prfn8V6pC0dltAf4AxiJtpthSKHszkriLwzh8PWopuc4y8uCXHL+WXxoSeuc5rc
         jkLtfLCX8c0UxJxGbcZmsipbRzmCd2JkBY1WcTUze51me+jJp0wvK8Fkg29pMU8DLvUF
         kjYm6gUD74vp3bA66pEtdLvVcyiMyyIeMaQwbkdQvKWODTznrzcXeKtzLr3cEhLHvDQp
         8APZ01oNszyHb+lMBQsdEUeXo6dJRVvk9dDkXiYwyIyGobpzAymhS5piubd0FT/j4m8p
         GB0Q==
X-Gm-Message-State: AOAM533IdW2jNxBOwRgJ6mzyc3SCHJyWVaeYVLv4xo7plmPWgIZmvwIc
        A0dDSiTMKmbQYtDSGoy5L1xxoVO0PBcBrHzyhzS9MUn2+YO8
X-Google-Smtp-Source: ABdhPJyJwGwIL1loYhchZjvnNXd4eyMCeUirhmBOuDgssB8pUDt9169y2A7L98/9mTHVSC/CagAOsT8bOf+hALkYwWJBC7G5uvBO
MIME-Version: 1.0
X-Received: by 2002:a6b:dc16:: with SMTP id s22mr14878581ioc.170.1620573367415;
 Sun, 09 May 2021 08:16:07 -0700 (PDT)
Date:   Sun, 09 May 2021 08:16:07 -0700
In-Reply-To: <0000000000009f94c1057e772431@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e5b92105c1e723d5@google.com>
Subject: Re: [syzbot] WARNING in hsr_forward_skb
From:   syzbot <syzbot+fdce8f2a8903f3ba0e6b@syzkaller.appspotmail.com>
To:     arvid.brodin@alten.se, axboe@fb.com, axboe@kernel.dk,
        davem@davemloft.net, dvyukov@google.com, edumazet@google.com,
        hch@lst.de, kuba@kernel.org, kurt@linutronix.de,
        linux-block@vger.kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, m-karicheri2@ti.com,
        ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit 9d6803921a16f4d768dc41a75375629828f4d91e
Author: Kurt Kanzenbach <kurt@linutronix.de>
Date:   Tue Apr 6 07:35:09 2021 +0000

    net: hsr: Reset MAC header for Tx path

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=119c7fedd00000
start commit:   3af409ca net: enetc: fix destroyed phylink dereference dur..
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=8cb23303ddb9411f
dashboard link: https://syzkaller.appspot.com/bug?extid=fdce8f2a8903f3ba0e6b
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1525467ad00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114c0b12d00000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: net: hsr: Reset MAC header for Tx path

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
