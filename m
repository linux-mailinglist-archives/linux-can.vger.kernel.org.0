Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4290B37BA24
	for <lists+linux-can@lfdr.de>; Wed, 12 May 2021 12:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230225AbhELKOP (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 12 May 2021 06:14:15 -0400
Received: from mail-il1-f200.google.com ([209.85.166.200]:47828 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbhELKON (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 12 May 2021 06:14:13 -0400
Received: by mail-il1-f200.google.com with SMTP id m18-20020a056e020df2b02901a467726f49so19151450ilj.14
        for <linux-can@vger.kernel.org>; Wed, 12 May 2021 03:13:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QsFoIF7+TXSZxLlCnFsTt3IaVFcGwD9RJbkW47UyGlA=;
        b=k5CY16q/EOhCt/pb9xCp+X9Qr9/TGSwQ6VbxJHv8gyAZ6T8/6g3V0a2rHCDvMhH8vI
         1U3AjkC7dlmEvDubbHKNce0pUK6zH30gy9zDSIS6F9lNqHbJr3yUlb++vS4B4h3ni0uN
         IVSfDK7uTU6Uw+qxaWlJ8ppOnzAJ6SfBrrnnWnOJ86g7sn09rJ7V3aANJr1F9k4ASFuk
         1qlViJK07vm0p/z8EI7aJnVmhPwMzP6f4Ol15uMLwMH1cgd4B57/GPAOTurk00qRVtP/
         I95azgkZNxDLspB+fEfY3AOotLZH+rqop+EFMQPreZGsLKcePhkIHkrHcdqhFyhgV2Ql
         TJRA==
X-Gm-Message-State: AOAM530jbV9lvI//2MUrx4aNCL8b9Ciu9C9W9amdcIpFQAQDaD2d48MO
        3c0+/uaiNSxkWtFM8OItsZgbBjWm2p+zE+ipjiJNFHL07iRr
X-Google-Smtp-Source: ABdhPJzK9DvyxlU39vr0TQCdZh91ks01LjLIzA5HtsRDNbuPVf/NBs2iiNdzZan43Z1RRmaTXl6CMdSWH9UF16deYyYIUANjpgrl
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:144f:: with SMTP id p15mr29977292ilo.143.1620814385945;
 Wed, 12 May 2021 03:13:05 -0700 (PDT)
Date:   Wed, 12 May 2021 03:13:05 -0700
In-Reply-To: <000000000000a16c4f05c21ecc1c@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b8a27f05c21f4195@google.com>
Subject: Re: [syzbot] KASAN: use-after-free Read in bcm_rx_handler
From:   syzbot <syzbot+0f7e7e5e2f4f40fa89c0@syzkaller.appspotmail.com>
To:     davem@davemloft.net, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot has bisected this issue to:

commit e057dd3fc20ffb3d7f150af46542a51b59b90127
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Date:   Mon Sep 28 20:04:04 2020 +0000

    can: add ISO 15765-2:2016 transport protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16883835d00000
start commit:   009fc857 mISDN: fix possible use-after-free in HFC_cleanup()
git tree:       net-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15883835d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=11883835d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b072be26137971e1
dashboard link: https://syzkaller.appspot.com/bug?extid=0f7e7e5e2f4f40fa89c0
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c9f9b3d00000

Reported-by: syzbot+0f7e7e5e2f4f40fa89c0@syzkaller.appspotmail.com
Fixes: e057dd3fc20f ("can: add ISO 15765-2:2016 transport protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
