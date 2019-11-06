Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2D370F1030
	for <lists+linux-can@lfdr.de>; Wed,  6 Nov 2019 08:27:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729958AbfKFH1C (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 6 Nov 2019 02:27:02 -0500
Received: from mail-io1-f72.google.com ([209.85.166.72]:35568 "EHLO
        mail-io1-f72.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729816AbfKFH1C (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 6 Nov 2019 02:27:02 -0500
Received: by mail-io1-f72.google.com with SMTP id n16so17531333iom.2
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2019 23:27:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=NYZBN2qq6yyZ8/rwJcWC5cQMVkLTLOTvsfT7QODO4L4=;
        b=OKRtM2lYWE4Wipfb3Zo8kJ2vuEtXNROP4efL6h7ukbnNZPHtp+eBmOWAihNtB5h9n+
         obPWOpateYcjPBGXXdFhmhF4ANY2QTzXbiKiLJ78yG/EUyKxqwOdF6SvmiaTclMbBUD0
         yDOsDGEDWtDRoMkWuEJ8MXYoRNmJqQYKwxOlAgexJlgN6tcX1NR4FNtdabmV3jnWnrkN
         V8+xhOczYiML1CHaF5AO9z1DYNafc+pPmlvJuFZ1aN9/MWbQ1C0MSx/hczEZbOgdIQzY
         +/V9eHDv+ROwHZ7rXIHr8hn/5BeM2sN6vUbmu+MT5JHKL0g0ddr/0IJYGYpC7RircNXd
         eiYw==
X-Gm-Message-State: APjAAAX1uo8RZ1EAWbK7xWecfpVKl2XHlyROUlIzq8xVRt32YtXdHCsu
        N22J21X/mrprmGw9H5qFky04c9mZOHTeXM73h81eLINVrVC8
X-Google-Smtp-Source: APXvYqyd5FMJZ30orhu9VqKFCYkocrvkw/KRPvt/6hEEuXDUTOVp4lK7oLQ6TTlI9LlVVvYppYwsRyiSWDBpBRBhmASMZ1QlV/mc
MIME-Version: 1.0
X-Received: by 2002:a92:1b1c:: with SMTP id b28mr1150609ilb.278.1573025221369;
 Tue, 05 Nov 2019 23:27:01 -0800 (PST)
Date:   Tue, 05 Nov 2019 23:27:01 -0800
In-Reply-To: <00000000000047580205969ee89b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000008aea290596a8795e@google.com>
Subject: Re: general protection fault in j1939_sk_sendmsg
From:   syzbot <syzbot+7044ea77452b6f92b4fd@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15874852e00000
start commit:   a99d8080 Linux 5.4-rc6
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17874852e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13874852e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5e2eca3f31f9bf
dashboard link: https://syzkaller.appspot.com/bug?extid=7044ea77452b6f92b4fd
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15a99e8ae00000

Reported-by: syzbot+7044ea77452b6f92b4fd@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
