Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0011405CE
	for <lists+linux-can@lfdr.de>; Fri, 17 Jan 2020 10:08:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729093AbgAQJGC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jan 2020 04:06:02 -0500
Received: from mail-io1-f71.google.com ([209.85.166.71]:54840 "EHLO
        mail-io1-f71.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726908AbgAQJGC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2020 04:06:02 -0500
Received: by mail-io1-f71.google.com with SMTP id u6so14695037iog.21
        for <linux-can@vger.kernel.org>; Fri, 17 Jan 2020 01:06:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=WNXjdzyGh8ua3twp/xWEP9YTi5f399ywdktK+q8UWxU=;
        b=hk6BK07rAK6Cxdhxvbz12vH5NZF5elmMCEORHWsg9344XnNxgXRzQDMTDXaL3cIRK+
         4N+nqJu3/lij9+bqMJUtXoIpxwwwlGszd72lBzg5kgSEWO/osJ2pu8eqs0HJADaGkHvQ
         wJMPyCWiNud6VdNgmlz/BggaKCRiLJ2bcTCi1Ur3xgYOa/1xFqpjqj919FJbpXBqQlQ9
         4aDjn8pgbu7JUBkAVEStbdlSCf52wJDXx5mbR62aGOLKiUXFns+exJ0Yu75jGBw2Bif7
         o1XWn3YxCXhApvOLv2wjSYg+6H0XfukkX7nZm0jBuwUT8C2a2xFHkRoV1Ckyqnc7pemD
         3MgA==
X-Gm-Message-State: APjAAAUZIYvQ0BH9on49CHCYPXCWMuce7mA3lra0EVN5646e9D0xeBQN
        V4u/azAdgUbynGiDWFpdeNOenuhBsxXJ7+r4NCQ76uKOA9qW
X-Google-Smtp-Source: APXvYqzeQjj9HgIT2ODEiPfQcwnJHJ9IOn5ynE9jA++dhS1p4psfqy43bh3944jkXkKtmBgvbsSRbYi2cKGJWAjjnFtqgPVESlLS
MIME-Version: 1.0
X-Received: by 2002:a5d:9d10:: with SMTP id j16mr1297633ioj.0.1579251961344;
 Fri, 17 Jan 2020 01:06:01 -0800 (PST)
Date:   Fri, 17 Jan 2020 01:06:01 -0800
In-Reply-To: <000000000000a367e3059691c6b4@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002ab713059c524079@google.com>
Subject: Re: general protection fault in j1939_sk_bind
From:   syzbot <syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com>
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

syzbot suspects this bug was fixed by commit:

commit 00d4e14d2e4caf5f7254a505fee5eeca8cd37bd4
Author: Oleksij Rempel <o.rempel@pengutronix.de>
Date:   Fri Dec 6 14:18:35 2019 +0000

     can: j1939: j1939_sk_bind(): take priv after lock is held

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1001b266e00000
start commit:   32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
dashboard link: https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177c34a2e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: can: j1939: j1939_sk_bind(): take priv after lock is held

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
