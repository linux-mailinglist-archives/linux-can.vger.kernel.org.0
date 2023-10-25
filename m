Return-Path: <linux-can-owner@vger.kernel.org>
X-Original-To: lists+linux-can@lfdr.de
Delivered-To: lists+linux-can@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F5C7D6166
	for <lists+linux-can@lfdr.de>; Wed, 25 Oct 2023 08:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbjJYGCe (ORCPT <rfc822;lists+linux-can@lfdr.de>);
        Wed, 25 Oct 2023 02:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbjJYGCe (ORCPT
        <rfc822;linux-can@vger.kernel.org>); Wed, 25 Oct 2023 02:02:34 -0400
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66BD7AF
        for <linux-can@vger.kernel.org>; Tue, 24 Oct 2023 23:02:32 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3ebbbdbf9so7518917b6e.0
        for <linux-can@vger.kernel.org>; Tue, 24 Oct 2023 23:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698213751; x=1698818551;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Wii8E7zHSEDik3+/ZAl9Uy7hVmIz0evyew93pf3levg=;
        b=nSPexcL55rCV+7F8dJ3QpWuBUxORiS52KXBXZAAoSllWHY1m4ZxQj/8gpT7zm4coVa
         hckKGESgjwZd2cSpiyWpdwLd3u+vkmzGdEmTQ5buBgZ61Z1ORUdewm1AwMGEqxfSOgy6
         ap/yqQyD1IDCB8YsHzLmPKiQDkcC3uXxsCapKJf4CAX5fU4ENdIjrg+fCt/r5xqJA5eS
         ldwanvAjMRVvVd/eSBk76k1GETneFCHnIu653BYRJ6awKCvejRmiKWATH1HzRtlkSzsQ
         A/u5hUvdSgHjKY3ZxyQsxqd3cL5E168BgVvweT6FU7q3/Myb5cZtG/MzQZbJBFKH4qRL
         d7Eg==
X-Gm-Message-State: AOJu0YzbqTeutlpJWjI9PZJLeeJ9ITENvRQsVzhISb+iqEBNkWB1L1tF
        3yi+eJKNQM6HskWCzGruA9IuHELky8+x5QVPH3VqltmbJlEq
X-Google-Smtp-Source: AGHT+IHssJml8McZlRux6ZXt3VOeHacpOyLeRKgWH6j9CJmj9sveOQS0uWJF+F3U2CxWMMjmBub9b2Hx+0PMCfEE4WJkoUN7Sz2i
MIME-Version: 1.0
X-Received: by 2002:a05:6870:472c:b0:1e5:7978:9ce4 with SMTP id
 b44-20020a056870472c00b001e579789ce4mr6743294oaq.11.1698213751574; Tue, 24
 Oct 2023 23:02:31 -0700 (PDT)
Date:   Tue, 24 Oct 2023 23:02:31 -0700
In-Reply-To: <000000000000e8364c05ceefa4cf@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006a55890608843368@google.com>
Subject: Re: [syzbot] [can?] possible deadlock in j1939_session_activate
From:   syzbot <syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com>
To:     davem@davemloft.net, edumazet@google.com, hdanton@sina.com,
        kernel@pengutronix.de, kuba@kernel.org, linux-can@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux@rempel-privat.de,
        mkl@pengutronix.de, netdev@vger.kernel.org, pabeni@redhat.com,
        robin@protonic.nl, socketcan@hartkopp.net,
        syzkaller-bugs@googlegroups.com, wg@grandegger.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_00,FROM_LOCAL_HEX,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SORTED_RECIPS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-can.vger.kernel.org>
X-Mailing-List: linux-can@vger.kernel.org

syzbot has bisected this issue to:

commit 259bdba27e32368b4404f69d613b1c1014c07cbf
Author: Oliver Hartkopp <socketcan@hartkopp.net>
Date:   Wed Mar 9 12:04:16 2022 +0000

    vxcan: enable local echo for sent CAN frames

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14a2e55d680000
start commit:   84186fcb834e Merge tag 'urgent/nolibc.2023.10.16a' of git:..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16a2e55d680000
console output: https://syzkaller.appspot.com/x/log.txt?x=12a2e55d680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7d1f30869bb78ec6
dashboard link: https://syzkaller.appspot.com/bug?extid=f32cbede7fd867ce0d56
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15c6300d680000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=17e6935d680000

Reported-by: syzbot+f32cbede7fd867ce0d56@syzkaller.appspotmail.com
Fixes: 259bdba27e32 ("vxcan: enable local echo for sent CAN frames")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
