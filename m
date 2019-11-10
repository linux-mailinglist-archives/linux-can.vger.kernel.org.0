Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE2CF6BD3
	for <lists+linux-can@lfdr.de>; Sun, 10 Nov 2019 23:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726785AbfKJWzB (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Sun, 10 Nov 2019 17:55:01 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:36690 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726773AbfKJWzB (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Sun, 10 Nov 2019 17:55:01 -0500
Received: by mail-io1-f70.google.com with SMTP id z12so4956734iop.3
        for <linux-can@vger.kernel.org>; Sun, 10 Nov 2019 14:55:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=/Pa8UKCMA8SPihRiDsHarMOuNUw5vqsXgCzbPaMPce4=;
        b=Fw99CDunQCSvs8S2yDNhLvKSyVpuKuh1y45gGp3htRkHhtXO3Hn8mQv+xEo9IECnZt
         Z5Lq1CZLWFGfG8g35a68yCPtjhnMPc941PGFJN+Ic882Nle0nuhKj4ZlsVt5sVbfQLv2
         tlEUDjlfIVteTMA3V7kyXiqVBIxIpke6ZkhVMytdoVJKYigI0LFOpQ+q9vUovC/jRUil
         Btcf8HNSxkUWFRW/FLbnHMnjZsUPJmYZ8reVPz2Mt23LKnsNrwLmiLRVkQ9E9YKlR8wR
         m01IXlKsCSso4Y93VA6TwiKFtQtnNmxBY9DaQeNJD53ejYWoAtk+OyLRcY1X6iwTI4PX
         +o/g==
X-Gm-Message-State: APjAAAXWLt8UDa8AjQTxoNtWMckuBD0cRW0uU4FHSeXhxfe8tjqTtZEC
        uBVL2BfGTCpfEbD555oIhtdNWEeMoA+vJhY1I2d+kid+aFhU
X-Google-Smtp-Source: APXvYqxWupxkjD8ceSh/6a3yrJv8V9rVgU5A/fgW9YnNAd6CimDELG1I6tO19zEfdiU5wFsMPZGE1ex5HT3ZsMNciuLWHpaXCXfE
MIME-Version: 1.0
X-Received: by 2002:a05:6638:6b6:: with SMTP id d22mr23089821jad.60.1573426500631;
 Sun, 10 Nov 2019 14:55:00 -0800 (PST)
Date:   Sun, 10 Nov 2019 14:55:00 -0800
In-Reply-To: <000000000000a3cc890597025437@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a68113059705e7d4@google.com>
Subject: Re: KASAN: use-after-free Read in j1939_sk_recv
From:   syzbot <syzbot+07ca5bce8530070a5650@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10f08e72e00000
start commit:   5591cf00 Add linux-next specific files for 20191108
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=12f08e72e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=14f08e72e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e1036c6ef52866f9
dashboard link: https://syzkaller.appspot.com/bug?extid=07ca5bce8530070a5650
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=165ad206e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14cf9c3ce00000

Reported-by: syzbot+07ca5bce8530070a5650@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
