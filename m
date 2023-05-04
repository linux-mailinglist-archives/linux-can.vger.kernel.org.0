Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE1D06F7030
	for <lists+linux-can@lfdr.de>; Thu,  4 May 2023 18:48:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjEDQsI (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Thu, 4 May 2023 12:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjEDQsD (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Thu, 4 May 2023 12:48:03 -0400
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A5E422B
        for <linux-can@vger.kernel.org>; Thu,  4 May 2023 09:47:41 -0700 (PDT)
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-760eead6a4aso45629739f.3
        for <linux-can@vger.kernel.org>; Thu, 04 May 2023 09:47:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683218849; x=1685810849;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qWpjF4Bamr/uAlbk5+thvSEr3uGSTELUNEl8xA/w3zM=;
        b=iDC5sX9HIydTA0xX3sz2QOD3U4KBVZayKCRboF4HmGDEvgMQ/nZKXC4rMufYtAGLPX
         hXBiOHUZ3o9XXUc9FPrmZBwz4/TptoR2Tzdc9MRoFkOYFljzudEYqOfILZHz+nKUS0Tr
         x52mBxnc0I99cmW0D1r/i2fblV3YMnKbBw081QbUpedtDoHoM1aymqFCKeL1/IXvvhtv
         yQDOBfcCRuP4l6f/uCrYKRv72TpuzW1dPd2Dp8kp7TvkNIA0r+qhIS6qu+YVEHDWDzb8
         SNTvZ3VM7sq24o/yc6gikIU8FxHad0xG2J6cwy3ITjiOiOKQP8vP8WyDy1BPUWot/aOF
         q1Gg==
X-Gm-Message-State: AC+VfDzDQprxU1CRwpgBtUwFP18nM5xeWSrZ8ZJNmJgkoZmzxkyRs/9J
        AmDEgjayfk8VH/H4rW7ZiKFkITxtfc6kCKifSFhFooVFsqul
X-Google-Smtp-Source: ACHHUZ5SZU2SmCOWlboo7Uh+rQCO1f6NOtN2Ip3jDJiWe24VB/gKcB7g4seQWvUIw+UP8Xp7S1XBVelINmQdFvYroY2s3raHckvZ
MIME-Version: 1.0
X-Received: by 2002:a5d:9f4a:0:b0:760:ebc0:c396 with SMTP id
 u10-20020a5d9f4a000000b00760ebc0c396mr118960iot.3.1683218848919; Thu, 04 May
 2023 09:47:28 -0700 (PDT)
Date:   Thu, 04 May 2023 09:47:28 -0700
In-Reply-To: <000000000000951c2505d8a0a8e5@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000091b72905fae0eda2@google.com>
Subject: Re: [syzbot] [can?] WARNING in j1939_session_deactivate_activate_next
From:   syzbot <syzbot+3d2eaacbc2b94537c6c5@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, kernel@pengutronix.de,
        kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org,
        o.rempel@pengutronix.de, pabeni@redhat.com, robin@protonic.nl,
        socketcan@hartkopp.net, syzkaller-bugs@googlegroups.com,
        william.xuanziyang@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot suspects this issue was fixed by commit:

commit d0553680f94c49bbe0e39eb50d033ba563b4212d
Author: Ziyang Xuan <william.xuanziyang@huawei.com>
Date:   Mon Sep 6 09:42:00 2021 +0000

    can: j1939: fix errant WARN_ON_ONCE in j1939_session_deactivate

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10cf0990280000
start commit:   fa182ea26ff0 net: phy: micrel: Fixes FIELD_GET assertion
git tree:       net
kernel config:  https://syzkaller.appspot.com/x/.config?x=796b7c2847a6866a
dashboard link: https://syzkaller.appspot.com/bug?extid=3d2eaacbc2b94537c6c5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1455e3b2880000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10296e7c880000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: can: j1939: fix errant WARN_ON_ONCE in j1939_session_deactivate

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
