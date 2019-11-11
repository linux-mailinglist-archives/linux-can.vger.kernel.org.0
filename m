Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C881F785E
	for <lists+linux-can@lfdr.de>; Mon, 11 Nov 2019 17:07:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbfKKQHC (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Mon, 11 Nov 2019 11:07:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:33226 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726893AbfKKQHC (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Mon, 11 Nov 2019 11:07:02 -0500
Received: by mail-il1-f197.google.com with SMTP id s14so7355800ila.0
        for <linux-can@vger.kernel.org>; Mon, 11 Nov 2019 08:07:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=gFl20HjZDqq+nPQeJUYSxv5Bfmo8ZIyMRQ74ccfUZsc=;
        b=FVpElW2vOgq6i6JJixqqYRwRD9oFfUYLjvk7XM63Pn5PDWu68dJYmSxxkEr+DF8mZD
         xPDBNi/MaYY19QoBnY0I3I1rqDOsE6caSYs3cTTWe9PVQILkbgdSTshI6EkaTHlhsKlP
         hLepEfMuQjCrDEDJmxs25b4OBiZrYcD2O6X3zhGMce+YqHK4JlBGWlskwgAyUyhnFw/h
         6rO3fBDtTOJ035BWkQ+UJZ4lhfrqYbN/csB8ZIdTSsQI8yXQswyMZp0oV6duYflZD3Gz
         2wY8r2vqdYlhGdJ/FGT3/KZS24hK4qwnRgguMufHY+ijokom3s9r3vs5Jhf/7xZoXvtk
         BFzg==
X-Gm-Message-State: APjAAAVFdzweNIDuzukl3WqYteKPJinIUmn6UrLRVXRAABJwSJzPrfsW
        6BIQALmOaip+/IuTOTNuwiXmNTaSQkxgYfwCPhOwE8z4ZeV7
X-Google-Smtp-Source: APXvYqywxuAwIOiw8d0TKszs0yk4o9kaGMvUJ9K55SHH6Im/F08TWUOQQw1vBGPnwfBhSwGcTMIJv9gca9cNfCX3fkgdzA02Qkyu
MIME-Version: 1.0
X-Received: by 2002:a92:dd0f:: with SMTP id n15mr31057502ilm.146.1573488421314;
 Mon, 11 Nov 2019 08:07:01 -0800 (PST)
Date:   Mon, 11 Nov 2019 08:07:01 -0800
In-Reply-To: <000000000000aae1480596a5632b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000692ac105971452c5@google.com>
Subject: Re: WARNING: refcount bug in j1939_netdev_start
From:   syzbot <syzbot+afd421337a736d6c1ee6@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17100f3ae00000
start commit:   9805a683 Merge branch 'x86-urgent-for-linus' of git://git...
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=14900f3ae00000
console output: https://syzkaller.appspot.com/x/log.txt?x=10900f3ae00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=896c87b73c6fcda6
dashboard link: https://syzkaller.appspot.com/bug?extid=afd421337a736d6c1ee6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10d713c6e00000

Reported-by: syzbot+afd421337a736d6c1ee6@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
