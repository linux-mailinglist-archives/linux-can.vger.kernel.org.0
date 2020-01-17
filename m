Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73D7E1409AB
	for <lists+linux-can@lfdr.de>; Fri, 17 Jan 2020 13:24:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727285AbgAQMYc (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Fri, 17 Jan 2020 07:24:32 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:45985 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727195AbgAQMYc (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Fri, 17 Jan 2020 07:24:32 -0500
Received: by mail-io1-f72.google.com with SMTP id c23so14929785ioi.12
        for <linux-can@vger.kernel.org>; Fri, 17 Jan 2020 04:24:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=LQuU3kHZ1FMuiRxbMaZ9AWO1eIyspLIkHsPMvZ1a484=;
        b=SM8Zg/ByQthC1cXf3weUFGTHhBgkhCmzetL2R97SPd0sBhMihE1qkzY/aI0EzLFivz
         sdCInLfi67745qYrlb6U8eMl7F4M/ndV3Kqm0KqAu+JGQqpqmd3dLhf0ASFg3TfbQ0tS
         NlBXPlfCFW3dpdfFCkiVjIr5F2mhYRZ49a3LSKN1dEwRElIQKxu6ScbLXIVX6Hns0SEo
         eWbrEX5/M3rh/uRkAdInW274GabVjOF1plopKCutCyiIE0Yajn62DBizZH3l7J23nRVF
         xEUabaWos5sqFNZ2WInTPoy8eQO7BAMRrvpPvy5gl3dENk67lZ3Bj9veF2o/zE/pSReW
         PXbQ==
X-Gm-Message-State: APjAAAWYKZ8GMTBDhjhxLurMsVr1fTbbcm/8S/76KlDG5IWH26dDVEqs
        clSRyXKys6ukko05L6twwnEVsLErndtGyo68dIiuH4BhHT+w
X-Google-Smtp-Source: APXvYqyizADGiZmu7qE8essoa//THW2fVjAdL/z3dW7wzWY+DLnaSeKqxd8KXmc+23FipRNQPYaYKw3Hz1wz3iZ0YNvN1H/wXfn7
MIME-Version: 1.0
X-Received: by 2002:a6b:8f41:: with SMTP id r62mr30597631iod.140.1579263871310;
 Fri, 17 Jan 2020 04:24:31 -0800 (PST)
Date:   Fri, 17 Jan 2020 04:24:31 -0800
In-Reply-To: <20200117122429.GB11961@pengutronix.de>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000e637b059c55069e@google.com>
Subject: Re: Re: general protection fault in j1939_sk_bind
From:   syzbot <syzbot+4857323ec1bb236f6a45@syzkaller.appspotmail.com>
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     linux-can@vger.kernel.org, o.rempel@pengutronix.de,
        toggle-mailboxes@pengutronix.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

> On Fri, Jan 17, 2020 at 01:06:01AM -0800, syzbot wrote:
>> syzbot suspects this bug was fixed by commit:

>> commit 00d4e14d2e4caf5f7254a505fee5eeca8cd37bd4
>> Author: Oleksij Rempel <o.rempel@pengutronix.de>
>> Date:   Fri Dec 6 14:18:35 2019 +0000

>>      can: j1939: j1939_sk_bind(): take priv after lock is held

>> bisection log:   
>> https://syzkaller.appspot.com/x/bisect.txt?x=1001b266e00000
>> start commit:   32ef9553 Merge tag 'fsnotify_for_v5.5-rc1' of  
>> git://git.ke..
>> git tree:       upstream
>> kernel config:   
>> https://syzkaller.appspot.com/x/.config?x=c2e464ae414aee8c
>> dashboard link:  
>> https://syzkaller.appspot.com/bug?extid=4857323ec1bb236f6a45
>> syz repro:       
>> https://syzkaller.appspot.com/x/repro.syz?x=177c34a2e00000

>> If the result looks correct, please mark the bug fixed by replying with:

> #syz fix: can: j1939: j1939_sk_bind(): take priv after lock is held

Your 'fix:' command is accepted, but please keep  
syzkaller-bugs@googlegroups.com mailing list in CC next time. It serves as  
a history of what happened with each bug report. Thank you.


> --
> Pengutronix e.K.                           |                             |
> Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
> 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
> Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
