Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77A3DF5BCE
	for <lists+linux-can@lfdr.de>; Sat,  9 Nov 2019 00:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728265AbfKHXWE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 8 Nov 2019 18:22:04 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:40825 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727731AbfKHXWC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 8 Nov 2019 18:22:02 -0500
Received: by mail-io1-f70.google.com with SMTP id 125so6756892iou.7
        for <linux-can@vger.kernel.org>; Fri, 08 Nov 2019 15:22:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=fZBWZmhBvbt6zcf8opfeH4uRGdLcSuaPay33uvUsov8=;
        b=Y/e0HNZ2Yy4b2iTuh/YO0kHiPTxwKYWJhHfmoc2ztQJPQJxKWrmOlZ1nevRiD9iA7M
         eR37MWYVY7V1vdIdok7y4TAOuw3CZJgG9DmJrftQpOHcDM4VZ/QJdEU30nXiasSoYWoV
         tX2eoitKyaPuoC3wQoikG9SgcekgzDTIH5KxnWjQddViiFQta6rJAowDF9jZGaVuHij3
         c0hE2vFBhIZQwqjYBU4tIx2UwXRMl+yIeTgmocnQUu/QbLdXUEplIYqlkFJB+qnq9Beb
         HzulgoD12pIDnUQRFyIuFu4p7NFj9GR3ggPZATZDvWq2peTMFOLm51rNSHwyCtlWMvm5
         HdKA==
X-Gm-Message-State: APjAAAVLcQKkrBNgihyOBKJyEy6iOKNnjTmXuTuQMDNmpc9UCf1fwtBN
        iLsUoHR+Yl8Edil7FY+wiSDp+5pVwX6OdTyllqi0ht1r4P10
X-Google-Smtp-Source: APXvYqxXK+B0noGMchCiLhdOqlZkZLD11zQO6N8pxV4Mx78bt78T6dhHXUrD3Fbmsm2Qj/LYzrfMK2p60Ns7ZEMWeqS+vpidEYKD
MIME-Version: 1.0
X-Received: by 2002:a92:9e4c:: with SMTP id q73mr15670936ili.53.1573255320305;
 Fri, 08 Nov 2019 15:22:00 -0800 (PST)
Date:   Fri, 08 Nov 2019 15:22:00 -0800
In-Reply-To: <0000000000006264c60596d8c5fa@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008207e30596de0cf3@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_deactivate
From:   syzbot <syzbot+a47537d3964ef6c874e1@syzkaller.appspotmail.com>
To:     bst@pengutronix.de, davem@davemloft.net,
        dev.kurt@vandijck-laurijssen.be, ecathinds@gmail.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        lkp@intel.com, maxime.jayat@mobile-devices.fr, mkl@pengutronix.de,
        netdev@vger.kernel.org, o.rempel@pengutronix.de, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot has bisected this bug to:

commit 9d71dd0c70099914fcd063135da3c580865e924c
Author: The j1939 authors <linux-can@vger.kernel.org>
Date:   Mon Oct 8 09:48:36 2018 +0000

     can: add support of SAE J1939 protocol

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17325552e00000
start commit:   847120f8 Merge branch 'for-linus' of git://git.kernel.org/..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14b25552e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10b25552e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=a47537d3964ef6c874e1
userspace arch: i386
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164973b4e00000

Reported-by: syzbot+a47537d3964ef6c874e1@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
