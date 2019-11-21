Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD065104F27
	for <lists+linux-can@lfdr.de>; Thu, 21 Nov 2019 10:26:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726573AbfKUJ0E (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 21 Nov 2019 04:26:04 -0500
Received: from mail-io1-f70.google.com ([209.85.166.70]:43228 "EHLO
        mail-io1-f70.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKUJ0D (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 21 Nov 2019 04:26:03 -0500
Received: by mail-io1-f70.google.com with SMTP id y20so1751479iot.10
        for <linux-can@vger.kernel.org>; Thu, 21 Nov 2019 01:26:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=6ozcDbr2hFtQSnK/28jfucsXIR73JWIXzNBJp3f0sak=;
        b=CMkqwR7q73QEv2JDyJud1g9CJyqUempU+ReleLfFlXQdgqw4vHf0T6FWHDrmScFKM9
         pEf6gttInJTPhjygdxQ8pywNAE2/Eg1oViHY1MxiN72Kc5xE00PNsickZ7PAMi3dV6E5
         NWQ9NpC5TONezVAS6AyKY0MKLgU3MRzPtmF5V/GgcImRPe2somL01nbLPcoLq12d+B74
         2XXABrfsPf4QrDp3LSIu4zc1VuUjSjgF72UrSUlnfFYjlnqxkCMQogHAHvJwI9U5sHbW
         adKwviPHsQxcAbCmkH3L0ahiJ+pvmcnlH91gnkAg6g761664NT+JtsmorPpe6CwsRI+W
         nSTg==
X-Gm-Message-State: APjAAAVcDlFBCBO2ti5w9iaOCh46xkctYmlUK/XmONTMUudUVngxi82L
        VJ3PDPM8JtSoRvLfsZKy3yumJ7W8qeGuwolVSsFTvFQRAUYz
X-Google-Smtp-Source: APXvYqw8McZGbc2E/hPpvSV9U/mYJEuNQ3Tf7YiJBqO3ltBpa24uKOnf8sl9TjJv3OXD3dnvqSNkYTI9MC9u8nButoyEwUC6F1z+
MIME-Version: 1.0
X-Received: by 2002:a92:45ca:: with SMTP id z71mr9226460ilj.106.1574328361224;
 Thu, 21 Nov 2019 01:26:01 -0800 (PST)
Date:   Thu, 21 Nov 2019 01:26:01 -0800
In-Reply-To: <00000000000028f3c20597d2d8ee@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb10ec0597d7e2bb@google.com>
Subject: Re: WARNING in j1939_sk_queue_activate_next
From:   syzbot <syzbot+49595536c57ef38095ed@syzkaller.appspotmail.com>
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

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=152c6bace00000
start commit:   c74386d5 afs: Fix missing timeout reset
git tree:       upstream
final crash:    https://syzkaller.appspot.com/x/report.txt?x=172c6bace00000
console output: https://syzkaller.appspot.com/x/log.txt?x=132c6bace00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4737c15fc47048f2
dashboard link: https://syzkaller.appspot.com/bug?extid=49595536c57ef38095ed
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13b8ba86e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16ce855ae00000

Reported-by: syzbot+49595536c57ef38095ed@syzkaller.appspotmail.com
Fixes: 9d71dd0c7009 ("can: add support of SAE J1939 protocol")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
