Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E303FEFC9E
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 12:45:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730936AbfKELpE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 06:45:04 -0500
Received: from mail-il1-f198.google.com ([209.85.166.198]:51382 "EHLO
        mail-il1-f198.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730704AbfKELpD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 06:45:03 -0500
Received: by mail-il1-f198.google.com with SMTP id x2so14832852ilk.18
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2019 03:45:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=QCC2Zuft5IrSbuyDgMXl4CHaLN5HBJGcl6ykToE6Ed8=;
        b=Cl8H94SvraNnMPIEqvotg2zWrCca89WB/lCgdIS3bPjS5K/SATOIAkl3SwEbv6T+A0
         mCHSqBD+H2hA33goZGiVNMxaFeKxRLZetzE98I6x2+9HWk08Bi3oJfkiZx7XCi87NCUS
         koUBVZE3gLPzieP4s3eBZVBiA4qleWGXuwcK1uGetU4e2uZ/tJZ1ahrOvSU5aqREWZEU
         7TRdHog2/MCSFPLXgFiLsobRYpCf1pVQV6+rVYyeYoXEbXNyH1rP/Heco8u+meP4KylU
         CMaRL9bcVezkoZD2Kt+dGg1VTHne6dPehNhtv7MLMqT/SHvC0QW1cRVT3JUY0LyEgAo5
         dKFA==
X-Gm-Message-State: APjAAAWVzdXq1hJsmOSdk6ONCS1mgIX3hivUuUp6Sx6vwkmuskpvy7k2
        lnL8UFTItbfhTu2dstxVvDH9nzPLy6BlYQ1+agBMDYbDsPVp
X-Google-Smtp-Source: APXvYqxODW9NHJW/4EGLldbad5zqA1/v64aLeXSjpLD0OrWyJ+niu+pzFgfeGWWvRMHqE1vxcY6Q2oZjQUQLXqzmYw875vDSNqU9
MIME-Version: 1.0
X-Received: by 2002:a92:d981:: with SMTP id r1mr15781326iln.64.1572954300760;
 Tue, 05 Nov 2019 03:45:00 -0800 (PST)
Date:   Tue, 05 Nov 2019 03:45:00 -0800
In-Reply-To: <000000000000de1eec059692c021@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000058481f059697f6e7@google.com>
Subject: Re: KASAN: use-after-free Write in j1939_sock_pending_del
From:   syzbot <syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11150314e00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13150314e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15150314e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=07bb74aeafc88ba7d5b4
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16fd7044e00000

Reported-by: syzbot+07bb74aeafc88ba7d5b4@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
