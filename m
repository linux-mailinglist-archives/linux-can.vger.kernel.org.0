Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C5971C315F
	for <lists+linux-can@lfdr.de>; Mon,  4 May 2020 05:02:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgEDDCG (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 3 May 2020 23:02:06 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:51947 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726864AbgEDDCF (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 3 May 2020 23:02:05 -0400
Received: by mail-io1-f69.google.com with SMTP id k1so11836572iov.18
        for <linux-can@vger.kernel.org>; Sun, 03 May 2020 20:02:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=VsgFqYSkkd5RuUdbSLmpmT3wYB5MsDwArGNEdSX9o6A=;
        b=U6w2tzuNqjBhzaPbGI77AlYnmYKI1y80mc+JtQGA4rOPW8Bh0p0bCw1EW7+WkaGhCw
         r6NzTrKtsK0uNo2tnYvMlKHO9BTxDroWlpQh9951T0mf1rR0Uxhk1ihZ/EzeAWeNfUya
         xe4F6fPOgA+vU4ulVu06BNLn2GUiC5r+F9u/w4hiwRjgSpzvKTAacrL3CAQK9k0h75Ik
         jHL1WYy9+DHSxHDrwfDN4IqrSC6aPmHV/GbYtasQTONC3q1l+4YaOrqW8zVY8njTL8FZ
         ZvuGbGvVp2/BCvazUnUkcV6hqERq/f60X63oFLTh4fUvCuA5dRcFDhqeSlXqhRYA0fE/
         2aQw==
X-Gm-Message-State: AGi0PuYUCR9oTT1UhCQGfGzASJjXODNoVarQySmmyw2mXVPIkml+7Tep
        I5BZdWcuESGQfrm1DqBjvEISxjs5jgEzjcnJuwdgk6T4JE71
X-Google-Smtp-Source: APiQypKVjvGUSvnQLOwHaUNc3oSLx1OL9IDYU+TwsaaCuFKXkqDorCljUIAIiJwrVKP9h2yMm1lLreb2XNEBCIfKdpGQt0q5p9WS
MIME-Version: 1.0
X-Received: by 2002:a6b:4113:: with SMTP id n19mr13759133ioa.187.1588561324819;
 Sun, 03 May 2020 20:02:04 -0700 (PDT)
Date:   Sun, 03 May 2020 20:02:04 -0700
In-Reply-To: <0000000000001b1a1d057e776c92@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007851da05a4c9c169@google.com>
Subject: Re: WARNING in hsr_addr_subst_dest
From:   syzbot <syzbot+b92e4f1472a54e1c7dec@syzkaller.appspotmail.com>
To:     ap420073@gmail.com, arvid.brodin@alten.se, axboe@fb.com,
        axboe@kernel.dk, davem@davemloft.net, dvyukov@google.com,
        hch@lst.de, kuba@kernel.org, linux-block@vger.kernel.org,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        ming.lei@redhat.com, mkl@pengutronix.de, netdev@vger.kernel.org,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-can-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot suspects this bug was fixed by commit:

commit 4b793acdca0050739b99ace6a8b9e7f717f57c6b
Author: Taehee Yoo <ap420073@gmail.com>
Date:   Fri Feb 28 18:01:46 2020 +0000

    hsr: use netdev_err() instead of WARN_ONCE()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130746ffe00000
start commit:   ea200dec Merge tag 'armsoc-fixes' of git://git.kernel.org/..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=dcf10bf83926432a
dashboard link: https://syzkaller.appspot.com/bug?extid=b92e4f1472a54e1c7dec
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b5cafee00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12574271e00000

If the result looks correct, please mark the bug fixed by replying with:

#syz fix: hsr: use netdev_err() instead of WARN_ONCE()

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
