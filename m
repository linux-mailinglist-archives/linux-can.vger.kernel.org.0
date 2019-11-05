Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE8EF6CC
	for <lists+linux-can@lfdr.de>; Tue,  5 Nov 2019 09:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388060AbfKEIFE (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Tue, 5 Nov 2019 03:05:04 -0500
Received: from mail-il1-f200.google.com ([209.85.166.200]:47715 "EHLO
        mail-il1-f200.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387974AbfKEIFE (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Tue, 5 Nov 2019 03:05:04 -0500
Received: by mail-il1-f200.google.com with SMTP id c19so17927989ilf.14
        for <linux-can@vger.kernel.org>; Tue, 05 Nov 2019 00:05:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=A+4AkRt/iJ32TVTQDYf76dEd7rbEn0HxYNkhXJNAhU4=;
        b=LxT+RzM+Cy8qQCEHl4EvvRK+NuzZGY+RYpFWue8A5TTkHC+ZPjGcVDrPIIttv31MSQ
         KpbQNdysQsic461QU5eZJj6TYjbC+9U32huLu+kZ4w+edXy1PA8nr3Fd+MFuFO13zmk8
         jqCd5W0K7/ZN13XPllASqvpN5oWS8yN3zzc6JR8HazXWxclrAUmFOMPrSJCROYHpnKuq
         RJ1fJmbvp6wU/svSQbM22pbrcEhug+XtlGFvd57Auj94BIFZF/VOyfOn55uL/H+Th1AG
         25r+nDCbbwWk5gZPHSiUXSF/QnK5EnK7AC4Z09IMInFN/vNr0+eS7aNtlXMVheqlKu6H
         Cxrg==
X-Gm-Message-State: APjAAAU33AnR1V4OP+bHnLnkvC4fC7Cx2OkFhHQaNM0HnzDn+QLoJAy4
        FYVfa9chorKJP583LrsHmcY2qcoqTQLRqkx3D21l9o8LxNl4
X-Google-Smtp-Source: APXvYqxxHa3WZGVREfBIgxsSHWRMFio4aR3soJvRprK7KTi8nNn6BI9Am+gZILpmI5NcZhdyGyBTD3WyVzvP9Bg1F+VtznmK0N4k
MIME-Version: 1.0
X-Received: by 2002:a92:8dd9:: with SMTP id w86mr31839322ill.93.1572941101014;
 Tue, 05 Nov 2019 00:05:01 -0800 (PST)
Date:   Tue, 05 Nov 2019 00:05:01 -0800
In-Reply-To: <0000000000009393ba059691c6a3@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009427b5059694e33c@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_session_get_by_addr
From:   syzbot <syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com>
To:     Jose.Abreu@synopsys.com, arvid.brodin@alten.se,
        davem@davemloft.net, ilias.apalodimas@linaro.org,
        joabreu@synopsys.com, jose.abreu@synopsys.com,
        kernel@pengutronix.de, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot has bisected this bug to:

commit 2af6106ae949651d529c8c3f0734c3a7babd0d4b
Author: Jose Abreu <Jose.Abreu@synopsys.com>
Date:   Tue Jul 9 08:03:00 2019 +0000

     net: stmmac: Introducing support for Page Pool

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15f481c8e00000
start commit:   1574cf83 Merge tag 'mlx5-updates-2019-11-01' of git://git...
git tree:       net-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=17f481c8e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=13f481c8e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c26333525dde4c39
dashboard link: https://syzkaller.appspot.com/bug?extid=d9536adc269404a984f8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16050314e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=159c59b2e00000

Reported-by: syzbot+d9536adc269404a984f8@syzkaller.appspotmail.com
Fixes: 2af6106ae949 ("net: stmmac: Introducing support for Page Pool")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
