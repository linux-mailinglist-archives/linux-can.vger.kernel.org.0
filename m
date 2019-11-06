Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18C39F0C2E
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 03:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730756AbfKFCnC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 21:43:02 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:41654 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730562AbfKFCnC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 21:43:02 -0500
Received: by mail-il1-f200.google.com with SMTP id o185so20284824ila.8
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2019 18:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=uSWnjSO8aRmC6HOtbozEviyKgrIraDFwwf90scm40l0=;
        b=kvT5OfgJvXL819DRCSVwVnMXGuimP6yQawDhMHzZyem8RiRO9yiu9k972Qm0g+ZRoV
         VmreQpVlTyQ1yLtDBn6knJi1nGZzk8XMvYFqPaW4RjoPz/eHjVc50nTyjG7aBewVfDom
         fNJ+BTRvUhSWmHbaHmJWIFYnHckr0z7tfut7XvFNjAA501XC33O5HTuXF1CNFP7nFUbc
         KmxzcOBEPenbvaKiZHvRksuZbMW/Hn1js6jHN0EnUdQuj89znp5LaDhjGvXYcthmtdxy
         zRyf8VEs5IPjWxi8B3RhMbJ8H/CYIS+myIent7+n+Izo3iUD9RLmS6E8bdxZRFFz+Zrg
         o02w==
X-Gm-Message-State: APjAAAUjzIsC6cx77O6TvOVeYgBV1GSbd0JwhZnL1Hzc/hCljpa4Si6V
        2U3t66iUkkHgQyF2G+qmPnCMlDWyPCBHCIghc7XRd9TMxnn6
X-Google-Smtp-Source: APXvYqxWaexPBXY5jrl37JvvcUZAaVp3KXSs+h0t1RYE4hSK4+O06OdivMpHLxC+8f80DUzb4Mq0EMSAeFKl27IKU5J4/7z8BlIP
MIME-Version: 1.0
X-Received: by 2002:a92:ce42:: with SMTP id a2mr235457ilr.69.1573008181583;
 Tue, 05 Nov 2019 18:43:01 -0800 (PST)
Date:   Tue, 05 Nov 2019 18:43:01 -0800
In-Reply-To: <0000000000005ed7710596937e86@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e46daf0596a48179@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_xtp_rx_abort_one
From:   syzbot <syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1157fb1ae00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1357fb1ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1557fb1ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=db4869ba599c0de9b13e
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1435c078e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=139a3542e00000

Reported-by: syzbot+db4869ba599c0de9b13e@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
