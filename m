Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 133B6F6D6B
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 04:57:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfKKD5E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 10 Nov 2019 22:57:04 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:50303 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726824AbfKKD5D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 10 Nov 2019 22:57:03 -0500
Received: by mail-il1-f197.google.com with SMTP id l63so6479140ili.17
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2019 19:57:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=ahqf5JMi9x4MvVhOL42cOCJqrc4gS0aQJVD9aozCigk=;
        b=p3prtXfQO680NdxAJGGQpQbcIOGoHffY6WS7ie9rEmp5jcLyx2WwEW97oV1UGosGEI
         tTowTrwt06ouJiHonllhYXYDcaDCSztYr7XEpAuSMzAc7Typ9veootAYiUvTUvcM6hJ/
         OeNxSEmI8ol+hINbrxdlzTdLprMIZfbxl1l+a78vDozRDDTdOXyTRNNgGQz6cYDAIAR5
         E9cn5FmKFtVeK7HCr7k/hmTos1+Yr9/GZmw1Y6v+pGaTjNPECLsvkkIBnHNTN+L80WdP
         j9rJUQgBusloDtDRH7dp2QYEQw/nPtdOr3ohSacoY1/F0c/x2HVYS+gsv2j1IVXLgout
         My0g==
X-Gm-Message-State: APjAAAWfAVG/g3OwQytGWjldTngk6id/1Hkpxpio8RMRKHdWTnAdPnEA
        xhU1Njh9zbPYYcYaRyEC0UtixarCe4/ritofvZdqRfpfLm1L
X-Google-Smtp-Source: APXvYqxIayoK3rWM7U/FC6CNlkGPnuolY7jUbXULvgiXcBHeAhVQj+4RetmukhTi4OYUOkBjLlTShjAPyzdnLzWMGXOucgeE3et/
MIME-Version: 1.0
X-Received: by 2002:a02:3903:: with SMTP id l3mr22649703jaa.72.1573444621272;
 Sun, 10 Nov 2019 19:57:01 -0800 (PST)
Date:   Sun, 10 Nov 2019 19:57:01 -0800
In-Reply-To: <00000000000082c66d059705e442@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b98cf305970a1fd3@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr_locked
From:   syzbot <syzbot+ca172a0ac477ac90f045@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11bc06d6e00000
start commit:   00aff683 Merge tag 'for-5.4-rc6-tag' of git://git.kernel.o..
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=13bc06d6e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=15bc06d6e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=ca172a0ac477ac90f045
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=144150e2e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aaa9fce00000

Reported-by: syzbot+ca172a0ac477ac90f045@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
