Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5384396C8F
	for <lists+linux-can@lfdr.de>; Tue,  1 Jun 2021 07:00:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232635AbhFAFBz (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 1 Jun 2021 01:01:55 -0400
Received: from mail-il1-f198.google.com ([209.85.166.198]:40947 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhFAFBv (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 1 Jun 2021 01:01:51 -0400
Received: by mail-il1-f198.google.com with SMTP id b4-20020a920b040000b02901dc81bf7e72so4057345ilf.7
        for <linux-can@vger.kernel.org>; Mon, 31 May 2021 22:00:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=HZoCrhifvFqebweO5oM8sTQXrnYAq0UL7ZIrots2vSc=;
        b=M+uAj0H1hJ0/e9UgFx4Y3iT8pZmTzmM4zeHBnHsiLxNs0zhVKO879cqWCtpcnjDShW
         uX+QJWGSbgb8bAZFgIf59nuPOdBfUElGDvQKm4TeHh0lpcFqPW+Y7Nz8jwlK6xNPly/d
         us7JKH2RQXeBk/jwzuaCCFH5fm7oYVV7hEPCLcPvev+jR/Dfw44M0iO8IKJXVFZ85aE7
         konBNdF4glwaWS7EokEVi/0h7Rq1MaY+MQjsd0eDNwVuxAHWY/0HyEt01D/OYI5utqlf
         A4Fs42J1dtbK5PIVHj2/th6C+qtrUgkN/W6fXzyenFAHHbsR1Yi7Cw+Q3wefonKu+kJq
         NUYw==
X-Gm-Message-State: AOAM5309y/UJFbqNbG7SpV5lea6N54SJR2yqWYQbwAukezva0WzMli5v
        FQZpsnrvxi3XUu4f8ex73oN16fC/1LiNenyzytbSrwoVpu/M
X-Google-Smtp-Source: ABdhPJyDPqVeQwFPYxvwDFNm5lVzsEmrtB9fOyxrUNzo2mPUK0UzLNL7BZ0jpoGpdR7H0zY1Wl5YoHHlpd3CmiPaYpmOLCQaOLqA
MIME-Version: 1.0
X-Received: by 2002:a92:d201:: with SMTP id y1mr19795884ily.103.1622523610124;
 Mon, 31 May 2021 22:00:10 -0700 (PDT)
Date:   Mon, 31 May 2021 22:00:10 -0700
In-Reply-To: <000000000000f32b3c05958ed0eb@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006bd5ff05c3ad37da@google.com>
Subject: Re: [syzbot] INFO: task hung in register_netdevice_notifier (2)
From:   syzbot <syzbot+355f8edb2ff45d5f95fa@syzkaller.appspotmail.com>
To:     a@unstable.cc, ast@kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
        bpf@vger.kernel.org, brouer@redhat.com, daniel@iogearbox.net,
        davem@davemloft.net, hawk@kernel.org, jakub.kicinski@netronome.com,
        john.fastabend@gmail.com, kafai@fb.com, kuba@kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        mareklindner@neomailbox.ch, mkl@pengutronix.de,
        netdev@vger.kernel.org, socketcan@hartkopp.net,
        songliubraving@fb.com, sw@simonwunderlich.de,
        syzkaller-bugs@googlegroups.com, xdp-newbies@vger.kernel.org,
        yhs@fb.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot has bisected this issue to:

commit 6bf071bf09d4b2ff3ee8783531e2ce814f0870cb
Author: Jesper Dangaard Brouer <brouer@redhat.com>
Date:   Tue Jun 18 13:05:27 2019 +0000

    xdp: page_pool related fix to cpumap

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1397c4a7d00000
start commit:   7ac3a1c1 Merge tag 'mtd/fixes-for-5.13-rc4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1057c4a7d00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1797c4a7d00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=266cda122a0b56c
dashboard link: https://syzkaller.appspot.com/bug?extid=355f8edb2ff45d5f95fa
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cc630fd00000

Reported-by: syzbot+355f8edb2ff45d5f95fa@syzkaller.appspotmail.com
Fixes: 6bf071bf09d4 ("xdp: page_pool related fix to cpumap")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
